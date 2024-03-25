section .txt

	global _start

_start:
	mov eax, 0x20
	push big
	mov [big], eax
	mov [real+1], eax
	mov eax, 1 
	syscall

section .bss
	big RESB 32
	real RESD 64
	str_1 RESB 20
section .data
	hack TIMES 5 db 'hack'
