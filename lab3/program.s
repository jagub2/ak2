SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.bss
.comm txtsysread, 3 # bufor dla sysread
.data
  li1: .int 20 # przykladowa liczba
  txtsr_len: .long 3 # dlugosc buforu dla sysread
.text
  fmtprintf: .asciz "%s, a tu jakas liczba: %d\n" # ciag formatujacy dla printfa, do testow
  txt: .asciz "Tekst" # dane do printfa
  fmtscanf: .asciz "%d" # ciag formatujacy dla scanf, do testow
  txtsyswrite: .ascii "Tekst, a tu jakas liczba: 20\n" # tekst dla sys_write, do testow
  txtsw_len: .long . - txtsyswrite # dlugosc tekstu dla sys_write

  czasy: .asciz "printf: %llu\nscanf: %llu\nsys_write: %llu\nsys_read: %llu\n" # ciag formatujacy dla printfa, pokazujacego pomiary

  cyfra: .asciz "%04hX " # ciag formatujacy dla jednej cyfry, dla wyniku dodawania
  nl: .asciz "\n" # znak nowej linii

.globl main

main:

# POMIAR PRINTF -> %r15

  rdtsc # pobierz ilosc cykli zegara
  shl $32, %rdx
  or %rax, %rdx # polacz wynik w jeden rejestr
  mov %rdx, %r8 # wrzuc do innego rejestru
  push %r8 # zachowaj na stosie

  mov $fmtprintf, %rdi # argumenty do printfa
  mov $txt, %rsi
  mov li1, %rdx
  mov $0, %rax
  call printf # wywolanie printfa

  rdtsc # znowu pobierz ilosc cykli zegara
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r9
  pop %r8 # zdejmij ze stosu

  mov %r9, %r15 # oblicz roznice
  sub %r8, %r15
  push %r15 # wrzuc wynik na stos
  nop

# POMIAR SCANF - %r14

  rdtsc # pobieranie jak wyzej, z wrzuceniem na stos
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r8
  push %r8

  mov $fmtscanf, %rdi # argumenty do scanf
  mov $li1, %rsi
  mov $0, %rax
  call scanf # wywolanie scanf

  rdtsc # ponowne pobranie
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r9
  pop %r8 # zdjecie ze stosu

  mov %r9, %r14
  sub %r8, %r14 # obliczenie roznicy, wrzucenie wyniku na stos
  push %r14
  nop

# POMIAR SYS_WRITE -> %r13

  rdtsc # ponowne pobranie ilosci cykli, z wrzuceniem na stos
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r8
  push %r8

  mov $SYSWRITE, %eax # wywolanie funkcji systemowej
  mov $STDOUT, %ebx
  mov $txtsyswrite, %ecx
  mov txtsw_len, %edx
  int $0x80

  rdtsc # pobranie czasu
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r9
  pop %r8 # zdjecie poprzedniego wyniku ze stosu

  mov %r9, %r13
  sub %r8, %r13 # obliczenie roznicy, wrzucenie na stos
  push %r13
  nop

# POMIAR SYS_READ -> %r12

  rdtsc # pomiary dla sys_read, z wrzuceniem na stos
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r8
  push %r8

  mov $SYSREAD, %eax # wywolanie sys_read
  mov $STDIN, %ebx
  mov $txtsysread, %ecx
  mov txtsr_len, %edx
  int $0x80

  rdtsc # ponowny pomiar
  shl $32, %rdx
  or %rax, %rdx
  mov %rdx, %r9
  pop %r8

  mov %r9, %r12
  sub %r8, %r12 # obliczenie roznicy, wrzucenie na stos
  nop

####
  pop %r15 # zdjecie wynikow ze stosu
  pop %r14
  pop %r13

  mov $czasy, %rdi # argumenty dla printf - tekst formatujacy + poszczegolne ilosci cykli
  mov %r15, %rsi
  mov %r14, %rdx
  mov %r13, %rcx
  mov %r12, %r8
  mov $0, %rax
  call printf # wywolanie printf

######### operacje na zmiennych zdefiniowanych w pliku .c

  mov $10, %rcx # wrzuc dlugosc liczb
  clc # wyczysc flage przeniesienia
dodawanie:
  mov liczba1(,%rcx,2), %ax # przenies cyfre liczby 1 do ax
  mov liczba2(,%rcx,2), %bx # ----------||--------- 2 do bx
  mov %ax, %dx # przenies ax do dx
  adc %bx, %dx # dodaj z przeniesieniem
  mov %dx, wynik(,%rcx,2) # wrzuc sume do wyniku
  loop dodawanie
  nop

  mov $0, %rcx # petla podobna do powyzszej, tylko wypisuje liczbe (wynik)
wypisywanie:
  inc %rcx
  mov wynik(,%rcx,2), %rsi
  push %rcx
  mov $cyfra, %rdi
  mov $0, %rax
  call printf
  pop %rcx
  #loop wypisywanie
  cmp $10, %rcx
  jl wypisywanie

  mov $nl, %rdi # wypisz znak nowej linii
  mov $0, %rax
  call printf
  nop

koniec: # zakoncz program
  mov $SYSEXIT, %eax 
  mov $EXIT_SUCCESS, %ebx
  int $0x80

