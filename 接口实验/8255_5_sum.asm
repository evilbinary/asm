data segment
    lei db   80h, 40h, 20h, 0fh,08h, 04h,02h,01h
    hang db  0ffh,0a8h,0d8h,00h,0ffh,92h,92h,0ffh
data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov cx,0ffffh
l1:
    push cx
    mov cx,8
    lea si,hang
    lea di,lei
l0:
    mov dx,280h
    mov al,[si]
    shr al,1
    out dx,al
    
    mov dx,290h
    mov al,[di]
    out dx,al
  
    mov al,0
    out dx,al
  
    inc si
    inc di
    
    
    loop l0
    pop cx
  call delay1
    loop l1
    mov ah,4ch
    int 21h

delay1 proc
  push cx
  push bx
  mov bx,01h
l4:
  mov cx,0ffffh
l5:
  nop
  loop l5
  dec bx
  jnz l4
  pop bx
  pop cx
  ret
delay1 endp
  
code ends
  end start