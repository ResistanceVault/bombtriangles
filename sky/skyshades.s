buildskyshades:

  moveq  #$0006,d0
  move.w #$0b36,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_0,a0
  jsr buildcolortable

  move.w #$0b36,d0
  moveq  #$0003,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_0+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  moveq  #$0007,d0
  move.w #$0b37,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_1,a0
  jsr buildcolortable

  move.w #$0b37,d0
  moveq  #$0003,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_1+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  moveq  #$0008,d0
  move.w #$0b38,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_2,a0
  jsr buildcolortable

  move.w #$0b38,d0
  moveq  #$0004,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_2+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  moveq  #$0009,d0
  move.w #$0b39,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_3,a0
  jsr buildcolortable

  move.w #$0b39,d0
  moveq  #$0004,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_3+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  moveq  #$000A,d0
  move.w #$0b3a,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_4,a0
  jsr buildcolortable

  move.w #$0b3a,d0
  moveq  #$0005,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_4+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  moveq  #$000B,d0
  move.w #$0b3b,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_5,a0
  jsr buildcolortable

  move.w #$0b3b,d0
  move.w #$0005,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_5+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  move.w #$000C,d0
  move.w #$0b3c,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_6,a0
  jsr buildcolortable

  move.w #$0b3c,d0
  move.w #$0006,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_6+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  move.w #$000D,d0
  move.w #$0b3d,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_7,a0
  jsr buildcolortable

  move.w #$0b3d,d0
  move.w #$0006,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_7+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable

  move.w #$000E,d0
  move.w #$0b3f,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_8,a0
  jsr buildcolortable

  move.w #$0b3f,d0
  move.w #$0007,d1
  moveq  #(SKY_COLOR_SHADES/2)-1,d7
  lea SKY_COLORSTABLE_8+SKY_COLOR_SHADES/2*2,a0
  jsr buildcolortable
  rts

  IFD                 EFFECTS
scrollskycolors:
  ;movem.l             d0/d1/d2/a0,-(sp)
  move.w              FRAMECOUNTER,d0
  andi.w              #$003F,d0
  bne.w               dontchangeskycolor
  move.w              SKY_COLORSTABLE_INCREMENT,d1
  move.w              SKY_COLORSTABLE_COUNTER,d2
  lea                 SKY_COLORSTABLE_0,a0
  ;clr.w                  $100
  ;move.w                 #$1234,d3
  move.w              (a0,d2.w),SKY_COLOR_1
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_2
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_3
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_4
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_5
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_6
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_7
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_8
  adda.l              #SKY_COLOR_SHADES*2,a0
  move.w              (a0,d2.w),SKY_COLOR_9
  add.w               d1,d2
  beq.s               invertskyincrement
  cmpi.w              #SKY_COLOR_SHADES*2,d2
  beq.s               invertskyincrement
updateskydata:
  move.w              d1,SKY_COLORSTABLE_INCREMENT
  move.w              d2,SKY_COLORSTABLE_COUNTER
dontchangeskycolor:
  ;movem.l             (sp)+,d0/d1/d2/a0
  rts
invertskyincrement:
  neg.w               d1
  add.w               d1,d2
  bra.s               updateskydata
  ENDC