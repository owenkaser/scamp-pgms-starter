	.PUBLIC Ndig

Ndig:	XAE
	LD	Row
	RR
	ST 	Row
	JP	No		; jumps to 'No' from main file if positive.
	LDI	Duck
	JMP	Go		; jumps to 'Go' from main file, if 'No' wasn't jumped too.
