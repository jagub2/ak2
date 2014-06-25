SHELL=bash

program: calka.o program.o set_fpu.o get_fpu.o
	gcc -g -o program program.o calka.o set_fpu.o get_fpu.o

program.o: program.c
	gcc -g -o program.o -c program.c

calka.o: calka.s
	gcc -g -o calka.o -c calka.s

set_fpu.o: set_fpu.s
	gcc -g -o set_fpu.o -c set_fpu.s

get_fpu.o: get_fpu.s
	gcc -g -o get_fpu.o -c get_fpu.s

clean: 
	rm -f program *.o

test: program test.sh
	bash test.sh

