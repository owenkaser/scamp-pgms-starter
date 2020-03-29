                ;Moves block of memory
                ;'From'=source start address
                ;'To'=destination start address
                ;'Length'=No of bytes
                ;(Relocatable)
                ;
            E       =       -128    ;Extension as offset
                    .=0F1B
                ;
            From:   .=.+2
            To:     .=.+2
            Length: .=.+1
                ;
    Entry:  LDI     0
            XAE
            SCL
            LD      To+1
            CAD     From+1
            LD      To
            CAD     From
            SRL
            JP      Fgt     ;'From' greater than 'To'
            LD      Length  ;Start fron end
            XAE
            Fgt:    CCL
            LD      From+1
            ADE
            XPAL    1
            LD      From
            ADI     0
            XPAH    1
            CCL
            LD      To+1
            ADE
            XPAL    2
            LD      To
            ADI     0
            XPAH    2
            CCL
            LDE
            JNZ     Up
            LDI     2
            Up:     CAE     ;i.e. subtract 1
            XAE             ;Put it in ext.
    Move:   LD      E(1)
            ST      @E(2)   ;Move byte
            DLD     Length
            JNZ     Move
            XPPC    3       ;Return

            .END
