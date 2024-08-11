ORG 100h
jmp start

str: DB 'A', 'S', 'S', 'E','M','B','L','E','R'          
buf: DB 0,0,0,0,0,0,0,0,0,0Dh,0Ah, 24h

start:
LEA SI, str
LEA BX, buf
;MOV CX, 9   
MOV CX, 25
ADD BX, CX
DEC BX      
   

mem1: 
LODSB   
mov [BX],AL
DEC BX
LOOP mem1

MOV  dx, buf
MOV  ah, 09h 
INT  21h      
MOV  ah, 0 
INT  16h 
RET
