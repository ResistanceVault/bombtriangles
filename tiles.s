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
    dc.l PATTERN_FULL
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

PATTERN_FULL:
PATTERN_FULL_1:
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
PATTERN_FULL_2:
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
PATTERN_FULL_3:
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
PATTERN_FULL_4:
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
PATTERN_FULL_5:
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111
  dc.b      %11111111

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
  dc.l      PATTERN_FULL

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

  ; Load address of current text into a0
  ;DEBUG 1234
  movea.l    TILETXT_PTR,a0

  ; which character we want to print? Read the ascii code
  ; at addr in a5, then we increment and update the pointer
  adda.w    BANNER_CURRENT_X,a0

  ; If the text is finished print AFONT (fallback)
  cmp.l     TILETXT_PTR_END,a0
  bcs.s     tiletextnoreset
  lea       WFONT,a4
  bra.s     tilestartdrawingprocess
tiletextnoreset:

  move.b    (a0),d0
  sub.b     #65,d0

  ; a4 will hold the pointer to the font, each font is 3 bytes so we multiply d0 by 3
  mulu      #3,d0
  lea       AFONT,a4
  adda.w    d0,a4
  
tilestartdrawingprocess:
  ; Load bitplane pointers and point them to the font location
  lea       SCREEN_0,a0
  lea       SCREEN_00,a3
  move.w    #40*(256-5*WIDTHTILE),d7
  add.w     BANNER_CURRENT_Y,d7
  adda.w    d7,a0
  adda.w    BANNER_CURRENT_X,a0

  adda.w    d7,a3
  adda.w    BANNER_CURRENT_X,a3

  ; Start drawing the font with the CPU (cmooooon m68k I know you can do it)
  moveq     #WIDTHTILE-1,d0
blittilecpu_startcycle:
  cmp.w #WIDTHTILE-2,d0
  bge.w blitwithnoletters
  tst.w d0
  beq.w blitwithnoletters

  move.b (a1),d7
  move.b (a4),d6

  btst #0,d0

  beq.s donotincrementfont
  addq #1,a4
  lsl.b #2,d6
  bra.s blittilecpu_elaborate
donotincrementfont
  lsr.b #2,d6
blittilecpu_elaborate:
  andi.b #%00111100,d6
  not.b d6
  and.b d6,d7
  move.b d7,(a3)
  move.b d7,(a0)
  
  move.b (a2),d7
 ;   move.b AFONT,d6
  ;lsr.b #2,d6
  ;andi.b #$C,d6
  ;not.b d6
  and.b d6,d7
  move.b d7,256*40(a3)
  move.b d7,256*40(a0)
  addq #1,a1
  addq #1,a2
  bra.w blitwithnolettersend
blitwithnoletters:
  move.b    (a1),(a3)
  move.b    (a2),256*40(a3)
  move.b    (a1)+,(a0)
  move.b    (a2)+,256*40(a0)
blitwithnolettersend:
  adda.w    #40,a0
  adda.w    #40,a3
  dbra      d0,blittilecpu_startcycle
  rts

TILETXT_PTR:
  dc.l TILETXT1
TILETXT_PTR_END:
  dc.l TILETXT1_END

TILETXT1:
  DC.B "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
TILETXT1_END:

TILETXT2:
  DC.B "IA"
TILETXT2_END:
even

AFONT:
  dc.b %11101010
  dc.b %10101110
  dc.b %10101010
BFONT:
  dc.b %11101010
  dc.b %11001010
  dc.b %10101110
CFONT:
  dc.b %11101000
  dc.b %10001000
  dc.b %10001110
DFONT:
  dc.b %11001010
  dc.b %10011001
  dc.b %10101100
EFONT:
  dc.b %11101000
  dc.b %11101000
  dc.b %10001110
FFONT:
  dc.b %11101000
  dc.b %11101000
  dc.b %10001000
GFONT:
  dc.b %11101000
  dc.b %10001010
  dc.b %10101110
HFONT:
  dc.b %10101010
  dc.b %11101010
  dc.b %10101010
IFONT:
  dc.b %00100010
  dc.b %00100010
  dc.b %00100010
JFONT:
  dc.b %00100010
  dc.b %00100010
  dc.b %10100110
KFONT:
  dc.b %10101100
  dc.b %10001100
  dc.b %10101010
LFONT:
  dc.b %10001000
  dc.b %10001000
  dc.b %10001110
MFONT:
  dc.b %10101110
  dc.b %11101010
  dc.b %10101010
NFONT:
  dc.b %10101010
  dc.b %11101110
  dc.b %10101010
OFONT:
  dc.b %10101010
  dc.b %10101010
  dc.b %10101110
PFONT:
  dc.b %11101010
  dc.b %10101100
  dc.b %10001000
QFONT:
  dc.b %11101010
  dc.b %10101010
  dc.b %11100100
RFONT:
  dc.b %11101010
  dc.b %10101100
  dc.b %10101010
SFONT:
  dc.b %11101000
  dc.b %10001110
  dc.b %00101110
TFONT:
  dc.b %11100100
  dc.b %01000100
  dc.b %01000100
UFONT:
  dc.b %10101010
  dc.b %10101010
  dc.b %10101110
VFONT:
  dc.b %10101010
  dc.b %10101010
  dc.b %10100100
WFONT: ; empty font , real W not representable with such low bits
  dc.b 0
  dc.b 0
  dc.b 0
XFONT:
  dc.b %10101010
  dc.b %11101010
  dc.b %10101010
YFONT:
  dc.b %10101010
  dc.b %01000100
  dc.b %01000100
ZFONT:
  dc.b %11100010
  dc.b %00100100
  dc.b %10001110
  even