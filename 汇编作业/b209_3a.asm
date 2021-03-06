data segment
    p5  db 0
    p6  db 0
    p7  db 0
    p8  db 0
    p9  db 0
    msg1 db 'please input score!','$'
    msg5 db 'p5= ','$'
    msg6 db 'p6= ','$'
    msg7 db 'p7= ','$'
    msg8 db 'p8= ','$'
    msg9 db 'p9= ','$'
data ends
code segment
start:
    assume cs:code,ds:data
    mov ax,data
    mov ds,ax
    lea dx,msg1
    call msg
    call changecol
    
    mov cx,10  ;number count
ll:
    call input
    call changecol 
    cmp bl,90
    jae l90
    cmp bl,80
    jae l80
    cmp bl,70
    jae l70
    cmp bl,60
    jae l60
    cmp bl,50
    jae l50
lm:
    dec cx
    cmp cx,0
    jnz ll
    jmp en
l90:
    inc p9
    jmp lm
l80:
    inc p8
    jmp lm
l70:
    inc p7
    jmp lm
l60:
    inc p6
    jmp lm
l50:
    inc p5
    jmp lm
en:    
    lea dx,msg5
    call msg
    mov bl,p5
    call disp
    call changecol
    
    lea dx,msg6
    call msg
    mov bl,p6
    call disp
    call changecol
    
    lea dx,msg7
    call msg
    mov bl,p7
    call disp
    call changecol
    
    lea dx,msg8
    call msg
    mov bl,p8
    call disp
    call changecol
    
    lea dx,msg9
    call msg
    mov bl,p9
    call disp
    call changecol

    mov ah,04ch
    int 21h
;bx/bl=get input number
input proc
    push ax
    push cx
    mov ch,2 ;if 16 ch=4 ,if 8 bit ch=2
    mov cl,4
l00:
    shl bl,cl
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
     mov ch,2
l2:   
     mov cl,4
     rol bl,cl
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
    push dx
    mov ah,2
    mov dl,0dh
    int 21h
    mov ah,2
    mov dl,0ah
    int 21h
    pop dx
    pop ax     
    ret
changecol endp
code ends
end start