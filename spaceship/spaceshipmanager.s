SPACESHIP_DECIMALDIGITS          EQU 64
SPACESHIP_START_X                EQU 64
SPACESHIP_START_Y                EQU 44
SPACESHIP2_START_X               EQU 33
SPACESHIP2_START_Y               EQU -4
SPACESHIP2_SPRITE_HEIGHT_WITH_BOMB         EQU 20
SPACESHIP2_SPRITE_HEIGHT_WITHOUT_BOMB      EQU 10
SPACESHIP2_TIMER1_SECONDS        EQU 100
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
  move.l                  #$00000000,SPACESHIP1_BPL1_RAY
  move.w                  #SPACESHIP_SPRITE_HEIGHT_NO_RAY,SPACESHIP_SPRITE_HEIGHT
  ENDM

SPACESHIP_RAY_ON MACRO
  ;move.l #$00000000,SPACESHIP1_BPL0_RAY
  move.l                 #$05400540,SPACESHIP1_BPL1_RAY
  move.w                 #SPACESHIP_SPRITE_HEIGHT_WITH_RAY,SPACESHIP_SPRITE_HEIGHT
  ENDM

SPACESHIPCURRENTPOSITION:
  dc.w                   2*SPACESHIP_START_X*SPACESHIP_DECIMALDIGITS           ;X current position
  dc.w                   SPACESHIP_START_Y*SPACESHIP_DECIMALDIGITS             ;Y current position

SPACESHIPDESTINATIONPOSITION:
  dc.w                   2*SPACESHIP_DESTINATION_X*SPACESHIP_DECIMALDIGITS    ;X destination position
  dc.w                   SPACESHIP_DESTINATION_Y*SPACESHIP_DECIMALDIGITS      ;Y destination position

SPACESHIPDIRECTIONVECTOR:
  dc.l                   0

SPACESHIP2CURRENTPOSITION:
  dc.w                   2*SPACESHIP2_START_X*SPACESHIP_DECIMALDIGITS           ;X current position
  dc.w                   SPACESHIP2_START_Y*SPACESHIP_DECIMALDIGITS

SPACESHIP2VELOCITY:
  dc.w                   2*2*SPACESHIP_DECIMALDIGITS           ;X current position
  dc.w                   2*SPACESHIP_DECIMALDIGITS

SPACESHIP2ACCELLERATION:
  dc.w                   -2*1           ;X current position
  dc.w                   -1


SPACESHIP_FRAME_COUNTER:
  dc.w                  SPACESHIP_FRAME_RATE
SPACESHIP_FRAME_PTR:
  dc.l                  SPACESHIP2_DIFF
BIGSPACESHIP_WINDOW_FRAME_PTR:
  dc.l                  BIGSPACESHIP_WINDOW_FRAME_2

SPACESHIP_SPRITE_HEIGHT:
  dc.w                  30

SPACESHIP2_SPRITE_HEIGHT:
  dc.w                  20

SPACESHIP2_TIMER:
  dc.w SPACESHIP2_TIMER1_SECONDS

; this is a 3 state variable, he's the explenation:
; -1 : Spaceship 2 is at rest, sprite wont be drawn nor updated
;  0:  Spaceship is going towards drop point, physic is applied and sprite is drawn
;  1:  Spaceship is at drop point, like state -1 physic and sprite update is OFF but timer is running
BOMBDROP:
  dc.w                   -1

SPACESHIPMANAGER:

  ; spaceship light animation start
  subq                 #1,SPACESHIP_FRAME_COUNTER
  bne.w                spaceship_do_not_update_lights

  lea                  BIGSPACESHIP_WINDOW_FRAME_PTR(PC),a4
  move.l               (a4),a5
  lea                  40*8+30+SCREEN_2,a2
  moveq                #3-1,d7 ; Cycle for each bitplane
spaceshipwindowloop:
  ;move.l               (a5),(a2)
  ;move.l               (a5)+,40(a2)
  adda.w               #224*40,a2
  dbra d7,spaceshipwindowloop

  lea                  SPACESHIP1_BPL0,a2
  lea                  SPACESHIP2_BPL0,a3
  lea                  SPACESHIP_FRAME_PTR(PC),a0

  move.l               (a0),a1
  move.l               (a1),20(a3)
  move.l               (a1)+,20(a2)
  move.l               (a1),28(a3)
  move.l               (a1)+,28(a2)
  move.l               (a1),32(a3)
  move.l               (a1)+,32(a2)
  lea                  SPACESHIP1_BPL1,a2
  lea                  SPACESHIP2_BPL1,a3
  move.l               (a1),20(a3)
  move.l               (a1)+,20(a2)
  move.l               (a1),28(a3)
  move.l               (a1)+,28(a2)
  move.l               (a1),32(a3)
  move.l               (a1)+,32(a2)
  move.w               #SPACESHIP_FRAME_RATE,SPACESHIP_FRAME_COUNTER

  ; if a1 contains now the same address of SPACESHIP_DIFF_END
  ; we must start from the first frame
  cmp.l                #SPACESHIP_DIFF_END,a1
  bne.s                spaceship_ptr_do_not_reset
  move.l               #SPACESHIP1_DIFF,a1
  move.l               #BIGSPACESHIP_WINDOW_FRAME_1,a5
spaceship_ptr_do_not_reset:

  ; update ptrs
  move.l               a1,(a0)
  move.l               a5,(a4)

spaceship_do_not_update_lights:
  ; spaceship light animation end

  ; vector 2 is current position
  lea                  SPACESHIPCURRENTPOSITION(PC),a1

  ; vector 1 is destination position
  lea                  SPACESHIPDESTINATIONPOSITION(PC),a0

  ; sub them
  SUB2DVECTORSTATIC    SPACESHIPDIRECTIONVECTOR

  ; set magnitude 1
  moveq                #1*64,d7
  lea                  SPACESHIPDIRECTIONVECTOR(PC),a0
  jsr                  SET2DMAGNITUDE_FAKE

  ; add SPACESHIPDIRECTIONVECTOR to SPACESHIPCURRENTPOSITION

  lea                  SPACESHIPDIRECTIONVECTOR(PC),a0
  lea                  SPACESHIPCURRENTPOSITION(PC),a1

  ADD2DVECTOR

  ; Dump new vector into spaceship sprite
  move.l               SPACESHIPCURRENTPOSITION(PC),d0
  move.w               d0,d1
  swap                 d0

  lea                  SPACESHIP1_BPL0,a0
  lea                  SPACESHIP1_BPL1,a1
  move.w               SPACESHIP_SPRITE_HEIGHT(PC),d7
  bsr.w                movespaceshipsprite

  ; Compute position of spaceship 2
  lea                  BOMBDROP(PC),a4
  tst.w                (a4)
  bne.w                spaceship2_end
  lea                  SPACESHIP2ACCELLERATION(PC),a0
  lea                  SPACESHIP2VELOCITY(PC),a1
  ADD2DVECTOR

  lea                  SPACESHIP2VELOCITY(PC),a0
  ; if current velocity is zero change the sprite, bomb has to be dropped
  tst.l               (a0)
  bne.s               .bombnodrop
  move.w               #1,(a4) ; stop the spaceship and start timer until something tells otherwise
.bombnodrop
  lea                  SPACESHIP2CURRENTPOSITION(PC),a1
  ADD2DVECTOR

  ; Dump new vector into spaceship2 sprite
  move.l               SPACESHIP2CURRENTPOSITION(PC),d0
  move.w               d0,d1
  swap                 d0

  ; d1 is the sprite vertical position, if d1 is > 255 it surely means
  ; that we are moving away from the dropzone and we are far enough that
  ; the spaceship is not into the screen, hence, we reset the sprite to initial state
  cmpi.w               #250*SPACESHIP_DECIMALDIGITS,d1
  blt.s                spaceship2donotreset
  move.l               #$00600010,SPACESHIP2_BPL0_BOMB ; reconstruct sprite
  move.w               #$0FF0,SPACESHIP2_BPL1_BOMB ; reconstruct sprite
  ; set new sprite height
  move.w               #SPACESHIP2_SPRITE_HEIGHT_WITH_BOMB,SPACESHIP2_SPRITE_HEIGHT
  move.w               #-1,(a4)     ; stop the sprite sprite

  ; restore position
  move.w               #2*SPACESHIP2_START_X*SPACESHIP_DECIMALDIGITS,SPACESHIP2CURRENTPOSITION
  move.w               #SPACESHIP2_START_Y*SPACESHIP_DECIMALDIGITS,SPACESHIP2CURRENTPOSITION+2

  move.w               #2*2*SPACESHIP_DECIMALDIGITS,SPACESHIP2VELOCITY
  move.w               #2*SPACESHIP_DECIMALDIGITS,SPACESHIP2VELOCITY+2

  move.w               #-2*1,SPACESHIP2ACCELLERATION
  move.w               #-1,SPACESHIP2ACCELLERATION+2

spaceship2donotreset:

  lea                  SPACESHIP2_BPL0,a0
  lea                  SPACESHIP2_BPL1,a1
  move.w               SPACESHIP2_SPRITE_HEIGHT(PC),d7
  bsr.w                movespaceshipsprite

spaceship2_end:
  cmpi.w               #1,(a4)
  bne.s                dontruntimer
  subi.w               #1,SPACESHIP2_TIMER
  ; when timer reaches 0 we cut the sprite, change vector accelleration and resume physics sprite update operations
  bne.s                dontruntimer
  move.w               #SPACESHIP2_TIMER1_SECONDS,SPACESHIP2_TIMER ; restore timer
  move.w               #0,(a4) ; resume physics and sprite update
  move.l               #0,SPACESHIP2_BPL0_BOMB ; trim sprite
  move.l               #0,SPACESHIP2_BPL1_BOMB ; trim sprite
  ; set new sprite height
  move.w               #SPACESHIP2_SPRITE_HEIGHT_WITHOUT_BOMB,SPACESHIP2_SPRITE_HEIGHT

  ;change accelleration Y vector to the opposite to force spaceship to exit to the bottom
  ; of the screen
  neg.w                SPACESHIP2ACCELLERATION+2

dontruntimer:
  rts

movespaceshipsprite:
    ; normalize for sprite
  lsr.w                #7,d0
  lsr.w                #6,d1

  ; if d0 is odd we are moving the spaceship to an odd location, in this case we must set
  btst                 #0,d0
  beq.s                .fspaceship2_no_odd_x
  bset                 #0,3(a0)
  bset                 #0,3(a1)
  bra.s                .fspaceship2_place_coords
.fspaceship2_no_odd_x:
  bclr                 #0,3(a0)
  bclr                 #0,3(a1)
.fspaceship2_place_coords:
  move.b               d0,1(a0)
  move.b               d0,1(a1)

  move.b               d1,(a0)
  move.b               d1,(a1)

  add.w                d7,d1

  move.b               d1,2(a0)
  move.b               d1,2(a1)
  rts