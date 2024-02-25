; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    bcall(_RunIndicOff)
    bcall(_GetKey)
    LD H, 0
    LD L, A
    bcall(_DispHL)
    RET
.end

; Neat! R, L, U, D keys are 1,2,3,4