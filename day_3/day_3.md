# Number Systems, Registers, Memory, Variables
### Groups of bits
| Name | Number of consecutive (0/1)s
| - | - 
| bit | 1
| nibble | 4
| byte | 8
| word | 16
| dword | 32
| quadword | 64

### Numbers

The non-decimal number formats in spasm can be specified with prefixes or suffixes.

| Prefix | Suffix | Base |
| - | - | - |
| %_ | _b | binary |
| $_ | _h | Hexadecimal |
| @_ | _o | Octal |
| _ | _d | Deximal |

### Registers

Registers are sections of very expensive RAM inside the CPU that are used to store and rapidly operate on numbers. For the z80, at least for now, will look at `A B C D E F H L` and `IX`. The single-letter registers are 8 bits. `2^8 = 256`, so we can store `0-255`. Registers can be _combined_ into four register pairs:

```
A F
B C
D E
H L
```

These, together with `IX`, are 16-bit and can store a number in the range `0-65535`. Some registers have special purposes.

### 8-bit Registers

 - `A` as Accumulator is primary register for arithmetic ops and for accessing memory.
 - `B` as an 8-**b**it counter.
 - `C` for... hardware ports?
 - `F` is for flags.

### 16-bit Registers

- `HL` has two purposes.
    1. Like the 16 bit accumulator.
    2. Stores **h**igh and **l**ow bytes of addresses.
- `BC` used by instructions and code sections that operate on streams of bytes as a **b**yte **c**ounter
- `DE` holds the memory address of a **de**stination.
- `IX` let's say this is the **i**nde**x** register. Using `IX` results in slower and more inflated code over `HL`, even though they are mostly interchangeable (why **???**).

### Loading

To store to a register, use the `LD` instruction.

`LD destination, source`

Among the registers we have discussed, these are the valid load operations:

S↓D→|A|B|C|D|E|H|L|BC|DE|HL|(BC)|(DE)|(HL)|(imm16)
|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|
|A |✓|✓|✓|✓|✓|✓|✓||||✓|✓|✓|✓
|B |✓|✓|✓|✓|✓|✓|✓||||||✓|
|C |✓|✓|✓|✓|✓|✓|✓||||||✓|
|D |✓|✓|✓|✓|✓|✓|✓||||||✓|
|E |✓|✓|✓|✓|✓|✓|✓||||||✓|
|H |✓|✓|✓|✓|✓|✓|✓||||||✓|
|L |✓|✓|✓|✓|✓|✓|✓||||||✓|
|BC ||||||||||||||✓
|DE ||||||||||||||✓
|HL ||||||||||||||✓
|(BC)|✓
|(DE)|✓
|(HL)|✓|✓|✓|✓|✓|✓|✓
|(imm16)|✓|||||||✓|✓|✓
|imm8|✓|✓|✓|✓|✓|✓|✓||||||✓
|imm16||||||||✓|✓|✓

(`imm_` means "immediate value")

#### Examples

 - `LD A, 25` stores 25 into register A.
 - `LD D, B` loads value in `B` into `D`.
 - `LD (8325h), A` loads the value of `A` into the address `8325h`. Note that we can only de-reference `imm16` in the table above.

#### What the hell:

We can't do `LD BC, DE`, must do
```
LD B, D
LD C, E
```

### Signed Numbers

Lots of schemes for making a string of bits represent a negative number, but we ill only focus on two's complement. The most significant bit tells us if the number is negative or not. If it's positive, the representation is like a normal unsigned number excpet we're capped at `2^7-1`.


`01111111b = 127`

If the sign bit is flipped, then we subtract the bits from zero (wrapping around).

`11111111b (unsigned)= 255`

`11111111b (signed)= -1`****

### Memory and Location

The Ti-83+ `RAM` consists of 32 Kb. The address space is `%8000` to `%FFFF` (`%0000` through `%7FFF` are for `ROM`). 

(Wait a second... 2^(16 - 3) = 8192 bytes, how do we have 32 kilobytes? Can we only address 4 bytes at a time **???**)

When you run a program, the calculator takes the series of bytes and transfers them to some other place in memory (`$9D95`) sending everything to the processor. Assembly is the process of converting instructions to bytes. An instruction can take one to four bytes, and a `ROM` call takes up three bytes. The location counter is the location of memory in the program relative to the start. This can be used in programs by `$` or `*`.

### Literals

Constant values implicit from how it's expressed in source. For instance, `86` and `Hello, world!`. There's integers, characters, and strings.

### Text

Text constants are discernable from string constants in that they aren't flanked by "". Text are used by the assembler to create the program. The whole source file is a text constant.

### Manifest Constant

A stand-in for a literal constant (like constexpr?). Can assign literals to symbols. Valid symbols are comprised of letters, digits, underscores and periods. Maximum 32 characters long. First character is a letter or an underscore.

### Equates

Use `=` or `.equ` or `.EQU`, see the header files for instance.

### Labels

Labels are symbols followed by a colon and can be used anywhere in the program where a word value can be put. For instance:

```
Label:                    ; L.C. = $9452
    LD     HL, Label      ; HL = $9452
```

### Local Labels

```
.org $1000
.MODULE    x
_local:
           LD HL, _local

.MODULE    y
_local     .equ $5000
           LD HL, _local
```
(**???** this doesn't assemble with SPASM)

### Macros

Pretty straightforward:

`#define symbol literal`. Can use `#defcont` with multiple lines, where the macro'd code needs explicit `\`s to denote the line breaking.

### Variables

Too few registers, not good for variables. There are two ways to create a "variable".

1. At the end of a program, create a label that will be used to access this variable. emmediately after, allocate memory for the variable using `.db value_list` or `.dw value_list`. Note that these just insert bytes into the program. 

    So, with our hello world,

    ```
    msg:
        .db "Hello world!", 0
    ```
    creates the label `msg` whose numeric value is the address of the bytes that we're inserting into memory with `.db "Hello world!"`. We load this address into the `HL` register with 

    ```
        ld hl, msg
        bcall(_PutS)            ; Display the text
        bcall(_NewLine)
    ```

    and, presumably `_PutS` prints characters beginning at an address.

2. Use memory that's not gonna get used (TI specific). For instance, `AppBackUpScreen` has already carved out 768 bytes for us. So we can do things like

    ``` 
    garbage = AppBackUpScreen+4
    refuse = AppBackUpScreen+8
    ```

Note: storing 16 bits requires two bytes, surprise surprise!

```
LD HL, 5611
LD (garbage), HL
```

5611 > 255, in fact 5611 = `15 EB`. So, this instruction will manipulate garbage, and garbage+1.

