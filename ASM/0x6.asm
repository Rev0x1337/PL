format pe console
include '.\include\win32ax.inc'
entry start

.data
txt_login1	db 'Login: ',0
txt_password1	db 'Password: ',0
type 		db '%s',0
login1		db 0,0,0,0,0,0,0,0,0,0,0
password1	db 0,0,0,0,0,0,0,0,0,0,0
res_pass 	db 0,"A",0,"A","A",0,"A",0,"N","f",0,0
maxlen 		db 10
not_equ 	db 10,13,"Fail!", 24h
okmes		db 10,13,"Good!", 24h

	RESULT 	db 'f','A','I','L','!',0
	OK_FAIL	db 0


.code
start:

	call [IsDebuggerPresent]
	add esp, 4
	cmp eax, 0
	je No_debug
		push 0
		call [ExitProcess]

No_debug:
	
	push ebx
	push ecx
	push txt_login1
	call [printf]
	add esp, 4
	push login1
	push type
	call [scanf]
	add esp, 8
		;push 10
	push txt_password1
	call [printf]
	add esp, 4
	push password1
	push type
	call [printf]
	add esp, 8

	xor eax, eax
	lea esi, [login1]
	mov ecx, 10
	xor edx, edx

label0:
	
	mov ax, [esi]
	inc esi
	cmp ax, 0
	je ex0
	inc edx
	loop labe10

ex0:

	xor ah,ah
	mov ah, [maxlen]
	cmp ah, dl
	jg RESMES
	lea esi, [login1]
	lea edi, [password1]
	push 0
	pop ebx
	mov ecx, 10

label1:
	
	xor eax, eax
	mov al, [esi]
	add bx, ax
	inc esi
	loop label1

	push 0
	pop edx
	mov ecx, 10

label2:

	xor eax, eax
	mov al, [edi]
	add dx, ax
	inc edi
	loop label2
	sub ebx, edx
	jnz next1
	lea esi, [OK_FAIL]
	push 0001
	pop eax
	mov [esi], eax

next1:

	lea esi, [login1]
	lea edi, [password1]
	mov ecx, 10

label3:

	xor eax, eax
	mov al, [esi]
	shr al, 2
	add al, 25
	push eax
	inc esi
	loop label3
	xor edx, edx
	mov ecx, 5

label4:

	xor eax, eax
	xor ebx, ebx
	mov al, [edi]
	pop ebx
	xor eax, ebx
	jnz nxt2
	jmp nxt3

nxt2:
	
	inc edx

nxt3:

	inc edi
	loop label4
	lea esi, [OK_FAIL]
	cmp edx, 0
	jg nxt4
	push 0001
	pop eax
	mov [esi], eax

nxt4:

	mov eax, [fs:18h]
	mov eax, [eax+30]
	movzx eax, byte [eax+2]
	or eax, eax
	je ndb2
	mov [esi], eax

ndb2:

	pop ebx
	inc ebx
	pop ebx
	mov eax, ebx
	xor ebx, eax
	pop eax
	pop ebx
	mov ecx, 5

label5:

	xor eax, eax
	xor ebx, ebx
	mov al, [edi]
	xor eax, ebx
	inc edi
	loop label5
	pop eax
	add eax, 25
	sub eax, 10
	jz notequ
	jmp RESMES

RESMES:

	lea esi, [OK_FAIL]
	mov al, [esi]
	cmp al, 1
	je OK_MES

	push eax
	push esi
	lea esi, [RESULT]
	xor eax, eax
	mov al, 13h
	add al, 33h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 20h
	add al, 21h
	add al, 20h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 20h
	add al, 20h
	add al, 29h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 20h
	add al, 20h
	add al, 2ch
	mov [esi], al
	
	xor eax, eax
	inc esi
	mov al, 1h
	add al, 20h
	mov [esi], al
	pop esi
	pop eax
	jmp PRINT

PRINT:
	
	jmp notequ

OK_MES:

	push eax
	push esi
	lea esi, [RESULT]
	xor eax, eax
	mov al, 23h
	add al, 24h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 20h
	add al, 2fh
	add al, 20h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 30h
	add al, 2fh
	add al, 10h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 20h
	add al, 24k
	add al, 20h
	mov [esi], al

	xor eax, eax
	inc esi
	mov al, 10h
	add al, 11h
	mov [esi], al
	pop esi
	pop eax

notequ:

	push RESULT
	call [printf]
	add esp, 4
	call [getch]
		pop ecx
		pop ebx
		push 0
		call [ExitProcess]

		ret

section '.idata' import data readable
library kernel32,'kernel32.dll',msvcrt,'msvcrt.dll'
import msvcrt,printf,'printf',getch,'_getch',scanf,'scanf'
include '.\INCLUDE\api\kernel32.inc'

	


