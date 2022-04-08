SPACESHIPCURRENTPOSITION:
  dc.w  $2400                 ;X current position
  dc.w  $0c00                 ;Y current position

SPACESHIPDESTINATIONPOSITION:
  dc.w    $2400               ;X destination position
  dc.w    $2f00               ;Y destination position

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
  move.l #$23002f00,SPACESHIPDESTINATIONPOSITION
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

 

  lsr.w #6,d0
  lsr.w #6,d1



 
  DEBUG 1234



  ;moveq #$80,d0
  ;swap d0

  move.b d0,SPACESHIP1_BPL0_HSTART
  move.b d0,SPACESHIP1_BPL1_HSTART
  ;rts

  ;swap d0
  move.b d1,SPACESHIP1_BPL0_VSTART
  move.b d1,SPACESHIP1_BPL1_VSTART

  add.w #10,d1

  move.b d1,SPACESHIP1_BPL0_VSTOP
  move.b d1,SPACESHIP1_BPL1_VSTOP
  movem.l                (sp)+,d0-d7/a0-a6
  rts