2.
ORG 0000H
AJMP START
START:
L:MOV DPTR,#8000H
MOV P1,#0FFH
MOV A,P1
MOVX @DPTR,A
AJMP L 
END


org 000h
ajmp main
org 100h
main:
	mov sp,#80
	

	mov r0,#40h
	mov a,#20h
	mov r1,#0ah
loop:
	mov @r0,a
	inc a
	inc r0
	djnz r1,loop

	
	
	mov dptr,#0100h
	mov a,33h
    movx @dptr,a
	
	mov dptr,#200h
	mov a,55h
	movx @dptr,a
	
	mov dptr,#100h
	movx a,@dptr
	mov 30h,a
	mov dptr,#200h
    movx a,@dptr
    mov 31h,a
    

	
	ajmp $ 
	end