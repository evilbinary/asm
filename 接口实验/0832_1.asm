data segment
data ends
code segment
assume cs:code,ds:data
start:  
    mov ax,data
    mov ds,ax
    
 l2:   
    mov cx,15
    call delay1 
    mov al,1
 l1:
    mov dx,280h
    out dx,al
    add al,10h
    call delay
    loop l1
    
    add al,3
    call delay1 
     mov cx,15
l3:
    sub al,10h
    mov dx,280h
    out dx,al
    call delay
    loop l3
     
    jmp l2
    
    mov ah,4ch
    int 21h
    
delay proc
    push bx
    push cx
    mov cx,01h
d2:
    mov bx,0ffh
d1:
    dec bx
    jnz d1
    loop d2
    pop cx
    pop bx
    ret
delay endp

delay1 proc 
    push cx
    mov cx,200
dd1:
    call delay
    loop dd1
    pop cx
    ret
delay1 endp
code ends
end start