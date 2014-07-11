data segment
  a dw ?
  b dw ?
  ca dw ?  
  msg1 db 'first  num=','$'
  msg2 db 'second num=','$'
  msg3 db 'third  num=','$'
  msg4 db 'mid    num=','$'
data ends
code segment
start:
    assume cs:code,ds:data
    mov ax,data 
    mov ds,ax
    xor ax,ax     ;input 3 num
    
    lea dx,msg1
    call msg 
    
    call getnum
    mov a,dx 
    call  changecol
    lea dx,msg2
    call msg
    
    call getnum
    mov b,dx 
    
    call  changecol
    lea dx,msg3
    call msg
    
    call getnum
    mov ca,dx  
    
    call  changecol
    lea dx,msg4
    call msg
    xor dx,dx
     
    mov ax,a
    mov bx,b
    mov cx,ca
    cmp ax,bx
    jbe l1
    cmp bx,cx
    jae lb
    cmp ax,cx
    jbe la 
lc:
    mov bx,ca
    call disp
    jmp lend
l1:
    cmp bx,cx
    jbe lb
    cmp ax,cx
    jb lc
la: 
    mov bx,a
    call disp
    jmp lend
lb:
    mov bx,b
    call disp
lend:    
    mov ah,1
    int 21h 
    mov ah,04ch
    int 21h
;bx= output num    
disp proc
    push ax
    push cx
    push dx
     mov ch,4
l22:   
     mov cl,4
     rol bx,cl
     mov dl,bl
     and dl,0fh
     add dl,30h
     cmp dl,39h
     jbe l11
     add dl,7
l11:         
    mov ah,2
    int 21h
    dec ch
    jnz l22
    pop dx
    pop cx
    pop ax
    ret 
 disp endp
;dx =input num
getnum proc
  push ax
  push cx
  push bx
  xor dx,dx
  mov ah,1
  int 21h
  sub al,30h
  mov bl,10
  mul bl
  mov dx,ax
  mov ah,1
  int 21h
  sub al,30h
  and ah,00h
  add dx,ax
  pop bx
  pop cx
  pop ax
  ret
getnum endp 
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
    mov ah,2
    mov dl,0dh
    int 21h
    mov ah,2
    mov dl,0ah
    int 21h
    pop ax     
    ret
changecol endp
code ends
end start