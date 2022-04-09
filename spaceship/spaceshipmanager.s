SPACESHIP_DECIMALDIGITS EQU 64
SPACESHIP_START_X       EQU 64
SPACESHIP_START_Y       EQU 44
SPACESHIP_DESTINATION_X EQU 160
SPACESHIP_DESTINATION_Y EQU 100
SPACESHIP_SPRITE_HEIGHT EQU 10

SPACESHIP_SET_NEW_DESTINATION MACRO
  move.l #((SPACESHIP_DECIMALDIGITS*2*\1)<<16)|\2,SPACESHIPDESTINATIONPOSITION
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

SPACESHIPMANAGER:
  movem.l                d0-d7/a0-a6,-(sp)
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

  IFND CAMBIO
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

  add.w #SPACESHIP_SPRITE_HEIGHT,d1

  move.b d1,SPACESHIP1_BPL0_VSTOP
  move.b d1,SPACESHIP1_BPL1_VSTOP
  movem.l                (sp)+,d0-d7/a0-a6
  rts