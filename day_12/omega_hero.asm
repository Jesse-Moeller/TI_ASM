; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.ORG userMem - 2
; Constants
BLANK .EQU $00
OMEGA .EQU $CA
; Begin Program
.DB t2ByteTok, tAsmCmp
; Scratch memory for old cursor position
OldRow:
    .DB $00
OldCol:
    .DB $00
    LD  A, 0
    LD  (CurRow), A
    LD  (CurCol), A
KeyLoop:
    bcall(_GetCSC)
    CP  skRight
    JR  Z, Right
    CP  skLeft
    JR  Z, Left
    ; down, up
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
; Assumption is that Omega is at OldRow and OldCol,
; CurRow and CurCol have been updated and we now need
; to wipe the old Omega and draw the new Omega.
UpdateOmega:
    LD  A, OMEGA
    bcall(_PutMap)
    LD  HL, CurRow
    LD  B, (HL)
    LD  HL, CurCol
    LD  C, (HL)
    PUSH BC
    LD  A, (OldRow)
    LD  (CurRow), A
    LD  A, (OldCol)
    LD  (CurCol), A
    LD  A, BLANK
    bcall(_PutMap)
    POP BC
    LD  (CurRow), BC
    JR KeyLoop
.end

; Oof this is ugly, revisit with coffee