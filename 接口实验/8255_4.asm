data segment
    cw db 88h
    porta dw 280h
    portb dw 281h
    portc dw 282h
    portcon dw 283h
    stepnum db 0ch,06h,03h,09h
    i db 0
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    xor dx,dx
    xor ax,ax
    
    mov al,cw
    mov dx,portcon
    out dx,al
   
a2:
    mov dx,portc
    in al,dx
    test al,80h
    jz a1 
    
    mov bx,offset stepnum 
    mov cx,1
    cmp i,4
    jb t2
    mov i,0
 t2:
    call turn
    inc i 
    jmp a2
 a1:  
    mov cx,1
    cmp i,0
    ja t3
    mov i,4
t3:
    call turn
    dec i  
    jmp a2
    mov ah,4ch
    int 21h
    
turn proc  
t1:
    mov al,i
    xlat
    mov dx,porta
    out dx,al
    call delay
    loop t1
    ret
turn endp

delay proc
    push cx
    push dx
    mov cx,100
d1:
    mov dx,1000
d2:
    dec dx
    jnz d2
    loop d1
    pop dx
    pop cx
    ret
delay endp

 


code ends
end start