org 00h
ajmp main
org 100h
main:
	mov sp,#80h
	mov r1,#8


	mov a,#1h
loop:
	mov p1,a
	rl a
	acall delay
	djnz r1,loop
    
	
	ajmp $
delay:
d1:
	mov r6,#0ah
	mov r7,#0b3h
	djnz r7,$
	djnz r6,d1
	ret
	end	
	
