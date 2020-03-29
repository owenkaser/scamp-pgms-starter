                ;Converts decimal number entered at
                ;keyboard to hex and displays result
                ;
                ;'MEM' =minus, 'TERM' clears display
                ;(Relocatable)
            ADL     =       0C
            ADH     =       0E
            Ram     =       0F00
            Dispa   =       015A
            Count   =       011
            Minus   =       012
            Ltemp   =       013
                ;
                    .=0F50
    Dhex:   LDI     0
            ST      Minus(2)
            ST      ADH(2)
            ST      ADL(2)
    Disp:   LDI     H(Dispa)
            XPAH    3
            LDI     L(Dispa)-1
            XPAL    3
            XPPC    3
            JMP     Comd        ;Command key
            LDI     10          ;Number in extension
            ST      Count(2)    ;Multiply by 10
            SCL
            LD      Minus(2)
            XAE
            XRE
            CAE
            XAE
            LDE                 ;Same as: LDI 0
            CAE                 ;         CAD 0
            XAE
            JMP     Digit
    Addd:   LD      Ltemp(2)    ;Low byte of product
    Digit:  CCL
            ADD     ADL(2)
            ST      Ltemp(2)
            LDE                 ;High byte of product
            ADD     ADH(2)
            XAE                 ;Put back
            DLD     Count(2)
            JNZ     Addd
            LDE
            ST      Adh(2)
            LD      Ltemp(2)
            ST      Adl(2)
            JMP     Disp        ;Display result
    Comd:   XRI     3           ;'TERM'?
            JZ      Dhex        ;Restart if so
            LDI     X'FF        ;Must be 'MEM'
            ST      Minus(2)
            JMP     Disp
                ;
                    .=0FFB
            .DBYTE  Ram         ;Set P2->Ram
                ;
            .END
