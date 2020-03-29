       .=0F12
SCALE: .BYTE 0
       .BYTE 0FF,0EC,0DB,0CA,0BB,0AC
       .BYTE 09E,091,085,079,06E,063
       .BYTE 059,050,047,03F,037,030
       .BYTE 029,022,01C,016,011,00C

       .BYTE 044,048,04C,051,055,05B
       .BYTE 060,066,06C,072,079,080
       .BYTE 088,090,098,0A1,0AB,0B5
       .BYTE 0C0,0CB,0D7,0E4,0F2,0FF

CYCLES: .=.+1
COUNT:  .=.+1
STOP:   XPPC 3

BEGIN: LDI  H(SCALE)
       XPAH 1
       LDI  H(TUNE)
       XPAH 2
       LDI  L(TUNE)
       XPAL 2
PLAY:  LD   @+1(2)
       XAE
       LDE
       JZ   STOP
       SR
       SR
       SR
       SR
       SR
       ST   COUNT
       LDI  L(SCALE)
       XAE
       ANI  X'1F
       CCL
       ADE
       XPAL 1
       LD   (1)
       XAE
HOLD:  LD   +24(1)
       ST   CYCLES
PEAL:  LDE
       JNZ  SOUND
       DLY  X'80
       JMP  MORE
SOUND: DLY  X'00
       CSA
       XRI  X'07
       CAS
       DLD  CYCLES
       JZ   MORE
       NOP
       LDI  X'10
       DLY  X'00
       JMP  PEAL
MORE:  DLD  COUNT
       JP   HOLD
       DLY  X'20
       JMP PLAY

       .=0F90
TUNE:  .BYTE 02D,02D,02F,04C,00D,02F
       .BYTE 031,031,032,051,00F,02D
       .BYTE 02F,02D,02C,02D,00D,00F
       .BYTE 011,012,034,034,034,054
       .BYTE 012,031,032,032,032,052
       .BYTE 011,02F,031,012,011,00F
       .BYTE 00D,051,012,034,016,032
       .BYTE 071,06F,08D,0
       .END
