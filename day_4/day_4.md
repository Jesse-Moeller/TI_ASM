# Flags

The 8-bit `F` register has 8 flags.

bit | name | function
|-|-|-
0| C - carry | Indicates unsigned overflow
1| N - add/subtract |(last instruction was addition) ? 0 : 1. Used exclusively with `DAA`.
2| P/V - parity/overflow| Detects signed overflow OR determines the parity of accumulator. Depends on the instruction.
3 | N/A
4 | H - half carry | Used exclusively for the `DAA` instruction.
5 | N/A
6 | Z - zero | if last instruction caused a register to equal zero, this flag is set. Otherwise, flag is reset.
7| S - sign | (`A` evaluated positive) ? 0 : 1

What's `DAA`? It's "decimal adjust accumulator". After two BCD numbers ("binary-coded decimals") are combined, flags are set and the `DAA` is a fixup operation after doing normal arithmetic between BCDs.