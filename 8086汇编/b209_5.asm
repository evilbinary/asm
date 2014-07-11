stack segment
    dw   128  dup(0)
stack ends
data segment          
    array dw 10 dup(?)
    count1 equ ($-array)/2
    count dw count1-1
    flag db 0
data ends
code segment
assume cs:code,ds:data
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    xor ax,ax
    
    ;mov ax,09672
    ;call hex2dec
    
    lea si,array
    mov cx,count1
    call inputarray     ;输入
    call changecol
    
    lea di,array
    call sort           ;排序

     lea si,array        
     mov cx,count1
     call putarray      ;输出
     
    mov ah,04ch  
    int 21h
;dx,ax/cx  dx=余数,ax=商 
divdec proc
    push bx
    xor dx,dx
    div cx
    mov bx,dx
    xor cx,cx
    cmp flag,cl
    je dl1
dl2:   
    add al,30h
    mov dl,al
    mov ah,2
    int 21h
    jmp dle
dl1:
    cmp al,0
    je dle
    mov flag,1
    jmp dl2
dle:    
    mov ax,bx
    pop bx
    ret
divdec endp
;ax=inputnumber
hex2dec proc
    push ax
    push cx
    push dx
    mov cx,10000
    call divdec
    mov cx,1000
    call divdec
    mov cx,100
    call divdec
    mov cx,10
    call divdec
    mov flag,1
    mov cx,1
    call divdec
    mov flag,0
    pop dx
    pop cx
    pop ax
    ret
hex2dec endp
;di=array addr  
sort proc
    push ax
    push cx
    push dx
    push si
    push di
sl:      
    mov si,di
    mov cx,count
sl2:   
    mov ax,[si]
    cmp ax,[si+2]
    jb  sl3
    mov dx,[si+2]
    mov [si+2],ax
    mov [si],dx
sl3: 
    add si,2   
    loop sl2 
    dec count   
    jnz sl
    pop di
    pop si
    pop dx
    pop cx
    pop ax
    ret
sort endp 
;si=in addr  lea si,arrary,cx=count
putarray proc
     push bx
     push cx
     push si
p1:    
     mov ax,[si]
     call hex2dec
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
