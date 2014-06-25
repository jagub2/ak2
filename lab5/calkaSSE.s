.section .data
  zero:  .float 0, 0, 0, 0
  jeden: .float 1, 1, 1, 1
  mn: .float 0.5, 1.5, 2.5, 3.5
  cztery: .float 4, 4, 4, 4

  # do ostatniej operacji (jezeli liczba operacji nie jest podzielna przez 4)
  ltrzy: .float 1, 1, 1, 0
  ldwa: .float 1, 1, 0, 0
  ljeden: .float 1, 0, 0, 0

.section .text
.globl calka
.type  calka, @function

calka:
  # argumenty funkcji -> xmm0 (wartosc startowa), xmm1 (koncowa), xmm2 (krok)
  # oblicz liczbe iteracji petli
  movups %xmm1, %xmm11
  subps %xmm0, %xmm11
  xor %rcx, %rcx
  divps %xmm2, %xmm11
  cvtss2si %xmm11, %ecx # licznik petli
  # kroki (do dodawania)
  movss %xmm2, %xmm12
  punpckldq %xmm12, %xmm12
  punpckldq %xmm12, %xmm12 # rozszerz liczbe na 4 pozycje
  movss %xmm0, %xmm11
  punpckldq %xmm11, %xmm11
  punpckldq %xmm11, %xmm11
  # kolejne kroki
  movups %xmm12, %xmm13
  movups mn, %xmm4 # "wagi krokow", chcemy wartosc "srodkowa" miedzy dwoma x
  mulps %xmm4, %xmm13 # pomnoz kroki przez wage
  addps %xmm11, %xmm13 # startowe x'y
  movups cztery, %xmm11
  movups %xmm12, %xmm10
  mulps %xmm11, %xmm12 # 4 kroki na raz, wiec nie chcemy dodawac jednego kroku do kazdego, ale 4 kroki
  movups jeden, %xmm15 # jedynki
  movups zero, %xmm14 # zera
  movups zero, %xmm0 # wynik

petla:
  movups jeden, %xmm4 # xmm4 = 1
  divps %xmm13, %xmm4 # xmm4 /= x
  addps %xmm4, %xmm0  # wynik += xmm4
  addps %xmm12, %xmm13 # "kroki++"
  sub $3, %ecx # 4 kroki w jednym zamachu, wiec odejmij 3 (1 odejmuje loop)
  cmp $4, %ecx # mniej niz 4?
  jb ostatnieDzialanie
  loop petla
  jmp koniec

ostatnieDzialanie:
  cmp $0, %ecx
  je koniec
  cmp $3, %ecx
  je trzyLiczby
  cmp $2, %ecx
  je dwieLiczby
  cmp $1, %ecx
  je jednaLiczba

trzyLiczby:
  movups ltrzy, %xmm5
  jmp policzOstatnie

dwieLiczby:
  movups ldwa, %xmm5
  jmp policzOstatnie

jednaLiczba:
  movups ljeden, %xmm5
  jmp policzOstatnie

policzOstatnie:
  movups jeden, %xmm4
  mulps %xmm5, %xmm4 # wyzeruj danego x (ostatni jeden/dwa/trzy)
  divps %xmm13, %xmm4
  addps %xmm4, %xmm0

koniec:
  mulps %xmm10, %xmm0 # wynik *= krok (pierwotny)
  haddps %xmm14, %xmm0 # zsumuj horyzontalnie
  haddps %xmm14, %xmm0 # dwa razy
  ret

