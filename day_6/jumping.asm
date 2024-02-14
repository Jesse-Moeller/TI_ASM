; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    ld a, 11 ; set this not equal to 10 to fail
    cp 10
    jr Z, success
    jr fail
success:
    ld bc, msg_success
    jr fail
fail:
    ld bc, msg_fail
    jr 
    jr clear_and_print
clear_and_print: ; prints str at addr in stack
    bcall(_ClrLCDFull) ; this clears hl!
    pop hl
    ld a, 0
    ld (CurRow), a
    ld (CurCol), a
    bcall(_PutS)            ; display the text
    bcall(_NewLine)
    ret
msg_success:
    .db "Success!", 0
msg_fail:
    .db "Fail!", 0
.end