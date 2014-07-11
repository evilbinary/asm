org 00h
ajmp main
org 100h
main:
	mov sp,#80h
	mov dptr,#8300h
loop:
	mov p1,#0ffh
	mov a,p1
	movx @dptr,a

	ajmp loop
    
	
	ajmp $

	end	
	
