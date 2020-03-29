
;reaction time
;gives readout of reaction time in miliseconds
;display lights up after a random delay
;Press ‘MEM’ as quickly as possible
;Press ‘0” to play again. (Relocatable)
;150 = excellent, 250 = average, 350 = poor 

Cycles 		=	500		;SC/MP cycles per msec
Ram		= 	0F00
Disp		= 	0D00
Adlh		=	5
Adl		= 	12
Adh		=	14
Dispa		=	015A		; Address to segments’
;
		= 0F20
Begin		LDI	H(Dispa)
		XPAH	3
		LDI	L(Disp)
		XPAL	3
		LD	Adih(2)		;’Random’ number
Wait:		XAE
		DLY	Cycles/4	
		CCL
		ADE			;Count down
		JP	Wait
		ST	+3(1)		;Light ‘8’ on display
		LDE			; Now zero
		ST	Adl(2)
		ST	Adh(2)
; Main loop; length without DLY = 151 cycles
Time:		LDI	(Cycles-151 – 13)/2
		DLY	0
		SCL
		LD	Adl(2)
		DAE
		ST	Adl(2)
		LD	Adh(2)
		DAE
		ST	Adh(2)
		LDE
		CCL
		CAD	+3(1)	;test for key
		JZ	Time
Stop		XPPC	3	;go display time
		JMP	Stop	;illegal return
		Jmp	Begin	;Number key
;
		.=0FF9		; pointers restored
;				;from ram
		.DBYTE	Disp	;P1 -> Display
		.DBYTE	Ram	;P2-> Ram
		.END	

