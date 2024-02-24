# Bit Shifting

#### Logical

|||
|-|-
`SRL { reg8 \| (HL) }` | Shifts right, pads with 0. Rightmost bit to carry.
`SLL { reg8 \| (HL) }` | Shifts left, pads with 1. Leftmost bit to carry.

`SLL` is pretty weird, and it's not documented. If we want to use it, can put these directives in the program:

```
.addinstr    SLL (HL)    CB36 2 NOP 1
.addinstr    SLL (IX*)   DDCB 4 ZIX 1 3600
.addinstr    SLL (IY*)   FDCB 4 ZIX 1 3600
.addinstr    SLL A       CB37 2 NOP 1
.addinstr    SLL B       CB30 2 NOP 1
.addinstr    SLL C       CB31 2 NOP 1
.addinstr    SLL D       CB32 2 NOP 1
.addinstr    SLL E       CB33 2 NOP 1
.addinstr    SLL H       CB34 2 NOP 1
.addinstr    SLL L       CB35 2 NOP 1
```

#### Arithmetic

These are done such that the signed bit doesn't change.

|||
|-|-
`SRA { reg8 \| (HL) }` | Shifts right, preserves bit 7. Rightmost bit to carry. Affects flags.
`SLA { reg8 \| (HL) }` | Shifts left, pads with 0. Leftmost bit to carry. Affects flags.

#### Rotations

Similar to shift, but keeps all the bits in the register (no padding).

|||
|-|-
`RR { reg8 \| (HL) }` | Rotate right.
`RL { reg8 \| (HL) }` | Rotate left.

|||
|-|-
`RRC { reg8 \| (HL) }` | Rotate right with carry.
`RLC { reg8 \| (HL) }` | Rotate left with carry.

There are faster versions of the rotates specialized for the accumulator, `RRA, RLA, RRCA, RLCA`.

#### 16-bit shifts and more

Be creative! `ADD HL, HL` is kind of like `SLA`. Can use bit shifting to pack data. For example:

```
    LD     A, (temp_year)  ; Temporary uncompressed year
    LD     B, 7
PackYear:
    RRA                   ; Put bit 0 into carry
    RR     H              ; Transfer to H
    DJNZ   PackYear
; HL = %yyyyyyy? ????????
    LD     A, (temp_day)   ; Temporary uncompressed day
    LD     B, 5
PackDay:
    RRA
    RR     H              ; Transfer to H
    RR     L              ; Catch runoff
    DJNZ   PackDay
; HL = %dddddyyy yyyy????
    LD     A, (temp_month) ; Temporary uncompressed month
    LD     B, 4
PackMonth:
    RRA
    RR     H
    RR     L
    DJNZ   PackMonth
; HL = %mmmmdddd dyyyyyyy
    LD     (packed_date), HL
```