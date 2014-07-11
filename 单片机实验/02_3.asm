org 00h
ajmp main
org 100h
main:
	mov sp,#80h
	mov dptr,#8300h
loop:
	mov p1,#0fh
	mov a,p1
	swap a
	mov p1,a
	
	ajmp loop
    
	
	
	ajmp $

	ret
	end	
	
