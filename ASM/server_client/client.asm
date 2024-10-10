.586P
.MODEL FLAT, stdcall
STD_OUTPUT_HANDLE equ -11
EXTERN  connect@12:NEAR
EXTERN  gethostbyname@4:NEAR
EXTERN  shutdown@8:NEAR
EXTERN  recv@16:NEAR
EXTERN  send@16:NEAR
EXTERN  accept@12:NEAR
EXTERN  listen@8:NEAR
EXTERN  bind@12:NEAR
EXTERN  closesocket@4:NEAR
EXTERN  socket@12:NEAR
EXTERN  CharToOemA@8:NEAR
EXTERN  WSAStartup@8:NEAR
EXTERN  wsprintfA:NEAR
EXTERN  GetLastError@0:NEAR 
EXTERN  ExitProcess@4:NEAR
EXTERN  lstrlenA@4:NEAR
EXTERN  WriteConsoleA@20:NEAR
EXTERN  GetStdHandle@4:NEAR

includelib c:\masm32\lib\user32.lib
includelib c:\masm32\lib\kernel32.lib
includelib c:\masm32\lib\ws2_32.lib

;-----------------------------------------------

WSADATA STRUCT
wVersion	WORD	?
wHighVersion	WORD	?
szDescription	BYTE 257 dup (?)
szSystemStatus	BYTE 129 dup (?)
iMaxSockets	WORD	?
iMaxUdpDg	WORD	?
lpVendorInfo	DWORD	?
WSADATA ENDS
;-----------------------------------------------
S_UN_B STRUCT
s_b1 BYTE 0
s_b2 BYTE 0
s_b3 BYTE 0
s_b4 BYTE 0
S_UN_B ENDS

S_UN_W STRUCT 
s_w1 WORD 0
s_w2 WORD 0
S_UN_W ENDS

ADDRESS_UNION UNION 
s_u_b S_UN_b <>
s_u_w S_UN_w <>
s_addr DWORD 0
ADDRESS_UNION ENDS

in_addr STRUCT
s_un ADDRESS_UNION <>
in_addr ENDS

sockaddr_in STRUCT
sin_family    WORD      0
sin_port      WORD      0
sin_addr      in_addr <>
sin_zero      BYTE 8 dup (0)
sockaddr_in ENDS

hostent STRUCT
h_name      DWORD      ?
h_alias     DWORD      ?
h_addr      WORD       ?
h_len       WORD       ?
h_list      DWORD      ?
hostent ENDS

;-----------------------------------------------

;ñåãìåíò äàííûõ
_DATA SEGMENT 
	HANDL DD ?
	LENS  DD ?
	ERRS    DB "Error %u ",0
	IP      DB "IP address %hu.%hu.%hu.%hu",0
	IPA     DD ?
	S1 DD ?
	S2    DD ?
	comp DB "ya.ru",0
	txt  DB "Data from client",0
	txt1 DB "IP address",0
	LEN  DD ?
	sin2 sockaddr_in <0>
	hp   hostent <0>
	BUF DB  100 DUP(0)
	BUF1 DB  100 DUP(0)
	wsd  WSADATA <0>
_DATA ENDS

_TEXT SEGMENT 
START:

	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle@4
	MOV  HANDL,EAX

	PUSH OFFSET wsd
	MOV  EAX,0
	MOV  AX,0202H
	PUSH EAX
	CALL WSAStartup@8	
	CMP  EAX,0
	JZ   NO_ER1
	CALL ERRO
	JMP  EXI
NO_ER1:

	PUSH OFFSET comp
	CALL gethostbyname@4
	CMP  EAX,0
	JNZ  NO_ER2
	CALL ERRO
	JMP  EXI
NO_ER2:

	MOV  EBX,[EAX+12]
	MOV  EDX,[EBX]
	MOV  EDX,[EDX]
	MOV  IPA,EDX 
	SHR  EDX,24
	AND  EDX,000000FFH
	PUSH EDX
	MOV  EDX,IPA
	SHR  EDX,16
	AND  EDX,000000FFH
	PUSH EDX
	MOV  EDX,IPA
	SHR  EDX,8
	AND  EDX,000000FFH
	PUSH EDX
	MOV  EDX,IPA
	AND  EDX,000000FFH
	PUSH EDX
	PUSH OFFSET IP
	PUSH OFFSET BUF1
	CALL wsprintfA
	ADD  ESP,24
	LEA  EAX,BUF1
	MOV  EDI,1
	CALL WRITE
	MOV  EDX,IPA
	MOV  sin2.sin_addr.s_un.s_addr,EDX
	MOV  sin2.sin_port,2000	
	MOV  sin2.sin_family,2 

	PUSH 0
	PUSH 1  ;SOCK_STREAM	
	PUSH 2  ;AF_INET
	CALL socket@12
	CMP  EAX, NOT 0
	JNZ  NO_ER3
	CALL ERRO
	JMP  EXI	
NO_ER3:
	MOV  s1,EAX

	PUSH sizeof(sockaddr_in)		
	PUSH OFFSET sin2
	PUSH s1
	CALL connect@12
	CMP  EAX, 0
	JZ   NO_ER4
	CALL ERRO
	JMP  CLOS	
NO_ER4:

	PUSH 0
	PUSH 100
	PUSH OFFSET buf
	PUSH s1
	CALL recv@16

	PUSH OFFSET buf1
	PUSH OFFSET buf
	CALL CharToOemA@8

	LEA  EAX,BUF1
	MOV  EDI,1
	CALL WRITE

	PUSH 0
	PUSH OFFSET txt
	CALL lstrlenA@4
	PUSH EAX
	PUSH OFFSET txt
	PUSH s1
	CALL send@16
	;æäåì îòâåòà
	PUSH 0
	PUSH 100
	PUSH OFFSET buf
	PUSH s2
	CALL recv@16 
	;â íà÷àëå ïåðåêîäèðîâêà
	PUSH OFFSET buf1
	PUSH OFFSET buf
	CALL CharToOemA@8
;	LEA  EAX,BUF1
;	MOV  EDI,1
;	CALL WRITE
CLOS:
	PUSH S1
	CALL closesocket@4
EXI:
	PUSH 0
 	CALL ExitProcess@4
;EAX - íà íà÷àëî ñòðîêè      
;EDI - ñ ïåðåâîäîì ñòðîêè èëè áåç
WRITE   PROC
PUSH  EAX
PUSH  EAX
CALL  lstrlenA@4
MOV   ESI,EAX 
POP   EBX
CMP   EDI,1
JNE   NO_ENT 
MOV  BYTE PTR [EBX+ESI],13
MOV  BYTE PTR [EBX+ESI+1],10
MOV  BYTE PTR [EBX+ESI+2],0
ADD  EAX,2
NO_ENT:
PUSH 0
PUSH OFFSET LENS
PUSH EAX
PUSH EBX
PUSH HANDL
CALL WriteConsoleA@20
RET
WRITE   ENDP
ERRO    PROC
CALL GetLastError@0
PUSH EAX
	PUSH OFFSET ERRS
	PUSH OFFSET BUF1
	CALL wsprintfA
	ADD  ESP,12
	LEA  EAX,BUF1
	MOV  EDI,1
	CALL WRITE
	RET
ERRO    ENDP
_TEXT ENDS
END START
