section .bss
char_ans  resb 4
char_ans_len  equ $-char_ans
p_count resq 1
n_count resq 1

%macro cout 2
	mov rax,1
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
    
	%macro cin 2
	mov rax,00
	mov rdi,00
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
section .data
    array dq 12,-43,22,44,-4,-3,43
    n equ 7
	msg db 10,"Postive :  ",10
    msg_len equ $-msg
    msg1 db 10,"Negetive : ",10
    msg1_len equ $-msg1
   


	

section .text
	global _start
_start:
	mov rsi ,array
    mov rcx ,n
    mov rbx ,0
    mov rdx ,0
    
    
    
    next_num: 
        mov rax,[rsi]
        shl rax,1
        jc negetive
    postive:
        inc rbx
        jmp next
    negetive: 
        inc rdx
   
    next: 
        add rsi,8
        dec rcx
        jnz next_num

        mov [p_count],rbx
        mov [n_count],rdx

        cout msg,msg_len
        mov rax,[p_count]
        call display


        cout msg1,msg1_len
        mov rax,[n_count]
        call display
        exit
        display:
        mov rbx,10
        mov rcx,2
        mov rsi,char_ans+1
        cnt:
        mov rdx,0
        div rbx
        cmp dl,09h
        jbe add_30
        add dl,07h

        add_30:
        add dl,30h
        mov [rsi],dl
        dec rsi
        dec rcx
        jnz cnt
        cout char_ans,2
        ret