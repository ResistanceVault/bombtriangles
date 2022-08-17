    include "AProcessing/libs/vectors/operations.s"

    include "txttiles/txttiles.s"
    include "bombs/bombmanager.s"
    include "spaceship/spaceshipmanager.s"
    include "twister/twistermanager.s"

ammxmainloop3:
            SWAP_BPL
            bsr.s            CLEARTOP

            IFD LADDERS
            ; move ladders
            bsr.w            moveladders
            ENDC

            ; execute the drawing routine
            IFD                 DEBUGCOLORS
            move.w              #$0F00,$dff180
            ENDC
            bsr.w              WALKINGTRIANGLE
            IFD                 DEBUGCOLORS
            move.w              #$00F0,$dff180
            ENDC

            rts

CLEARTOP:
            move.l          SCREEN_PTR_0,d0
            addi.l          #40*3,d0
            WAITBLITTER
            move.w           #$0100,$dff040
            move.w           #$0000,$dff042
            move.l           d0,$dff054
            ;move.l           SCREEN_PTR_0,$dff054 ; copy to d channel
            move.w           #2,$DFF066           ; D mod
            move.w           #$2D93,$dff058

            bsr.w            BOMBMANAGER

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
            IFD                 EFFECTS
            jsr              muovicopper                                                    ; red bar after $ff
            IFND        NOGREENGLOW
            jsr              scrollcolors                                                   ; color cycling
            ENDC
            bsr              scrollskycolors                                               ; change sky colors
            ENDC
            bsr.w            SPACESHIPMANAGER

            WAITBLITTER
            ;move.l           SCREEN_PTR_1,$dff054 ; copy to d channel
            move.l          SCREEN_PTR_1,d0
            addi.l          #40*3,d0
            move.l          d0,$dff054
            move.w          #$2D93,$dff058
            bsr.w           TWISTERMANAGER

            rts

            IFD LADDERS
            include          "ladder.s"
            ENDC

            include          "stages/walkingtriangle.s"


ROTATIONS_ANGLES_64:
    IFND LOL
    dcb.w 64,0
    ELSE
            dc.w             005,011,016,022,028,033,039,044,050,056
            dc.w             061,067,072,078,084,089,095,100,106,112
            dc.w             117,123,129,134,140,145,151,157,162,168
            dc.w             173,179,185,190,196,201,207,213,218,224
            dc.w             229,235,241,246,252,258,263,269,274,280
            dc.w             286,291,297,302,308,314,319,325,330,336
            dc.w             342,347,353,000
    ENDC

ROTATIONS_ANGLES_64_180:
    IFND LOL
    dcb.w 64,0
    ELSE
            dc.w             185,191,196,202,208,213,219,225,230,236
            dc.w             241,247,253,258,264,270,275,281,286,292
            dc.w             298,303,309,315,320,326,331,337,343,348
            dc.w             354,000,005,011,016,022,028,033,039,045
            dc.w             050,056,061,067,073,078,084,090,095,101
            dc.w             106,112,118,123,129,135,140,146,151,157
            dc.w             163,168,174,180
    ENDC
ROTATIONS_ANGLES_64_END:


