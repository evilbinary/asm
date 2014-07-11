data segment
data ends
code segment
start:
    assume cs:code,ds:data
    mov ax,data
    mov ds,ax
    call input
    call changecol
    call disp
    mov ah,04ch
    int 21h
    
;bx/bl=get input number
input proc
    push ax
    push cx
    mov ch,4
    mov cl,4
l00:
    shl bx,cl
    mov ah,1
    int 21h
    cmp al,61h
    jb l22
    sub al,20h
l22:
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
;bx=output number
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
msg proc
    push ax
    push dx  
    mov ah,9
    int 21h 
    pop dx
    pop ax
    ret
msg endp
changecol proc 
    push ax
    mov ah,2
    mov dl,0dh
    int 21h
    mov ah,2
    mov dl,0ah
    int 21h
    pop ax     
    ret
changecol endp
code ends
end start