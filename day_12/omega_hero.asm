; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.ORG userMem - 2
; Constants
BLANK .EQU $20
OMEGA .EQU $CA
; Begin Program
.DB t2ByteTok, tAsmCmp
    bcall(_RunIndicOff)
    bcall(_ClrLCDFull)
    LD  BC, 0
    LD  (IY+(appFlags+appTextSave)), C
    LD  (CurRow), BC
    JR  UpdateOmega
KeyLoop:
    bcall(_GetCSC)
    CP  skRight
    JR  Z, Right
    CP  skLeft
    JR  Z, Left
    CP  skDown
    JR  Z, Down
    CP  skUp
    JR  Z, Up
    CP  skClear
    RET Z
    JR  KeyLoop
Right:
    LD  A, B
    CP  15
    JR  Z, KeyLoop
    INC B
    JR  UpdateOmega
Left:
    LD  A, B
    CP  0
    JR  Z, KeyLoop
    DEC B
    JR  UpdateOmega
Down:
    LD  A, C
    CP  7
    JR  Z, KeyLoop
    INC C
    JR  UpdateOmega
Up:
    LD  A, C
    CP  0
    JR  Z, KeyLoop
    DEC C
    JR  UpdateOmega
UpdateOmega:
    LD  A, BLANK
    bcall(_PutMap)
    LD  (CurRow), BC
    LD  A, OMEGA
    bcall(_PutMap)
    JR KeyLoop
.end