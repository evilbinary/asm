data segment
    h db 0
    m db 0
    s db  0
    hs db 0  
    ms dw 0 
    count db 0
data ends
code segment
start:
	assume cs:code,ds:data
	mov ax,data
	mov ds,ax
	xor ax,ax

	mov al,1ch
	mov ah,35h
	int 21h
	push es
	push bx
	
	push ds
	mov dx,offset fun
	mov ax,seg fun
	mov ds,ax
	mov ah,25h
	mov al,1ch 
	int 21h
    pop ds
    
    ;mov ah,0
    ;mov al,4
    ;int 10h
    
     call loadtime 
a:	
    mov ah,0bh
	int 21h
	cmp al,0
	jne e
	
	 
 
	mov bh,1
	mov dh,100
	mov dl,200
	mov ah,2
	int 10h 
	
	cmp count,180
	jb b
	call sound
b:
	call time
	;call changecol
	call delay 
	
	
	jmp a
e: 
	pop dx
	pop ds
	mov al,1ch
    mov ah,25h
	int 21h

	mov ah,04ch
	int 21h

fun proc near
    push ax
    push cx
    push ds
    mov ax,data
    mov ds,ax
    sti
    add ms,55
    cmp ms,1000
    jb h1
    mov ms,0
    inc s
    mov cl,s
    cmp s,60
    jb h1
    mov s,0
    inc m  
    cmp m,60
    jb h1
    mov m,0
    inc h
h1:
    inc count
    cmp count,181
    jb f1
    mov count,0
f1:
    cli
    pop ds
    pop cx
    pop ax
    iret
fun endp

time proc
    push ax
    push cx
    push dx
    xor ax,ax
    mov al,h
    call hex2dec 
    call msg
    mov al,m
    call hex2dec
    call msg
    mov al,s
    call hex2dec
    pop dx
    pop cx
    pop ax
    ret
time endp	
;cx=次数
sound proc
    push ax
    push dx
    mov ah,2
    mov dl,07h
    int 21h
    pop dx
    pop ax
    ret
sound endp

loadtime proc
    push ax
    push cx
    push dx
    mov ah,2ch
    int 21h
    mov h,ch
    mov m,cl
    mov s,dh
    mov hs,dl
    pop dx
    pop cx
    pop ax
    ret
loadtime endp
delay proc
    push cx
    push dx
    mov cx,1000
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
;换行
changecol proc 
    push ax
    push dx
    mov ah,2
    mov dl,0dh
    int 21h
    ;mov ah,2
    ;mov dl,0ah
    ;int 21h
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
    add al,30h
    mov dl,al
    mov ah,2
    int 21h   
    mov ax,bx
    pop bx
    ret
divdec endp
;ax=inputnumber
hex2dec proc
    push ax
    push cx
    push dx
    mov cx,10
    call divdec
    mov cx,1
    call divdec
    pop dx
    pop cx
    pop ax
    ret
hex2dec endp
disp proc
    push ax
    push cx
    push dx
    mov ch,2
l22:   
     mov cl,4
     rol bl,cl
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
code ends
end start