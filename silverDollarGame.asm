         .=0F12
START:  .BYTE 0FF; starting position: must be ascending order
        .BYTE 03
        .BYTE 05
        .BYTE 08
        .BYTE 09
        .BYTE 0
RAM     = 0F00
POS:    .=.+6 ;current position
COUNT   = 024 ;ram offsets
KEY     = 025 ;for key last pressed
INIT    = 026 ;zero
KYBD    = 0185 ;in monitor
E       = -128 ;extension reg

        .=0F28
BEGIN:   LDI  H(RAM)
        XPAH 2
        LDI  L(RAM)
        XPAL 2
        LDI  H(POS)
        XPAH 1
        LDI  L(POS)
        XPAL 1
        LDI  6
        ST   COUNT(2)
SETUP:   LD   -6(1) ;transfer start to pos
        ST   @+1(1)
        DLD  COUNT(2)
        JNZ  COUNT(2)
YMOVE:  LDI  0 ;you go first!
        ST   KEY(2) ;clear key store
        ;generate display from POS
DISP:	LDI  H(POS)
    	XPAH 1
    	LDI  L(POS)+1
        XPAL 1
        LDI  9
CLEAR:  XAE ;clear display buffer
        LDI  08 ;underline
        ST   E(2)
        LDE
        CAI  1
        JP   CLEAR
        LDI  5
        ST   COUNT(2)
NPOS:   LD   @+1(1)
        RR
        JP   EVEN
ODD:    ANI  07F
        XAE
        LD   E(2)
        ORI  030 ;segments E & F
        ST   E(2)
        JMP  CONT
EVEN:   XAE
        LD   E(2)
        ORI  06 ;segments B & C
        ST   E(2)
CONT:   DLD  COUNT(2)
        JNZ  NPOS
        ;display current position
SHOW:   LDI  H(KYBD)
        XPAH 3
        LDI  L(KYBD)-1
        XPAL 3
        XPPC 3
        JMP  COMA ;command key
        LDE
        JZ   SHOW
        SCL
        CAI  6 ;1-5 allowed
        JP   SHOW
        LDI  H(POS)
        XPAH 1
        LDI  L(POS)
        CCL
        ADE
        XPAL 1
        LD   (1)
        CCL
        ADI  -1
        CCL
        CAD  -(1)
        JP   FINE 2 ;valid move
        JMP  SHOW
FINE 2: LD   KEY(2)
        JNZ  FIRSTN
        LDE
        ST   KEY(2) ;first key press
FIRSTN: XRE ;not first press
        JNZ  DISP(2) ;not allowed
        DLD  (1) ;make move
        JMP  DISP(2) ;display result
COMA:   LD   KEY(2) ;mem pressed 
        JZ   DISP(2) ;you have not moved!
GO:     LDI  3
        ST   COUNT(2)
        LDI  H(POS)
        XPAH 1
        LDI  L(POS)
        XPAL 1
        LDI  0
        XAE
TRY:    LD   +1(1)
        CCL
        CAD  @+2(1)
        ST   4(1)
        XRE ;keep nim sum
        XAE
        DLD  COUNT(2)

        JNZ  TRY
SOLVE:  LDE
        JZ   NOGO ;safe position
        XOR  (1)
        SCL
        CAD  @+2(1)
        JP   SOLVE
        CCL
        ADD  -7(1) ;make my move
        ST   -7(1)
        JMP  YMOVE(2) ;now you, good luck!
NOGO:   LDI  05
        ST   COUNT(2) ;make first move
NO:     LD   @-1(1)
        CCL
        ADI  -1
        CCL
        CAD  -1(1)
        JP   FINE
        DLD  COUNT(2)
        JNZ  NO
        JMP  +7(3) ;i.e. abort-- I lose
FINE:   DLD  (1) ;make my move
        JMP  YMOVE(2) ;now you chum
        .END
