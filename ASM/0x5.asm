extern GetStdHandle
extern WriteConcoleA
extern ExitProcess

STD_OUTPUT_HANDLE EQU -11
lpReserved EQU 0
EXIT_CODE EQU 0

section .text
	global _start

_start:

	mov eax, 1
	add [var], eax
	inc eax
	sub [var], eax
	dec byte [var]
	add [var], byte '0'

	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov ebx, eax

	push lpReserved
	lea eax, write
	push eax
	...

section .data
	var db 3
	var_len EQU $-var

	str_1_w db 'Hello!!!!', 0xA
	str_1_w_len EQU $-str_1_w
	write dd 0
