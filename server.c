#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <stdio.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdbool.h>
#include <stdlib.h>
#include "stringops.h"
#define CRLF  "\r\n" // carriage return line feed
#define SP    " "

typedef struct {
    string method;
    string uri;
    string version;
} http_req_line;

typedef enum http_status {
    HTTP_RES_OK                  = 200,
    HTTP_RES_INTERNAL_SERVER_ERR = 500,
    HTTP_RES_BAD_REQUEST         = 400,
    HTTP_RES_NOT_FOUND           = 404
} http_status;

// typedef struct{
//     const char * version;
//     http_status status;
// }http_resp_status_line;


const char * http_status_to_string(http_status status){
    switch(status){
        case HTTP_RES_OK:
            return "OK";
        case HTTP_RES_BAD_REQUEST:
            return "Bad Request";
        case HTTP_RES_INTERNAL_SERVER_ERR:
            return "Internal Servor Error";
        case HTTP_RES_NOT_FOUND:
            return "Not Found";
        default:
            return "Unknown";
    }
}
http_req_line http_req_line_init() {
    http_req_line line;
    memset(&line, 0, sizeof(line));
    return line;
}
string http_response_generate(char* buf,size_t buf_len,http_status status,size_t body_len){
    int n=0;
    string response;
    response.len=0;
    memset(buf,0,buf_len);
    response.len+=sprintf(buf, "HTTP/1.0 %d %s" CRLF, status, http_status_to_string(status));
    response.len+=sprintf(buf + response.len, "Content-Type: text/html" CRLF); /// wont see css without this

    response.len += sprintf(buf+response.len,"Content-Length: %zu" CRLF ,body_len);
    response.len+=sprintf(buf+response.len,CRLF);
    // response.len=n;
    response.data=buf;
    return response;
}
bool http_send_response(int socket,string header,string body){
    ssize_t n=send(socket,header.data ,header.len,MSG_MORE); ///MSG_MORE to prevent under sized packets
    if(n<0){
        perror("send()");
        return false;
    }
    if(n==0){
        fprintf(stderr,"send() returned 0");
    }
    n=send(socket,body.data,body.len,0);
    return true;

}

int handle_client(int client_socket) {
    ssize_t n = 0;
    char buf[1024];
    string hello = string_from_cstr(
        "<span style=\"\n"
        "    color: red;\n"
        "    font-weight: bold;\n"
        "\">Hello Harsh Panchal</span>"
    );
    
    string bye = string_from_cstr(
        "<span style=\"\n"
        "    color: blue;\n"
        "    font-weight: bold;\n"
        "\">Bye Harsh Panchal</span>"
    );
    
    for (;;) {
        memset(buf, 0, sizeof(buf));
        n = read(client_socket, buf, sizeof(buf) - 1);
        if (n < 0) {
            perror("read(client_socket)");
            return -1;
        }
        if (n == 0) {
            printf("Connection closed gracefully\n");
            break;
        }
        printf("Requests:\n%s", buf);

       
        buf[n] = '\0';
        char *eol = strstr(buf, CRLF);
        if (!eol) {
            fprintf(stderr, "Malformed request (no CRLF)\n");
            close(client_socket);
            return -1;
        }
        size_t L = eol - buf;
        char line[1024];
        if (L >= sizeof(line)) L = sizeof(line) - 1;
        memcpy(line, buf, L);
        line[L] = '\0';

       
        string_splits comps = split_string(line, ' ');
        if (comps.count != 3) {
            fprintf(stderr, "Invalid request line (got %zu parts)\n", comps.count);
            free_splits(&comps);
            close(client_socket);
            return -1;
        }

      
        http_req_line req_line = http_req_line_init();
        req_line.method.data  = comps.splits[0].start;
        req_line.method.len   = comps.splits[0].len;
        req_line.uri.data     = comps.splits[1].start;
        req_line.uri.len      = comps.splits[1].len;
        req_line.version.data = comps.splits[2].start;
        req_line.version.len  = comps.splits[2].len;
        free_splits(&comps);
        /// routing logic
        string route_hello = string_from_cstr("/hello");
        string route_bye   = string_from_cstr("/bye");

        if (strings_equal(&req_line.uri, &route_hello)) {
            http_send_response(client_socket,http_response_generate(buf,sizeof(buf),HTTP_RES_OK,hello.len),hello);
        }
        else if (strings_equal(&req_line.uri, &route_bye)) {
            http_send_response(client_socket,http_response_generate(buf,sizeof(buf),HTTP_RES_OK,bye.len),bye);
        }
        else {
            http_send_response(client_socket,http_response_generate(buf,sizeof(buf),HTTP_RES_OK,hello.len),hello);
        }

        close(client_socket);
        break;
    }
    printf("-------------------\n");
    return 0;
}


int main(void) {
    int rc = 0;
    struct sockaddr_in bind_addr;
    struct sockaddr_in client_sock;
    int tcp_socket = 0;
    int ret = 0;
    int client_socket = 0;
    int enabled = 1;
    socklen_t client_len = sizeof(client_sock);

    memset(&bind_addr, 0, sizeof(bind_addr));
    tcp_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (tcp_socket == -1) {
        perror("socket");
        return 0;
    }
    printf("Socket created\n");

    (void)setsockopt(tcp_socket, SOL_SOCKET, SO_REUSEADDR, &enabled, sizeof(enabled));/// reuse port
    bind_addr.sin_port = htons(6970); /// little endian to big endian
    bind_addr.sin_family = AF_INET;

    inet_pton(AF_INET,"0.0.0.0",&bind_addr.sin_addr); /// on 0.0.0.0 or use inet_pton()

    rc = bind(tcp_socket, (const struct sockaddr *)&bind_addr, sizeof(bind_addr));
    //  note typecasting of pointer to sockaddr and not sockaddr_in
    if (rc < 0) {
        perror("bind()");
        ret = 1;
        goto exit;
    }
    printf("bind succeeded\n");

    rc = listen(tcp_socket, SOMAXCONN);///SOMAXCONN = size of our request queue
    if (rc < 0) {
        perror("listen()");
        ret = 1;
        goto exit;
    }
    printf("listen succeeded\n");

    for (;;) {
        printf("Waiting for connections...\n");
        client_socket = accept(tcp_socket,(struct sockaddr *)&client_sock,&client_len); /// pop front from queue
        char client_ip[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &(client_sock.sin_addr), client_ip, INET_ADDRSTRLEN);
        printf("Got connection from %s:%d\n", client_ip, ntohs(client_sock.sin_port));
        if (client_socket < 0) {
            perror("accept()");
            continue;
        }
        rc = handle_client(client_socket);
    }

exit:
    close(tcp_socket);
    return ret;
}
