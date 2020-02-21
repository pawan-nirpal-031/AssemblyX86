%macro print 2
mov rax ,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdi,00
syscall
%endmacro

section .bss
charans resb 2
pcount resq 1
ncount resq 1

section .data
arr dq  11h,-2h,-33h,22h,43h,-66h,77h
n equ 7
msg1 db "Positive count",10
len1 equ $- msg1

msg2 db "Negetive count ",10
len2 equ $-msg2


section .text
global _start:
    _start:
    mov rbx,0
    mov rdx,0
    mov rsi,arr
    mov rcx,n

back:
    mov rax,[rsi]
    shl rax,1
    jc negetive
    inc rbx
    jmp next

negetive:
    inc rdx

next:
    add rsi,8
    dec rcx
    jnz back

mov [pcount],rbx
mov [ncount],rdx

print msg1,len1
mov rax,[pcount]
call display

print msg2,len2
mov rax,[ncount]
call display

exit

display:
mov rbx,16
mov rcx,2
mov rsi,charans+1

cnt:
mov rdx,0
div rbx
cmp dl,09h
jbe add30
add dl,07h


add30:
    add dl,30h
    mov [rsi],dl
    dec rsi
    dec rcx
    jnz cnt
    print charans,2
ret