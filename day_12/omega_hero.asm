; .binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.ORG userMem - 2
; Constants
BLANK .EQU $00
OMEGA .EQU $CA
; Scratch memory for old cursor position
OldRow:
.DB $00
OldCol:
.DB $00
; Begin Program
.DB t2ByteTok, tAsmCmp
; Initialize (delta = true)
; Loop:
;   - get user input, transform user input to bounds-checked 
;   updates for cursor pos and update accordingly.
;   - if delta, render blank to old and omega to new, reset delta
.end