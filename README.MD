
# Multithreaded HTTP Server in C

A lightweight, multithreaded HTTP server implemented in C using POSIX sockets and pthreads. This server runs on Linux, serves static files, and supports URI-based routing. It is designed for educational and practical use, demonstrating core concepts of network programming, concurrency, and HTTP protocol handling.

---

## Demo
Watch the demo ->
![Demo GIF](demo_video/server.gif)


## Features

- **POSIX Sockets**: Handles TCP connections using the standard Linux socket API.
- **Multithreaded**: Uses pthreads to process multiple client requests concurrently.
- **Static File Serving**: Delivers HTML, JPEG, CSS, JavaScript and other static files from a specified directory.
- **URI-Based Routing**: Maps incoming HTTP requests to files or handler functions based on the URI.
- **HTTP/1.1 Support**: Implements the GET and HEAD methods, responding to invalid requests with proper error messages.
- **Linux Only**: Developed and tested on Linux systems.

---

## Installation

### Prerequisites

- GCC (GNU Compiler Collection)
- GNU Make
- Linux OS
- POSIX pthreads library (usually included by default)


### Clone the Repository

```bash
git clone https://github.com/harsh-panchal-804/HTTP-Server-in-C

```



---

## Build and Run

### Build

Compile the server using the provided Makefile:

```bash
make
```


### Run

Start the server with:

```bash
./server
```

By default, the server listens on a specified port (e.g., 6970). You can access it from your browser or with tools like `curl`:

```
http://localhost:6970/
```

## Usage

- Place your static files (e.g., HTML, JPEG) in the server's root directory.
- The server will map URIs to files (e.g., `/about.html` serves `about.html` from the root).
- The server can handle multiple connections.
- Error responses are sent as HTML for easy debugging in browsers.

---


## Project Structure

- `server.c` – Main server implementation (sockets, threads, routing)
- `Makefile` – Build instructions
- `README.md` – Project documentation

---

## License

This project is open-source. See the `LICENSE` file for details.

---

## Contributing

Pull requests and suggestions are welcome! Please open an issue to discuss changes or report bugs.

---

