; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    LD     HL, 1337
    bcall(_DispHL)
    RET
.end