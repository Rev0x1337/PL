org 100h
jmp start
msg:    db      "Hello, World!", 0Dh,0Ah, 24h   
hidden:    db      "Hidden content!", 0Dh,0Ah, 24h 
start:
    call proc1
ret 
   
proc proc1     
        mov     dx, msg
        mov     ah, 09h 
        int     21h      
        mov     ah, 0 
        int     16h  
        push     hide
        ret       
        
proc    hide
        mov     dx, hidden
        mov     ah, 09h 
        int     21h      
        mov     ah, 0 
        int     16h  
        ret
