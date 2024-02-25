; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    LD     A, 3
    LD     (CurRow), A    ; Set row 3
    LD     A, 4
    LD     (CurCol), A    ; Set column 4
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    LD     A, R         ; Print whatever!
    bcall(_PutC)        ; giving a cryptic ASCII code. 
    RET
.end