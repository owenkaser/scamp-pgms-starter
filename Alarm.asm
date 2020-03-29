;Outputs are held on when alarm
;time = Actual time, i.e. for one sec
;
    Crom    =       010B    ;Segment table
    Disp    =       0D00    ;Display address
    Ram     =       0F00
    Row     =       Ram+010
             .=0F12
             .=.+1                 ;Alarm time:hours
             .=.+1                 ;Minutes
             .=.+1                 ;Seconds
             .=.+1                 ;Not used
     Time:   .=.+4                 ;Actual time
             .BYTE   076           ;Excess: hours
             .BYTE   040           ;minutes
             .BYTE   040           ;seconds
     Speed:  .BYTE   020           ;Speed
             .=0F20
      Clock:  LDI     H(Crom)
              XPAH    3
              LDI     L(Crom)
              XPAL    3
      New:    LDI     H(Disp)
              XPAH    2
              LDI     L(Disp)+0D
              XPAL    2
              LDI     H(Time)
              XPAH    1
              LDI     L(Time)+4
              XPAL    1
              SCL
              LDI     5             ;Loop count
              ST       Row
      Again:  LD      @-1(1)
              DAI     0
              ST      (1)
              DAD     +4(1)
              JZ      Cs
              JZ      Cs            ;Equalize paths
              JMP     Cont
      Cs:     ST      (1)
      Cont:   LD      (1)
              ANI     0F
              XAE
              LD      -128(3)       ;Get segments
              ST      @+1(2)        ;Write to display
              LDI     040
              DLY     00            ;Equalize display
              LD      (1)
              SR
              SR
              SR
              SR
              XAE
              LD      -128(3)
              ST      @+2(2)        ;Leave a gap
              DLD     Row
              JNZ     Again
              LDI     3
              ST      Row           ;Digit count
              LDI     0
              XAE
      Loop:   LD      @-1(1)
              XOR     +4(1)         ;Same time?
              ORE
              XAE
              DLD     Row
              JNZ     Loop
              XAE
              JZ      Alarm         ;Times tally
              LDE
              JMP     Contin
      Alarm:  LDI     07            ;All flags on
              NOP                   ;pad out path
      Contin: CAS                   ;output to flags
              LDI     0FD           ;pad out loop to
              DLY     06            ;1/(100-speed) secs.
              JMP     New

              .END
