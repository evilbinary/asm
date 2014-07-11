code segment
    org 100h
    ;org 7c00h
start:    
	jmp begine
	nop
	BS_OEMName db 'cty12345'
	BPB_BytsPerSec dw 512
	BPB_SecPerClus  db 1
	BPB_RsvdSecCnt  dw 1
	BPB_NumFATs		 db 2
	BPB_RootEntCnt	 dw 224
	BPB_TotSec16	 dw 2880
    BPB_Media		 db 0F0h	
    BPB_FAT16		 dw 9
    BPB_SecPerTrk	 DW 18		; ÿ�ŵ�������
	BPB_NumHeads	 DW 2		; ��ͷ��(����)
	BPB_HiddSec		 DD 0		; ����������
	BPB_TotSec32	 DD 0		; ��� wTotalSectorCount �� 0 �����ֵ��¼������
	BS_DrvNum		 DB 0		; �ж� 13 ����������
	BS_Reserved1	 DB 0		; δʹ��
	BS_BootSig	    DB 29h		; ��չ������� (29h)
	BS_VolID	       DD 0		; �����к�
	BS_VolLab	    DB 'cty1.001   '; ���, ���� 11 ���ֽ�
	BS_FileSysType	 DB 'FAT12   '

    INITOFS dw  2000h
	INITSEG dw  9000h
	num db 2
	;filename db  'FLOWER  TXT'
	filename db 'RIVER   TXT'
	;filename db 'TREE    TXT'
	message 	db	'found'
	message1 	db	'no found'
begine:
    mov ax,cs
	mov ds,ax
	mov ss,ax
	
	call display
	xor ax,ax
	xor dx,dx
	int 13h
	mov ax,19
    call ReadSect
    mov si,INITOFS
    mov es,INITSEG
    call SearchFile

    mov ah,1
    int 21h
	ret
;es: di=��ַ ds: si=filename='RIVER   TXT'
SearchFile proc
    push ax
    push bx
    push cx
    cld
    mov bx,di
goon:
    mov di,bx 
    lea si,filename
    mov cl,11
    repz cmpsb
    cmp cl,0
    jz find
    add bx,32
    cmp bx,INITOFS+200h
    ja nofind
    jmp goon
find:
	lea ax,message
	mov cx,5
    call display
    jmp e
nofind:
    ;lea ax,message1
    ;mov cx,8
    ;call display
    
e:
    pop cx
    pop bx
    pop ax
    ret
SearchFile endp

	

;sectornum/18 ch=Q>>1 cl=R+1 dh=Q&1
;ax=������,num=������
ReadSect proc
    push bx
    push cx
    push dx
    push es
    mov bh,18
    div bh
    mov dl,al
    shr dl,1
    mov ch,dl
    and al,1
    mov dh,al
    inc ah
    mov cl,ah
    mov dl,00h
    mov bx,INITOFS
    mov es,INITSEG
l:
    mov ah,02h
    mov al,num
    int 13h
    jc l
    pop es
    pop dx
    pop cx
    pop bx
    ret
ReadSect endp
display proc
    push bx
	mov bp,ax
	mov ax,1301h
	mov bx,000ch
	int 10h
	pop bx
	ret
display endp
org 510+7c00h
dw  0aa55h 
code ends
end start