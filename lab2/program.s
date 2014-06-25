SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.bss
.comm liczba, 20
.data
  liczba_len: .long 20

.globl main

main:
  xor %r13, %r13 # starsza czesc liczby
  xor %r14, %r14 # mlodsza czesc liczby

wczytywanko: # wczytywanie liczby
  mov $SYSREAD, %eax 
  mov $STDIN, %ebx
  mov $liczba, %ecx
  mov liczba_len, %edx
  int $0x80

  mov %eax, liczba_len
  mov %eax, %ecx # wrzuc dlugosc wczytanej liczby do ecx - wg tego bedzie iterowac petla
  sub $3, %ecx # odrzucamy 3 znaki - 2 na poczatku - przedrostek; jeden na koncu - \n
  mov $2, %esi # esi - po nim nastepuje iterowanie liczby (w ascii); zaczynamy od liczby, nie chcemy przedrostka

  xor %r15, %r15 # tymczasowa wartosc liczby

  cmp $1, %eax # wczytany ciag ma jeden znak - najprawdopodobniej to znak nowej linii, zakoncz / moze tez sie zdarzyc ^D
  jbe toJestDobryMomentAbySprawdzicWynikiWGDB

dodajWartosc:
  xor %rax, %rax
  movb liczba(,%esi,1), %al
  cmpb $'0', %al # sprawdz, czy cyfra jest w dozwolonym zakresie
  jb zlyZnak
  cmpb $'9', %al
  jbe cyfra
  cmpb $'A', %al
  jb zlyZnak
  cmpb $'F', %al
  ja zlyZnak
  jbe litera
  jmp koniec # nie powinienem tu dotrzec, jak sie rozbisurmanie to powiedz mamie
dalej:
  inc %esi # esi -> indeks, po ktorym sie przesuwamy
  movq %rax, %rbx # al -> aktualna cyfra, wrzuc do rbx
  shl $4, %r15 # aktualna liczbe pomnoz przez 16 (schemat Hornera)
  add %rbx, %r15 # dodaj cyfre
  clc # na wszelki wypadek wyczysc flagi przeniesienia
  loop dodajWartosc

  add %r15, %r14 # petla skonczona, dodaj liczbe
  adc $0, %r13 # dodaj przeniesienie

  jmp wczytywanko # wczytaj od nowa

cyfra:
  sub $'0', %al
  jmp dalej

litera:
  sub $'A', %al
  add $10, %al
  jmp dalej

zlyZnak: # zly znak, wyjdz
  jmp toJestDobryMomentAbySprawdzicWynikiWGDB

toJestDobryMomentAbySprawdzicWynikiWGDB:
  nop

koniec:
  mov $SYSEXIT, %eax 
  mov $EXIT_SUCCESS, %ebx
  int $0x80

