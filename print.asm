%macro print 2
mov rax,1
mov rdi, 1
mov rsi,%1
mov rdx,%2
syscall 
%endmacro

%macro exit 0
mov rax,60
mov rdi,00
syscall
%endmacro

section .data
msg db 10 ,"Hello World",10
len equ  $ - msg

section .text
global _start
_start: 
  print msg,len
  exit
