org 100h
jmp start

str: db 'A', 'S', 'S', 'E','M','B','L','E','R'          
buf: db 0,0,0,0,0,0,0,0,0,0dh,0ah, 24h

start:
lea si, str
lea bx, buf
;mov cx, 9   
mov cx, 25
add bx, CX
dec bx      
   

mem1: 
lodsb   
mov [bx],al
dec bx
loop mem1

mov  dx, buf
mov  ah, 09h 
int  21h      
mov  ah, 0 
int  16h 
ren
