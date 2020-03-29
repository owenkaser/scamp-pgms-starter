                ;Finds greatest common divisor of two
                ;16-bit unsigned numbers
                ;uses Euclid's Algorithm. (Relocatable).
                ;
                ;Stack usage:
                ;           REL:    ENTRY:   USE:   RETURN:
                ;(P2)->     0       A(H)     A(H)   0
                ;           1       A(L)     A(L)   0
                ;           2       B(H)     B(H)   GCD(H)
                ;           3       B(L)     B(L)   GCD(L)
                ;
    AH          =       0
    AL          =       1
    BH          =       2
    BL          =       3
                ;
                .=0F20
    GCD:        SCL
                LD      BL(2)
                CAD     AL(2)
                ST      BL(2)
                XAE
                LD      BH(2)
                CAD     AH(2)
                ST      BH(2)
                SRL             ;Put carry in top bit
                JP      Swap
                JMP     GCD     ;Subtract again
    Swap:       CCL
                LD      AL(2)
                XAE
                ADE
                ST      AL(2)
                LDE
                ST      BL(2)
                LD      AH(2)
                XAE
                LD      BH(2)
                ADE
                ST      AH(2)
                XAE
                ST      BH(2)
                OR      AL(2)     ;OR with new AL(2)
                JNZ     GCD       ;Not finished yet
                XPPC    3         ;Return
                JMP     GCD       ;For repeat run

                .END
