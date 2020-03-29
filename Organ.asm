;
;Organ
; Each key on the keyboard generates a different note (though the scale is somewhat unconventional!)
; Relocatable

.= 0F1F
Count:		.=.+1
Disp:		= 	0D00  ; display & keyboard
;
Enter:		LDI	H(Disp)
		XPAH	1
New:		LDI	L(Disp)
		XPAL	1
		LDI	08
		ST	Count		;key row
Again		LD	@+1(1)
		XRI	OFF	; Key pressed?
		JZ	No
		DLY	00	;Delay with AC = key
		CSA
		XRI 	07	;Change flag
		CAS
		JMP	New
No:		DLD	Count
		JNZ	Again
		JMP	New
		.END






