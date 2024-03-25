section .txt

	global _start

_start:

	push big
	push pi
	push str_1

	mov eax, 1
	syscall

section .data

	big DD 1337133713
	pi DD 3.141592
	str_1 DB 'Assembly'
