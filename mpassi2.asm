section .bss
		char_ans resb 2
		char_anslen equ $-char_ans
			
section .data
		sblock db 10h,12h,14h,16h,18h
		dblock times 5 db 0
		n equ 5
		msg1 db 10,"Before block transfer:",10
		msg1_len equ $-msg1
		msg2 db 10,"Source block is:"
		msg2_len equ $-msg2
		msg3 db 10,"Destination block is:"
		msg3_len equ $-msg3
		msg4 db 10,"After block transfer:",10
		msg4_len equ $-msg4
      msg5 db " "
		msg5_len equ $-msg5
		msg6 db 10,10
		msg6_len equ $-msg6
		
%macro print 2
		mov rax,1
		mov rdi,1
		mov rsi,%1
		mov rdx,%2
		syscall
%endmacro


%macro exit 0
		mov rax,60
		mov rdx,00
		syscall
%endmacro

section .text
global _start
_start:
		print msg1,msg1_len
		print msg2,msg2_len
		mov rsi,sblock
		call disp_block
		print msg3,msg3_len
		mov rsi,dblock
		call disp_block
		print msg6,msg6_len
		call block_transfer
		print msg4,msg4_len
		print msg2,msg2_len
		mov rsi,sblock
		call disp_block
		print msg3,msg3_len
		mov rsi,dblock
		call disp_block
		print msg6,msg6_len
	   exit
		
block_transfer:
			mov rsi,sblock
			mov rdi,dblock
			mov rcx,5
		back:
			mov al,[rsi]
			mov [rdi],al
			inc rsi
			inc rdi
			dec rcx
			jnz back
			ret
			
disp_block:
			mov rbp,5
		next_num:
			mov al,[rsi]
			push rsi
			call display
			print msg5,msg5_len
			pop rsi
			inc rsi
			dec rbp
			jnz next_num
			ret
			
			
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





