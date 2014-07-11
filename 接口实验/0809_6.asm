data segment
    a db 512 dup(0)
    a1 db 512 dup(0)
    portcon dw 293h
    portc dw 292h
    cw db 89h
    t db 0
data ends
code segment
assume cs:code ,ds:data
start:
    mov ax,data
    mov ds,ax
    xor dx,dx
    xor ax,ax
    
    mov dx,portcon 
    mov al,cw
    out dx,al
lg:
 
l: 
    mov dx,portc
    in al,dx
    test al,80h
    jz l3
    
    mov dx,280h
    mov al,0h
    out dx,al
    mov dx,280h
    in al,dx
    mov t,al
    jmp l2
l3:         
    mov dx,281h
    mov al,0h
    out dx,al
    mov dx,281h
    in al,dx
    mov t,al
l2:
    mov dx,portc
    in al,dx
    test al,01h
    jz l2
    mov dl,t
    call display
   
    jmp lg
    
    ;lea si,a
    ;mov cx,512
    ;call output
    
    mov ah,4ch
    int 21h
   
 
output proc     ;si cx
    push cx
    push si
o1:
    mov dl,[si]
    call display
    
    
    inc si
    loop o1
    pop si
    pop cx
    ret
output endp

delay proc
    push bx
    push cx
    mov cx,100
d2:
    mov bx,100
d1:
    nop
    dec bx
    jnz d1
    loop d2  
    pop cx
    pop bx  
    ret
delay endp     
  
display proc    ;dl
    push bx
    push cx
    push dx
    mov dh,dl
    mov cl,4
    shr dl,cl
    and dh,0fh
    mov bx,2
dd2:
    cmp dl,9
    jbe dd1
    add dl,7
dd1:
    add dl,30h
    ;mov al,dl
    mov ah,02h
    int 21h
    mov dl,dh
    dec bx
    jnz dd2
    mov dl,20h
    mov ah,02h
    int 21h
    pop dx
    pop cx
    pop bx
    ret
display endp
code ends
end start