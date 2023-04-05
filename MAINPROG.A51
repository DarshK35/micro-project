; Defining variables
MOTOR	equ P1
DELTA	equ 2500
SEQ:	db 01h, 02h, 04h, 08h
COUNT	equ 0

; Initializing microcontroller
mov MOTOR, #00h
mov TMOD, #01h
mov TH0, #0FCh
mov TL0, #18h
setb TR0
setb ET0
setb EA

t0isr:
	clr TF0
	;mov A, #COUNT
	;inc A
	;mov COUNT, A
	;anl A, #03h
	;mov R0, #SEQ
	;add A, R0
	;mov R0, A
	;movx A, @R0
	;mov MOTOR, A
	mov R6, 00h
	mov R5, 11h
	reti

main:
	sjmp $
end