SHELL=bash

program: program.s
	gcc -m32 -g -o program program.s

clean: 
	rm -f program wynik.txt

test: program test.sh
	bash test.sh
