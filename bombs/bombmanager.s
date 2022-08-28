BOMBTIMERSTART EQU 30

BOMB_RESET_TIMER MACRO
  move.w    #BOMBTIMERSTART,BOMBTIMER
  ENDM

; Sprite set definition start
BOMBMANAGER_SPRITESLIST_BOMB_ON:
  dc.l      BOMB2_BPL0
  dc.l      BOMB2_BPL1
  dc.l      BOMB1_BPL0
  dc.l      BOMB1_BPL1
BOMBMANAGER_SPRITESLIST_BOMB_ON_END:

BOMBMANAGER_SPRITESLIST_BOMB_RED:
  dc.l      BOMB4_BPL0
  dc.l      BOMB4_BPL1
BOMBMANAGER_SPRITESLIST_BOMB_RED_END:

BOMBMANAGER_SPRITESLIST_BOMB_BLOW:
  dc.l      BOMB8_BPL0
  dc.l      BOMB8_BPL1
  dc.l      BOMB9_BPL0
  dc.l      BOMB9_BPL1
  dc.l      BOMB10_BPL0
  dc.l      BOMB10_BPL1
  dc.l      BOMB0_BPL0
  dc.l      BOMB0_BPL1
  dc.l      BOMB0_BPL0
  dc.l      BOMB0_BPL1
  dc.l      BOMB0_BPL0
  dc.l      BOMB0_BPL1
  dc.l      BOMB0_BPL0
  dc.l      BOMB0_BPL1
BOMBMANAGER_SPRITESLIST_BOMB_BLOW_END:
; Sprite set definition end

BOMBMANAGER_PTR:
  dc.l      BOMBMANAGER_SPRITESLIST_BOMB_ON

BOMBMANAGER_PTR_START:
  dc.l      BOMBMANAGER_SPRITESLIST_BOMB_ON

BOMBMANAGER_PTR_END:
  dc.l      BOMBMANAGER_SPRITESLIST_BOMB_ON_END

BOMBTIMER:
  dc.w      BOMBTIMERSTART

BOMB_EXPLODE:
  ;move.l    #BOMB10_BPL0,d0
  ;lea       Sprite4pointers,a1
  ;jsr       POINTINCOPPERLIST_FUNCT
  ;move.l    #BOMB10_BPL1,d0
  ;lea       Sprite5pointers,a1
  ;jsr       POINTINCOPPERLIST_FUNCT
  ;BOMB_RESET_TIMER
  ;lea BOMBMANAGER_SPRITESLIST(PC),a0
  ;move.l #BOMB8_BPL0,(a0)+
  ;move.l #BOMB8_BPL1,(a0)+
  ;move.l #BOMB9_BPL0,(a0)+
  ;move.l #BOMB9_BPL1,(a0)+
  ;move.l #BOMB10_BPL0,(a0)+
  ;move.l #BOMB10_BPL1,(a0)
  move.w    #0,BOMBDROP
  cmp.l #BOMBMANAGER_SPRITESLIST_BOMB_BLOW_END,BOMBMANAGER_PTR_END
  beq.s BOMB_EXPLODE_END
  move.w #1,BOMBTIMER
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_BLOW,BOMBMANAGER_PTR
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_BLOW,BOMBMANAGER_PTR_START
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_BLOW_END,BOMBMANAGER_PTR_END
BOMB_EXPLODE_END:
  rts

BOMB_RED:
  ;move.l    #BOMB4_BPL0,d0
  ;lea       Sprite4pointers,a1
  ;jsr       POINTINCOPPERLIST_FUNCT
  ;move.l    #BOMB4_BPL1,d0
  ;lea       Sprite5pointers,a1
  ;jsr       POINTINCOPPERLIST_FUNCT
  ;BOMB_RESET_TIMER
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_RED,BOMBMANAGER_PTR
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_RED,BOMBMANAGER_PTR_START
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_RED_END,BOMBMANAGER_PTR_END
  rts

BOMB_SHORT:
  ;move.l    #BOMB3_BPL0,d0
  ;lea       Sprite4pointers,a1
  ;jsr       POINTINCOPPERLIST_FUNCT
  ;move.l    #BOMB3_BPL1,d0
  ;lea       Sprite5pointers,a1
  ;jsr       POINTINCOPPERLIST_FUNCT
  ;BOMB_RESET_TIMER
  ;lea BOMBMANAGER_SPRITESLIST(PC),a0
  ;move.l #BOMB3_BPL0,(a0)+
  ;move.l #BOMB3_BPL1,(a0)+
  ;move.l #BOMB3_BPL0,(a0)+
  ;move.l #BOMB3_BPL1,(a0)

  ;rts

BOMB_ON:
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_ON,BOMBMANAGER_PTR
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_ON,BOMBMANAGER_PTR_START
  move.l #BOMBMANAGER_SPRITESLIST_BOMB_ON_END,BOMBMANAGER_PTR_END
  rts

BOMBMANAGER:
  subq      #1,BOMBTIMER
  bne.s     bombmanager_end

  ; reset timer
  BOMB_RESET_TIMER

  ; manage here all the stuff to move to the next bomb sprite
  ; Sprite 4 init
  lea       BOMBMANAGER_PTR(PC),a0
  move.l    (a0),a2
  move.l    (a2),d0
  lea       Sprite4pointers,a1
  jsr       POINTINCOPPERLIST_FUNCT

  ; Sprite 5 init
  addq      #4,a2
  move.l    (a2),d0
  lea       Sprite5pointers,a1
  jsr       POINTINCOPPERLIST_FUNCT

  ; go to next sprite
  addq      #4,a2

  ; if we reached the end reset the pointer
  lea       BOMBMANAGER_PTR_END(PC),a3
  cmp.l     (a3),a2
  bne.s     bombmanager_dontresetptr
  lea       BOMBMANAGER_PTR_START(PC),a3
  move.l    (a3),a2
bombmanager_dontresetptr:
  ; update pointer
  move.l    a2,(a0)

bombmanager_end:
  rts