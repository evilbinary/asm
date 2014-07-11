stack segment
   dw  128 dup(0)
stack ends
data segment
h db ?
m db ?
s db ?
ms db ?
flag db 0
data ends
code segment
assume cs:code,ds:data,ss:stack
start:
    mov ax,ds
    mov ds,ax
    xor ax,ax
    
    
    call inputbl
    mov cl,bl
    xor ch,ch
    call changecol
    call time
    
    call beep
    ;call sound
    
    call changecol
    call time
    
    mov ah,04ch
    int 21h

;cl=响铃次数
beep proc
    push ax
    push cx
    
    in al,61h
    and al,11111100b
ba:
    dec cl
    cmp cl,0
    jz en
    mov cx,100
b2:
    
    xor al,2
    out 61h,al
    ;call delaya
    dec cx
    cmp cx,0
    jnz b2
    
    call delay
    jmp ba
    
en:   
    pop cx
    pop ax
    ret
beep endp

delaya proc
    push cx
    push dx
    mov cx,1
dde1:
    mov dx,400
dde2: 
    
    dec dx
    cmp dx,0
    jnz dde2
    loop dde1
    pop dx
    pop cx
    ret
delaya endp

delay proc
    push cx
    push dx
    mov cx,32767
de1:
    mov dx,32767
de2: 
    
    dec dx
    cmp dx,0
    jnz de2
    loop de1
    pop dx
    pop cx
    ret
delay endp
;cx=次数
sound proc
    push ax
    push dx
s1:
    mov ah,2
    mov dl,07h
    int 21h
    call delay
    loop s1
    pop dx
    pop ax
    ret
sound endp

msg proc
    push ax
    push dx
    mov ah,2
    mov dl,':'
    int 21h
    pop dx
    pop ax
    ret
msg endp

time proc
    push ax
    push cx
    push dx
    mov ah,2ch
    int 21h
    mov h,ch
    mov m,cl
    mov s,dh
    mov ms,dl
    xor ax,ax
    mov al,h
    call hex2dec 
    call msg
    ;xor ax,ax
    mov al,m
    call hex2dec
    call msg
    ;xor ax,ax
    mov al,s
    call hex2dec
    pop dx
    pop cx
    pop ax
    ret
time endp
;bx/bl=get input number
inputbl proc
    push ax
    push cx
    mov ch,2 ;if 16 ch=4 ,if 8 bit ch=2
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
inputbl endp
;换行
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
code ends
end start