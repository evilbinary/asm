stack segment
    dw   128  dup(0)
stack ends
data segment          
    array1 dw 6  dup (?)
    array dw 0aeh,343,432,7534,5431,59,556,224,5510,6645,221,2265,4521,144,46,36,72,14,82,99  
    count1 equ ($-array)/2
    count dw count1-1
data ends
code segment
assume cs:code,ds:data
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    xor cx,cx
    lea si,array1
    mov cx,6
    call inputarray
    call changecol
     lea si,array1 
     mov cx,6
     call putarray
    mov ah,1
    int 21h
l:      
    lea si,array1
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
;bx/bl=get input number
input proc
    push ax
    push cx
    mov ch,4 ;if 16 ch=4 ,if 8 bit ch=2
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
;si=array addr ,cx=count
inputarray proc
    push bx
    push cx
    push si
    
i1:
    call input
    mov [si],bx
    call changecol
    add si,2
    dec cx
    cmp cx,0
    jnz i1
    pop si
    pop cx
    pop bx
    ret
inputarray endp
code ends

end start  
