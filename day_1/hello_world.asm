.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp

    bcall(_ClrLCDFull)
    ld a, 0
    ld (CurRow), a
    ld (CurCol), a
    ld hl, msg
    bcall(_PutS)            ; Display the text
    bcall(_NewLine)
    ret

msg:
    .db "Hello world!", 0
.end