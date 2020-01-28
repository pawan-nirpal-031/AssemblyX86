  %macro print 2
       mov rax,1
       mov rdi,1
       mov rsi,%1
       mov rdx,%2
       syscall
    %endmacro
   
    %macro read 2
       mov rax,0
       mov rdi,0
       mov rsi,%1
       mov rdx,%2
       syscall
    %endmacro

    %macro exit 0
       mov rax,60
       mov rdi,00
       syscall
    %endmacro
;----------------------------------------------------------
section .bss

    charans resb 4
    charans_len equ $-charans
    buf resb 5
    ans resb 4
;----------------------------------------------------------
section .data

    msg1 db 10,"Equivalent hexadecimal number is = "
    msg1_len equ $-msg1

    msg2 db 10,
    msg2_len equ $-msg2

;----------------------------------------------------------
section .text

        global _start

   _start:

       mov rax,31
       call BCD_HEX
       print msg1,msg1_len
       print msg2,msg2_len
       exit
;----------------------------------------------------------
 BCD_HEX:
    read buf,6
    mov rsi,buf
    xor ax,ax
    mov rbp,5
    mov rbx,10
   
next:
    xor cx,cx
    mul bx
    mov cl,[rsi]
    sub cl,30h
    add ax,cx
    inc rsi
    dec rbp
    jnz next
    mov[ans],ax
    mov ax,[ans]
    call display
    ret
;----------------------------------------------------------
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
