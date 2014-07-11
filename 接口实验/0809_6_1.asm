data segment
    a db 512 dup(0)
    b db 512 dup(0)
    portcon dw 293h
    portc dw 292h
data ends
code segment
assume cs:code ,ds:data
start:
    mov ax,data
    mov ds,ax
    xor dx,dx
    xor ax,ax
    
    
    lea si,a
    mov cx,512
l:    
    mov dx,280h
    mov al,0h
    out dx,al
    
    mov dx,280h
    in al,dx
    ;mov al,0ffh
    mov dl,al
    mov [si],al
    inc si
    ;call display
    call delay
    dec cx
    jnz l
    
    lea si,a
    mov cx,512
    call output
    
    mov ah,4ch
    int 21h
    
    
output proc     ;si cx
    push cx
    push si
o1:
    mov dl,[si]
    call display
    mov dl,20h
    mov ah,02h
    int 21h
    
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
    pop dx
    pop cx
    pop bx
    ret
display endp
code ends
end start