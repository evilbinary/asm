data segment
data ends
code segment
start:
    assume cs:code,ds:data
    mov ax,data
    mov ds,ax
    call input
    call disp
    mov ah,04ch
    int 21h
;bx/bl
input proc
    push ax
    push cx
    mov ch,4
    mov cl,4
l00:
    shl bx,cl
    mov ah,1
    int 21h
    sub al,30h
    cmp al,9
    jbe l11
    sub al,7
l11:
    or bl,al
    dec ch
    jnz l00
    pop cx
    pop ax
    ret
input endp
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