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
 start:  
	mov ax,data
         mov ds,ax
      xor ax,ax
mov ah,9
    mov al,'b'
    mov bh,1
    mov bl,70h
    mov cx,1
    int 10h
    mov ah,1
    int 21h

    mov ah,04ch
    int 21h
      code ends
       end start
