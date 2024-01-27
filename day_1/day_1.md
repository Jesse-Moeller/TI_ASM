We're gonna write assembly for ti83+. Here's the tools:

- Wabbitemu (needs ti83+ ROM)
	- Emulator for all TI calculators
- spasm
	- z80 assembler

#### Using Spasm

Pretty simple. Save text files as `*.asm` and assemble them to programs using spasm.

`spasm source.asm HELLO.8xp`

You list the file extension based on what you're building. Here's a table:

`.73p`
 - TI-73 program
`.82p`
 - TI-82 program
`.83p`
 - TI-83 program
`.8xp`
 - TI-83+ (and 84+) program
`.8xv`
 - TI-83+ application variable
`.85p, .85s`
 - TI-85 program or string
`.86p, .86s`
 - TI-86 program or string
`.8xk`
 - TI-83+ (and 84+) Flash application (APP)
`.bin, .hex`
 - Unprocessed binary, or binary in Intel Hex format

Will need various includes for the different calculators. On windows the assemble call might look like `.\spasm64.exe -I .\inc\ .\hello_world.asm HELLO.8xp`. Once the output file has been correctly tagged with the TI file suffix Wabbitemu can load them by just using the `File->Open` UI.

