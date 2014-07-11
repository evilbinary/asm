data segment
x dw 10
y dw 5
z dw 40
v dw 60
u dw ?
r dw ?

data ends
code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax
        mov ax,x
        imul y
        add ax,z
        adc dx,0
        sub ax,540
        sbb dx,0
        mov bx,dx
        mov cx,ax
        mov ax,v
        cwd
        sub ax,cx
        sbb dx,bx
        idiv x
        mov u,ax
        mov r,dx
        mov bx,ax
        call disp
        mov bx,dx
        call disp
        mov ah,1
        int 21h
        mov ah,4ch
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
    pop ax
    pop cx
    pop dx
    ret 
disp endp
code ends
end start