data segment
	array db 10 dup(?)
	count equ $-array
	flag db ?
code segment
assume cs:code,ds:data
start:	mov ax,data
	mov ds,ax
	mov dx,count
in:	call inputbl
   	mov [si],bl
   	mov dl,20h
   	mov ah,2h
   	int 21h
   	inc si
   	loop in	
l0:	mov flag,0
	dec dx
	jc end
	mov cx,dx
	lea si,array
l1:	mov al,[si]
	cmp al,[si+1]
	jc l2
	jmp l3
l2:	mov flag,1
	mov bl,[si+1]
	mov [si],bl
	mov [si+1],al
	jmp l3
l3:	add si,1
	
	dec cx
	jnz l1
	cmp flag,0
	jnz l0
	jmp end

end:	lea si,array
   	mov cx,count
l4:	mov bl,[si]
   	call dispbl
   	inc si
   	loop l4
   	mov ah,4ch
   	int 21h

disparray proc
	push cx
	push si
	lea si,array
	mov cx,count
next:	mov bl,[si]
	call dispbl
	add si,1
	inc cx
	jnz next
	mov dl,0dh
	mov ah,2h
	int 21h
	mov dl,0ah
	mov ah,2h
	int 21h
	mov ah,2h
   	int 21h
	pop cx
	pop si
	ret
disparray endp
dispbl proc
   	push cx
   	mov ch,2h
  	mov cl,4h
L00:	rol bl,cl
   	mov dl,bl
   	and dl,0fh
   	add dl,30h
   	cmp dl,39h
   	jbe L01
   	add dl,7h
L01:	mov ah,2h
   	int 21h
   	dec ch
   	jnz L00
	mov dl,20h
   	mov ah,2h
   	int 21h
   	pop cx
   	ret 
dispbl endp
input proc
   	push cx
   	mov bl,0h
   	mov ch,2h
L10:	mov cl,4h
   	shl bl,cl
   	mov ah,1h
   	int 21h
   	sub al,30h
   	cmp al,9h
   	jna L11
   	sub al,7h
L11:	or bl,al
   	dec ch
   	jnz L10
   	pop cx
   	ret
input endp
code ends
end start