section .bss
char_ans resb 2
char_ans_len equ $-char_ans




section .data
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



msg db 10,"Hex equvilant ",10
msg_len equ $-msg

msg1 db 10,"New program",10
msg1_len equ $-msg1

msg2 db 10,"Assmebly program 2",10
msg2_len equ $-msg2



	

section .text
	global _start
_start:
	mov rax, 31
	cout msg,msg_len

	call display
	exit


display :
	mov rbx,16
	mov rcx,2
	mov rsi,char_ans+1

cnt:
	mov rdx,0
	div rbx
	cmp dl,09h
	jbe add30
	add dl,07h

add30 : add dl,30h
        mov [rsi],dl
		dec rsi
		dec rcx
		jnz cnt
		cout char_ans,2
		ret 
	



	
	
	
