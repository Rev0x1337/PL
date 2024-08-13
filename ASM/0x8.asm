name "flags"

ORG 100h

    LEA BX, label1
    mov CX,00feh   ; 254    
    LEA SI, low
    mov DL, [SI] 
    LEA SI, high
    mov DH, [SI]
all_symb1:       
    cmp   CL, DH
    Jb high_bord ;CL < DH 
    jmp nothing1 
high_bord:
    cmp   CL, DL     
    Ja toarray ; CL > DL 
     
    jmp nothing1
       
toarray:    
    mov [BX],CL  
    inc BX     
    
nothing1:    
    LOOP all_symb1
    
    mov CX,result-label1 ; label1 length    
    LEA SI, dig_low
    mov DL, [SI] 
    LEA SI, dig_high
    mov DH, [SI]   
    LEA SI, result-3  ; from end to start    
    MOV BX, [SI] 
from_label1:       
    MOV BX, [SI]
    PUSH SI
    cmp   BL, DH
    Jb high_dig ; < high 
    
    jmp nothing3 
high_dig:
    cmp   BL, DL     
    Ja check_dig1 ; low < 
     
    jmp nothing3     

check_dig1:
    PUSH AX 
    PUSH BX
    XOR AX,AX  
    MOV SI,offset parity   
    MOV AX,[SI]
    XOR AL,BL   
    CMP AL,0
    JE nothing2
    
chk_mod:
    CMP AL,2
    JL chk_parity
    DEC AL
    DEC AL
    JMP chk_mod
chk_parity:
    CMP AL,0
    JG nothing2 

print_dig1:  
    PUSH BX
    PUSH DX
    LEA  SI, result
    MOV  [SI],BL 
    MOV  dx, result
    MOV  ah, 09h 
    INT  21h
    POP DX
    POP BX   
    
nothing2:    
    POP BX
    POP AX     

nothing3:
    PUSH AX
    PUSH DX
    PUSH CX
     
    LEA SI, alp1_low
    mov DL, [SI] 
    LEA SI, alp1_high
    mov DH, [SI]       
    cmp   BL, DH
    Jbe high_alp ; < high 
    
    jmp nothing4 
high_alp:
    cmp   BL, DL     
    Jae print_alp1 ; low < 
     
    jmp nothing4         
        
print_alp1:  
       

    LEA  SI, result
    MOV  [SI],BL 
    MOV  dx, result
    MOV  ah, 09h 
    INT  21h
    
    PUSH BX

    XOR  AX, AX  
    LEA  SI, shift
    mov  AL, [SI]     
    XOR  BL,AL
 
    LEA  SI, result 
    MOV  [SI],BL 
    MOV  dx, result
    MOV  ah, 09h 
    INT  21h 
    POP  BX    
    
nothing4: 
    POP CX
    POP DX
    POP AX  

    POP SI
    DEC SI    
    loop from_label1

    MOV  dx, cr
    MOV  ah, 09h 
    INT  21h
             
    MOV  dx, cr
    MOV  ah, 09h 
    INT  21h
    
    MOV  dx, label1
    MOV  ah, 09h 
    INT  21h      
    MOV  ah, 0 
    INT  16h 
    RET
    
label1: DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0Dh,0Ah, 24h         
result: DB 0,24h
cr:     DB 0Dh,0Ah, 24h
     
low:     DB 20h ; SPACE
high:    DB 7dh ; ~         
dig_low: DB 2Fh
dig_high:   DB 3Ah   
parity:     DB 30h
alp1_low:    DB 41h
alp1_high:   DB 5ah   
shift:       DB 20h


