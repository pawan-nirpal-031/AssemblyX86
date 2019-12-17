section .data
msg db 10,"Hello Microprocesser ",10
msg_len equ $-msg

msg1 db 10,"New program",10
msg1_len equ $-msg1

msg2 db 10,"Assmebly program 2",10
msg2_len equ $-msg2

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

section .text
	global _start
_start:
	

	cout msg,msg_len

	cout msg1,msg1_len

	cout msg2,msg2_len
	 
	exit