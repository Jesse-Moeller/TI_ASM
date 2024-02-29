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
; Scratch memory for old cursor position
OldRow:
    .DB $00
OldCol:
    .DB $00
    bcall(_RunIndicOff)
    bcall(_ClrLCDFull)
    LD  BC, 0
    LD (IY+(appFlags+appTextSave)), C
    LD  (CurRow), BC
    LD  (OldRow), BC
    LD  A, OMEGA
    bcall(_PutMap)
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
    LD  A, (CurCol)
    CP  15
    JR  Z, KeyLoop
    INC A
    LD  (CurCol), A
    JR  UpdateOmega
Left:
    LD  A, (CurCol)
    CP  0
    JR  Z, KeyLoop
    DEC A
    LD  (CurCol), A
    JR  UpdateOmega
Down:
    LD  A, (CurRow)
    CP  7
    JR  Z, KeyLoop
    INC A
    LD  (CurRow), A
    JR  UpdateOmega
Up:
    LD  A, (CurRow)
    CP  0
    JR  Z, KeyLoop
    DEC A
    LD  (CurRow), A
    JR  UpdateOmega
UpdateOmega:
    LD  A, OMEGA
    bcall(_PutMap)
    LD  BC, (CurRow)
    LD  HL, (OldRow)
    LD  (CurRow), HL
    LD  A, BLANK
    bcall(_PutMap)
    LD  (CurRow), BC
    LD  (OldRow), BC
    JR KeyLoop
.end