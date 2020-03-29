Ram	 =	 0F00
Disp	 =	 0D00
Crom	 =	 010B
Adr	 =	 011B
Dispa	 =	 015A

Dl	 =	 0
D3	 =	 2
Adll	 =	 4
Adl	 =	 12
Adh	 =	 14
Ddta	 =	 15
Row	 =	 16
Next	 =	 17
Key	 =	 20
	.EXTERN  Nchar
	.EXTERN  fBobul

Start:	 LDI	 0
	 ST	 ADL
	 ST	 ADH
	 XPAL	 2
	 LDI	 OF
	 XPAH	 2
	  
	 LDI	 H(Crom)
	 XPAH	 3
	 LDI	 L(Crom)
	 XPAL	 3
No_Key:  LDI	 04
	 ST	 Row(1)
	 LDI	 H(digits)
	 XPAH	 1
	 LDI	 L(Digits)
	 XPAL	 1
	 SCL
Incr:	 LD	 +4(1)
	 DAI	 090
	 ST	 +4(1)
	 ANI	 0F
	 XAE
	 LD	 -128(3)
	 ST	 @+1(1)
	 DLD	 Row(2)
	 JNZ	 Incr
	 LDI	 H(Disp)
	 XPAH	 1
	 LDI	 L(Disp)
	 XPAL	 1
	 LD	 3(1)
 	 XRI	 OFF
	 JZ	 No_key
  
Clear:	 LDI	 OFF
	 ST	 Ddta(2)
	 LDI	 0
	 ST	 DL(2)
	 ST	 D3(2)

	 JMP	 Nchar			;jumps to Nchar.asm to get label if neccessary.

Comd:	 XRI	 03
	 JZ	 Start(2)
	 XRI	 05
	 JNZ	 Clear 

Go:	 LDI	 L(Crom)
	 ST	 DL(2)
	 ST	 D3(2)
Bulls:	 LDI	 H(Key)
	 XPAH	 1
	 LDI	 L(Key)
	 XPAL	 1
	 LDI	 080
	 XAE
	 LDI	 04
	 ST	 Next(2)
Bull_2:	 LD	 Adll-Key(1)
	 XOR	 @+1(1)
	 JNZ	 Nobul
	 ILD	 DH(2)
	 LD	 -1(1)
	 ORE	
	 ST	 -1(1)
	 LD	 Adll-Key-1(1)
	 ORE
	 ST	 Adll-Key-1(1)

	 JMP	 fBobul			;jumps to fBobul.asm to get label if neccessary.	 

fBobul:	 DLD	 Next(2)
	 JNZ	 Bull_2
Cows:	 LDI	 04
	 St	 Next(2)
Nerow:	 LDI	 04
	 ST	 Row(2)
	 LDI	 04
	 ST 	 Row(2)
	 LDI	 H(Adll)
	 XPAH	 3
	 LDI	 L(Adll)+4
	 XPAL	 3
	 LD	 @-1(1)
	 JP	 Try
Nocow:	 DLD	 Next(2)
	 JNZ	 Nerow
	 JMP	 Finito
Notry:	 DLD	 Row(2)
	 JZ	 Nocow
Try:	 LD	 (1)
	 XOR	 @-1(3)
	 JNZ	 Notry
	 ILD	 DL(2)
	 LD	 (3)
	 ORE
	 ST	 (3)
	 JMP	 Nocow 

Finito:	 LDI	 04
	 ST	 Next(4)
Unset:	 LD	 (1)
	 ANI	 07F
	 ST	 @+1(1)
	 DLD	 Next(2)
	 JNZ	 Unset
	 LDI	 H(Crom)
	 XPAH	 1
	 LD	 DL(2)
	 XPAL	 1
 	 LD 	 (1)
	 ST	 DL(2)
	 LD	 D3(2)
	 XPAL	 1
	 LD	 (1)
	 ST	 D3(2)
	 LDI	 0FF			
	 ST	 Ddta(2)
	 JMP	 Nchar(2)

	 .END








	
	
