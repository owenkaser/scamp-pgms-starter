                    ;Multiplies two unsigned 8-bit numbers
                    ;(Relocateable)
                    ;
                    ;Stack usage:
                    ;         REL:        ENTRY:    USE:      RETURN:
                    ;          -1                   Temp
                    ;(P2)->     0         A         A         A
                    ;           1         B         B         B
                    ;           2                   Result(H) Result(H)
                    ;           3                   Result(L) Result(L)
                    ;
    A          =          0
    B          =          1
    Temp       =          -1
    RH         =          2
    RL         =          3

                      .=0F50
      Mult:       LDI       8
                  ST        Temp(2)
                  LDI       0
                  ST        RH(2)
                  ST        RL(2)
      Nbit:       LD        B(2)
                  CCL
                  RR
                  ST        B(2)
                  JP        Clear
                  LD        RH(2)
                  ADD       A(2)
      Shift:      RRL
                  ST        RH(2)
                  LD        RL(2)
                  RRL
                  ST        RL(2)
                  DLD       Temp(2)
                  JNZ       Nbit
                  XPPC      3
                  JMP       Mult
      Clear:      LD        RH(2)
                  JMP       Shift
      ;
                  .END
