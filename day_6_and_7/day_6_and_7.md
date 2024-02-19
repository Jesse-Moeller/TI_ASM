# Stacks and Control Structures

#### The Hardware Stack

The z80 stack is a Last In, First Out data array of 16 bit values and has two associated instructions:

```
PUSH reg16
POP reg16
```

The hardware stack grows from the bottom, and is about 400 bytes.

#### JP and JR

Unconditional jump:

```
JP label
JR label
```

These cause execution to **J**ump to `label`. `JP` and `JR` are identical except that `JR` can jump forwards 129 bytes or backwards 126 bytes. On the other hand, `JP` can jump anywhere in memory, even outside of the program. When compiled, `JR` takes up one less byte than `JP`, `JR` takes 7 or 12 cycles, and `JP` takes 10 cycles always. The jump distance restriction on `JR` only shows at assemble time.

Conditional jump:

```
JP condition, label
```

where `condition` is one of

|`condition`| description
|-|-
|Z|zero flag is set
|NZ|zero flag is reset
|C|carry flag is set
|NC|carry flag is reset
|PE|parity/overflow is set
|PO|parity/overflow is reset
|M|sign flag is set
|P|sign flag is reset

If we want to force a conditional jump to execute, we can use 

```
CP { reg8 \| imm8 \| (HL) }
```

which subtracts the operand from the accumulator, but leaves the accumulator intact and only affects `F`. How else might one discover that `A > B` ?

#### Chaining Conditions

For example, how would we do
```
if ( a >= 7 || a != 8 ) 
    goto success;
else
    goto fail;
```
?
```
CP 7
JP NC, success
CP 8 // If we get here this means that A > 7, so, A>=8. Just need to check the ==8 case.
JP NZ, success
JP fail
fail:
    // blah blah failure
success:
    // blah blah success
```

#### Loops

Pretty simple, you have a counter, two labels, and a condition to check.

```
    LD     A, 0          ; Initialization
While:
    CP     100          ; Loop termination test
    JR     NC, EndWhile
    INC    A            ; Loop body
    JR     While
EndWhile:
```

The above is also a for loop, where we execute something 100 times. Not all while loops are for loops. Additonally, the z80 has a special instruction specifically for for loops. Here's how to substract 1 from `A` 100 times:

```
    LD     B, 100
loop:
    DEC    A
    DJNZ   loop
```

the instruction `DJNZ label` subtracts one from `B` (warning: zero => overflow) and jumps to `label` if `B` is not zero. This jump is subject to the same restrictions as `JR`.

#### Procedures

A _procedure_ is any block of code which is designed to be `CALL`ed into:

```
CALL label
```

and ends with `RET`. When we're in some part of the code LOCATION far away from function `foo`, the `CALL` function pushes the program counter (LOCATION) onto the hardware stack. Then, `foo` executes and performs whatever functions are intended, and lasty calls RET. RET is basically doing `POP PC`, so that ideally LOCATION is placed back into the program counter, and that's where execution continues (where we left off before entering `foo`).