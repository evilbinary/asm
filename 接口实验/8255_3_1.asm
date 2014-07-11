data segment
    cw db 8bh
    porta dw 280h
    portb dw 281h
    portc dw 282h
    portcon dw 283h
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
    mov cx,10
l:
    mov dx,portc
    in al,dx
    test al,002h
    jnz l
    mov dx,portb
    in al,dx
    push cx
    mov cl,4
    shl al,cl
    pop cx
    mov dx,porta
    out dx,al
l1:
    mov dx,portc
    in al,dx
    test al,02h
    jz l1
    loop l
    mov ah,4ch
    int 21h
code ends
end start