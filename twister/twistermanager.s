TWISTERMANAGER:
    moveq #100,d7 ; twister height
    moveq #0,d5 ; y position
        SETBITPLANE                              0,a0
        lea ROT_Z_MATRIX_Q5_11,a1
    ; d6 is a/amp
    moveq #0,d6

twister_mainloop:
    ;x1=((sin((a/amp)+ang))*32)+150;
;		x2=((sin((a/amp)+ang+90))*32)+150;
;		x3=((sin((a/amp)+ang+90*2))*32)+150;
;		x4=((sin((a/amp)+ang+90*3))*32)+150;

    move.w 4(a1,d6.w),d0
    lsr.w #6,d0
   ; lsr.w #5,d0
    bset                                     d0,(a0,d5.w)
    add.w #40,d5
    addq #8,d6

    dbra d7,twister_mainloop
    rts