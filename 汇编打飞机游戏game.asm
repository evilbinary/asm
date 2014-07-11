data segment
    face db 1,0ah,4,0
    face1 db 1,01h,4,0
    tank db 0b1h,70h,0,0
         db 2h,71h,1,-1
         db 4h,7ch,1,0
         db 2h,71h,1,1
     ball db 4h,0ch,0,0
     count db 0
     x  db 0
     y  db 0
     tank_x  db 10
     tank_y  db 23
     
     ball_x  db 10
     ball_y  db 23
     
     face_x  db 11
     face_y  db 3
     face1_x db 10
     face1_y db 1
     
     rand_x  db 0
     rand_y  db 0
     
     flage db 1
     keyspace db 1
     keyleft db 1
     keyright db 1
     keyquit  db 1
     oldseg dw ?
     oldoffset dw ?
     score dw 0
     flag db 0
     msgscore db 'SCORE: ','$'
     msgver  db 'Game Version 1.0    by 小E','$'
     msgend db 'YOUR SCORE IS  ','$'
data ends

code segment
assume cs:code,ds:data
start:
	mov ax,data
	mov ds,ax
	xor ax,ax
	
	call GameInit
a:
    
    mov ah,face_x  ;笑脸
    mov al,face_y
    mov x,ah
    mov y,al
    lea si,face
    mov cx,1        
    call Draw                
                    ;笑脸1
    
    mov ah,face1_x
    mov al,face1_y
    mov x,ah
    mov y,al
    lea si,face1
    mov cx,1
    call Draw
    
    mov ah,face_x
    mov al,face1_x
    call rand
    mov rand_x,ah
    mov rand_y,al
    mov x,ah
    mov y,al
    lea si,face1
    mov cx,1
    call Draw    
 
    
    call GameStart
    
    mov dh,ball_x  ;判断是否击中
    cmp dh,face_x
    jne aa
    mov dl,ball_y
    cmp dl,face_y
    jne aa          ;击中
    add score,10
    call sound
aa:
    mov dh,ball_x 
    cmp dh,face1_x
    jne bb
    mov dl,ball_y
    cmp dl,face1_y
    jne bb
    add score,50
    call sound
bb:    
    ;call delay
    mov flage,0
    mov ah,face_x
    mov al,face_y
    mov x,ah
    mov y,al
    lea si,face
    mov cx,1
    call Draw
    
    mov flage,0
    mov ah,face1_x
    mov al,face1_y
    mov x,ah
    mov y,al
    lea si,face1
    mov cx,1
    call Draw
    
 
    mov ah,rand_x
    mov al,rand_y
    mov x,ah
    mov y,al
    mov flage,0
    lea si,face1
    mov cx,1
    call Draw    
 
 
   
    call showver
    call showscore
    cmp count,17 
    jb b
    add face_x,1  
    add face1_x,2    ;笑脸走速度
b:
    cmp face_x,100
    jb aa1
    mov face_x,1
aa1:
    cmp face_x,70
    jb aa2
    mov face1_x,60
aa2:

    mov flage,1
    cmp keyquit,0
    je en
	jmp a
en:
    call GameEnd
	mov ah,04ch
	int 21h

;游戏初始化	
GameInit proc
    push ax
  
    mov ah,0
    mov al,3
    int 10h  
    
	mov al,1ch
	mov ah,35h
	int 21h
	mov oldseg,es
	mov oldoffset, bx
	
	push ds
	mov dx,offset fun
	mov ax,seg fun
	mov ds,ax
	mov ah,25h
	mov al,1ch 
	int 21h
    pop ds
    
    pop ax
    ret
GameInit endp
;游戏开始
GameStart proc
    push ax
    call testkey
    cmp keyleft,0
    ja a2
    add tank_x,-1
a2:
    cmp keyright,0
    ja a3
    add tank_x,1
a3:
    
    
    call draw_tank
    cmp ball_y,0
    ja a1
    cmp keyspace,0
    ja a4
    mov al,tank_x
    mov ball_x,al
    mov al,tank_y
    mov ball_y,al 
a4:
    
    mov keyspace,1
a1:

    mov keyleft,1
    mov keyright,1
    
    pop ax
    ret
GameStart endp
showscore proc
    push ax
    push dx
    mov bh,0
    mov ah,2
    mov dh,0
    mov dl,1
    int 10h
    lea dx,msgscore
    call msg
    mov ax,score
    call hex2dec
    pop dx
    pop ax
    ret
showscore endp
showver proc
    push ax
    push dx
    mov bh,0
    mov ah,2
    mov dh,0
    mov dl,25
    int 10h
    lea dx,msgver
    call msg
    pop dx
    pop ax
    ret
showver endp
msg proc
    push ax
    push dx  
    mov ah,9
    int 21h 
    pop dx
    pop ax
    ret
msg endp
 
divdec proc
    push bx
    xor dx,dx
    div cx
    mov bx,dx
    xor cx,cx
    cmp flag,cl
    je dl1
dl2:   
    add al,30h
    mov dl,al
    mov ah,2
    int 21h
    jmp dle
dl1:
    cmp al,0
    je dle
    mov flag,1
    jmp dl2
dle:    
    mov ax,bx
    pop bx
    ret
divdec endp
;ax=inputnumber
hex2dec proc
    push ax
    push cx
    push dx
    mov cx,10000
    call divdec
    mov cx,1000
    call divdec
    mov cx,100
    call divdec
    mov cx,10
    call divdec
    mov flag,1
    mov cx,1
    call divdec
    mov flag,0
    pop dx
    pop cx
    pop ax
    ret
hex2dec endp
fun proc near
    push ax
    push cx
    push ds
    mov ax,data
    mov ds,ax
    sti
    
    inc count
    cmp count,18
    jb f1
    mov count,0
f1:
    cli
    pop ds
    pop cx
    pop ax
    iret
fun endp

testkey proc
    push ax
    push dx
    mov ah,6
    mov dl,0ffh
    int 21h
    cmp al,20h
    jne t1
    mov keyspace,0
t1:
    cmp al,'a'
    jne t2
    mov keyleft,0
t2:
    cmp al,'d'
    jne t3
    mov keyright,0
t3:
    cmp al,'q'
    jne t4
    mov keyquit,0
t4:
    mov ah,0ch
    mov al,6
    int 21h
    pop dx 
    pop ax
    ret
testkey endp
;ax
rand proc
    push bx
    push cx
    push dx
    mov bx,3271
    mul bx
    add ax,1091
    mov cl,8
    shr ax,cl
    and ax,07fh
    pop dx
    pop cx
    pop bx 
    ret
rand endp

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

draw_ball proc
    mov ah,ball_x
	mov al,ball_y
	mov x,ah
	mov y,al
    lea si,ball
	mov cx,1
	cmp keyspace,1
	je db1
	call Draw
	call delay
	mov flage,0
	mov ah,ball_x 
	mov al,ball_y
	mov x,ah
	mov y,al
	lea si,ball
	mov cx,1
	call Draw
	mov flage,1
	add ball_x,0
	add ball_y,-1
db1:
    ret
draw_ball endp
	
draw_tank proc
    mov ah,tank_x
	mov al,tank_y
	mov x,ah
	mov y,al
    lea si,tank
	mov cx,4
	call Draw

	call draw_ball
 
	call delay
	mov flage,0
	mov ah,tank_x
	mov al,tank_y
	mov x,ah
	mov y,al
	lea si,tank
	mov cx,4
	call Draw
	mov flage,1
	;add tank_x,1
	;add tank_y,0
    ret
draw_tank endp

;si=aray x=dh,y=dl,count ,flage
Draw proc
    push ax
    push bx
    push cx
    push dx
d1:
    ;push dx
    mov dh,y
    mov dl,x
    cmp cx,0
    jz de
    add dh,[si+2]
    add dl,[si+3]
    mov ah,2
    mov bh,0
    int 10h
    push cx
    mov cx,1
    
    mov ah,9
    mov al,[si]
    mov bh,0
    mov bl,[si+1]
    cmp flage,0
    jne d2
    mov bl,00h
d2:
    int 10h
    pop cx
    add si,4
    dec cx
    ;pop dx
    jmp d1
de:   
    pop dx
    pop bx
    pop cx
    pop ax
    ret
Draw endp
delay proc
    push cx
    push dx
    mov cx,500
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

;游戏结束
GameEnd proc
    mov bh,0
    mov ah,2
    mov dh,10
    mov dl,25
    int 10h 
    lea dx,msgend
    call msg
    mov ax,score
    call hex2dec

    mov ah,1
    int 21h   
	mov dx,oldoffset
    mov ax,oldseg
	mov ds,ax
	mov al,1ch
    mov ah,25h
	int 21h
    ret
GameEnd endp
code ends
end start
