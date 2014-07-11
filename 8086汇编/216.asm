data segment
	grade db 50,55,57,60,61,69,70,78,80,81,89,90,97
	count db $-grade
	p5 db 0
	p6 db 0
	p7 db 0
	p8 db 0
	p9 db 0
data ends
code segment
assume cs:code ,ds:data
start: mov ax,data
       mov ds,ax
       lea si,grade
    l0: 
       mov al, [si]
       cmp al,60
       jb l1
       cmp al,70
       jb l2
       cmp al,80
       jb l3
       cmp al,90
       jb l4
       inc p9	
l5:	 mov ch,count
	cmp ch,0
        je l6
        dec count
        inc si
        jmp l0


   l1: inc p5
        jmp l5
    l2: inc p6
        jmp l5
    l3: inc p7
        jmp l5
    l4: inc p8
        jmp l5

    l6: call disp
	mov ah,04ch
	int 21h

  disp proc
      mov al,p5
      add al,30h
      mov ah,2
      int 21h

      mov al,p6
      add al,30h
      mov ah,2
      int 21h

      mov al,p7
      add al,30h
      mov ah,2
      int 21h
      mov al,p8
      add al,30h
      mov ah,2
      int 21h
      mov al,p9
      add al,30h
      mov ah,2
      int 21h

      ret
      disp endp
code ends
    end start

