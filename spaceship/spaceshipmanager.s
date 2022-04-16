SPACESHIP_DECIMALDIGITS          EQU 64
SPACESHIP_START_X                EQU 64
SPACESHIP_START_Y                EQU 44
SPACESHIP_DESTINATION_X          EQU 160
SPACESHIP_DESTINATION_Y          EQU 100
SPACESHIP_SPRITE_HEIGHT_WITH_RAY EQU 30
SPACESHIP_SPRITE_HEIGHT_NO_RAY   EQU 10
SPACESHIP_FRAME_RATE             EQU 60*1

SPACESHIP_SET_NEW_DESTINATION MACRO
  move.l #((SPACESHIP_DECIMALDIGITS*2*\1)<<16)|\2*SPACESHIP_DECIMALDIGITS,SPACESHIPDESTINATIONPOSITION
  ENDM
SPACESHIP_SET_NEW_DESTINATION2 MACRO
  move.w #SPACESHIP_DECIMALDIGITS*2*\1,SPACESHIPDESTINATIONPOSITION
  move.w #\2*SPACESHIP_DECIMALDIGITS,SPACESHIPDESTINATIONPOSITION+2
  ENDM

SPACESHIP_RAY_OFF MACRO
  ;move.l #$00000000,SPACESHIP1_BPL0_RAY
  move.l #$00000000,SPACESHIP1_BPL1_RAY
  move.w #SPACESHIP_SPRITE_HEIGHT_NO_RAY,SPACESHIP_SPRITE_HEIGHT
  ENDM

SPACESHIP_RAY_ON MACRO
  ;move.l #$00000000,SPACESHIP1_BPL0_RAY
  move.l #$05400540,SPACESHIP1_BPL1_RAY
  move.w #SPACESHIP_SPRITE_HEIGHT_WITH_RAY,SPACESHIP_SPRITE_HEIGHT
  ENDM

SPACESHIPCURRENTPOSITION:
  dc.w  2*SPACESHIP_START_X*SPACESHIP_DECIMALDIGITS           ;X current position
  dc.w  SPACESHIP_START_Y*SPACESHIP_DECIMALDIGITS             ;Y current position

SPACESHIPDESTINATIONPOSITION:
  dc.w  2*SPACESHIP_DESTINATION_X*SPACESHIP_DECIMALDIGITS    ;X destination position
  dc.w  SPACESHIP_DESTINATION_Y*SPACESHIP_DECIMALDIGITS      ;Y destination position

SPACESHIPDIRECTIONVECTOR:
  dc.l                   0

DESTINATION_REACHED:
  dc.w                  0

SPACESHIP_FRAME_COUNTER:
  dc.w                  SPACESHIP_FRAME_RATE
SPACESHIP_FRAME_PTR:
  dc.l                  SPACESHIP2_DIFF

SPACESHIP_SPRITE_HEIGHT:
  dc.w 30

SPACESHIPMANAGER:
  movem.l                d0-d7/a0-a6,-(sp)

  ; spaceship light animation start
  subq                 #1,SPACESHIP_FRAME_COUNTER
  bne.s                spaceship_do_not_update_lights
  lea                  SPACESHIP1_BPL0,a2
  lea                  SPACESHIP_FRAME_PTR(PC),a0
  move.l               (a0),a1
  move.l               (a1)+,16(a2)
  move.l               (a1)+,36(a2)
  move.l               (a1)+,40(a2)
  lea                  SPACESHIP1_BPL1,a2
  move.l               (a1)+,16(a2)
  move.l               (a1)+,36(a2)
  move.l               (a1)+,40(a2)
  move.w               #SPACESHIP_FRAME_RATE,SPACESHIP_FRAME_COUNTER

  ; if a1 contains now the same address of SPACESHIP_DIFF_END
  ; we must start from the first frame
  cmp.l                #SPACESHIP_DIFF_END,a1
  bne.s                spaceship_ptr_do_not_reset
  move.l               #SPACESHIP1_DIFF,a1
spaceship_ptr_do_not_reset:

  ; update ptr
  move.l               a1,(a0)

spaceship_do_not_update_lights:
  ; spaceship light animation end

  ; vector 2 is current position
  lea                  SPACESHIPCURRENTPOSITION(PC),a1

  ; vector 1 is destination position
  lea                  SPACESHIPDESTINATIONPOSITION(PC),a0

  ; sub them
  SUB2DVECTORSTATIC    SPACESHIPDIRECTIONVECTOR

  tst.w DESTINATION_REACHED
  bne.s nogotonextlocation
  nop

  ; try to understand if the destination point has been reached
  ;move.w SPACESHIPDIRECTIONVECTOR+2,d7

  IFD CAMBIO
  tst.w SPACESHIPDIRECTIONVECTOR+2
  bne.s nogotonextlocation
  move.l SPACESHIPDESTINATIONPOSITION,SPACESHIPCURRENTPOSITION
  ;move.l #$23002f00,SPACESHIPDESTINATIONPOSITION
  SPACESHIP_SET_NEW_DESTINATION 64,150
  move.w #1,DESTINATION_REACHED
  movem.l                (sp)+,d0-d7/a0-a6
  rts
  ENDC
nogotonextlocation:

  ; set magnitude 1
  moveq                #1*64,d7
  lea                  SPACESHIPDIRECTIONVECTOR(PC),a0
  jsr                  SET2DMAGNITUDE_FAKE

  ; add SPACESHIPDIRECTIONVECTOR to SPACESHIPCURRENTPOSITION

  lea                  SPACESHIPDIRECTIONVECTOR(PC),a0
  lea                  SPACESHIPCURRENTPOSITION(PC),a1

  ADD2DVECTOR

  ; Dump new vector into spaceship sprite
  move.l SPACESHIPCURRENTPOSITION(PC),d0
  ;move.l #$24000c00,d0
  move.w d0,d1
  swap d0

  ; if d0 is odd we are moving the spaceship to an odd location, in this case we must set
  btst #0,d0
  beq.s spaceship_no_odd_x
  bset #0,3+SPACESHIP1_BPL0
  bset #0,3+SPACESHIP1_BPL1
  bra.s spaceship_place_coords
spaceship_no_odd_x:
  bclr #0,3+SPACESHIP1_BPL0
  bclr #0,3+SPACESHIP1_BPL1
spaceship_place_coords:

  ; normalize for sprite
  lsr.w #7,d0
  lsr.w #6,d1

  DEBUG 1234

  move.b d0,SPACESHIP1_BPL0_HSTART
  move.b d0,SPACESHIP1_BPL1_HSTART

  move.b d1,SPACESHIP1_BPL0_VSTART
  move.b d1,SPACESHIP1_BPL1_VSTART

  add.w SPACESHIP_SPRITE_HEIGHT,d1

  move.b d1,SPACESHIP1_BPL0_VSTOP
  move.b d1,SPACESHIP1_BPL1_VSTOP
  movem.l                (sp)+,d0-d7/a0-a6
  rts