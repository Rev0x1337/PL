; If the line contains ">", then "YES" is displayed, if not, then "NO" is displayed.

extern ExitProcess
extern ReadConsoleA
extern WriteConsoleA
extern GetStdHandle

STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
lpReserved EQU 0
EXIT_CODE EQU 0

section .txt
  global _start

_start:
  
  xor edx, edx
  push STD_INPUT_HANDLE
  call GetStdHandle
  
  push lpReserved
  push read
  push 6
  push BUF
  push eax
  call ReadConsoleA
  
  mov eax, len_BUF
  mov ecx, eax
  mov eax, '>'
  mov edi, BUF
  cld
  repne scasb
  
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

  read dd 0
  BUF db 0, 0, 0, 0, 0, 0, 0
  len_BUF EQU $-BUF
  Yess db 'Yes!'
  Yess_len EQU $-Yess
  Noo db 'No :('
  No_len EQU $-Noo

