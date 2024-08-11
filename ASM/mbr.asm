
#make_boot#

org 7c00h 
start:   
    mov cx,0x10
    lea si, text1
    mov ah,0x0e 
l0:
    lodsb
    int 10h
    test al,al
    loopnz l0  
        
    lea si,username   
    mov cx,10 
l1:
    mov ah, 00h    
    int 16h   
    cmp al,13
    je ex0
    mov [si],al
    inc si   
    loop l1
ex0:    
    mov cx,0x11
    lea si, text2
    mov ah,0x0e 
l2:
    lodsb
    int 10h
    test al,al
    loopnz l2  
        
    lea si,password   
    mov cx,10  
l3:
    mov ah, 00h    
    int 16h
    cmp al,13
    je ex1    
    mov [si],al
    inc si   
    loop l3
        
ex1: 
    lea si,lives 
    mov bh,[si]
    lea di, key
    mov bl,[di]
    push si 
    lea di,username
    lea si, user     
    mov cx, 10
l4:
    mov al,[di]
    cmp al,13     
    je ex2  
    cmp al,0     
    je ex2 
    xor al,bl
    mov ah,[si]
    cmp al,ah     
    jne wrong1
    inc si
    inc di
    loop l4     
ex2:
    lea di,password
    lea si, pass 
    mov cx, 10
l5:
    mov al,[di]
    cmp al,13     
    je ex3     
    cmp al,0
    je ex3 
    xor al,bl 
    mov ah,[si]
    cmp al,ah
    jne wrong1  
    inc si
    inc di
    loop l5
        
wrong1:    
    pop si
    dec bh
    cmp bh,0
    je ProcessOtherKey   
    mov [si],bh
    jmp start

ex3:           
           
ok:     
    pop si    
    

;    INT 19h 
;   jmp to_os_load

    
ProcessOtherKey:                     
    jmp $


text1 db 'Enter username: ',0   
username db 0,0,0,0,0,0,0,0,0,0                  
text2 db 10,'Enter password: ',0   
password db 0,0,0,0,0,0,0,0,0,0    
user db 0xce, 0xcb, 0xc2, 0xc6, 0xc1,0
pass db 0xdf, 0xef, 0xdc, 0xdc, 0xd8, 0x9f, 0xdd, 0xcb,0     
key db 0xaf     
lives db 3 
text3 db 'Password OK!: ',0    
db (510-($-start)) dup (0)
db 0x55, 0xAA
