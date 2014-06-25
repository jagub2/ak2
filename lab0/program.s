SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.align 32
.data
  tekst: .ascii "TutajTrzebaCosWpisacAbyUstalicDlugosc"
  tekst_len = . - tekst
  wpisales: .ascii "Wpisales:\n"
  wpisales_len = . - wpisales

.global main
main:
  mov $SYSREAD, %eax      # wywolaj funkcje `read` kernela
  mov $STDIN, %ebx        # argumenty na podstawie `man 2 read`
  mov $tekst, %ecx
  mov $tekst_len, %edx
  int $0x80               # wywolaj funkcje
  mov %eax, %esp          # wynik (dlugosc tekstu) wrzuc do %esp
                          # bo %eax zostanie nadpisany

  mov $SYSWRITE, %eax     # jak wyzej, ale z funkcja `write`
  mov $STDOUT, %ebx
  mov $wpisales, %ecx
  mov $wpisales_len, %edx
  int $0x80

  mov %esp, %edx          # przerzuc %esp do %edx (argument pod tytulem dlugosc)
  mov $SYSWRITE, %eax     # dalej jak wyzej, wypisz tekst
  mov $STDOUT, %ebx
  mov $tekst, %ecx
  int $0x80

  mov $SYSEXIT, %eax      # wywolaj `exit`
  mov $EXIT_SUCCESS, %ebx # z kodem 0 (EXIT_SUCCESS)
  int $0x80

