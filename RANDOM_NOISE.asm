	;Relocatable
	;Generates sequence 2115 bits long
	; 
	
	.=0F1E
Line:	.=.+1	;For random number
	;	;Must not be zero
Noise: 	LD	Line
	RRL
	ST	Line
	LD	Line+1
	RRL
	ST 	Line+1
	CCL		;Ex-or of bits 1 and 2
	ADI	02	;In bit 3
	RR		;Rotate bit 3 to
	RR		;Bit 7
	RR
	ANI 	087	;Put it in carry and
	CAS		;Update flags
	JMP	Noise

	.END
        
