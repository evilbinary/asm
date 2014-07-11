org 00h
ajmp main
org 003h
ajmp int0

org 100h
main:
	mov sp,#80h
	setb ex0
	setb it0
	setb ea
	mov dptr,#8000h
	movx @dptr,a


	
	
 ll:
	ajmp ll
	
int0:
 	mov dptr,#8000h
 	movx a,@dptr
 	mov dptr,#8300h
 	movx @dptr,a
 	mov dptr,#8000h
 	movx @dptr,a

	
	reti
 

	end	
	
