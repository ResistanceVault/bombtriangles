; Program to handle LADDERS
; To draw ladders use HW sprites

                include    "ladder2.i"


LADDERSPACING            equ 45
LADDERHEIGHT             equ 3
LADDERVERTICALPOSITION   equ STARTWALKYPOS+49
LADDERHORIZONTALPOSITION equ $C4
LADDERHORIZONTALSPACING  equ 14

START_LADDERS MACRO
  move.w #$AAAA,LADDER_CTRL
  ENDM

STOP_LADDERS MACRO
  move.w #$0,LADDER_CTRL
  ENDM

; SET THIS TO $AAAA TO START MOVING LADDERS
; RESET TO ZERO TO STOP THEM
LADDER_CTRL:
                dc.w       $0000


RIGHTLADDERCOUNTER:
                dc.w       LADDERSPACING-1
moveladders:
                DEBUG 1234


                ROR       LADDER_CTRL
                bcc.w      moveladders_end
                bsr.w      drawtopstep
                tst.w      RIGHTLADDERCOUNTER
                bne.s      proceedmoving

            ; reset ladder 1
                move.b     #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*2,LADDER_1_VSTART0
                move.b     #LADDERVERTICALPOSITION-LADDERSPACING*2,LADDER_1_VSTOP0

                move.b     #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*1,LADDER_1_VSTART1
                move.b     #LADDERVERTICALPOSITION-LADDERSPACING*1,LADDER_1_VSTOP1

                move.b     #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*0,LADDER_1_VSTART2
                move.b     #LADDERVERTICALPOSITION-LADDERSPACING*0,LADDER_1_VSTOP2

            ; reset ladder 2
                move.b     #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*3,LADDER_2_VSTART0
                move.b     #LADDERVERTICALPOSITION-LADDERSPACING*3,LADDER_2_VSTOP0

                move.b     #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*2,LADDER_2_VSTART1
                move.b     #LADDERVERTICALPOSITION-LADDERSPACING*2,LADDER_2_VSTOP1

                move.b     #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*1,LADDER_2_VSTART2
                move.b     #LADDERVERTICALPOSITION-LADDERSPACING*1,LADDER_2_VSTOP2

                move.w     #LADDERSPACING-1,RIGHTLADDERCOUNTER
                move.w     #358,ANGLESTEP
                rts
proceedmoving;
                subi.w     #1,RIGHTLADDERCOUNTER
                subi.b     #1,LADDER_1_VSTART0
                subi.b     #1,LADDER_1_VSTOP0
                subi.b     #1,LADDER_1_VSTART1
                subi.b     #1,LADDER_1_VSTOP1
                subi.b     #1,LADDER_1_VSTART2
                subi.b     #1,LADDER_1_VSTOP2
       
                addi.b     #1,LADDER_2_VSTART0
                addi.b     #1,LADDER_2_VSTOP0
                addi.b     #1,LADDER_2_VSTART1
                addi.b     #1,LADDER_2_VSTOP1
                addi.b     #1,LADDER_2_VSTART2
                addi.b     #1,LADDER_2_VSTOP2
moveladders_end:
                rts

drawtopstep:
              ; Sprite 2 init
                MOVE.L     LADDER_PTR,d0
                LEA        SpritePointers+16,A1	
                move.w     d0,6(a1)
                swap       d0
                move.w     d0,2(a1)
                swap       d0
              ;         clr.w $100
              ;move.w #$1234,d3
                move.l     d0,a0
                move.w     -2(a0),d5
                ;tst.w      STEPS_COUNTER
                ;bne.s      step_noreset
                add.w      d5,d0
                addq       #2,d0
                ;move.w     #2,STEPS_COUNTER
                move.l     d0,LADDER_PTR
                cmp.l      #step_end+2,d0
                bne.s      step_noreset
                move.l     #step_0+2,LADDER_PTR
step_noreset:
                ;subq       #1,STEPS_COUNTER
                rts

LADDER_PTR:     dc.l       step_0+2
STEPS_COUNTER:  dc.w       0