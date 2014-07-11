data segment
data ends
code segment
start:
	assume cs:code,ds:data
	mov ax,data
	mov ds,ax
	xor ax,ax
    call cls
	mov ah,04ch
	int 21h
cls proc
    mov ax,0600h
    mov bh,30h
    mov cx,0
    mov dx,184fh
    int 10h
    ret
cls endp
code ends
end start