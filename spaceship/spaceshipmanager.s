SPACESHIPCURRENTPOSITION:
  dc.w                   $0c00
  dc.w                   $2400

SPACESHIPDESTINATIONPOSITION:
  dc.w                   $2800
  dc.w                   $2600

SPACESHIPDIRECTIONVECTOR:
  dc.l                   0

SPACESHIPMANAGER:
  movem.l                d0-d7/a0-a6,-(sp)
  ; vector 2 is current position
  lea                  SPACESHIPCURRENTPOSITION(PC),a1

  ; vector 1 is destination position
  lea                  SPACESHIPDESTINATIONPOSITION(PC),a0

  ; sub them
  SUB2DVECTORSTATIC    SPACESHIPDIRECTIONVECTOR

  ; try to understand if the destination point has been reached
  tst.w SPACESHIPDIRECTIONVECTOR+2
  bne.s nogotonextlocation
  move.l #$28002700,SPACESHIPDESTINATIONPOSITION
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
  lsr.l #6,d0
  DEBUG 1234



  ;moveq #$80,d0
  swap d0

  move.b d0,SPACESHIP1_BPL0_HSTART
  move.b d0,SPACESHIP1_BPL1_HSTART
  ;rts

  swap d0
  move.b d0,SPACESHIP1_BPL0_VSTART
  move.b d0,SPACESHIP1_BPL1_VSTART

  add.w #10,d0

  move.b d0,SPACESHIP1_BPL0_VSTOP
  move.b d0,SPACESHIP1_BPL1_VSTOP
  movem.l                (sp)+,d0-d7/a0-a6
  rts