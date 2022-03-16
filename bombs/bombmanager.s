BOMBTIMERSTART EQU 100

BOMBMANAGER_SPRITESLIST:
  dc.l      BOMB2_BPL0
  dc.l      BOMB2_BPL1
  dc.l      BOMB1_BPL0
  dc.l      BOMB1_BPL1
BOMBMANAGER_SPRITESLIST_END:

BOMBMANAGER_PTR:
  dc.l      BOMBMANAGER_SPRITESLIST

BOMBTIMER:
  dc.w      BOMBTIMERSTART

BOMBMANAGER:
  subq      #1,BOMBTIMER
  bne.s     bombmanager_end

  ; reset timer
  move.w    #BOMBTIMERSTART,BOMBTIMER

  ; manage here all the stuff to move to the next bomb sprite
  ; Sprite 4 init
  lea       BOMBMANAGER_PTR,a0
  move.l    (a0),d0
  lea       Sprite4pointers,a1
  jsr       POINTINCOPPERLIST_FUNCT

  ; Sprite 5 init
  move.l    4(a0),d0
  lea       Sprite5pointers,a1
  jsr       POINTINCOPPERLIST_FUNCT

  ; go to next sprite
  addq      #8,d0

  ; if we reached the end reset the pointer
  cmp.l     #BOMBMANAGER_SPRITESLIST_END,d0
  bne.s     bombmanager_dontresetptr
  move.l    #BOMBMANAGER_SPRITESLIST,d0
bombmanager_dontresetptr:
  ; update pointer
  move.l    d0,BOMBMANAGER_PTR

bombmanager_end:
  rts