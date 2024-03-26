EXIT_SYSCALL EQU 1
%assign var_1 -10
%assign var_2 25
%define var_elem 5

section .data
	var TIMES var_elem dw 0

section .text

	global _start

_start:

	mov eax, var_1
	mov ebx, 10
	add eax, ebx

	mov [var], ebx
	inc ebx
	mov [var+2], ebx

	mov ebp, var
	mov [ebp+4], 15
	mov [ebp+3], byte var_2

	mov eax, EXIT_SYSCALL
	syscall
