SHELL=bash

program: program.o nums.o
	gcc -g -o program program.o nums.o

nums.o: nums.c
	gcc -g -o nums.o -c nums.c

program.o: program.s
	gcc -g -o program.o -c program.s

clean: 
	rm -f program *.o

#test: program test.sh
#	bash test.sh
