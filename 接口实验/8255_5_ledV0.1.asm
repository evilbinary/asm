data segment
    cw db 88h
    porta dw 280h
    portb dw 281h
    portc dw 282h
    portcon dw 283h
    lednum db 03fh,06h,5bh,4fh,066h,6dh,7dh,07h,7fh,6fh
    count db 10
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
    mov bx,offset lednum
    mov al,0
l:
    mov dx,portc
    in al,dx
    test al,80h
    jnz l
    mov al,count
    xlat lednum
    mov dx,porta
    out dx,al
    dec count
    
 l1:
    mov dx,portc
    in al,dx
    test al,80h
    jz l1
    loop l
    
    mov ah,4ch
    int 21h

code ends
end start