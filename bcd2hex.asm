%macro print 2
		mov rax,1
		mov rdi,1
		mov rsi,%1
		mov rdx,%2
		syscall
%endmacro
%macro read 2
	mov rax,00
	mov rdi,00
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro exit 0
		mov rax,60
		mov rdx,00
		syscall
%endmacro
section .bss
	
	
	
	
	
	
	
section .data
	
section .text
global _start
_start:
		print 
									



bdc_hex:
        //print
    read buf,6
    mov rsi buf
    xor ax,ax
    mov rbp,5
    mov rbx,10

next:
    xor cx,cx
    mul bx
    mov cl,[rsi]
    sub cl,cx
    inc rsi
    dec rbp
    jnz next
    mov [ans] ,ax
            
display:
	  mov rbx,16
	  mov rcx,2
	  mov rsi,char_ans+1	
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
		print char_ans,2
		ret
		

