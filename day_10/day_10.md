# Other Registers

#### Index Registers

We have two: `IX` and `IY`, very similar to `HL` except slower to work with. They are totally interchangable with `HL` except that all three of these are mutually exclusive.

```
    LD     IX, $40      ; Load $0040 into IX
    LD     IY, ($4552)  ; Load value at byte $4552 into IY
    LD     ($8000), IX  ; Load the value of IX into byte $8000
    ADD    IX, BC       ; Add BC to IX
    DEC    IY           ; Decrement IY
    ADD    HL, IY       ; Illegal!
    LD     H, (IX)      ; Note that this is okay
```

With Index registers, we can supply offsets when accessing memory:
```
    LD     (IX - 5), A    ; Load A to the address in IX minus five.
    LD     B, (IY + 0)    ; Load from address in IY. Could also be simply (IY).
```

The `IY` register is claimed by the OS.

#### Index Register Halves

If you need an 8-bit counter badly, can use the halves of the index registers. It's not officially supported, so this is pretty hacky stuff. Nevertheless, if we need to do it:

1. Pick an instruction that allows _both_ `H` and `L` as an operand (excluding bit manipulation).
2. Use `H` if you want high, `L` if you want low.
3. Immediately precede instruction with `.DB $DD` to use `IX` or `.DB $FD` to use `IY`.

Loading high half of `IX` into `E`:
```
    .DB    $DD
    LD     E, H
```

Subtracting low half of `IY` from accumulator:
```
    .DB    $FD
    SUB    L
```

#### Stack Pointer

Recall that `PUSH HL` is identical to 

```
    DEC    SP
    LD     (SP), H
    DEC    SP
    LD     (SP), L
```

and `POP HL` is identical to 

```
    LD L, (SP)
    INC SP
    LD H, (SP)
    INC SP
```

Can actually use `SP` as a 16-bit register.

```
    ADC    HL, SP

    ADD    HL, SP
    ADD    IX, SP
    ADD    IY, SP

    DEC    SP

    EX     (SP), HL
    EX     (SP), IX
    EX     (SP), IY

    INC    SP

    LD     (imm16), SP
    LD     SP, (imm16)
    LD     SP, HL
    LD     SP, IX
    LD     SP, IY
    LD     SP, imm16

    SBC    HL, SP
```

Most valuable are the `EX` instructions, which swap most recently pushed value. Can also use the `SP` to move data quickly.

```
    DI                       ; You don't need to know why this is necessary yet
    LD     (save_sp), SP      ; Save SP away
    LD     SP, $1000+1000     ; Have to start at the end because SP is    
                             ; decremented before a PUSH
    LD     HL, $1050          ; Memory block will be 1050 1050 ...
    LD     B, 125             ; PUSH 125*4=500 times, @ 2 bytes a PUSH = 1000 bytes
Loop:
    PUSH   HL
    PUSH   HL
    PUSH   HL
    PUSH   HL
    DJNZ   Loop
    LD     SP, (save_sp)      ; Restore SP
    EI                       ; You don't need to know why this is necessary yet
```

Or clearing (in this case `AppBackupScreen`)
```
    DI
    LD    (save_sp), SP
    LD    SP, AppBackupScreen + 768    ; 768 byte area
    LD    HL, $0000
    LD    B, 48        ; PUSH 48*8=384 times, @ 2 bytes a PUSH = 768 bytes
Loop:
    PUSH  HL          ; Do multiple PUSHes in the loop to save cycles
    PUSH  HL
    PUSH  HL
    PUSH  HL
    PUSH  HL
    PUSH  HL
    PUSH  HL
    PUSH  HL
    DJNZ  Loop

    LD    SP, (save_sp)
    EI
    RET
save_sp:
    .DW   0
```

Lastly, can use `SP` to quit.
```
    ;Start of program
    LD     (save_sp), SP
    .
    .
    .
    ;Somewhere within the program
    LD     SP, (save_sp)
    RET
```

#### Memory Refresh Register

We have an 8-bit register `R`. Bits 0 to 6 are incremented after each instruction is executed. Can use as a RNG of sorts:

```
    LD     A, ($9000)        ;A random number seed — make the result "more random"
    LD     B, A
    LD     A, R
    ADD    A, B
    LD    ($9000), A
```

#### Interrupt Vector Register and Shadow Registers.

There's an 8-bit vector register `I`, and all of our shadow registers are `AF'`, `BC'`, `DE'` and `HL'` which are used with interrupts. More on Day 22.