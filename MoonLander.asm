;Land a rocket on the moon
;Dispaly shows altitude-velocity-fuel
;keys 1-7  control the thrust
Grav = 5 ;Force of gravity
Disp = 0D00 ;Display address
Crom = 010B ;Segment table
E = -128 ;Extension as offset
Row = Ret-0F03 ;Ram offsets
Count = Ret-0F04
;Variables

.= 0F05
Save .=.+1
H1: .=.+1
L1: .=.+1
Alt: .=.+3	     ;Altitude
Vel: .=.+3     ;Velocity
Accn: .=.+2  ;Acceleration
Thr: .=.+2    ;Thrust
Fuel: .=.+2   ;Fuel left
;Original values
Init:	BYTE	08,050,0	;Altitude = 850
	.BYTE	099,080,0		;Velocity = -20
	.BYTE	099,098	;aCCELERATION = -2
	.BYTE	0,02	;Thrust = 2 
	.BYTE	058,0	;Fuel = 5

;Subroutine to display AC as two digits
Ret:	XPPC	2 ;P2 contains 0F20
Disp:	ST	Save
	LDI	H(Crom)
	XPAH	1
	ST	H1	;Run out of pointers
	LDI	L(Crom)
	XPAL	1
	ST	L1
	LD	Save
	CCL
	ANI	0F
Loop:	XAE
	LD	E(1)
	ST	@ + 1(3)
	LDI	0	;Delay point
	DLY	2	;Determines speed
	LD	Save
	SR
	SR
	SR
	SR
	XAE
	CSA
	SCL
	JP	Loop	;Do it tuice
	LDI	0
	ST	@ + 1(3)	;Blank between
	LD	H1	;Restoresp1:
	XPAH	1
	LD	L1
	XPAH	1
	JMP	Ret	;Return
;Main moon-landing program
Start:	LDI	H(Init)
	XPAH	1
	LDI	L(Init)
	XPAL	1
	LDI	H(Ret)
	XPAH	2
	LDI	L(Ret)
	XPAL	2
	LDI	12
	ST	Count(2)
Set:	LD	+11(1)
	ST	@-1(1)
	DLD	Count(2)
	JNZ	Set
;Main loop
Again:	LDI	H(Disp)-1
	XPAH	3
	LDI	L(Disp)-1
	XPAL 3
	LDI	1
	ST	Count(2)
	LD	@+6(1)	;P1->Vel + 2
	JP	Twice	;Altitude positive?
	LD	@+4(1)	;P1->Thr+1
	JMP	Off	;Don't update
Twice:	LDI	2	;Update velocity anc
	ST	Row(2)	;Then altitude....
	CCL
Dadd:	LD	@-1(1)
	DAD	+2(1)
	ST	(1)
	DLD	Row(2)
	JNZ	Dadd
	LD	+2(1)
	JP	Pos	;Gone negative?
	LDI	X'99
Pos:	DAD	@-1(1)
	ST	(1)
	DLD	Count(2)
	JP	Twice
	LD	@12(1)	;P1->Alt
	ILD	Row(2)	;Row:=1
	SCL
D sub:	LD	@-1(1)	;Fuel
	CAD	-2(1)	;Subtracct thrust
	ST	(1)
	NOP
	DLD	Row(2)
	JP	Dsub
	CSA	;P1->Fuel now
	JP	Off	;Fuel run out?
	JMP	Accns
Off:	LDI	0
	ST	-1(1)	;Zero thrust
Accns:	LD	-1(1)
	SCL
	DAL	099-Grav
	ST	-3(1)	;Accn+1
	LDI	X'99
	DAI	0
	ST	-4(1)	;Accn
Dispy:	LD	(1)	;Fuel
	XPPC	2	;Display it OK
	LD	-7(1)	;Vel
	JP	Posv
	LDI	X'99
	SCL
	CAD	-6(1)	;Vel+1
	SCL
	DAI	0
	JMP	ST0
Posv:	LD	-6(1)	;Vel+1
Sto:	XPPC	2	;Display velocity
	LD	-9(1)	;Alt+1
	XPPC	2	;Display it
	LD	@-1(3)	;Get ride of lank
	LD	@-10(1)	;P1->Alt now
	XPPC	2
	LDI	10
	ST	Count(2)
Toil:	LD	@-1(3)	;Key pressed?
	JP	Press	;key0-7?
	XRI	X'DF	;Command Key?
	JZ	Start(2)	;Begin again if so
	DLD	Count(2)
	JNZ	Toil
	JMP	Again(2)	;Another circuit
	LD	+9(1)	;Thr + 1
	JZ	Back	;Engines stopped?
	XPAL	3	;Which row?
	St	+9(1)	;Set thrust
Back:	JMP	Again(2)	;Carry on counting
	.END
