# Rom Call Key Input

#### GetKey

The call `_GetKey` is a blocking call, waiting on keypress. It stores the keycode into `A`. While blocked, some things still get through:

1. Changing contrast (via keypad)
2. Get screen shots over Graph Link
3. Turn calculator off by hitting `2nd`->`ON` (bad!)

The third can be patched with an undocumented ROM call: `_GetKeyRetOff` (if we want this, have to set `_GetKeyRetOff .EQU $500B`). Once executed, all `_GetKey`s behave similarly.

#### Run Indicator

`_RunIndicOff` turns off the pesky run indicator.

`_RunIndicOn` turns on the pesky run indicator.

#### Non-blocking GetKey

Can use `_GetCSC` to do non-blocking version of `_GetKey`. Necessarily it will need to be called in a loop. Note that both of the methods here are passive!