
;Message
; Display a moving message on the 7-segment displays (relocatable)
;

		.= 0F1F
Speed:		.=.+1
;
Tape		LDI  H(Disp)
		XPAH	1
		LDI	L(Disp)
		XPAL	1
		LDI	H(Text)
		XPAH	2
		LDI	L(Text)-8
		XPAL	2
		LDI	X’CO	; Determines sweep speed
		ST 	Speed
Again:		LDI	7
Loop		XAE
		LD	-128(2)
		ST	-128(1)
		LDI	X’FF
		CCL
		ADE		;i.e. decrement ext
		JP	Loop
		DLD	Speed
		JNZ	Again
		LD	@-1(2)	;Move letters
		JP	Move	:x’80 = end of text
		JMP	Go
;
Disp		=	0D00
;
;A sample message
;Message is stored backwards in memory
; first character is ‘end of text’, x’80
; For a continuous message, first and
;Last seven characters must be the
; same (as in this case).
;

		.=0FA0
		.BYTE 	080, 079, 079, 06D, 040, 037
		.BYTE 	077, 039, 040, 03E, 06F, 06E
		.BYTE 	040, 06D, 077, 040, 06E, 03E
		.BYTE 	07F, 040, 079, 037, 030, 071
		.BYTE 	040, 06E, 038, 038, 03F, 01F
		.BYTE 	040, 077, 040, 06D, 030, 040
		.BYTE 	039, 040, 071, 03F, 040, 06D
		.BYTE 	040, 079, 079, 06D, 040, 037
		.BYTE 	077, 039
Text		= .		;start of message
		.END
