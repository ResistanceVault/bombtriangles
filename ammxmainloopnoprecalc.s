       include "ladder.s"

SET2BITPLANES MACRO
            move.w           #%0010001000000000,BPLCON0POINTER
            ENDM


ANGLESTEP:
            dc.w             0

ammxmainloop3:
            movem.l          d0-d7/a0-a6,-(sp)    
  
            
            SWAP_BPL
            move.l           CLEARFUNCTION,a0
            jsr              (a0)
           

            ; move ladders
            bsr.w            moveladders
            IFD ASSS

            move.w           MUSICCOUNTER,d1
            cmpi.w           #64,d1
            bne.s            musicnoreset
            move.w           #$0000,MUSICCOUNTER
            subi.l           #1,BEATCOUNTER
            bne.s            noresetbeatcounter
            move.l           BEATDELAY,BEATCOUNTER
            ;add.l            #4,DRAWFUNCTCOUNTER comment to stay on first effect
            move.l           LAST_ITERATION_FUNCTION_PTR,a0
            ;move.l           (a0),a0
            ;jsr              (a0)
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
            ;add.w            #1,MUSICCOUNTER comment to stay of the first effect

            lea              DRAWFUNCTARRAY_START(PC),a0
            add.l            DRAWFUNCTCOUNTER(PC),a0
            cmp.l            #DRAWFUNCTARRAY_END,a0
            bne.s            drawfunctcounternoreset

            move.l           #0,DRAWFUNCTCOUNTER
            lea              DRAWFUNCTARRAY_START,a0
            move.l           #LAST_ITERATION_FUNCTION_START,LAST_ITERATION_FUNCTION_PTR
drawfunctcounternoreset:
              ENDC

                   ; execute the drawing routine
            lea              DRAWFUNCTARRAY_START(PC),a0
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
            move.l           SCREEN_PTR_OTHER_1,$dff054                                                             ; copy to d channel
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
            
            include          "stages/walkingtriangle.s"

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



            