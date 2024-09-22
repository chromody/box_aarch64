
//The box() function must be written in ARMv8 assembler.  The code below is given to get you started:

.global     box
.extern     _term_txtheight
.extern     _term_txtwidth

box:
 //------------------------------------------------------------------Prologue
    // standard entry: save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!

    // Save the arguments.  Called functions may overwrite x0-x3
    sub     sp, sp, 32
    stp     x0, x1, [sp]
    stp     x2, x3, [sp, 16]

    // sr in w0, sc in w1, er in w2, ec in w3
    
//--------------------------------------------------------------------

    // Make sure the argument are valid
    //passing variable onto function
    sub sp, sp, 32 //startRow, startColumn, endRow, endColumn need to be saved on stack
    stp w0, w1, [sp]
    stp w2, w3, [sp, 16]
    bl      _box_check_box_
    ldp w0, w1, [sp]
    ldp w2, w3, [sp, 16]
    add sp, sp, 32


    cmp     w0, 0
    bne     _box_error_

 
    // first, draw the corners:
    // +        +
    // +        +
    ldp     x0, x1, [sp]
    ldp     x2, x3, [sp, 16]
    bl      _box_draw_corners_

    // Now, draw the top and bottom:
    // +------+
    // +------+

    // You figure out what goes here

    // draw left and right sides

    // You figure out what goes here

    mov     w0, 0
    b       _box_exit_

_box_error_:
    mov     w0, 1

_box_exit_:
    add     sp, sp, 32   // pop save arg regs

    ldp     x29, x30, [sp], 16
    ret
    
/*
    Inputs: startRow, startColumn, endRow, endColumn
    Purpose: to check if the bounds make logical sense
    Functions called: int term_txtheight(), int term_txtwidth()
    Total registers: sp, x0, x30(link register), w0 (startRow), w1(startColumn), w2(endRow), w3(endColumn), x9(term_txtheight), x10(term_txtwidth)
*/
 _box_check_box_:
    //Prologue
    //    save link and stack frame registers
    //    load the stack frame with the pointer to current frame
    stp     x29, x30, [sp, -16]!
    ldp w0, w1, [sp, 16]
    ldp w2, w3, [sp, 32]


    //----------------------Getting max height
    sub sp, sp, 16
    stp x30, x0, [sp]
    bl term_txtheight // calling function for max height\

    sub sp, sp, 16
    str x0, [sp]
    ldr x9, [sp]
    add sp, sp, 16

    ldp x30, x0, [sp]
    add sp, sp, 16
    //----------------------

    //----------------------Getting max height
    sub sp, sp, 16
    stp x30, x0, [sp]
    bl term_txtwidth // calling function for max height\

    sub sp, sp, 16
    str x0, [sp]
    ldr x10, [sp]
    add sp, sp, 16

    ldp x30, x0, [sp]
    add sp, sp, 16
    //----------------------

    //----------------------Checking for error
    cmp x2, x9 //comparing endRow max_width
    bge _box_check_box_error

    cmp x3, x10 //comparing endColumn max_height
    bge _box_check_box_error

    cmp x2, x0
    blt _box_check_box_error

    cmp x3, x1
    blt _box_check_box_error
    //----------------------

    //Epilogue
    ldp     x29, x30, [sp], 16
    ret
    //

    _box_check_box_error:
        ldp     x29, x30, [sp], 16
        ret

 _box_draw_corners_:
 	ret
