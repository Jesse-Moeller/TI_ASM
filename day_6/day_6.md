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
