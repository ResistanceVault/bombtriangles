
ammxmainloop3:
            movem.l          d0-d7/a0-a6,-(sp)    
  
            SWAP_BPL
            move.l           CLEARFUNCTION,a0
            jsr              (a0)

            ; execute banner routine
            bsr.w banner

            ; move ladders
            bsr.w            moveladders

            ; execute the drawing routine
            lea              DRAWFUNCTARRAY_START(PC),a0
            move.l           (a0),a0
            jsr              (a0)          
                   
            movem.l          (sp)+,d0-d7/a0-a6
            move.l           SCREEN_PTR_0,d0

            rts

CLEARFUNCTION:
            dc.l             CLEARTOP
CLEARTOP: 
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042        
            move.l           SCREEN_PTR_0,$dff054                                                                   ; copy to d channel
            move.w           #2,$DFF066 ;dmod                                                                        ;D mod
            move.w           #$3013,$dff058
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #2,$DFF066
            move.w           #$0000,$dff042
                    
            move.l           SCREEN_PTR_1,$dff054                                                                   ; copy to d channel
            move.w           #$3013,$dff058
            rts
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

VOID:
            rts

LAST_ITERATION_FUNCTION_PTR:
            dc.l             LAST_ITERATION_FUNCTION_START
            
            include          "ladder.s"
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

WIDTHTILE equ 9

space_1:
    dc.b $FE
    ;dc.b $FC
    dc.b $FC
    dc.b $FC
    dc.b $FC
    dc.b $FC
    dc.b $FC
    dc.b $FC
    dc.b $FC
    dc.b $00

space_2:
    dc.b $00
    ;dc.b $7E
    dc.b $7E
    dc.b $7E
    dc.b $7E
    dc.b $7E
    dc.b $7E
    dc.b $7E
    dc.b $7E
    dc.b $FE

BANNER_CURRENT_X:
    dc.w 0
BANNER_CURRENT_Y:
    dc.w 0

banner:
    cmpi.w #40*5*WIDTHTILE,BANNER_CURRENT_Y
    beq.s donotresetbannerx
    bsr.w blittilecpu
    
    addq #1,BANNER_CURRENT_X
    cmpi.w #40,BANNER_CURRENT_X
    bne.s donotresetbannerx
    move.w #0,BANNER_CURRENT_X
    add.w  #40*WIDTHTILE,BANNER_CURRENT_Y

donotresetbannerx:
    rts
blittilecpu:
    ;move.l SCREEN_PTR_0,a0
    ;move.l SCREEN_PTR_OTHER_0,a3
    lea SCREEN_0,a0
    lea SCREEN_00,a3
    move.w  #40*(256-5*WIDTHTILE),d7
    add.w BANNER_CURRENT_Y,d7
    adda.w d7,a0
    adda.w BANNER_CURRENT_X,a0

    adda.w d7,a3
    adda.w BANNER_CURRENT_X,a3

    lea space_1,a1
    lea space_2,a2
    moveq #WIDTHTILE-1,d0
blittilecpu_startcycle:
    move.b (a1),(a3)
    move.b (a2),256*40(a3)
    move.b (a1)+,(a0)
    move.b (a2)+,256*40(a0)
    adda.w #40,a0
    adda.w #40,a3
    dbra d0,blittilecpu_startcycle
    rts
