## Parts of the z80 Program

### Directives

Things precided by either a period or a #. In the case of `hello_world.asm`,

```
.binarymode TI8X
.nolist
#include "ti83plus.inc"
.list
.org userMem - 2
.db t2ByteTok, tAsmCmp
    bcall(_homeup)
    ld hl, 0
    ld (CurCol), hl         ; Shortcut to setting CurCol and CurRow to 0
    ld hl, msg
    bcall(_PutS)            ; Display the text
    bcall(_NewLine)
    ret
msg:
    .db "Hello world!", 0
.end
```

`.binarymode` tells the Brass assembler that it's a specific type of program. 

```
.nolist
.list
```

affect something called a listing file that the assembler creates. Then 

`#define text1 tex2`

is pure replacement. The `#include` command copies another file line for line. We have also `text .equ number` which finds/replaces `text` with `number` before assembling. The `.db` command specifies data (data bytes?) and `.end` specifies end of the source. The command `.org number` specifies where in memory the program is loaded into. In the case above, peek at `ti83plus.inc` to find the value of `userMem`.

Instructions, which are all the processor knows how to do, are indented. We can also execute ROM calls via `bcall()`. Inspecting the source, we have

`#define bcall(xxxx) rst 28h \ .dw xxxx`

So, there's a lot to unpack here most likely. ROM calls are basically already-written routines that TI has given us. `ret` quits the program. The `_ClrLCDFull` routine clears the screen.

Template:

```
.binarymode TI8X
.nolist
#include    "ti83plus.inc"
.list
.org    $9D93
.db    t2ByteTok, tAsmCmp
    ; Your program goes here.
.end
.end
```