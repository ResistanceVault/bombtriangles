SET2BITPLANES MACRO
            move.w           #%0010001000000000,BPLCON0POINTER
            ENDM

ammxmainloop3:
            movem.l          d0-d7/a0-a6,-(sp)    
  
            SWAP_BPL
            move.l           CLEARFUNCTION,a0
            jsr              (a0)

            move.w           MUSICCOUNTER,d1
            cmpi.w           #64,d1
            bne.s            musicnoreset
            move.w           #$0000,MUSICCOUNTER
            subi.l           #1,BEATCOUNTER
            bne.s            noresetbeatcounter
            move.l           BEATDELAY,BEATCOUNTER
            add.l            #4,DRAWFUNCTCOUNTER
            move.l           LAST_ITERATION_FUNCTION_PTR,a0
            move.l           (a0),a0
            jsr              (a0)
            add.l            #4,LAST_ITERATION_FUNCTION_PTR

noresetbeatcounter:
            IFD              USE_MUSICCOUNTER
            move.w           #$0FF0,$dff180
            ENDC

            bra.s            musicaddcounter
musicnoreset:
            IFD              USE_MUSICCOUNTER
            move.w           #$0000,$dff180
            ELSE
            nop
            ENDC
musicaddcounter:
            add.w            #1,MUSICCOUNTER


            lea              DRAWFUNCTARRAY_START(PC),a0
            add.l            DRAWFUNCTCOUNTER(PC),a0
            cmp.l            #DRAWFUNCTARRAY_END,a0
            bne.s            drawfunctcounternoreset

            move.l           #0,DRAWFUNCTCOUNTER
            lea              DRAWFUNCTARRAY_START,a0
            move.l           #LAST_ITERATION_FUNCTION_START,LAST_ITERATION_FUNCTION_PTR
drawfunctcounternoreset:

                   ; execute the drawing routine
            move.l           (a0),a0
            jsr              (a0)
                         
                   
            movem.l          (sp)+,d0-d7/a0-a6
            move.l           SCREEN_PTR_0,d0

            rts

CLEARFUNCTION:
            dc.l             CLEAR
CLEAR: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           SCREEN_PTR_0,$dff054                                                                   ; copy to d channel
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$8014,$dff058
            rts

CLEAR_BPL_1: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           SCREEN_PTR_0,$dff054                                                                   ; copy to d channel
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$4014,$dff058
            rts

CLEAR_BPL_2: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           SCREEN_PTR_1,$dff054                                                                   ; copy to d channel
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$4014,$dff058
            rts

CLEAR_BPL_2_OTH: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           SCREEN_PTR_OTHER_1,$dff054                                                                   ; copy to d channel
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$4014,$dff058
            rts

CLEAR_BPL_3: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           #SCREEN_2,$dff054                                                                      ; copy to d channel
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$4014,$dff058
            rts
CLEAR_BPL_4: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           #SCREEN_3,$dff054                                                                      ; copy to d channel
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$4014,$dff058
            rts

VOID:
            rts

FRAMECOUNTER:  
            dc.w             0 
MUSICCOUNTER:  
            dc.w             0

DRAWFUNCTCOUNTER:  
            dc.l             0
BEATCOUNTER:   
            dc.l             1
BEATDELAY:  dc.l             1


LAST_ITERATION_FUNCTION_PTR:
            dc.l             LAST_ITERATION_FUNCTION_START
            
TRANSITION1:
            WAITBLITTER
            move.w           #$09F0,$dff040
            move.w           #$0000,$dff042   
            move.l           #SCREEN_2,$dff050                                                                      ; a source
            move.l           SCREEN_PTR_0,$dff054                                                                   ; d destination 
            move.w           #0,$dff064                                                                             ; A MOD
            move.w           #0,$dff066                                                                             ; D mod
            move.w           #$8014,$dff058
            move.l           #VOID,CLEARFUNCTION
            SETBEATDELAY     #8
            move.l           #BIGTRIANGLE_Z_COLOR,BIGTRIANGLE_Z_COLOR_PTR
            SET2BITPLANES
            rts

            include          "stages/rollingtriangle.s"
            include          "stages/sheartriangle.s"

            include          "stages/smalltriangle.s"
            include          "stages/pyramid.s"


MEDIUMTRIANGLE:
            SETBEATDELAY     #1
            move.w           ANGLE,d0
            jsr              LOADIDENTITYANDROTATEX
            VERTEX_INIT      1,#0,#-25,#0
            VERTEX_INIT      2,#25,#25,#0
            VERTEX_INIT      3,#-25,#25,#0
            jsr              TRIANGLE3D_NODRAW
            bsr.w            increase_angle_by_1

            WAITBLITTER
            STROKE           #3
            jsr              ammx_fill_table
            rts

BIGTRIANGLE:
            SETBEATDELAY     #1
            move.w           ANGLE,d0
            jsr              LOADIDENTITYANDROTATEX
            VERTEX_INIT      1,#0,#-50,#0
            VERTEX_INIT      2,#50,#50,#0
            VERTEX_INIT      3,#-50,#50,#0
            jsr              TRIANGLE3D_NODRAW
            bsr.w            increase_angle_by_1

            WAITBLITTER
            bsr.w            CLEAR_BPL_3
            STROKE           #3
            jsr              ammx_fill_table
            ;move.w              #1,BEATDELAY+2


            rts

ROTATIONS_ANGLES_64:  
            dc.w             005,011,016,022,028,033,039,044,050,056
            dc.w             061,067,072,078,084,089,095,100,106,112
            dc.w             117,123,129,134,140,145,151,157,162,168
            dc.w             173,179,185,190,196,201,207,213,218,224
            dc.w             229,235,241,246,252,258,263,269,274,280
            dc.w             286,291,297,302,308,314,319,325,330,336
            dc.w             342,347,353,000

ROTATIONS_ANGLES_64_180:
            dc.w             185,191,196,202,208,213,219,225,230,236
            dc.w             241,247,253,258,264,270,275,281,286,292
            dc.w             298,303,309,315,320,326,331,337,343,348
            dc.w             354,000,005,011,016,022,028,033,039,045
            dc.w             050,056,061,067,073,078,084,090,095,101
            dc.w             106,112,118,123,129,135,140,146,151,157
            dc.w             163,168,174,180
ROTATIONS_ANGLES_64_END:

ROTATIONS_ANGLES_64_PTR: 
            dc.l             ROTATIONS_ANGLES_64

            include          "stages/bigtrianglez.s"

ROTATION_ANGLES_512_START:
            dc.w             000,001,001,002,003,004,004,005,006,006,007,008,008,009,010,011,011,012,013,013,014
            dc.w             015,015,016,017,018,018,019,020,020,021,022,022,023,024,025,025,026,027,027,028,029
            dc.w             029,030,031,032,032,033,034,034,035,036,036,037,038,039,039,040,041,041,042,043,043
            dc.w             044,045,046,046,047,048,048,049,050,050,051,052,053,053,054,055,055,056,057,057,058
            dc.w             059,060,060,061,062,062,063,064,065,065,066,067,067,068,069,069,070,071,072,072,073
            dc.w             074,074,075,076,076,077,078,079,079,080,081,081,082,083,083,084,085,086,086,087,088
            dc.w             088,089,090,090,091,092,093,093,094,095,095,096,097,097,098,099,100,100,101,102,102
            dc.w             103,104,104,105,106,107,107,108,109,109,110,111,111,112,113,114,114,115,116,116,117
            dc.w             118,118,119,120,121,121,122,123,123,124,125,126,126,127,128,128,129,130,130,131,132
            dc.w             133,133,134,135,135,136,137,137,138,139,140,140,141,142,142,143,144,144,145,146,147
            dc.w             147,148,149,149,150,151,151,152,153,154,154,155,156,156,157,158,158,159,160,161,161
            dc.w             162,163,163,164,165,165,166,167,168,168,169,170,170,171,172,172,173,174,175,175,176
            dc.w             177,177,178,179,180,180,181,182,182,183,184,184,185,186,187,187,188,189,189,190,191
            dc.w             191,192,193,194,194,195,196,196,197,198,198,199,200,201,201,202,203,203,204,205,205
            dc.w             206,207,208,208,209,210,210,211,212,212,213,214,215,215,216,217,217,218,219,219,220
            dc.w             221,222,222,223,224,224,225,226,226,227,228,229,229,230,231,231,232,233,233,234,235
            dc.w             236,236,237,238,238,239,240,241,241,242,243,243,244,245,245,246,247,248,248,249,250
            dc.w             250,251,252,252,253,254,255,255,256,257,257,258,259,259,260,261,262,262,263,264,264
            dc.w             265,266,266,267,268,269,269,270,271,271,272,273,273,274,275,276,276,277,278,278,279
            dc.w             280,280,281,282,283,283,284,285,285,286,287,287,288,289,290,290,291,292,292,293,294
            dc.w             294,295,296,297,297,298,299,299,300,301,302,302,303,304,304,305,306,306,307,308,309
            dc.w             309,310,311,311,312,313,313,314,315,316,316,317,318,318,319,320,320,321,322,323,323
            dc.w             324,325,325,326,327,327,328,329,330,330,331,332,332,333,334,334,335,336,337,337,338
            dc.w             339,339,340,341,341,342,343,344,344,345,346,346,347,348,348,349,350,351,351,352,353
            dc.w             353,354,355,355,356,357,358,358
ROTATION_ANGLES_512_END:
RESET_ANGLE_512:
            move.l           #ROTATION_ANGLES_512_START,ROTATION_ANGLES_512_PTR
            rts
RESET_ANGLE_512_AND_BPL_3_4:
            bsr.w            CLEAR_BPL_4
            bsr.w            CLEAR_BPL_3
            move.l           #ROTATION_ANGLES_512_START,ROTATION_ANGLES_512_PTR
            rts
ROTATION_ANGLES_512_PTR:
            dc.l             ROTATION_ANGLES_512_START

            include          "stages/doubletrianglex.s"
            include          "stages/doubletriangley.s"

ANGLE:      dc.w             0

decrease_angle_by_1:
            sub.w            #1,ANGLE
            BPL.s            decrease_angle_by_1_exit
            move.w           #359,ANGLE
decrease_angle_by_1_exit:
            rts

increase_angle_by_1:
            add.w            #1,ANGLE
            cmpi.w           #360,ANGLE
            bcs.s            increase_angle_by_1_exit
            move.w           #0,ANGLE
increase_angle_by_1_exit:
            rts

increase_angle_by_n:
            add.w            d0,ANGLE
            cmpi.w           #360,ANGLE
            bcs.s            increase_angle_by_1_exit
            move.w           #0,ANGLE
increase_angle_by_n_exit:
            rts

; draws the same figure into the second bpl but reversed
; clipping each line
COUNTER_REVERSED:
            dc.w             0

ammx_fill_table_reversed:
            movem.l          d0/d2-d7/a0/a1/a2/a3/a4/a5/a6,-(sp)                                                    ; stack save

            move.w           #1,AMMX_FILL_TABLE_FIRST_DRAW
            move.w           AMMXFILLTABLE_END_ROW,d5

            lea              FILL_TABLE,a0

	; Reposition inside the fill table according to the starting row
            move.w           AMMXFILLTABLE_CURRENT_ROW,d6
            move.w           d6,d1
            lsl.w            #2,d6
            add.w            d6,a0
	; end of repositioning

            MINUWORD         d1,FILLTABLE_FRAME_MIN_Y
            MAXUWORD         d5,FILLTABLE_FRAME_MAX_Y

            sub.w            d1,d5
            bmi.w            ammx_fill_table_end_reversed

            lea              PLOTREFS,a4
            add.w            d1,d1
            move.w           0(a4,d1.w),d1

            IFD              USE_DBLBUF
            move.l           SCREEN_PTR_0,a5
            ELSE
            lea              SCREEN_0,a5
            ENDC

            move.l           #$7FFF8000,a2
            move.w           #40,a6

            move.w           #$0000,COUNTER_REVERSED
ammx_fill_table_nextline_reversed:

            move.w           (a0),d6                                                                                ; start of fill line
            move.w           2(a0),d7                                                                               ; end of fill line
            move.l           a2,(a0)+
	
            jsr              ammx_fill_table_single_line_bpl1

	; experimental, calculate the top of the figure addr in a1
            move.l           SCREEN_PTR_0,a1                                                                        ; experimental
            adda.w           d1,a1                                                                                  ; experimental (now a1 is the addr of the top of the figure)

	; blitting in reverse
            WAITBLITTER
            move.w           #$09F0,$dff040
            move.w           #$0000,$dff042
            move.l           a1,$dff050                                                                             ; bltAptr
            adda.l           #40*256,a1                                                                             ; experimental go to bpl 2
            move.w           d5,d0
            sub.w            COUNTER_REVERSED,d0
            mulu.w           #40,d0
            adda.w           d0,a1
            add.w            #1,COUNTER_REVERSED
            move.l           a1,$dff054                                                                             ; copy to d channel
            move.w           #$0000,$dff064
            move.w           #$0000,$dff066                                                                         ;D mod
            move.w           #$0054,$dff058
	; end blitting in reverse
            add.w            a6,d1
	
            dbra             d5,ammx_fill_table_nextline_reversed
ammx_fill_table_end_reversed:
            move.w           #-1,AMMXFILLTABLE_END_ROW
            movem.l          (sp)+,d0/d2-d7/a0/a1/a2/a3/a4/a5/a6
            rts

            