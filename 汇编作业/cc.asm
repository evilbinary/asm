data segment
data ends
code segment
start:
	assume cs:code,ds:data
	mov ax,data
	mov ds,ax
	call cc 
	call disp
	mov ah,1
	int 21h
	mov ah,04ch
	int 21h 
	
cc proc
	mov ah,1h
	int 21h
	cmp al,39h
	jbe l1 
	sub al,37h 
	jmp ll1
l1:	
    sub al,30h
ll1:
	mov bl,al
	mov cl,4h
	rol bl,cl

	mov ah,1h
	int 21h
	cmp al,39h
	jbe l2 
	sub al,37h   
	jmp ll2
l2:	
    sub al,30h
ll2:
    or bl,al
    
	ret
cc endp

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