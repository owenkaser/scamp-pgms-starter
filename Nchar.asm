	.PUBLIC Nchar

Nchar:	 CCL	
	 LDI	 H(Dispa)
	 XPAH	 3
	 LDI	 L(Dispa)-1
	 XPAL	 3
	 XPPC	 3
	 JMP	 COMD
	 LDE
	 ADI	 OF6
	 JP	 Nchar
	 LDI	 L(Adr)-1
	 XPAL	 3
	 XPPC	 3
	 JMP	 Blank
         

