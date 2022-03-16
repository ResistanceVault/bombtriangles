    include "tiles.s"
    include "bombs/bombmanager.s"

ammxmainloop3:
            SWAP_BPL
            bsr.w            CLEARTOP

            ; execute banner routine
            subq             #1,TILE_COUNTER
            bne.s            donoresettilecounter
            move.w           #TILES_TIMEOUT_SECONDS*50,TILE_COUNTER ; reset the timer
            move.l           TILE_PTR(PC),a0
            SET_TILES        (a0)
            move.l           4(a0),TILETXT_PTR
            addq             #8,a0
            move.l           a0,d0
            cmpi.l           #TILE_DATA_END,d0
            bne.s            tiledatanoreset
            lea              TILE_DATA(PC),a0
tiledatanoreset:
            move.l           a0,TILE_PTR
donoresettilecounter:

            bsr.w            banner

            ; move ladders
            bsr.w            moveladders

            ; execute the drawing routine
            ;lea              DRAWFUNCTARRAY_START(PC),a0
            ;move.l           (a0),a0
            ;jsr              (a0)
            jsr               WALKINGTRIANGLE

            rts

CLEARTOP:
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042
            move.l           SCREEN_PTR_0,$dff054 ; copy to d channel
            move.w           #2,$DFF066           ; D mod
            move.w           #$2E53,$dff058

            jsr             BOMBMANAGER

            WAITBLITTER
            move.l           SCREEN_PTR_1,$dff054 ; copy to d channel
            move.w           #$2E53,$dff058
            rts

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


