section .text
extern printf ;библиотечная функция
extern putchar 
global main
main: ;точка входа
; PROLOG
push rbp
mov rbp, rsp
mov rax, 1
mov rdi, 1
mov rsi, msg
mov rdx, len
syscall

mov eax, 1
cpuid
test ecx, 00000010000000000000000000000000b
jne AES
je noAES
AES:
	call da
	jmp metka
noAES:
	call net

metka:
mov eax, 1
cpuid
test ecx, 01000000000000000000000000000000b
jne rrand
je norrand
rrand:
	call da
	jmp metka1
norrand:
	call net

; PREPARE RETURN VALUE  ;return value from main rax=0
; EPILOG

metka1:
mov eax, 7
mov ecx, 0
cpuid
test ebx, 001000000000000000000000000000000b
je da
jne net

pop rbp
ret
da:
 	mov rdi, 0x31
 	call putchar wrt ..plt
	ret

net:
	mov rdi, 0x30
	call putchar wrt ..plt
	ret
	
;=======секция констант===========
section .rodata
buffer: db "000", 0xa, 0
msg: db "AES/RDSEED/SHA: ", 0xa
len EQU $ - msg
;=================================
