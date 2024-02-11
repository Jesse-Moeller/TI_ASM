# Data Manipulation

#### Adding and Subtracting

We have some pretty basic instructions:
|Syntax|Function|FLAGS
|-|-|-
`INC { reg8 \| reg16 \| (HL) }` | Adds one to the operand. | `S,Z,P/V (overflow)`
`DEC { reg8 \| reg16 \| (HL) }` | Subtracts one to the operand. | `S,Z,P/V (overflow)`
`ADD A, { reg8 \| imm8 \| (HL) }` | Adds operand to (8-bit) accumulator. | `S,Z,P/V,C (overflow)`
`ADD {HL | IX | IY}, reg16` | Adds operand to 16 bit register (*).| `S,Z,P/V (overflow),C`
`SUB { reg8 \| imm8 \| (HL) }` | Subtracts operand from the accumulator.| `S,Z,P/V (overflow),C`
`SBC A, { reg8 \| imm8 \| (HL) }` | Subtracts operand _and_ carry flag from (8-bit) accumulator.| `S,Z,P/V (overflow),C`
`SBC HL, reg16` | Subtracts operand _and_ carry flag from(16-bit) accumulator.| `S,Z,P/V (overflow),C`

(`reg8` (`reg16`) means "any 8-bit (16-bit) register")

(*) - The registers `HL` and (`IX`/`IY`) are mutually exclusive. If the first operand is HL, the second can be any other 16-bit register except (`IX`/`IY`)

#### 16-bit Subtraction

If we don't want to use `SBC` to modify `HL`, we can also do `ADD HL, reg16` where we've loaded into `reg16` some negative number. Sometimes, though, we may beed to do `SBC` when we want to subtract, because we can't use `HL` to negate a value that's already in some other register. So we have to clear the carry flag before `SBC`ing.

```
SCF -- set carry flag
CCF -- COMPLEMENT carry flag
SBC HL, BC
```

That's an annoying waste of 8 cycles :)

If we want to negate a 16 bit register for purposes of `ADD` subtraction, we can do the two's complement:
```
	LD     A, B
	CPL
	LD     B, A
	LD     A, C
	CPL
	LD     C, A
; We have now found the one's complement of BC so, by definition of
; the two's complement:
	INC    BC
```

#### Multiplication

It's repeated addition!

#### Division

Later. 

#### Overflow

```
LD A, 203
ADD A, 119
```

`A` will hold 66, and the carry flag will be set.

#### Registers and RAM

```
LD HL, $D361
```

This yields

|H|L
|-|-
|D3|61 

However, `LD ($2315), HL` subsequently will result in 

|$2315|$2316
|-|-
|61|D3 

This is called "little endian", becauase the little end goes first.

#### Arrays

An array is a collection of data structures, each exactly the same. The structure can be as simple as a single byte or as complex as a set of records. As long as you are consistent. The address of any given element in the array is simply `base_address + index * size_of_element`.

#### Structures

(**???** documentation seems to use TASM struct, need to look at this again later.)