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





 ;bx
print_bx proc
    push ax
    push cx
    push dx
     mov ch,4
d2:   
     mov cl,4
     rol bx,cl
     mov dl,bl
     and dl,0fh
     add dl,30h
     cmp dl,39h
     jbe d1
     add dl,7
d1:         
    mov ah,2
    int 21h
    dec ch
    jnz d2
    pop dx
    pop cx
    pop ax
    ret 
print_bx endp
;bl 
print_bl proc
    push ax
    push cx
    push dx
    mov ch,2
l22:   
     mov cl,4
     rol bl,cl
     mov dl,bl
     and dl,0fh
     add dl,30h
     cmp dl,39h
     jbe l11
     add dl,7
l11:         
    mov ah,2
    int 21h
    
    dec ch
    jnz l22
    pop dx
    pop cx
    pop ax
    ret 
print_bl endp
code ends
end start