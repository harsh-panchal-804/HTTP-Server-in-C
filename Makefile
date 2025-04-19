CFLAGS=-Wall -Wextra -pedantic
COMPILER=gcc
server:server.c stringops.h fs.h
	${COMPILER} ${CFLAGS} $< -o $@ 

.PHONY:clean

clean:
	rm -rf server
	