# Bit-Level Instructions

#### Logic

We can do bit-level logic against the accumulator. 
```
AND { reg8 \| imm8 \| (HL) }
OR  { reg8 \| imm8 \| (HL) }
XOR { reg8 \| imm8 \| (HL) }
CPL
```

(Side note... AND (∧) and XOR (⊕) are multiplication and addition in the field of two elements. Can recover OR (∨) as A∨B = (A∧B)⊕(A⊕B) and NOT (¬) as ¬A=A⊕1)

#### Practical perspective

"I want _these_ bits _set_" - Use OR, 1's on the bits you care about.

"I want _these_ bits _clear_" - Use AND, 0's on the bits you care about.

"I want to _toggle_ some of _these_ bits" - Use XOR, 1's on the bits you care about.

What can we do with these?

1. 16-bit counters:
    ```
    Loop:
    DEC    BC         ; Update the counter
    LD     A, B        ; Load one half of the counter
    OR     C          ; Bitmask with the other half of the counter
    JR     NZ, Loop    ; If Z is reset then neither B or C is zero, so repeat
    ```
    In the above example, BC == 0 if and only if Z is set.

2. Calculating remainders:

    ```
        AND    %00011111     ; A = A mod 32
        AND    %00000111     ; A = A mod 8
    ```
    This can be used in a count loop to keep a, say `mod 8` counter.
3. Optimizations
    |Instruction|Bytes|Cycles|BITWISE HOTNESS|Bytes|Cycles|Notes
    |-|-|-|-|-|-|-
    `CP 0`|2|7|`OR A` or `AND A`| 1|4 | P/V is affected differently.
    `LD A, 0`|2|7|`XOR A` or `SUB A`|1|4| Hits flags.
4. Signed arithmetic
    
    XORing the Sign and Overflow flags correspond to the 4 possible results.

#### Single-bit instructions


|Instruction| Description|
|-|-
`SET n, { reg8 \| (HL) }`| Sets bit $n$
`RES n, { reg8 \| (HL) }`| Resets bit $n$ 
`BIT n, { reg8 \| (HL) }`| Tests bit $n$