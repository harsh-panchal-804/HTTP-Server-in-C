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

const char *CRLF = "\r\n"; // carriage return line feed
const char *SP   = " ";

typedef struct {
    const char *data;
    size_t      len;
} string;

bool strings_equal(string *l, string *r) {
    size_t min_len = l->len < r->len ? l->len : r->len;
    return memcmp(l->data, r->data, min_len) == 0;
}

string string_from_cstr(const char *str) {
    string s;
    s.len  = strlen(str);
    s.data = str;
    return s;
}

typedef struct {
    string method;
    string uri;
    string version;
} http_req_line;

typedef enum {
    HTTP_RES_OK                  = 200,
    HTTP_RES_INTERNAL_SERVER_ERR = 500,
    HTTP_RES_BAD_REQUEST         = 400
} http_result;

http_req_line http_req_line_init() {
    http_req_line line;
    memset(&line, 0, sizeof(line));
    return line;
}

typedef struct {
    const char *start;
    size_t      len;
} string_view;

typedef struct {
    string_view *splits;
    size_t       count;
    size_t       capacity;
} string_splits;

static string_splits split_string(const char *str, char split_by) {
    size_t len = strlen(str);
    string_splits result;
    result.count    = 0;
    result.capacity = 8;
    result.splits   = calloc(result.capacity, sizeof(string_view));
    if (!result.splits) {
        perror("calloc");
        exit(EXIT_FAILURE);
    }

    const char *token_start = str;
    for (size_t i = 0; i < len; ++i) {
        if (str[i] == split_by) {
            if (result.count >= result.capacity) {
                result.capacity *= 2;
                string_view *tmp = realloc(result.splits, result.capacity * sizeof(string_view));
                if (!tmp) {
                    perror("realloc");
                    free(result.splits);
                    exit(EXIT_FAILURE);
                }
                result.splits = tmp;
            }
            result.splits[result.count].start = token_start;
            result.splits[result.count].len   = &str[i] - token_start;
            result.count++;
            token_start = &str[i + 1];
        }
    }

    // Add final token
    if (token_start <= str + len) {
        if (result.count >= result.capacity) {
            result.capacity *= 2;
            string_view *tmp = realloc(result.splits, result.capacity * sizeof(string_view));
            if (!tmp) {
                perror("realloc");
                free(result.splits);
                exit(EXIT_FAILURE);
            }
            result.splits = tmp;
        }
        result.splits[result.count].start = token_start;
        result.splits[result.count].len   = str + len - token_start;
        result.count++;
    }

    return result;
}

static void free_splits(string_splits *splits) {
    if (splits && splits->splits) {
        free(splits->splits);
        splits->splits   = NULL;
        splits->count    = 0;
        splits->capacity = 0;
    }
}

int handle_client(int client_socket) {
    ssize_t n = 0;
    char buf[1024];
    const char *hello =
        "HTTP/1.0 200 OK\r\n"
        "Content-Type: text/html\r\n"
        "\r\n"
        "<span style=\"color: red; font-weight: bold;\">Hello Harsh Panchal</span>";
    const char *bye =
        "HTTP/1.0 200 OK\r\n"
        "Content-Type: text/html\r\n"
        "\r\n"
        "<span style=\"color: blue; font-weight: bold;\">Bye Harsh Panchal</span>";

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
            (void)write(client_socket, hello, strlen(hello));
        }
        else if (strings_equal(&req_line.uri, &route_bye)) {
            (void)write(client_socket, bye, strlen(bye));
        }
        else {
            (void)write(client_socket, hello, strlen(hello));
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
    int tcp_socket = 0;
    int ret = 0;
    int client_socket = 0;
    int enabled = 1;

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
    bind_addr.sin_addr.s_addr = INADDR_ANY; /// on 0.0.0.0 or use inet_addr()

    rc = bind(tcp_socket, (const struct sockaddr *)&bind_addr, sizeof(bind_addr))
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
        client_socket = accept(tcp_socket, NULL, NULL); /// pop front from queue
        if (client_socket < 0) {
            perror("accept()");
            continue;
        }
        printf("Got a connection\n");
        rc = handle_client(client_socket);
    }

exit:
    close(tcp_socket);
    return ret;
}
