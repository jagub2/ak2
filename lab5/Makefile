SHELL=bash

program: calkaSSE.o program.o
	gcc -g -o program program.o calkaSSE.o

program.o: program.c
	gcc -g -o program.o -c program.c

calkaSSE.o: calkaSSE.s
	gcc -g -o calkaSSE.o -c calkaSSE.s

clean: 
	rm -f program *.o

test: program test.sh
	bash test.sh

