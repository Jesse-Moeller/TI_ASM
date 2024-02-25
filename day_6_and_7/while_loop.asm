; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    LD A, 0
    LD (CurRow), A
    LD (CurCol), A
While:
    CP 255
    JR NC, EndWhile ; <=> while a < 255, continue with this block.
    INC A
    LD HL, CurRow
    INC (HL)
    LD HL, CurCol
    INC (HL)
    LD HL, msg
    PUSH AF
    bcall(_PutS)            ; Display :) (hopefully wrapping around?)
    POP AF
    JR While
EndWhile:
    RET

msg:
.db ":)", 0
.end