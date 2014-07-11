data segment
	arry	db 7,2,3,7,9,21,0,5,6
data ends
code segment
start:
	assume cs:code,ds:data
	lea si,arry
	mov dx,9
l1:
	mov bx,0
l3:
	cmp bx,dx
	ja l2
	mov ax,[si+bx]
	cmp ax,[si+bx+1]
	jb l4
	xchg ax,[si+bx+1]
	mov [si+bx],ax
l4:
	inc bx
	jmp l3
l2:
	dec dx
	jnz l1
	mov ah,04ch
	int 21h
code ends
end start