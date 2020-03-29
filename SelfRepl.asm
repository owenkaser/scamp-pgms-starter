
;self-replicating program
; makes a copy of itself an then executes the copy.
;Only possible in a processor which permits one to write relocatable code, like SC/MP
;
		LDX	= 	Loop-Head-1 ; offset for load
		STX	=	Last-Store-1	; offset for store
		;
			= 0F12
Head:		LDI	LDX
		XAE
Loop:		LD	-128(O)		;PC-relative-ext=offset
		XAE
		CCL
		ADI	STX-LDX
		XAE
Store:		ST	-128(O)		;ditto 
		LDE
		SCL
		CAI	STX-LDX-1	;i.e. increment ext
		XAE
		LDE	
		XRI	Last-Loop-1	;finished ?
		JNZ	Loop
		DLY	X’FF		;shows how many copies
Last		=			;were executed
		.END
