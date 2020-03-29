                ;Gives square root of 16-nit unsigned number
                ;Integer part only. (Relocatable).
                ;
                ;Stack usage:
                ;         REL:    ENTRY:    USE:    RETURN:
                ;          -1               Temp
                ;(P2)->     0     Number(H)         Root(H)
                ;          +1     Number(L)         Root(L)
                ;
    HI          =     0
    LO          =     1
    Temp        =     -1
    ;
                .=0F20
    SQRT:       LDI   X'00
                ST    Temp(2)
    Loop:       SCL
                DLD   Temp(2)
                ADD   Temp(2)
                XAE
                LDI   X'FE
                ADI   X'00
                XAE
                ADD   LO(2)
                ST    LO(2)
                LDE
                ADD   HI(2)
                ST    HI(2)
                SRL
                JP    EXIT
                JMP   LOOP
    Exit:       LDI   X'00
                ST    HI(2)
                CAD   Temp(2)
                ST    LO(2)
                XPPC  3       ;Return
                JMP   SQRT    ;For Repeat
                  ;
                .=0FFB
                  ;
                .DBYTE 0F80   ;P2->Number

                .END
