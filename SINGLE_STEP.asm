	;Adds a facility for executing programs a
	;Single instruction at a time, displaying
	;The program counter and op-code
	;After each step.
	;
	;To examine registers, abort and 
	;use the monitor in the usual way
	;To continue, go to 0F90
	;
P3H	=	0FF7	;For program to be
P3L	=	0FF8	;Single-stepped
P1H	=	0FF9	;Save user's registers:
P1L	=	0FFA	;(can be examined or
P2H	=	0FFB	;altered between
P2L	=	0FFC	;steps from monitor)
A	=	0FFD
E	=	0FFE
S	=	0FFF
ADL	=	12
ADH	=	14
Word	=	13
Ram	=	0f00
Dispd	=	0140

	.=0F90
SS:	ST	A
	LD	P3L	;Pick up user's program
	XPAL	3	;Address
	LD 	P3H
	XPAH	3
	LD	@-1(3)	;Ready for jump
	JMP	Ret
Step:	LD	ADH(2)
	XPAH	3
	LD	ADL(2)
	XPAL	3
	LD	@-1(3)
	LD	E	;Restore user's context:
	XAE
	LD	P1L
	XPAL	1
	LD	P1H
	XPAH	1
	LD 	P2L
	XPAL	2
	LD	P2H
	XPAH	2
	LDI	01	;Flag 0 Resets counter
	CAS		;Put it high
	LD	S
	ANI	X'FE	;Put flag 0 low
	CAS		;Start counting nads
	LD	A
	IEN
	NOP		;Pad out to 8
	NOP		
	XPPC	3	;Go to user's program
		; Here on interrupt after one instruction
	ST	A	;Save user's context
Ret:	LDE
	ST	E
	CSA
	ST	S
	XPAH	1
	ST	P1H
	XPAL	1
	ST	P1L
	LDI	H(Ram) 	;Set P2->Ram
	XPAH	2
	ST	P2H
	LDI	L(Ram)
	XPAL	2
	ST	P2L
	LD	@1(3)
	LD	(3)	;Get op-code
	ST	Word(2)
	LDI	H(Dispd)
	XPAH	3
	ST	ADH(2)
	ST	P3H	;So can enter via 'SS'
	LDI	L(Dispd)-1
	XPAL	3
	ST	ADL(2)
	ST	P3L
	XPPC	3	;Go to display routine
	JMP	Step	;Command return so step
	JMP	No	;Number return illegal
	
	.END