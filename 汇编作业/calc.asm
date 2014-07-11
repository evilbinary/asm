data segment
    x   dw 10
    y   dw 67
    z   dw  23
    v   dw 170
data ends
code segment
start:
   	assume cs:code,ds:data
    mov ax,x
    imul y 
    add ax,z
    adc dx,0
    sub ax,540
    sbb dx,0
    mov bx,ax
    mov cx,dx
    mov ax,v
    cwd
    sub ax,bx
    sbb dx,cx
    idiv x
    push dx
    mov bx,ax
    call disp
    pop dx
    mov bx,dx
    call disp
   
    mov ah, 1
    int 21h
    mov ax, 4c00h  
    int 21h 
    
disp proc 
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
    ret 
disp endp
	
code ends
end start