STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
lpReserved EQU 0

extern ExitProcess
extern ReadConsoleA
extern WriteConsoleA
extern GetStdHandle

section .txt
	global _start

_start:
	
	push STD_INPUT_HANDLE
	call GetStdHandle
	
	push lpReserved
	push read
	push 6
	push BUF
	push eax
	call ReadConsoleA
	
	mov ecx, str1_len
	mov esi, BUF
	mov edi, str1
	rep cmpsb
	jz Yes
	jmp No
	
Yes:
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov ebx, eax
	
	push lpReserved
	push 0
	push Yess_len
	push Yess
	push ebx
	call WriteConsoleA
	push 0 
	call ExitProcess
No:
	push STD_OUTPUT_HANDLE
	call GetStdHandle
	mov ebx, eax
	
	push lpReserved
	push 0
	push No_len
	push Noo
	push ebx
	call WriteConsoleA 
	push 0
	call ExitProcess


section .data
	str1 db 'CODEBY', 0
	str1_len EQU $-str1-1
	BUF db 0, 0, 0, 0, 0, 0, 
	read dd 0
	Yess db 'Yes!'
	Yess_len EQU $-Yess
	Noo db 'No :('
	No_len EQU $-Noo
