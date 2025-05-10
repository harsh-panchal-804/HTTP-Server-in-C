CFLAGS=-Wall -g -Wextra -pedantic -O3 -lpthread
COMPILER=gcc
server:server.c stringops.h fs.h
	${COMPILER} ${CFLAGS} $< -o $@ 

.PHONY:clean

clean:
	rm -rf server
	