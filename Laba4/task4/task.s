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
test edx, 10000000000000000000000000b
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
test edx, 100000000000000000000000000b
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
test ebx, 100000b
jne AVX2
je noAVX2
AVX2:
	call da
	jmp metka2
noAVX2:
	call net
metka2:

mov eax, 7
mov ecx, 0
test ebx, 10000000000000000
jne da
je net

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
msg: db "SSE/SSE2/AVX2/AVXF: ", 0xa
len EQU $ - msg
;=================================
