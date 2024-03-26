EXIT_SYSCALL EQU 1
%assign VAR 0x20
%define time 5

section .text
	global _start

_start:
	mov eax, VAR
	push big
	mov [big], eax
	mov [real+1], eax

	mov eax, EXIT_SYSCALL

	syscall

section .bss
	big RESB 32
	real RESD 64
	str_1 RESB 20

section .data

	assembly TIMES time db 'assembly'
