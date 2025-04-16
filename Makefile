CFLAGS=-Wall -Wextra -pedantic
COMPILER=gcc
server:server.c
	${COMPILER} ${CFLAGS} $^ -o $@ 

.PHONY:clean

clean:
	rm -rf server
	