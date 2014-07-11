stack segment
    dw   128  dup(0)
stack ends
data segment          
    
    array dw 0aeh,1,4,7,1,9,6,4,10,45,1,65,21,1,6,36,72,14,82,99  
    count1 equ ($-array)/2
    count dw count1-1
data ends
code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    xor cx,cx
l:      
    lea si,array
    mov cx,count
l2:   
    
    mov ax,[si]
    cmp ax,[si+2]
    jb  l3
    mov dx,[si+2]
    mov [si+2],ax
    mov [si],dx
l3: 
    add si,2   
    loop l2 
    dec count   
    jnz l 

     lea si,array 
     mov cx,count1
     call putarray
     
    mov ax, 4c00h  
    int 21h   
;si=in addr  lea si,arrary,cx=count
putarray proc
     push bx
     push cx
     push si
p1:    
     mov bx,[si]
     call disp
     call changecol
     add si,2
     dec cx
     jnz p1 
     pop si
     pop cx
     pop bx 
     ret
putarray endp    
disp proc
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
disp endp
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
