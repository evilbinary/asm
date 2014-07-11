data segment
  y dw ?
data ends
code segment
start:
   	assume cs:code,ds:data
    extern  max:far
 
   mov ax,3
	push ax
	mov ax,9
	push ax
	call max
	add sp,4
	add ax,0
	daa
	mov y,ax
	mov dx,y
	or dl,30h
	mov ah,2
	int 21h
	mov ax,4c00h
	int 21h
code ends
end start