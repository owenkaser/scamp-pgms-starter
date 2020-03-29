PORTB = 0E21
EXT   = -128
       .=0E80

START: LDI  H(ENDW)
       XPAH 2
       LDI  L(ENDW)
       XPAL 2
       LDI  H(PORTB)
       XPAH 1
       LDI  L(PORTB)
       XPAH 1
       LDI  X'FF
       ST   +2(1)
RESET: LDI  -NPTS
       CCL
NEXT:  XAE
       LD   E(2)
       ST   (1)
       LDE
       ADI  1
       JZ   RESET
       DINT
       JMP  NEXT

       .=0F20
WAVE:  .BYTE 077,092,0B0,0CB,0E1,0ED
       .BYTE 0EF,0E6,0D5,0BE,0A5,08E
       .BYTE 07F,077,076,07D,087,092
       .BYTE 09B,09E,09A,090,080,06F
       .BYTE 05C,04D,042,03D,03D,040
       .BYTE 046,04B,04D,04D,04A,046
       .BYTE 044,047,050,060
ENDW   = .
NPTS   = ENDW-WAVE
.END
