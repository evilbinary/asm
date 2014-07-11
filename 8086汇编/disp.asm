data segment
data ends
code segment
start:
    assume cs:code,ds:data
    xor ax,ax
    mov bx,0aeach
    call disp
    mov ah,1
    int 21h 
    mov ah,04ch
    int 21h
disp proc
    push ax
    push cx
    push dx
     mov ch,4
l2:   
     mov cl,4
     rol bx,cl
     mov dl,bl
     and dl,0fh
     add dl,30h
     cmp dl,39h
     jbe l1
     add dl,7
l1:         
    mov ah,2
    int 21h
    dec ch
    jnz l2
    pop dx
    pop cx
    pop ax
    ret 
disp endp
code ends
end start