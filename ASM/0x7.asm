;ret & call
section .text

	global _start

_start:

	mov eax, 999
	mov ebx, 100
	call mul
	mov [res], eax
	nop

mul:
	imul eax, ebx
	ret

section .data

	res dd 0 
