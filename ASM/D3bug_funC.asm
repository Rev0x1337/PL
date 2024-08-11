format pe console
include '.\include\win32ax.inc'
entry start
;//------------
.data
txt_login1    db  'Login:',0
txt_password1  db  'Password: ',0
type    db  '%s',0
login1      db  0,0,0,0,0,0,0,0,0,0,0

password1      db 0,0,0,0,0,0,0,0,0,0,0
res_pass DB 0,"A",0,"A","A",0,"A",0,"N","f",0,0
maxlen   DB 10
not_equ DB 10,13,"Fail! ", 24h
okmes DB 10,13,"Good! ", 24h

      RESULT  DB 'f','A','I','L','!',0
      OK_FAIL DB 0

;//------------
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
        push 10
        push txt_login1
        call [printf]
        add esp, 4
        push login1
        push type
        call [scanf]
        add esp, 8
        push 10
        push txt_password1
        call [printf]
        add esp, 4
        push password1
        push type
        call [scanf]
        add esp, 8

        xor eax,eax
        lea esi, [login1]
        mov ecx,10
        xor edx,edx
label0:
        mov ax,[esi]
        inc esi
        cmp ax,0
        je ex0
        inc edx
        loop label0
ex0:
        xor ah,ah
        mov ah,[maxlen]
        cmp ah,dl
        jg  RESMES
        cmp dl,0
        je  RESMES
        lea esi, [login1]
        lea edi, [password1]
        push 0
        pop ebx
        mov ecx,10
label1:
        xor eax,eax
        mov al, [esi]
        add bx,ax
        inc esi
        loop label1

        push 0
        pop edx
        mov ecx,10
label2:
        xor eax,eax
        mov al, [edi]
        add dx,ax
        inc edi
        loop label2
        sub ebx,edx
        jnz next1
        lea esi,[OK_FAIL]
        push 0001
        pop eax
        mov [esi],eax
next1:
        lea esi, [login1]
        lea edi, [password1]
        mov ecx,10
label3:
        xor eax,eax
        mov al, [esi]
        shr al,2
        add al,25
        push eax
        inc esi
        loop label3
        xor edx,edx
        mov ecx,5
label4:
        xor eax,eax
        xor ebx,ebx
        mov al, [edi]
        pop ebx
        xor eax,ebx
        jnz nxt2
        jmp nxt3
nxt2:
        inc edx
nxt3:
        inc edi
        loop label4
        lea esi,[OK_FAIL]
        cmp edx,0
        jg nxt4
        push 0001
        pop eax
        mov [esi],eax
nxt4:

        mov eax, [fs:18h]
        mov eax, [eax+30h]
        movzx eax, byte [eax+2]
        or eax, eax
        je ndb2
        push 254
        pop eax
        mov [esi],eax
ndb2:
        pop ebx
        inc ebx
        pop ebx
        mov eax,ebx
        xor ebx,eax
        pop eax
        pop ebx
        mov ecx,5
label5:
        xor eax,eax
        xor ebx,ebx
        mov al, [edi]
        xor eax,ebx
        inc edi
        loop label5
        pop eax
        add eax,25
        sub eax,10
        jz notequ
        jmp RESMES
RESMES:

LEA ESI, [OK_FAIL]

mov eax, [fs:18h]
add eax,32h
dec eax
dec eax
mov eax, [eax]
ADD eax,108
SUB eax,4
movzx eax, byte [eax]
;cmp eax, 0
inc eax
mov [ESI],al
MOV AL,[ESI]
CMP AL,1
JE OK_MES

PUSH EAX
PUSH ESI
LEA ESI,[RESULT]
XOR EAX,EAX
MOV AL,13H
ADD AL,33H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,20H
ADD AL,21H
ADD AL,20H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,20H
ADD AL,20H
ADD AL,29H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,20H
ADD AL,20H
ADD AL,2CH
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,1H
ADD AL,20H
MOV [ESI],AL
POP ESI
POP EAX
JMP PRINT

OK_MES:

PUSH EAX
PUSH ESI
LEA ESI,[RESULT]
XOR EAX,EAX
MOV AL,23H
ADD AL,24H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,20H
ADD AL,2FH
ADD AL,20H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,30H
ADD AL,2FH
ADD AL,10H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,20H
ADD AL,24H
ADD AL,20H
MOV [ESI],AL

XOR EAX,EAX
INC ESI
MOV AL,10H
ADD AL,11H
MOV [ESI],AL
POP ESI
POP EAX

PRINT:
      jmp notequ

notequ:
;        push 10
        push RESULT
        call [printf]
        add esp, 4
;        cinvoke  getch
        call [getch]
         pop ecx
         pop ebx
;        invoke  ExitProcess,0
         push 0
         call [ExitProcess]


         ret





;//------------
section '.idata' import data readable
library  kernel32,'kernel32.dll',msvcrt,'msvcrt.dll'
import   msvcrt,printf,'printf',getch,'_getch',scanf,'scanf'
include  '.\INCLUDE\api\kernel32.inc'
