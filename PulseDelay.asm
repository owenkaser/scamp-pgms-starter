                ;Pulse delayed by 1024 bit-times
                ;(Relocatable). Uses serial in/out.
                ;
            .=0F1F
    Bits:   .=.+1           ;bit counter
                ;
    Enter:  LDI     H(Scrat)
            XPAH    1
            LDIL    (Scrat)
    Next:   XPAL    1
            LDI     8
            ST      Bits
            LD      (1)     ;Get old byte
            XAE             ;Exchange
            ST      @+1(1)  ;Put back new byte
    Output: SIO             ;Serial I/O
            LDI     TC1
            DLY     TC2     ;Delay bits
            DLD     Bits
            JNZ     Output
            XPAL    1       ;P1 = 0D00 Yet?
            JNZ     Next
            JMP     Enter
    ;
    TC1     =       0       ;Bit-time
    TC2     =       4       ;Delay constants
    ;
    Scrat   =       0F80    ;Start of scratch area
            .END
