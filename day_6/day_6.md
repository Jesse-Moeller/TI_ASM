# Stacks and Control Structures

#### The Hardware Stack

The z80 stack is a Last In, First Out data array of 16 bit values and has two associated instructions:

```
PUSH reg16
POP reg16
```

The hardware stack grows from the bottom, and is about 400 bytes.

#### JP and JR

Simple:

```
JP label
JR label
```

These cause execution to **J**ump to `label`. `JP` and `JR` are identical except that `JR` can jump forwards 129 bytes or backwards 126 bytes. On the other hand, `JP` can jump anywhere in memory, even outside of the program. When compiled, `JR` takes up one less byte than `JP`, `JR` takes 7 or 12 cycles, and `JP` takes 10 cycles always. 