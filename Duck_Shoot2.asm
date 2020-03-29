Duck	=	061
Disp	=	0D00
	.=0F0F
Row:	.=.+1
Count:	.=.+1
Sum	.=.+1
	.EXTERN Ndig

Shoot:	LDI	H(Disp)
	XPAH	1
	LDI	L(Disp)
	XPAL	1
	LDI	1
	ST	Row
React:	LDI	0
	ST 	Sum
Shift: 	LDI	8

	JMP 	Ndig		; jumps to Ndig from seperate file (Ndig.asm)

No:	LDI	0
Go:	ST	-128(1)
	DLY	01
	LD	Sum
	JNZ	Nok
	LD 	-128(1)
	XRI 	0FF			
	JZ 	Nok
	ST 	Sum
	LD 	Row
	XRI	080
	ST	Row
Nok:	LDE
	SCL
	CAI	1
	JP	Ndig
	DLD	Count
	JZ	React
	LDI	7
	JMP	Ndig
	
	.END