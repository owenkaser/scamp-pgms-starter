                ;Divides an unsigned 16-bit number by
                ;an unsigned 8-bit number giving
                ;16-bit quotient and 8-bit remainder
                ;(Relocateable)
                ;
                ;Stack usage:
                ;       REL:    ENTRY:  Use:    RETURN:
                ;        -1              Quotient(1)
                ;(P2)->   0     Divisor         Quotient(H)
                ;        +1     Dividend(H)     Quotient(L)
                ;        +2     Dividend(L)     Remainder
                ;
    Quotient =      -1
    DSOR     =      0
    DNDH     =      1
    DNDL     =      2
                ;
           .=0F80
    Div:    LD      DSOR(2)
            XAE
            LDI     0
            ST      DSOR(2) ;Now Quoptient(H)
            ST      Quot(2) ;Quotient(L)
    Subh:   LD      DNDH(2)
            SCL
            CAE
            ST      DNDH(2)
            SRL
            JP      Stoph
            ILD     DSOR(2)
            JMP     Subh
    Stoph:  LD      DNDH(2)
            ADE             ;Carry is clear
            ST      DNDH(2) ;Undo damage
    Subl:   LD      DNDL(2)
            CCL
            CAE
            ST      DNDL(2)
            LD      DNDH(2)
            CAI     0
            ST      DNDH(2)
            SRL
            JP      Stopl
            ILD     Quot(2)
            JMP     Subl
     Stopl: LD      DNDL(2)
            ADE
            ST      DNDL(2) ;Remainder
            LD      Quot(2)
            ST      DNDH(2)
            XPPC    3       ;Return
            JMP     Div

            .END
