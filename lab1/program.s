SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.bss # dane beda wyzerowane, co wydaje sie byc czyms dobrym
.comm tekst, 50
.data
  tekst_len: .long 50

.global main
main:
  mov $SYSREAD, %eax # wczytaj ciag (do 50 znakow)
  mov $STDIN, %ebx
  mov $tekst, %ecx
  mov tekst_len, %edx
  int $0x80
  mov %eax, tekst_len # przerzuc nowa dlugosc do zmiennej odpowiadajacej za dlugosc

  mov $0, %esi # indeks aktualnego znaku

sprawdz: # sprawdz kazdy znak po kolei
  movb tekst(,%esi,1), %al
  cmpb $'0', %al # dozwolony przedzial: 0-z (na podstawie tablicy ASCII)
  jb zlyZnak
  cmpb $'z', %al
  ja zlyZnak
  cmpb $':', %al # porownaj ze znakami niealfanumerycznymi, w sumie do sprawdzenia 2 przedzialy (9-A; Z-a)
  jb dalej
  cmpb $'A', %al
  jb zlyZnak
  cmpb $'[', %al
  jb dalej
  cmpb $'a', %al
  jb zlyZnak
  cmpb $'z', %al
  ja zlyZnak
dalej:
  inc %esi # znak alfanumeryczny, przesun sie dalej i powtorz do konca napisu
  cmp tekst_len, %esi
  je utnijPoczatek # dojecalismy na koniec, `uciecie` niedozwolonych znakow na poczatku
  jmp sprawdz

zlyZnak: # jednak mamy zly znak, zamiana na *
  mov $'*', %al
  lea tekst(,%esi,1), %ebx
  movb %al, (%ebx) # zamien niedozwolony znak na *
  jmp dalej

utnijPoczatek:
  mov $0, %esi # przesuwamy napis wg esi
  mov $0, %edi # edi -> offset, ile trzeba dodac
  mov $0, %ebx # ebx -> wartosc rejestru oznacza czy ma kontynuowac (0 - tak, 1 - nie)
petlaUtnijPoczatek:
  movb tekst(,%esi,1), %al
  cmpb $'*', %al # sprawdz czy niedozwolony znak
  je utnijPocz1
  jne dobryZnak
powrotPetla:
  inc %esi # zwieksz esi, jezeli zakonczylismy to `utnij` koniec
  cmp tekst_len, %esi
  je utnijKoniec
  jmp petlaUtnijPoczatek

utnijPocz1:
  cmp $1, %ebx # ebx == 1 -> zakoncz
  jne utnijPocz2
  jmp powrotPetla

utnijPocz2:
  inc %edi # zly znak, zwieksz edi
  jmp powrotPetla

dobryZnak:
  mov $1, %ebx # trafilismy na znak alfanumeryczny ustaw ebx = 1
  jmp powrotPetla

utnijKoniec:
  mov tekst_len, %esi # przesuwamy napis wg esi, tym razem od konca
  dec %esi
petlaUtnijKoniec:
  movb tekst(,%esi,1), %al # analogicznie jak przy ucinaniu poczatku, szukamy ostatniego dozwolonego znaku
  cmpb $'*', %al
  je utnijKon1
  jne koniec # trafilsmy na dobry znak, wyjdz z petli (chcemy go wyswietlic)

utnijKon1:
  dec %esi
  jmp petlaUtnijKoniec

koniec:
  mov tekst_len, %edx # ustal dlugosc, odejmij wartosc niedozwolonych znakow z poczatku
  sub %edi, %edx

  mov tekst_len, %eax # analogicznie, od konca
  sub %esi, %eax
  sub %eax, %edx
  inc %edx

  mov $'\n', %al # dodaj znak nowej linii na koniec
  mov %edx, %ecx
  add %edi, %ecx
  lea tekst(,%ecx,1), %ebx
  movb %al, (%ebx)
  inc %edx

  mov $tekst, %ecx
  add %edi, %ecx

  mov $SYSWRITE, %eax # wywolaj wypisanie napisu
  mov $STDOUT, %ebx
  int $0x80

  mov $SYSEXIT, %eax # zakoncz program, z kodem 0
  mov $EXIT_SUCCESS, %ebx
  int $0x80

