; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    bcall(_homeup)
    ld hl, 0
    ld (CurCol), hl         ; Shortcut to setting CurCol and CurRow to 0
    ld hl, msg
    bcall(_PutS)            ; Display the text
    bcall(_NewLine)
    ret
msg:
    .db "Hello world!", 0
.end