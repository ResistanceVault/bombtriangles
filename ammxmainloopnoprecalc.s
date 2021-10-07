ammxmainloop3:
                       movem.l                     d0-d7/a0-a6,-(sp)    
  
                       SWAP_BPL
                       bsr.w                       CLEAR

                       move.w                      MUSICCOUNTER,d1
                       cmpi.w                      #64,d1
                       bne.s                       musicnoreset
                       move.w                      #$0000,MUSICCOUNTER
                       subi.l                      #1,BEATCOUNTER
                       bne.s                       noresetbeatcounter
                       move.l                      BEATDELAY,BEATCOUNTER
                       add.l                       #4,DRAWFUNCTCOUNTER

noresetbeatcounter:
                       IFD                         USE_MUSICCOUNTER
                       move.w                      #$0FF0,$dff180
                       ENDC

                       bra.s                       musicaddcounter
musicnoreset:
                       IFD                         USE_MUSICCOUNTER
                       move.w                      #$0000,$dff180
                       ELSE
                       nop
                       ENDC
musicaddcounter:
                       add.w                       #1,MUSICCOUNTER


                       lea                         DRAWFUNCTARRAY_START(PC),a0
                       add.l                       DRAWFUNCTCOUNTER(PC),a0
                       cmp.l                       #DRAWFUNCTARRAY_END,a0
                       bne.s                       drawfunctcounternoreset

                       move.l                      #0,DRAWFUNCTCOUNTER
                       lea                         DRAWFUNCTARRAY_START,a0
drawfunctcounternoreset:

                   ; execute the drawing routine
                       move.l                      (a0),a0
                       jsr                         (a0)
                         
                   
                       movem.l                     (sp)+,d0-d7/a0-a6
                       move.l                      SCREEN_PTR_0,d0

                       rts


CLEAR: 
                       WAITBLITTER
                       move.w                      #$0100,$dff040
                       move.w                      #$0000,$dff042        
                       move.l                      SCREEN_PTR_0,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ;D mod
                       move.w                      #$8014,$dff058
                       rts

CLEAR_BPL_1: 
                       WAITBLITTER
                       move.w                      #$0100,$dff040
                       move.w                      #$0000,$dff042        
                       move.l                      SCREEN_PTR_0,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ;D mod
                       move.w                      #$4014,$dff058
                       rts

CLEAR_BPL_2: 
                       btst                        #6,$dff002
waitblit_copy4bis:
                       btst                        #6,$dff002
                       bne.s                       waitblit_copy4bis
                       move.w                      #$0100,$dff040
                       move.w                      #$0000,$dff042        
                       move.l                      SCREEN_PTR_1,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ;D mod
                       move.w                      #$4014,$dff058
                       rts



FRAMECOUNTER:          dc.w                        0 
MUSICCOUNTER:          dc.w                        0

DRAWFUNCTCOUNTER:      dc.l                        0
BEATCOUNTER:           dc.l                        1
BEATDELAY:             dc.l                        1

DRAWFUNCTARRAY_START:
                       dc.l                        BIGTRIANGLE_Z
                       dc.l                        BIGTRIANGLE_Z_2
                       dc.l                        DOUBLETRIANGLE
                       dc.l                        SMALLTRIANGLE
                       dc.l                        MEDIUMTRIANGLE
                       dc.l                        BIGTRIANGLE
DRAWFUNCTARRAY_END:

SMALLTRIANGLE:
                       LOADIDENTITY
                       VERTEX_INIT                 1,#0,#-10,#0
                       VERTEX_INIT                 2,#10,#10,#0
                       VERTEX_INIT                 3,#-10,#10,#0
                       ROTATE_X_INV_Q_5_11         ANGLE
                       jsr                         TRIANGLE3D_NODRAW
                       bsr.w                       increase_angle_by_1

                       WAITBLITTER
                       STROKE                      #3
                       jsr                         ammx_fill_table
                       rts

MEDIUMTRIANGLE:
                       LOADIDENTITY
                       VERTEX_INIT                 1,#0,#-25,#0
                       VERTEX_INIT                 2,#25,#25,#0
                       VERTEX_INIT                 3,#-25,#25,#0
                       ROTATE_X_INV_Q_5_11         ANGLE
                       jsr                         TRIANGLE3D_NODRAW
                       bsr.w                       increase_angle_by_1

                       WAITBLITTER
                       STROKE                      #3
                       jsr                         ammx_fill_table
                       rts

BIGTRIANGLE:
                       LOADIDENTITY
                       VERTEX_INIT                 1,#0,#-50,#0
                       VERTEX_INIT                 2,#50,#50,#0
                       VERTEX_INIT                 3,#-50,#50,#0
                       ROTATE_X_INV_Q_5_11         ANGLE
                       jsr                         TRIANGLE3D_NODRAW
                       bsr.w                       increase_angle_by_1

                       WAITBLITTER
                       STROKE                      #3
                       jsr                         ammx_fill_table
                       rts

BIGTRIANGLE_Z_YPOS:    dc.w                        0
BIGTRIANGLE_Z_COORDS:
                    ;dc.w 0,0,2,2,4,5,6,7,8,10,11,12,13,14,15,17,17,19,19,22,21,24,23,26,25,29,27,31,30,33,32,36,34,38,36,41,38,43,40,45,42,48,44,50,46,53,49,55,51,57,53,60,55,62,57,65,59,67,61,69,63,72,65,74,68,77,70,79,72,81,74,84,76,86,78,88,80,91,82,93,84,96,86,98,89,100,91,103,93,105,95,108,97,110,99,112,101,115,103,117,105,120,108,122,110,124,112,127,114,129,116,131,118,134,120,136,122,139,124,141,127,143,129,146,131,148,133,151,135,153
                    ; dc.w 0,0,2,2,4,5,6,7,8,10,11,12,13,14,15,17,17,19,19,22,21,24,23,26,25,29,27,31,30,33,32,36,34,38,36,41,38,43,40,45,42,48,44,50,46,53,49,55,51,57,53,60,55,62,57,65,59,67,61,69,63,72,65,74,68,77,70,79,72,81,74,84,76,86,78,88,80,91,82,93,84,96,86,98,89,100,91,103,93,105,95,108,97,110,99,112,101,115,103,117,105,120,108,122,110,124,112,127,114,129,116,131,118,134,120,136,122,139,124,141,127,143,129,146,131,148,133,151,135,153
                       dc.w                        -25,-25,-23,-22,-20,-19,-18,-17,-15,-14,-13,-11,-10,-8,-8,-6,-5,-3,-3,0,0,3,3,6,5,8,8,11,10,14,13,17,15,20,18,22,20,25,23,28,25,31,28,33,30,36,33,39,35,42,38,45,40,47,43,50,45,53,48,56,50,58,53,61,55,64,58,67,60,70,63,72,65,75,68,78,70,81,73,83,75,86,78,89,80,92,83,95,85,97,88,100,90,103,93,106,95,109,98,111,100,114,103,117,105,120,108,122,110,125,113,128,115,131,118,134,120,136,123,139,125,142,128,145,130,147,133,150,135,153
BIGTRIANGLE_Z:
                       movem.l                     d0-d6/a0/a1,-(sp)
                       
                       move.w                      #%0100001000000000,BPLCON0POINTER

                       ENABLE_CLIPPING
                   
                     ;LOADIDENTITY

                       lea                         BIGTRIANGLE_Z_COORDS(PC),a1
                       move.w                      BIGTRIANGLE_Z_YPOS(PC),d1
                       adda                        d1,a1

                       move.w                      (a1),d0
                       asl.w                       #6,d0
                       move.w                      2(a1),d1
                       asl.w                       #6,d1
                     jsr                    TRANSLATE
                       LOADIDENTITYANDTRANSLATE    d0,d1
                       ROTATE                      ANGLE
                       

                       move.w                      #0,d0
                       move.w                      #-25,d1

                       move.w                      #-25,d6
                       move.w                      #25,d3

                       move.w                      #25,d4
                       move.w                      #25,d5
	
                       jsr                         TRIANGLE_NODRAW

                       

                       moveq                       #6,d0
                       bsr.w                       increase_angle_by_n

                       

                       WAITBLITTER
                       STROKE                      #3
                       jsr                         ammx_fill_table_clip
                       DISABLE_CLIPPING

                       
                       add.w                       #4,BIGTRIANGLE_Z_YPOS

                     ; if last frame of the section blit the triangle on bitplane 3
                       cmpi.w                      #64*4,BIGTRIANGLE_Z_YPOS
                       bne.s                       BIGTRIANGLE_Z_EXIT
                       move.l                      #$FFFFFFFF,SCREEN_2
                       move.w                      #0,BIGTRIANGLE_Z_YPOS

BIGTRIANGLE_Z_EXIT:
                       movem.l                     (sp)+,d0-d6/a0/a1
                       rts

BIGTRIANGLE_Z_2_YPOS:  dc.w                        0
BIGTRIANGLE_Z_2_COORDS: 
                       dc.w                        350,-25,347,-22,343,-19,340,-17,337,-14,333,-11,330,-8,326,-6,323,-3,320,0,316,3,313,6,310,8,306,11,303,14,300,17,296,20,293,22,290,25,286,28,283,31,279,33,276,36,273,39,269,42,266,45,263,47,259,50,256,53,253,56,249,58,246,61,243,64,239,67,236,70,232,72,229,75,226,78,222,81,219,83,216,86,212,89,209,92,206,95,202,97,199,100,195,103,192,106,189,109,185,111,182,114,179,117,175,120,172,122,169,125,165,128,162,131,159,134,155,136,152,139,148,142,145,145,142,147,138,150,135,153

BIGTRIANGLE_Z_2:
                       movem.l                     d0-d6/a1,-(sp)
                       move.w                      #%0100001000000000,BPLCON0POINTER

                       ENABLE_CLIPPING
                   
                       lea                         BIGTRIANGLE_Z_2_COORDS(PC),a1
                       move.w                      BIGTRIANGLE_Z_2_YPOS(PC),d1
                       adda                        d1,a1

                       move.w                      (a1),d0
                       asl.w                       #6,d0
                       move.w                      2(a1),d1
                       asl.w                       #6,d1
                       LOADIDENTITYANDTRANSLATE    d0,d1
                       ROTATE                      ANGLE

                       move.w                      #0,d0
                       move.w                      #-25,d1

                       move.w                      #-25,d6
                       move.w                      #25,d3

                       move.w                      #25,d4
                       move.w                      #25,d5
	
                       jsr                         TRIANGLE_NODRAW

                       moveq                       #6,d0
                       bsr.w                       increase_angle_by_n

                       WAITBLITTER
                       STROKE                      #3
                       jsr                         ammx_fill_table_clip
                       DISABLE_CLIPPING
                       add.w                       #4,BIGTRIANGLE_Z_2_YPOS

                     ; if last frame of the section blit the triangle on bitplane 3
                       cmpi.w                      #64*4,BIGTRIANGLE_Z_2_YPOS
                       bne.s                       BIGTRIANGLE_Z_2_EXIT
                       move.w                      #0,BIGTRIANGLE_Z_2_YPOS

BIGTRIANGLE_Z_2_EXIT:
                       movem.l                     (sp)+,d0-d6/a1
                       rts


DOUBLETRIANGLE:
                       movem.l                     d0-d7/a0-a6,-(sp)

                       move.w                      #%0010001000000000,BPLCON0POINTER

                       LOADIDENTITY
                       VERTEX_INIT                 1,#0,#-50,#0
                       VERTEX_INIT                 2,#50,#50,#0
                       VERTEX_INIT                 3,#-50,#50,#0
                       ROTATE_X_INV_Q_5_11         ANGLE
                       IFD                         DEBUGCOLORS
                       move.w                      #$00F0,$dff180
                       ENDC
                       jsr                         TRIANGLE3D_NODRAW
                       IFD                         DEBUGCOLORS
                       move.w                      #$0AAA,$dff180
                       ENDC
                       bsr.w                       increase_angle_by_1

                       WAITBLITTER
                       STROKE                      #3
                       bsr.w                       ammx_fill_table_reversed              
                       movem.l                     (sp)+,d0-d7/a0-a6
                       rts

ANGLE:                 dc.w                        0

increase_angle_by_1:
                       add.w                       #1,ANGLE
                       cmpi.w                      #360,ANGLE
                       bcs.s                       increase_angle_by_1_exit
                       move.w                      #0,ANGLE
increase_angle_by_1_exit:
                       rts

increase_angle_by_n:
                       add.w                       d0,ANGLE
                       cmpi.w                      #360,ANGLE
                       bcs.s                       increase_angle_by_1_exit
                       move.w                      #0,ANGLE
increase_angle_by_n_exit:
                       rts

; draws the same figure into the second bpl but reversed
; clipping each line
COUNTER_REVERSED:
                       dc.w                        0

ammx_fill_table_reversed:
                       movem.l                     d0/d2-d7/a0/a1/a2/a3/a4/a5/a6,-(sp)                                                                                                                                                                                                                                                                                                                                                                                                                                                             ; stack save

                       move.w                      #1,AMMX_FILL_TABLE_FIRST_DRAW
                       move.w                      AMMXFILLTABLE_END_ROW,d5

                       lea                         FILL_TABLE,a0

	; Reposition inside the fill table according to the starting row
                       move.w                      AMMXFILLTABLE_CURRENT_ROW,d6
                       move.w                      d6,d1
                       lsl.w                       #2,d6
                       add.w                       d6,a0
	; end of repositioning

                       MINUWORD                    d1,FILLTABLE_FRAME_MIN_Y
                       MAXUWORD                    d5,FILLTABLE_FRAME_MAX_Y

                       sub.w                       d1,d5
                       bmi.w                       ammx_fill_table_end_reversed

                       lea                         PLOTREFS,a4
                       add.w                       d1,d1
                       move.w                      0(a4,d1.w),d1

                       IFD                         USE_DBLBUF
                       move.l                      SCREEN_PTR_0,a5
                       ELSE
                       lea                         SCREEN_0,a5
                       ENDC

                       move.l                      #$7FFF8000,a2
                       move.w                      #40,a6

                       move.w                      #$0000,COUNTER_REVERSED
ammx_fill_table_nextline_reversed:

                       move.w                      (a0),d6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ; start of fill line
                       move.w                      2(a0),d7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ; end of fill line
                       move.l                      a2,(a0)+
	
                       jsr                         ammx_fill_table_single_line_bpl1

	; experimental, calculate the top of the figure addr in a1
                       move.l                      SCREEN_PTR_0,a1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ; experimental
                       adda.w                      d1,a1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ; experimental (now a1 is the addr of the top of the figure)

	; blitting in reverse
                       WAITBLITTER
                       move.w                      #$09F0,$dff040
                       move.w                      #$0000,$dff042
                       move.l                      a1,$dff050                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ; bltAptr
                       adda.l                      #40*256,a1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ; experimental go to bpl 2
                       move.w                      d5,d0
                       sub.w                       COUNTER_REVERSED,d0
                       mulu.w                      #40,d0
                       adda.w                      d0,a1
                       add.w                       #1,COUNTER_REVERSED
                       move.l                      a1,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ; copy to d channel
                       move.w                      #$0000,$dff064
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ;D mod
                       move.w                      #$0054,$dff058
	; end blitting in reverse
                       add.w                       a6,d1
	
                       dbra                        d5,ammx_fill_table_nextline_reversed
ammx_fill_table_end_reversed:
                       move.w                      #-1,AMMXFILLTABLE_END_ROW
                       movem.l                     (sp)+,d0/d2-d7/a0/a1/a2/a3/a4/a5/a6
                       rts