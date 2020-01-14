%macro print 2
	mov rax,1
	mov rdi,2
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

section .data
msg1 db 10,"enter 4 digit number:",10
msg1_l equ $- msg1	
msg2 db 10," 4 digit number is:",10
msg2_l equ $- msg2
msg3 db 10,"Not a valid number",10
msg3_l equ $- msg3
msg4 db 10,"enter 4 digit number:",10
msg4_l equ $- msg4
	
	
section .bss
	
	char_ans resb 4
	char_ans_l equ $- char_ans
	buf resb 4

section .text
	global _start:
_start:
	print msg1,msg1_l
	call Accept
	
	print msg2,msg2_l
	mov ax,bx
	call Display
	
	exit
	

Accept:
	read buf,5
	mov rsi,buf
	mov rcx,4
	mov bx,0
	
next_byte:
	shl bx,4
	mov al,[rsi]
	
	cmp al,'0'
	jb error
	cmp al,'9'
	jbe sub30
	
	cmp al,'A'
	jb error
	cmp al,'F'
	jbe sub37
	
	cmp al,'a'
	jb error
	cmp al,'f'
	jbe sub57
	
	sub57:sub al,20h
	sub37:sub al,07h
	sub30:sub al,30h
	
	add bx,ax
	inc rsi
	dec rcx 
	jnz next_byte
ret
error:
	print msg3,msg3_l	
	exit
Display:

	mov rbx,10
	mov rcx,4
	mov rsi,char_ans+3
	
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
	print char_ans,4
ret
	
