SET_TILES MACRO
  move.w #0,BANNER_CURRENT_X
  move.w #0,BANNER_CURRENT_Y
  move.l \1,TILE_POINTER
  ENDM
TILES_TIMEOUT_SECONDS equ 10

TILE_DATA:
    dc.l PA2022
    dc.l TILEPATTERN2
    dc.l SPOLETO
    dc.l TILEPATTERN2
TILE_DATA_END:

TILE_PTR:
    dc.l TILE_DATA

TILE_COUNTER:
    dc.w TILES_TIMEOUT_SECONDS*50
    
WIDTHTILE equ 9

TILEPATTERN2:
TILEPATTERN2_1:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

TILEPATTERN2_2:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

TILEPATTERN2_3:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

TILEPATTERN2_4:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

TILEPATTERN2_5:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

;--------------------------------------------------
PA2022:
PA2022_1:
  dc.b      %11110001
  dc.b      %10000000
  dc.b      %00111100
  dc.b      %01100011
  dc.b      %11001111

PA2022_2:
  dc.b      %10010010
  dc.b      %01000000
  dc.b      %00000100
  dc.b      %10010000
  dc.b      %01000001

PA2022_3:
  dc.b      %11110010
  dc.b      %01000000
  dc.b      %00001000
  dc.b      %10010000
  dc.b      %10000010

PA2022_4:
  dc.b      %10000011
  dc.b      %11000000
  dc.b      %00010000
  dc.b      %10010001
  dc.b      %00000100

PA2022_5:
  dc.b      %10000010
  dc.b      %01000000
  dc.b      %00111100
  dc.b      %01100011
  dc.b      %11001111


SPOLETO:
SPOLETO_1:
  dc.b      %11110011
  dc.b      %11001111
  dc.b      %00100000
  dc.b      %11110011
  dc.b      %11001111

SPOLETO_2:
  dc.b      %10000010
  dc.b      %01001001
  dc.b      %00100000
  dc.b      %10000011
  dc.b      %11001001

SPOLETO_3:
  dc.b      %01100011
  dc.b      %11001001
  dc.b      %00100000
  dc.b      %11110001
  dc.b      %10001001

SPOLETO_4:
  dc.b      %00110010
  dc.b      %00001001
  dc.b      %00100000
  dc.b      %10000001
  dc.b      %10001001

SPOLETO_5:
  dc.b      %11110010
  dc.b      %00001111
  dc.b      %00111100
  dc.b      %11110001
  dc.b      %10001111

tile_empty:
  dc.b      $0
    ;dc.b $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $00

space_1:
  dc.b      $FE
    ;dc.b $FC
  dc.b      $FC
  dc.b      $FC
  dc.b      $FC
  dc.b      $FC
  dc.b      $FC
  dc.b      $FC
  dc.b      $FC
  dc.b      $00

space_2:
  dc.b      $00
    ;dc.b $7E
  dc.b      $7E
  dc.b      $7E
  dc.b      $7E
  dc.b      $7E
  dc.b      $7E
  dc.b      $7E
  dc.b      $7E
  dc.b      $FE
  even

BANNER_CURRENT_X:
  dc.w      0
BANNER_CURRENT_Y:
  dc.w      0
TILE_POINTER:
  dc.l      SPOLETO

banner:
  cmpi.w    #40*5*WIDTHTILE,BANNER_CURRENT_Y
  beq.s     donotresetbannerx

    ; before drawing tiles fetch the pattern and determine if the file
    ; has to be drawn OR cleared
    ;DEBUG 1235
  move.w    BANNER_CURRENT_X(PC),d0
  move.w    d0,d2
  andi.w    #7,d2
  not.w     d2
  andi.w    #7,d2

  lsr.w     #3,d0
  move.l    TILE_POINTER(PC),a0
  move.b    (a0,d0.w),d1
  btst      d2,d1
  bne.s     donotcleartile
  lea       tile_empty(PC),a1
  lea       tile_empty(PC),a2
  bra.s     drawtile
donotcleartile:
    ; Draw (or clear) the tile
  lea       space_1(PC),a1
  lea       space_2(PC),a2
drawtile:
  bsr.w     blittilecpu
    
    ; Go to the next X location for next frame
  addq      #1,BANNER_CURRENT_X
  cmpi.w    #40,BANNER_CURRENT_X                ; check if raw is done, in this case reset X and go to next Y
  bne.s     donotresetbannerx
  move.w    #0,BANNER_CURRENT_X
  add.w     #40*WIDTHTILE,BANNER_CURRENT_Y
    ;DEBUG 1234
  add.l     #5,TILE_POINTER

donotresetbannerx:
  rts


blittilecpu:

  lea       SCREEN_0,a0
  lea       SCREEN_00,a3
  move.w    #40*(256-5*WIDTHTILE),d7
  add.w     BANNER_CURRENT_Y,d7
  adda.w    d7,a0
  adda.w    BANNER_CURRENT_X,a0

  adda.w    d7,a3
  adda.w    BANNER_CURRENT_X,a3

    
  moveq     #WIDTHTILE-1,d0
blittilecpu_startcycle:
  move.b    (a1),(a3)
  move.b    (a2),256*40(a3)
  move.b    (a1)+,(a0)
  move.b    (a2)+,256*40(a0)
  adda.w    #40,a0
  adda.w    #40,a3
  dbra      d0,blittilecpu_startcycle
  rts
