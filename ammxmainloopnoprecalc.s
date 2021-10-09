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
                       move.l                      SCREEN_PTR_0,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;D mod
                       move.w                      #$8014,$dff058
                       rts

CLEAR_BPL_1: 
                       WAITBLITTER
                       move.w                      #$0100,$dff040
                       move.w                      #$0000,$dff042        
                       move.l                      SCREEN_PTR_0,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;D mod
                       move.w                      #$4014,$dff058
                       rts

CLEAR_BPL_2: 
                       btst                        #6,$dff002
waitblit_copy4bis:
                       btst                        #6,$dff002
                       bne.s                       waitblit_copy4bis
                       move.w                      #$0100,$dff040
                       move.w                      #$0000,$dff042        
                       move.l                      SCREEN_PTR_1,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;D mod
                       move.w                      #$4014,$dff058
                       rts



FRAMECOUNTER:          dc.w                        0 
MUSICCOUNTER:          dc.w                        0

DRAWFUNCTCOUNTER:      dc.l                        0
BEATCOUNTER:           dc.l                        1
BEATDELAY:             dc.l                        1

DRAWFUNCTARRAY_START:
                       dc.l                        BIGTRIANGLE_Z
                       dc.l                        BIGTRIANGLE_Z
                       dc.l                        BIGTRIANGLE_Z
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

ROTATIONS_ANGLES_64:   dc.w                        005,011,016,022,028,033,039,044,050,056
                       dc.w                        061,067,072,078,084,089,095,100,106,112
                       dc.w                        117,123,129,134,140,145,151,157,162,168
                       dc.w                        173,179,185,190,196,201,207,213,218,224
                       dc.w                        229,235,241,246,252,258,263,269,274,280
                       dc.w                        286,291,297,302,308,314,319,325,330,336
                       dc.w                        342,347,353,000

ROTATIONS_ANGLES_64_180:
                       dc.w                        185,191,196,202,208,213,219,225,230,236
                       dc.w                        241,247,253,258,264,270,275,281,286,292
                       dc.w                        298,303,309,315,320,326,331,337,343,348
                       dc.w                        354,000,005,011,016,022,028,033,039,045
                       dc.w                        050,056,061,067,073,078,084,090,095,101
                       dc.w                        106,112,118,123,129,135,140,146,151,157
                       dc.w                        163,168,174,180
ROTATIONS_ANGLES_64_END:

ROTATIONS_ANGLES_64_PTR: 
                       dc.l                        ROTATIONS_ANGLES_64
BIGTRIANGLE_Z_YPOS:    dc.w                        0

; Triangle path cordinate - each chunk is 256 bytes (one long for each of the 64 coordinates)
BIGTRIANGLE_Z_COORDS:
                       ; start of first path
                       dc.w                        -23,279,-20,277,-18,275,-15,273,-13,271,-10,269,-08,267,-05,265,-03,263
                       dc.w                        000,261,003,259,005,257,008,255,010,253,013,251,015,249,018,247,020,245,023,243
                       dc.w                        025,241,028,239,030,237,033,235,035,233,038,231,040,229,043,227,045,225,048,223
                       dc.w                        050,221,053,219,055,217,058,215,060,213,063,211,065,209,068,207,070,205,073,203
                       dc.w                        075,201,078,199,080,197,083,195,085,193,088,191,090,189,093,187,095,185,098,183
                       dc.w                        100,181,103,179,105,177,108,175,110,173,113,171,115,169,118,167,120,165,123,163
                       dc.w                        125,161,128,159,130,157,133,155,135,153

                       ; start of second path
                       dc.w                        -23,278,-20,275,-18,273,-15,270,-13,267,-10,264,-08,262,-05,259,-03,256
                       dc.w                        000,253,003,250,005,248,008,245,010,242,013,239,015,237,018,234,020,231,023,228
                       dc.w                        025,225,028,223,030,220,033,217,035,214,038,211,040,209,043,206,045,203,048,200
                       dc.w                        050,198,053,195,055,192,058,189,060,186,063,184,065,181,068,178,070,175,073,173
                       dc.w                        075,170,078,167,080,164,083,161,085,159,088,156,090,153,093,150,095,148,098,145
                       dc.w                        100,142,103,139,105,136,108,134,110,131,113,128,115,125,118,122,120,120,123,117
                       dc.w                        125,114,128,111,130,109,133,106,135,103

                       ; start of thrid path
                       dc.w                        343,279,340,277,338,275,335,273,333,271,330,269,328,267,325,265,323,263
                       dc.w                        320,261,318,259,315,257,313,255,310,253,308,251,305,249,303,247,300,245,298,243
                       dc.w                        295,241,293,239,290,237,288,235,285,233,283,231,280,229,278,227,275,225,273,223
                       dc.w                        270,221,268,219,265,217,263,215,260,213,258,211,255,209,253,207,250,205,248,203
                       dc.w                        245,201,243,199,240,197,238,195,235,193,233,191,230,189,228,187,225,185,223,183
                       dc.w                        220,181,218,179,215,177,213,175,210,173,208,171,205,169,203,167,200,165,198,163
                       dc.w                        195,161,193,159,190,157,188,155,185,153
                      
                       ; start of fourth path
                       dc.w                        -22,278,-18,275,-15,273,-12,270,-09,267,-05,264,-02,262,001,259,005,256
                       dc.w                        008,253,011,250,014,248,018,245,021,242,024,239,028,237,031,234,034,231,037,228
                       dc.w                        041,225,044,223,047,220,050,217,054,214,057,211,060,209,064,206,067,203,070,200
                       dc.w                        073,198,077,195,080,192,083,189,087,186,090,184,093,181,096,178,100,175,103,173
                       dc.w                        106,170,110,167,113,164,116,161,119,159,123,156,126,153,129,150,133,148,136,145
                       dc.w                        139,142,142,139,146,136,149,134,152,131,155,128,159,125,162,122,165,120,169,117
                       dc.w                        172,114,175,111,178,109,182,106,185,103

BIGTRIANGLE_Z_COORDS_PTR: 
                       dc.l                        BIGTRIANGLE_Z_COORDS

BIGTRIANGLE_Z:
                       movem.l                     d0-d6/a0/a1,-(sp)
                       
                       move.w                      #%0100001000000000,BPLCON0POINTER

                       ENABLE_CLIPPING
                   
                       move.l                      BIGTRIANGLE_Z_COORDS_PTR(PC),a1
                       move.w                      BIGTRIANGLE_Z_YPOS(PC),d1
                       adda                        d1,a1

                       move.w                      (a1),d0
                       asl.w                       #6,d0
                       move.w                      2(a1),d1
                       asl.w                       #6,d1
                       jsr                         TRANSLATE
                       LOADIDENTITYANDTRANSLATE    d0,d1
                       move.l                      ROTATIONS_ANGLES_64_PTR,a0
                       ROTATE                      (a0)

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
                       add.l                       #2,ROTATIONS_ANGLES_64_PTR

                     ; if last frame of the section blit the triangle on bitplane 3
                       cmpi.w                      #64*4,BIGTRIANGLE_Z_YPOS
                       bne.w                       BIGTRIANGLE_Z_EXIT
                       
                       WAITBLITTER
                       move.w                      #$0DFC,$dff040
                       move.w                      #$0000,$dff042   
                       move.l                      SCREEN_PTR_0,$dff050                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ; a source
                       move.l                      #SCREEN_2,$DFF04C
                       move.l                      #SCREEN_2,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ; d destination 
                       move.w                      #$0000,$dff062                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ; b mod
                       move.w                      #$0000,$dff064                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;D mod
                       move.w                      #$4014,$dff058

                       move.w                      #0,BIGTRIANGLE_Z_YPOS
                       add.l                       #256,BIGTRIANGLE_Z_COORDS_PTR

                       
                       move.l                      ROTATIONS_ANGLES_64_PTR,d0
                       ;add.l #128,d0
                       move.l                       d0,ROTATIONS_ANGLES_64_PTR
                       cmpi.l #ROTATIONS_ANGLES_64_END,ROTATIONS_ANGLES_64_PTR
                       bne.s donotresetrotationangles
                       move.l                      #ROTATIONS_ANGLES_64,ROTATIONS_ANGLES_64_PTR
donotresetrotationangles:
                       ;subi.l #64,d0
                       ;move.l d0,ROTATIONS_ANGLES_64_PTR
                       ;add.l        #128,d0
                       ;move.l                      d0,ROTATIONS_ANGLES_64_PTR
                       ;neg.l ROTATIONS_ANGLES_SIZE
                       ;move.l d0,ROTATIONS_ANGLES_SIZE

BIGTRIANGLE_Z_EXIT:
                       movem.l                     (sp)+,d0-d6/a0/a1
                       rts

BIGTRIANGLE_Z_2_YPOS:  dc.w                        0
BIGTRIANGLE_Z_2_COORDS: 
                       ;dc.w                        350,-25,347,-22,343,-19,340,-17,337,-14,333,-11,330,-8,326,-6,323,-3,320,0,316,3,313,6,310,8,306,11,303,14,300,17,296,20,293,22,290,25,286,28,283,31,279,33,276,36,273,39,269,42,266,45,263,47,259,50,256,53,253,56,249,58,246,61,243,64,239,67,236,70,232,72,229,75,226,78,222,81,219,83,216,86,212,89,209,92,206,95,202,97,199,100,195,103,192,106,189,109,185,111,182,114,179,117,175,120,172,122,169,125,165,128,162,131,159,134,155,136,152,139,148,142,145,145,142,147,138,150,135,153
                       dc.w                        345,281,343,279,340,277,338,275,335,273,333,271,330,269,328,267,325,265,323,263,320,261,318,259,315,257,313,255,310,253,308,251,305,249,303,247,300,245,298,243,295,241,293,239,290,237,288,235,285,233,283,231,280,229,278,227,275,225,273,223,270,221,268,219,265,217,263,215,260,213,258,211,255,209,253,207,250,205,248,203,245,201,243,199,240,197,238,195,235,193,233,191,230,189,228,187,225,185,223,183,220,181,218,179,215,177,213,175,210,173,208,171,205,169,203,167,200,165,198,163,195,161,193,159,190,157,188,155,185,153
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
                       move.l                      ROTATIONS_ANGLES_64_PTR,a0
                       ROTATE                      (a0)

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
                       ;jsr                         ammx_fill_table_clip
                       DISABLE_CLIPPING
                       add.w                       #4,BIGTRIANGLE_Z_2_YPOS
                       add.l                       #2,ROTATIONS_ANGLES_64_PTR

                     ; if last frame of the section blit the triangle on bitplane 3
                       cmpi.w                      #64*4,BIGTRIANGLE_Z_2_YPOS
                       bne.s                       BIGTRIANGLE_Z_2_EXIT
                       WAITBLITTER
                       move.w                      #$0DFC,$dff040
                       move.w                      #$0000,$dff042   
                       move.l                      SCREEN_PTR_0,$dff050                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ; a source
                       move.l                      #SCREEN_2,$DFF04C
                       move.l                      #SCREEN_2,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ; d destination 
                       move.w                      #$0000,$dff062                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ; b mod
                       move.w                      #$0000,$dff064                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ; copy to d channel
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;D mod
                       move.w                      #$4014,$dff058
                       move.w                      #0,BIGTRIANGLE_Z_2_YPOS
                       move.l                      #BIGTRIANGLE_Z_COORDS,BIGTRIANGLE_Z_COORDS_PTR
                       move.l                      #ROTATIONS_ANGLES_64,ROTATIONS_ANGLES_64_PTR

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
                       movem.l                     d0/d2-d7/a0/a1/a2/a3/a4/a5/a6,-(sp)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ; stack save

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

                       move.w                      (a0),d6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ; start of fill line
                       move.w                      2(a0),d7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ; end of fill line
                       move.l                      a2,(a0)+
	
                       jsr                         ammx_fill_table_single_line_bpl1

	; experimental, calculate the top of the figure addr in a1
                       move.l                      SCREEN_PTR_0,a1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ; experimental
                       adda.w                      d1,a1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ; experimental (now a1 is the addr of the top of the figure)

	; blitting in reverse
                       WAITBLITTER
                       move.w                      #$09F0,$dff040
                       move.w                      #$0000,$dff042
                       move.l                      a1,$dff050                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ; bltAptr
                       adda.l                      #40*256,a1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ; experimental go to bpl 2
                       move.w                      d5,d0
                       sub.w                       COUNTER_REVERSED,d0
                       mulu.w                      #40,d0
                       adda.w                      d0,a1
                       add.w                       #1,COUNTER_REVERSED
                       move.l                      a1,$dff054                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ; copy to d channel
                       move.w                      #$0000,$dff064
                       move.w                      #$0000,$dff066                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;D mod
                       move.w                      #$0054,$dff058
	; end blitting in reverse
                       add.w                       a6,d1
	
                       dbra                        d5,ammx_fill_table_nextline_reversed
ammx_fill_table_end_reversed:
                       move.w                      #-1,AMMXFILLTABLE_END_ROW
                       movem.l                     (sp)+,d0/d2-d7/a0/a1/a2/a3/a4/a5/a6
                       rts