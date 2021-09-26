ammxmainloop3:
                   movem.l                d0-d7/a0-a6,-(sp)    
  
                   SWAP_BPL
                   bsr.w                  CLEAR

                   move.w                 MUSICCOUNTER,d1
                   cmpi.w                 #64,d1
                   IFD                    DEBUGCOLORS
                   move.w                 #$0AAA,$dff180
                   ENDC
                   add.w                  #1,MUSICCOUNTER

                   bsr.w                  calculate_triangle
                   
                   WAITBLITTER
                
                   STROKE                 #3

                   bsr.w                  ammx_fill_table_reversed                    
                   
                   movem.l                (sp)+,d0-d7/a0-a6
                   move.l                 SCREEN_PTR_0,d0

                   rts


CLEAR: 
                   WAITBLITTER
                   move.w                 #$0100,$dff040
                   move.w                 #$0000,$dff042        
                   move.l                 SCREEN_PTR_0,$dff054                    ; copy to d channel
                   move.w                 #$0000,$dff066                          ;D mod
                   move.w                 #$8014,$dff058
                   rts

CLEAR_BPL_1: 
                   WAITBLITTER
                   move.w                 #$0100,$dff040
                   move.w                 #$0000,$dff042        
                   move.l                 SCREEN_PTR_0,$dff054                    ; copy to d channel
                   move.w                 #$0000,$dff066                          ;D mod
                   move.w                 #$4014,$dff058
                   rts

CLEAR_BPL_2: 
                   btst                   #6,$dff002
waitblit_copy4bis:
                   btst                   #6,$dff002
                   bne.s                  waitblit_copy4bis
                   move.w                 #$0100,$dff040
                   move.w                 #$0000,$dff042        
                   move.l                 SCREEN_PTR_1,$dff054                    ; copy to d channel
                   move.w                 #$0000,$dff066                          ;D mod
                   move.w                 #$4014,$dff058
                   rts



FRAMECOUNTER:      dc.w                   0 
MUSICCOUNTER:      dc.w                   0

DRAWFUNCTCOUNTER:  dc.l                   0

DRAWFUNCTARRAY_START: 
                   dc.l                   BIGTRIANGLE_Z
                   dc.l                   SMALLTRIANGLE
                   dc.l                   MEDIUMTRIANGLE
                   dc.l                   BIGTRIANGLE
DRAWFUNCTARRAY_END:

SMALLTRIANGLE:
                   RESETFILLTABLE
                   LOADIDENTITY
                   VERTEX_INIT            1,#0,#-10,#0
                   VERTEX_INIT            2,#10,#10,#0
                   VERTEX_INIT            3,#-10,#10,#0
                   ROTATE_X_INV_Q_5_11    d1
                   jsr                    TRIANGLE3D_NODRAW
                   rts

MEDIUMTRIANGLE:
                   RESETFILLTABLE
                   LOADIDENTITY
                   VERTEX_INIT            1,#0,#-25,#0
                   VERTEX_INIT            2,#25,#25,#0
                   VERTEX_INIT            3,#-25,#25,#0
                   ROTATE_X_INV_Q_5_11    d1
                   jsr                    TRIANGLE3D_NODRAW
                   rts

BIGTRIANGLE:
                   RESETFILLTABLE
                   LOADIDENTITY
                   VERTEX_INIT            1,#0,#-50,#0
                   VERTEX_INIT            2,#50,#50,#0
                   VERTEX_INIT            3,#-50,#50,#0
                   ROTATE_X_INV_Q_5_11    d1
                   jsr                    TRIANGLE3D_NODRAW
                   rts

BIGTRIANGLE_Z:
                   movem.l                d0-d6/a1,-(sp)
                   move.l                 d1,d6
                   andi.l                 #$0000FFFF,d6
                   RESETFILLTABLE
                   LOADIDENTITY

                   move.w                 #160,d0
                   move.w                 #128,d1
                   jsr                    TRANSLATE
                   ROTATE                 d6


                   move.w                 #0,d0
                   move.w                 #-15,d1

                   move.w                 #-15,d6
                   move.w                 #15,d3

                   move.w                 #15,d4
                   move.w                 #15,d5


	
                   jsr                    TRIANGLE_NODRAW
                   movem.l                (sp)+,d0-d6/a1


                   rts


	
calculate_triangle:
                   movem.l                d0-d7/a0-a6,-(sp)    

                   LOADIDENTITY
                   VERTEX_INIT            1,#0,#-50,#0
                   VERTEX_INIT            2,#50,#50,#0
                   VERTEX_INIT            3,#-50,#50,#0
                   ROTATE_X_INV_Q_5_11    ANGLE
                   IFD                    DEBUGCOLORS
                   move.w                 #$00F0,$dff180
                   ENDC
                   jsr                    TRIANGLE3D_NODRAW
                   IFD                    DEBUGCOLORS
                   move.w                 #$0AAA,$dff180
                   ENDC
                   add.w                  #1,ANGLE
                   cmpi.w                 #360,ANGLE
                   bne.s                  disegnaexit
                   move.w                 #0,ANGLE
disegnaexit:
                   movem.l                (sp)+,d0-d7/a0-a6
                   rts

ANGLE:             dc.w                   0

; draws the same figure into the second bpl but reversed
; clipping each line
COUNTER_REVERSED:
                   dc.w                   0

ammx_fill_table_reversed:
                   movem.l                d0/d2-d7/a0/a1/a2/a3/a4/a5/a6,-(sp)     ; stack save

                   move.w                 #1,AMMX_FILL_TABLE_FIRST_DRAW
                   move.w                 AMMXFILLTABLE_END_ROW,d5

                   lea                    FILL_TABLE,a0

	; Reposition inside the fill table according to the starting row
                   move.w                 AMMXFILLTABLE_CURRENT_ROW,d6
                   move.w                 d6,d1
                   lsl.w                  #2,d6
                   add.w                  d6,a0
	; end of repositioning

                   MINUWORD               d1,FILLTABLE_FRAME_MIN_Y
                   MAXUWORD               d5,FILLTABLE_FRAME_MAX_Y

                   sub.w                  d1,d5
                   bmi.w                  ammx_fill_table_end_reversed

                   lea                    PLOTREFS,a4
                   add.w                  d1,d1
                   move.w                 0(a4,d1.w),d1

                   IFD                    USE_DBLBUF
                   move.l                 SCREEN_PTR_0,a5
                   ELSE
                   lea                    SCREEN_0,a5
                   ENDC

                   move.l                 #$7FFF8000,a2
                   move.w                 #40,a6

                   move.w                 #$0000,COUNTER_REVERSED
ammx_fill_table_nextline_reversed:

                   move.w                 (a0),d6                                 ; start of fill line
                   move.w                 2(a0),d7                                ; end of fill line
                   move.l                 a2,(a0)+
	
                   jsr                    ammx_fill_table_single_line_bpl1

	; experimental, calculate the top of the figure addr in a1
                   move.l                 SCREEN_PTR_0,a1                         ; experimental
                   adda.w                 d1,a1                                   ; experimental (now a1 is the addr of the top of the figure)

	; blitting in reverse
                   WAITBLITTER
                   move.w                 #$09F0,$dff040
                   move.w                 #$0000,$dff042
                   move.l                 a1,$dff050                              ; bltAptr
                   adda.l                 #40*256,a1                              ; experimental go to bpl 2
                   move.w                 d5,d0
                   sub.w                  COUNTER_REVERSED,d0
                   mulu.w                 #40,d0
                   adda.w                 d0,a1
                   add.w                  #1,COUNTER_REVERSED
                   move.l                 a1,$dff054                              ; copy to d channel
                   move.w                 #$0000,$dff064
                   move.w                 #$0000,$dff066                          ;D mod
                   move.w                 #$0054,$dff058
	; end blitting in reverse
                   add.w                  a6,d1
	
                   dbra                   d5,ammx_fill_table_nextline_reversed
ammx_fill_table_end_reversed:
                   move.w                 #-1,AMMXFILLTABLE_END_ROW
                   movem.l                (sp)+,d0/d2-d7/a0/a1/a2/a3/a4/a5/a6
                   rts