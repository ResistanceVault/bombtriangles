BOMBTIMERSTART EQU 30

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
  cmp.l     #BOMBMANAGER_SPRITESLIST_END,a2
  bne.s     bombmanager_dontresetptr
  move.l    #BOMBMANAGER_SPRITESLIST,a2
bombmanager_dontresetptr:
  ; update pointer
  move.l    a2,(a0)

bombmanager_end:
  rts