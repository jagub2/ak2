.section .data
  wartosc: .byte 0x00, 0x00
.section .text
.globl set_fpu
.type  set_fpu, @function

set_fpu:
    mov   $0, %rcx
    mov   %rdi, %rbx
    lea   wartosc(,%rcx,2), %rdx
    movw  %bx, (%rdx)
    fldcw wartosc
    ret

