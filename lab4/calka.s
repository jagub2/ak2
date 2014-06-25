.section .data
  zero:  .double 0
  jeden: .double 1
.section .text
.globl calka
.type  calka, @function

calka:
  pushq %rbp
  movq  %rsp, %rbp
  movsd %xmm0, -8(%rbp)  # start
  movsd %xmm1, -16(%rbp) # koniec
  movsd %xmm2, -24(%rbp) # krok
  fldl  -16(%rbp) # zaladuj koniec na stos
  fldl  zero      # zaladuj zero
  fstl  -32(%rbp) # wrzuc wynik (na razie zero)
  faddl -8(%rbp) # st(0) + start
petla:
  fcomi %st(1), %st(0) # porownaj koniec z aktualnym x
  ja    koniec # wiecej? wyjdz z petli
dalej:
  fldl  -32(%rbp) # wrzuc wynik na stos
  fldl  jeden     # wrzuc jedynke na stos
  fmull -24(%rbp) # pomnoz jedynke przez krok
  fdiv  %st(2)    # podziel przez aktualnego x (w koncu funkcja to 1/x)
  faddp           # dodaj i usun ze stosu (1/x * delta)
  fstpl -32(%rbp) # zapamietaj wynik
  faddl -24(%rbp) # x += krok
  jmp   petla

koniec:
  movsd -32(%rbp), %xmm0 # wrzuc wynik do %xmm0
  popq  %rbp
  ret

