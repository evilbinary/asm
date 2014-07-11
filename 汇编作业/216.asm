stack segment
    dw 256 dup(0)
stack ends
data segment
 array dw 2,4,15,17,13,26,23,62
   n   dw 8
count1 dw ?
count2 dw ?
 data ends
 code segment
 assume cs:code ,ds:data,ss:stack,es:nothing
 start:  mov ax,data
         mov ds,ax
         lea si,array
         dec n
         mov cx,n
         mov count1,cx
         mov dx,count1
      l0:mov count2,dx
      l1:mov ax,[si]
         cmp ax,[si+2]
          jb l3
      l2: add si,2
         dec count2
         cmp count2,0
         jne l1
         dec count1
         cmp count1,0
         jne l0
	
	
	jmp aa
      l3:
         
	mov bx,[si]
        mov dx,[si+2]
        mov [si],dx
	mov [si+2],bx
         
         jmp l2
	aa:
	
          call disp
        mov ah,4ch
	int 21h
      

     disp proc
          push bx
          push cx
          push si
          lea si,array
          mov cx,8
       l4:mov bx,[si]
          call dispbx
          mov dl,20h
          mov ah,2
          int 21h
          add si,2
          dec cx
          cmp cx,0
          jnz l4
	pop si
	pop cx
	pop bx
          ret
disp endp

dispbx proc
	push ax
	push bx
	push cx
	push dx
         mov ch,4
      l5:mov cl,4
         rol bx,cl
         mov dl,bl
         and dl,0fh
         add dl,30h
         cmp dl,39h
         jbe l6
         add dl,7
      l6:mov ah,2
         int 21h
         dec ch
         jnz l5
	pop dx
	pop cx
	pop bx
	pop ax
         ret
dispbx endp
      code ends
       end start