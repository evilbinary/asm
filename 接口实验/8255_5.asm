data segment
    cw db 81h
    porta dw 280h
    portb dw 281h
    portc dw 282h
    portcon dw 283h
    lednum db 03fh,06h,5bh,4fh,066h,6dh,7dh,07h,7fh,6fh
    count db 0
    hight db 0
    la db 0
    s67 db 0c0h
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    xor dx,dx
    xor ax,ax
    
    mov al,cw
    mov dx,portcon
    out dx,al
l3: 
    cmp hight,9
    jbe d3
    mov hight,0 
 d3:
    mov cx,1
d1:
   
    mov dx,1
d2: 
    push cx
    push dx
    
    mov s67,080h
    mov al,hight 
    mov count,al
    call displed
    mov s67,040h
    mov al,la
    mov count,al
    call displed
    pop dx
    pop cx
    dec dx
    jnz d2
    dec cx
    jnz d1 

    inc la
    cmp la,9
    jbe l2
    inc hight
    mov la,0
    
 l2: 
    mov s67,00h
    call displed   
    ;call delay1
    loop l3
    
    mov ah,4ch
    int 21h
 

delay1 proc
    push cx
    push dx
    mov cx,5
    mov dx,1000
dd2:
    dec dx
    jnz dd2
    loop dd2
    pop dx
    pop cx
    ret
delay1 endp 
delay proc
    push cx
    push dx
    mov cx,1
    mov dx,500
ddd2:
    dec dx
    jnz ddd2
    loop ddd2
    pop dx
    pop cx
    ret
delay endp
  
 
displed proc
    push dx
    push ax
    mov dx,portc
    mov al,s67
    out dx,al
    mov bx,offset lednum
    mov al,count
    xlat
    mov dx,portb
    out dx,al
    pop ax
    pop dx
    ret
displed endp
code ends
end start