SETBEATDELAY MACRO
            move.w              \1,BEATDELAY+2
            ENDM

SET2BITPLANES MACRO
            move.w              #%0010001000000000,BPLCON0POINTER
            ENDM

ammxmainloop3:
            movem.l             d0-d7/a0-a6,-(sp)    
  
            SWAP_BPL
            move.l              CLEARFUNCTION,a0
            jsr                 (a0)

            move.w              MUSICCOUNTER,d1
            cmpi.w              #64,d1
            bne.s               musicnoreset
            move.w              #$0000,MUSICCOUNTER
            subi.l              #1,BEATCOUNTER
            bne.s               noresetbeatcounter
            move.l              BEATDELAY,BEATCOUNTER
            add.l               #4,DRAWFUNCTCOUNTER
            move.l              LAST_ITERATION_FUNCTION_PTR,a0
            move.l (a0),a0
            jsr                 (a0)
            add.l               #4,LAST_ITERATION_FUNCTION_PTR

noresetbeatcounter:
            IFD                 USE_MUSICCOUNTER
            move.w              #$0FF0,$dff180
            ENDC

            bra.s               musicaddcounter
musicnoreset:
            IFD                 USE_MUSICCOUNTER
            move.w              #$0000,$dff180
            ELSE
            nop
            ENDC
musicaddcounter:
            add.w               #1,MUSICCOUNTER


            lea                 DRAWFUNCTARRAY_START(PC),a0
            add.l               DRAWFUNCTCOUNTER(PC),a0
            cmp.l               #DRAWFUNCTARRAY_END,a0
            bne.s               drawfunctcounternoreset

            move.l              #0,DRAWFUNCTCOUNTER
            lea                 DRAWFUNCTARRAY_START,a0
            move.l              #LAST_ITERATION_FUNCTION_START,LAST_ITERATION_FUNCTION_PTR
drawfunctcounternoreset:

                   ; execute the drawing routine
            move.l              (a0),a0
            jsr                 (a0)
                         
                   
            movem.l             (sp)+,d0-d7/a0-a6
            move.l              SCREEN_PTR_0,d0

            rts

CLEARFUNCTION:
            dc.l                CLEAR
CLEAR: 
            WAITBLITTER
            move.w              #$0100,$dff040
            move.w              #$0000,$dff042        
            move.l              SCREEN_PTR_0,$dff054                                                                   ; copy to d channel
            move.w              #$0000,$dff066                                                                         ;D mod
            move.w              #$8014,$dff058
            rts

CLEAR_BPL_1: 
            WAITBLITTER
            move.w              #$0100,$dff040
            move.w              #$0000,$dff042        
            move.l              SCREEN_PTR_0,$dff054                                                                   ; copy to d channel
            move.w              #$0000,$dff066                                                                         ;D mod
            move.w              #$4014,$dff058
            rts

CLEAR_BPL_2: 
            WAITBLITTER
            move.w              #$0100,$dff040
            move.w              #$0000,$dff042        
            move.l              SCREEN_PTR_1,$dff054                                                                   ; copy to d channel
            move.w              #$0000,$dff066                                                                         ;D mod
            move.w              #$4014,$dff058
            rts

CLEAR_BPL_3: 
            WAITBLITTER
            move.w              #$0100,$dff040
            move.w              #$0000,$dff042        
            move.l              #SCREEN_2,$dff054                                                                      ; copy to d channel
            move.w              #$0000,$dff066                                                                         ;D mod
            move.w              #$4014,$dff058
            rts
CLEAR_BPL_4: 
            WAITBLITTER
            move.w              #$0100,$dff040
            move.w              #$0000,$dff042        
            move.l              #SCREEN_3,$dff054                                                                      ; copy to d channel
            move.w              #$0000,$dff066                                                                         ;D mod
            move.w              #$4014,$dff058
            rts

VOID:
            rts

FRAMECOUNTER:  
            dc.w                0 
MUSICCOUNTER:  
            dc.w                0

DRAWFUNCTCOUNTER:  
            dc.l                0
BEATCOUNTER:   
            dc.l                1
BEATDELAY:  dc.l                1

DRAWFUNCTARRAY_START:
            dc.l                BIGTRIANGLE_Z           ; 1
            dc.l                BIGTRIANGLE_Z           ; 2
            dc.l                BIGTRIANGLE_Z           ; 3
            dc.l                BIGTRIANGLE_Z           ; 4
            dc.l                BIGTRIANGLE_Z           ; 5
            dc.l                BIGTRIANGLE_Z           ; 6
            dc.l                TRANSITION1             ; 7
            dc.l                DOUBLETRIANGLEX         ; 8
            dc.l                DOUBLETRIANGLEY         ; 9
            dc.l                SMALLTRIANGLE           ; 10
            dc.l                MEDIUMTRIANGLE          ; 11
            dc.l                BIGTRIANGLE             ; 12
DRAWFUNCTARRAY_END:

LAST_ITERATION_FUNCTION_START: 
            dc.l                VOID                    ; 1
            dc.l                VOID                    ; 2
            dc.l                VOID                    ; 3
            dc.l                VOID                    ; 4
            dc.l                VOID                    ; 5
            dc.l                VOID                    ; 6
            dc.l                VOID                    ; 7
            dc.l                RESET_ANGLE_512         ; 8
            dc.l                RESET_ANGLE_512         ; 9
            dc.l                VOID                    ; 10
            dc.l                VOID                    ; 11
            dc.l                VOID                    ; 12
LAST_ITERATION_FUNCTION_END:
LAST_ITERATION_FUNCTION_PTR:
            dc.l                LAST_ITERATION_FUNCTION_START

TRANSITION1:
            WAITBLITTER
            move.w              #$09F0,$dff040
            move.w              #$0000,$dff042   
            move.l              #SCREEN_2,$dff050                                                                      ; a source
            move.l              SCREEN_PTR_0,$dff054                                                                   ; d destination 
            move.w              #0,$dff064                                                                             ; A MOD
            move.w              #0,$dff066                                                                             ; D mod
            move.w              #$8014,$dff058
            move.l              #VOID,CLEARFUNCTION
            SETBEATDELAY        #8
            move.l              #BIGTRIANGLE_Z_COLOR,BIGTRIANGLE_Z_COLOR_PTR
            SET2BITPLANES
            rts


SMALLTRIANGLE:
            move.l              #CLEAR,CLEARFUNCTION

            move.w              ANGLE,d0
            jsr                 LOADIDENTITYANDROTATEX
            VERTEX_INIT         1,#0,#-10,#0
            VERTEX_INIT         2,#10,#10,#0
            VERTEX_INIT         3,#-10,#10,#0
            jsr                 TRIANGLE3D_NODRAW
            bsr.w               increase_angle_by_1

            WAITBLITTER
            bsr.w               CLEAR_BPL_4
            bsr.w               CLEAR_BPL_3
            STROKE              #3
            jsr                 ammx_fill_table
            rts

MEDIUMTRIANGLE:
            move.w              ANGLE,d0
            jsr                 LOADIDENTITYANDROTATEX
            VERTEX_INIT         1,#0,#-25,#0
            VERTEX_INIT         2,#25,#25,#0
            VERTEX_INIT         3,#-25,#25,#0
            jsr                 TRIANGLE3D_NODRAW
            bsr.w               increase_angle_by_1

            WAITBLITTER
            STROKE              #3
            jsr                 ammx_fill_table
            rts

BIGTRIANGLE:
            move.w              ANGLE,d0
            jsr                 LOADIDENTITYANDROTATEX
            VERTEX_INIT         1,#0,#-50,#0
            VERTEX_INIT         2,#50,#50,#0
            VERTEX_INIT         3,#-50,#50,#0
            jsr                 TRIANGLE3D_NODRAW
            bsr.w               increase_angle_by_1

            WAITBLITTER
            bsr.w               CLEAR_BPL_3
            STROKE              #3
            jsr                 ammx_fill_table
            move.w              #1,BEATDELAY+2


            rts

ROTATIONS_ANGLES_64:  
            dc.w                005,011,016,022,028,033,039,044,050,056
            dc.w                061,067,072,078,084,089,095,100,106,112
            dc.w                117,123,129,134,140,145,151,157,162,168
            dc.w                173,179,185,190,196,201,207,213,218,224
            dc.w                229,235,241,246,252,258,263,269,274,280
            dc.w                286,291,297,302,308,314,319,325,330,336
            dc.w                342,347,353,000

ROTATIONS_ANGLES_64_180:
            dc.w                185,191,196,202,208,213,219,225,230,236
            dc.w                241,247,253,258,264,270,275,281,286,292
            dc.w                298,303,309,315,320,326,331,337,343,348
            dc.w                354,000,005,011,016,022,028,033,039,045
            dc.w                050,056,061,067,073,078,084,090,095,101
            dc.w                106,112,118,123,129,135,140,146,151,157
            dc.w                163,168,174,180
ROTATIONS_ANGLES_64_END:

ROTATIONS_ANGLES_64_PTR: 
            dc.l                ROTATIONS_ANGLES_64
BIGTRIANGLE_Z_YPOS:    
            dc.w                0

; Triangle path cordinate - each chunk is 256 bytes (one long for each of the 64 coordinates)
BIGTRIANGLE_Z_COORDS:
                       ; start of first path
            dc.w                -23,279,-20,277,-18,275,-15,273,-13,271,-10,269,-08,267,-05,265,-03,263
            dc.w                000,261,003,259,005,257,008,255,010,253,013,251,015,249,018,247,020,245,023,243
            dc.w                025,241,028,239,030,237,033,235,035,233,038,231,040,229,043,227,045,225,048,223
            dc.w                050,221,053,219,055,217,058,215,060,213,063,211,065,209,068,207,070,205,073,203
            dc.w                075,201,078,199,080,197,083,195,085,193,088,191,090,189,093,187,095,185,098,183
            dc.w                100,181,103,179,105,177,108,175,110,173,113,171,115,169,118,167,120,165,123,163
            dc.w                125,161,128,159,130,157,133,155,135,153

                       ; start of second path
            dc.w                -23,278,-20,275,-18,273,-15,270,-13,267,-10,264,-08,262,-05,259,-03,256
            dc.w                000,253,003,250,005,248,008,245,010,242,013,239,015,237,018,234,020,231,023,228
            dc.w                025,225,028,223,030,220,033,217,035,214,038,211,040,209,043,206,045,203,048,200
            dc.w                050,198,053,195,055,192,058,189,060,186,063,184,065,181,068,178,070,175,073,173
            dc.w                075,170,078,167,080,164,083,161,085,159,088,156,090,153,093,150,095,148,098,145
            dc.w                100,142,103,139,105,136,108,134,110,131,113,128,115,125,118,122,120,120,123,117
            dc.w                125,114,128,111,130,109,133,106,135,103

                       ; start of thrid path
            dc.w                343,279,340,277,338,275,335,273,333,271,330,269,328,267,325,265,323,263
            dc.w                320,261,318,259,315,257,313,255,310,253,308,251,305,249,303,247,300,245,298,243
            dc.w                295,241,293,239,290,237,288,235,285,233,283,231,280,229,278,227,275,225,273,223
            dc.w                270,221,268,219,265,217,263,215,260,213,258,211,255,209,253,207,250,205,248,203
            dc.w                245,201,243,199,240,197,238,195,235,193,233,191,230,189,228,187,225,185,223,183
            dc.w                220,181,218,179,215,177,213,175,210,173,208,171,205,169,203,167,200,165,198,163
            dc.w                195,161,193,159,190,157,188,155,185,153
                      
                       ; start of fourth path
            dc.w                -22,278,-18,275,-15,273,-12,270,-09,267,-05,264,-02,262,001,259,005,256
            dc.w                008,253,011,250,014,248,018,245,021,242,024,239,028,237,031,234,034,231,037,228
            dc.w                041,225,044,223,047,220,050,217,054,214,057,211,060,209,064,206,067,203,070,200
            dc.w                073,198,077,195,080,192,083,189,087,186,090,184,093,181,096,178,100,175,103,173
            dc.w                106,170,110,167,113,164,116,161,119,159,123,156,126,153,129,150,133,148,136,145
            dc.w                139,142,142,139,146,136,149,134,152,131,155,128,159,125,162,122,165,120,169,117
            dc.w                172,114,175,111,178,109,182,106,185,103

                       ; start of fifth path
            dc.w                -22,278,-19,275,-16,273,-13,270,-11,267,-08,264,-05,262,-02,259,001,256
            dc.w                004,253,007,250,010,248,013,245,015,242,018,239,021,237,024,234,027,231,030,228
            dc.w                033,225,036,223,039,220,041,217,044,214,047,211,050,209,053,206,056,203,059,200
            dc.w                062,198,065,195,068,192,070,189,073,186,076,184,079,181,082,178,085,175,088,173
            dc.w                091,170,094,167,096,164,099,161,102,159,105,156,108,153,111,150,114,148,117,145
            dc.w                120,142,122,139,125,136,128,134,131,131,134,128,137,125,140,122,143,120,146,117
            dc.w                148,114,151,111,154,109,157,106,160,103

                       ; start of sixth path
            dc.w                -22,279,-19,277,-16,275,-13,273,-11,271,-08,269,-05,267,-02,265,001,263
            dc.w                004,261,007,259,010,257,013,255,015,253,018,251,021,249,024,247,027,245,030,243
            dc.w                033,241,036,239,039,237,041,235,044,233,047,231,050,229,053,227,056,225,059,223
            dc.w                062,221,065,219,067,217,070,215,073,213,076,211,079,209,082,207,085,205,088,203
            dc.w                091,201,094,199,096,197,099,195,102,193,105,191,108,189,111,187,114,185,117,183
            dc.w                120,181,122,179,125,177,128,175,131,173,134,171,137,169,140,167,143,165,146,163
            dc.w                148,161,151,159,154,157,157,155,160,153
BIGTRIANGLE_Z_COORDS_END:

BIGTRIANGLE_Z_COORDS_PTR: 
            dc.l                BIGTRIANGLE_Z_COORDS

BIGTRIANGLE_Z_COLOR:
            dc.b                1,2,1,2,3,3
BIGTRIANGLE_Z_COLOR_PTR:
            dc.l                BIGTRIANGLE_Z_COLOR

BIGTRIANGLE_Z:
            movem.l             d0-d6/a0/a1,-(sp)
                       
            move.w              #%0100001000000000,BPLCON0POINTER

            ENABLE_CLIPPING
                   
            move.l              BIGTRIANGLE_Z_COORDS_PTR(PC),a1
            move.w              BIGTRIANGLE_Z_YPOS(PC),d1
            adda                d1,a1

            move.w              (a1),d0
            move.w              2(a1),d1
            jsr                 LOADIDENTITYANDTRANSLATE   
            move.l              ROTATIONS_ANGLES_64_PTR,a0
            ROTATE              (a0)

            move.w              #0,d0
            move.w              #-25,d1

            move.w              #-25,d6
            move.w              #25,d3

            move.w              #25,d4
            move.w              #25,d5
	
            jsr                 TRIANGLE_NODRAW

            WAITBLITTER
            move.l              BIGTRIANGLE_Z_COLOR_PTR,a0

            STROKE              (a0)
            jsr                 ammx_fill_table_clip
            DISABLE_CLIPPING
                       
            add.w               #4,BIGTRIANGLE_Z_YPOS
            add.l               #2,ROTATIONS_ANGLES_64_PTR

                     ; if last frame of the section blit the triangle on bitplane 3
            cmpi.w              #64*4,BIGTRIANGLE_Z_YPOS
            bne.w               BIGTRIANGLE_Z_EXIT
                       
            WAITBLITTER
            move.w              #$0DFC,$dff040
            move.w              #$0000,$dff042   
            move.l              SCREEN_PTR_0,$dff050                                                                   ; a source
            ;add.w #16,$DFF050
            move.l              #SCREEN_2,$DFF04C
            ;add.w #16,$DFF04C
            move.l              #SCREEN_2,$dff054                                                                      ; d destination 
            ;add.w #16,$DFF054
            move.w              #0,$dff062                                                                             ; b mod
            move.w              #0,$dff064                                                                             ; A MOD
            move.w              #0,$dff066                                                                             ;D mod
            move.w              #$8014,$dff058

            move.w              #0,ANGLE

            add.l               #1,BIGTRIANGLE_Z_COLOR_PTR

            move.w              #0,BIGTRIANGLE_Z_YPOS
            add.l               #256,BIGTRIANGLE_Z_COORDS_PTR

                       
            move.l              ROTATIONS_ANGLES_64_PTR,d0
            move.l              d0,ROTATIONS_ANGLES_64_PTR
            cmpi.l              #ROTATIONS_ANGLES_64_END,ROTATIONS_ANGLES_64_PTR
            bne.s               donotresetrotationangles
            move.l              #ROTATIONS_ANGLES_64,ROTATIONS_ANGLES_64_PTR
           
donotresetrotationangles:

            ; if last of the routine calls
            cmpi.l              #BIGTRIANGLE_Z_COORDS_END,BIGTRIANGLE_Z_COORDS_PTR
            bne.s               donotchangedelay
            SETBEATDELAY        #2            
donotchangedelay:

BIGTRIANGLE_Z_EXIT:
            movem.l             (sp)+,d0-d6/a0/a1
            rts

ROTATION_ANGLES_512_START:
            dc.w                000,001,001,002,003,004,004,005,006,006,007,008,008,009,010,011,011,012,013,013,014
            dc.w                015,015,016,017,018,018,019,020,020,021,022,022,023,024,025,025,026,027,027,028,029
            dc.w                029,030,031,032,032,033,034,034,035,036,036,037,038,039,039,040,041,041,042,043,043
            dc.w                044,045,046,046,047,048,048,049,050,050,051,052,053,053,054,055,055,056,057,057,058
            dc.w                059,060,060,061,062,062,063,064,065,065,066,067,067,068,069,069,070,071,072,072,073
            dc.w                074,074,075,076,076,077,078,079,079,080,081,081,082,083,083,084,085,086,086,087,088
            dc.w                088,089,090,090,091,092,093,093,094,095,095,096,097,097,098,099,100,100,101,102,102
            dc.w                103,104,104,105,106,107,107,108,109,109,110,111,111,112,113,114,114,115,116,116,117
            dc.w                118,118,119,120,121,121,122,123,123,124,125,126,126,127,128,128,129,130,130,131,132
            dc.w                133,133,134,135,135,136,137,137,138,139,140,140,141,142,142,143,144,144,145,146,147
            dc.w                147,148,149,149,150,151,151,152,153,154,154,155,156,156,157,158,158,159,160,161,161
            dc.w                162,163,163,164,165,165,166,167,168,168,169,170,170,171,172,172,173,174,175,175,176
            dc.w                177,177,178,179,180,180,181,182,182,183,184,184,185,186,187,187,188,189,189,190,191
            dc.w                191,192,193,194,194,195,196,196,197,198,198,199,200,201,201,202,203,203,204,205,205
            dc.w                206,207,208,208,209,210,210,211,212,212,213,214,215,215,216,217,217,218,219,219,220
            dc.w                221,222,222,223,224,224,225,226,226,227,228,229,229,230,231,231,232,233,233,234,235
            dc.w                236,236,237,238,238,239,240,241,241,242,243,243,244,245,245,246,247,248,248,249,250
            dc.w                250,251,252,252,253,254,255,255,256,257,257,258,259,259,260,261,262,262,263,264,264
            dc.w                265,266,266,267,268,269,269,270,271,271,272,273,273,274,275,276,276,277,278,278,279
            dc.w                280,280,281,282,283,283,284,285,285,286,287,287,288,289,290,290,291,292,292,293,294
            dc.w                294,295,296,297,297,298,299,299,300,301,302,302,303,304,304,305,306,306,307,308,309
            dc.w                309,310,311,311,312,313,313,314,315,316,316,317,318,318,319,320,320,321,322,323,323
            dc.w                324,325,325,326,327,327,328,329,330,330,331,332,332,333,334,334,335,336,337,337,338
            dc.w                339,339,340,341,341,342,343,344,344,345,346,346,347,348,348,349,350,351,351,352,353
            dc.w                353,354,355,355,356,357,358,358
ROTATION_ANGLES_512_END:
RESET_ANGLE_512:
       move.l #ROTATION_ANGLES_512_START,ROTATION_ANGLES_512_PTR
       rts
ROTATION_ANGLES_512_PTR:
            dc.l                ROTATION_ANGLES_512_START

DOUBLETRIANGLEX:
            movem.l             d0-d7/a0-a6,-(sp)

            move.w              #%0010001000000000,BPLCON0POINTER
            move.l              #BIGTRIANGLE_Z_COORDS,BIGTRIANGLE_Z_COORDS_PTR
            move.l              #CLEAR,CLEARFUNCTION

            ;move.w              ANGLE,d0
            ;moveq               #0,d0
            move.l              ROTATION_ANGLES_512_PTR,a0
            move.w              (a0),d0
            add.l               #2,ROTATION_ANGLES_512_PTR

            jsr                 LOADIDENTITYANDROTATEX
            VERTEX_INIT         1,#0,#-50,#0
            VERTEX_INIT         2,#50,#50,#0
            VERTEX_INIT         3,#-50,#50,#0
            IFD                 DEBUGCOLORS
            move.w              #$00F0,$dff180
            ENDC
            jsr                 TRIANGLE3D_NODRAW
            IFD                 DEBUGCOLORS
            move.w              #$0AAA,$dff180
            ENDC
            ;bsr.w               increase_angle_by_1

            WAITBLITTER
            STROKE              #3
            bsr.w               ammx_fill_table_reversed
            movem.l             (sp)+,d0-d7/a0-a6
            rts

DOUBLETRIANGLEY:
            movem.l             d0-d7/a0-a6,-(sp)
            move.l              #CLEAR_BPL_1,CLEARFUNCTION
            move.w              #%0010001000000000,BPLCON0POINTER
            move.l              #BIGTRIANGLE_Z_COORDS,BIGTRIANGLE_Z_COORDS_PTR

            ;move.w              ANGLE,d0
            move.l              ROTATION_ANGLES_512_PTR,a0
            move.w              (a0),d0
            add.l               #2,ROTATION_ANGLES_512_PTR
            jsr                 LOADIDENTITYANDROTATEY
            VERTEX_INIT         1,#0,#-50,#0
            VERTEX_INIT         2,#50,#50,#0
            VERTEX_INIT         3,#-50,#50,#0
            IFD                 DEBUGCOLORS
            move.w              #$00F0,$dff180
            ENDC
            jsr                 TRIANGLE3D_NODRAW
            IFD                 DEBUGCOLORS
            move.w              #$0AAA,$dff180
            ENDC
            ;bsr.w               increase_angle_by_1

            WAITBLITTER
            STROKE              #3
            bsr.w               ammx_fill_table_reversed
            movem.l             (sp)+,d0-d7/a0-a6
            rts

ANGLE:      dc.w                0

increase_angle_by_1:
            add.w               #1,ANGLE
            cmpi.w              #360,ANGLE
            bcs.s               increase_angle_by_1_exit
            move.w              #0,ANGLE
increase_angle_by_1_exit:
            rts

increase_angle_by_n:
            add.w               d0,ANGLE
            cmpi.w              #360,ANGLE
            bcs.s               increase_angle_by_1_exit
            move.w              #0,ANGLE
increase_angle_by_n_exit:
            rts

; draws the same figure into the second bpl but reversed
; clipping each line
COUNTER_REVERSED:
            dc.w                0

ammx_fill_table_reversed:
            movem.l             d0/d2-d7/a0/a1/a2/a3/a4/a5/a6,-(sp)                                                    ; stack save

            move.w              #1,AMMX_FILL_TABLE_FIRST_DRAW
            move.w              AMMXFILLTABLE_END_ROW,d5

            lea                 FILL_TABLE,a0

	; Reposition inside the fill table according to the starting row
            move.w              AMMXFILLTABLE_CURRENT_ROW,d6
            move.w              d6,d1
            lsl.w               #2,d6
            add.w               d6,a0
	; end of repositioning

            MINUWORD            d1,FILLTABLE_FRAME_MIN_Y
            MAXUWORD            d5,FILLTABLE_FRAME_MAX_Y

            sub.w               d1,d5
            bmi.w               ammx_fill_table_end_reversed

            lea                 PLOTREFS,a4
            add.w               d1,d1
            move.w              0(a4,d1.w),d1

            IFD                 USE_DBLBUF
            move.l              SCREEN_PTR_0,a5
            ELSE
            lea                 SCREEN_0,a5
            ENDC

            move.l              #$7FFF8000,a2
            move.w              #40,a6

            move.w              #$0000,COUNTER_REVERSED
ammx_fill_table_nextline_reversed:

            move.w              (a0),d6                                                                                ; start of fill line
            move.w              2(a0),d7                                                                               ; end of fill line
            move.l              a2,(a0)+
	
            jsr                 ammx_fill_table_single_line_bpl1

	; experimental, calculate the top of the figure addr in a1
            move.l              SCREEN_PTR_0,a1                                                                        ; experimental
            adda.w              d1,a1                                                                                  ; experimental (now a1 is the addr of the top of the figure)

	; blitting in reverse
            WAITBLITTER
            move.w              #$09F0,$dff040
            move.w              #$0000,$dff042
            move.l              a1,$dff050                                                                             ; bltAptr
            adda.l              #40*256,a1                                                                             ; experimental go to bpl 2
            move.w              d5,d0
            sub.w               COUNTER_REVERSED,d0
            mulu.w              #40,d0
            adda.w              d0,a1
            add.w               #1,COUNTER_REVERSED
            move.l              a1,$dff054                                                                             ; copy to d channel
            move.w              #$0000,$dff064
            move.w              #$0000,$dff066                                                                         ;D mod
            move.w              #$0054,$dff058
	; end blitting in reverse
            add.w               a6,d1
	
            dbra                d5,ammx_fill_table_nextline_reversed
ammx_fill_table_end_reversed:
            move.w              #-1,AMMXFILLTABLE_END_ROW
            movem.l             (sp)+,d0/d2-d7/a0/a1/a2/a3/a4/a5/a6
            rts