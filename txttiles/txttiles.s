SET_TILES MACRO
  move.w #0,BANNER_CURRENT_X
  move.w #0,BANNER_CURRENT_Y
  move.l \1,TILE_POINTER
  ENDM
TILES_TIMEOUT_SECONDS equ 10

TILE_DATA:

  dc.l PATTERN_FULL
  dc.l TILETXT1

  dc.l PATTERN_FULL
  dc.l TILETXT2

  dc.l PATTERN_FULL
  dc.l MUSIC

  dc.l MAZE
  dc.l TILETXT_EMPTY

  dc.l PATTERN_FULL
  dc.l CODE

  dc.l OZZY
  dc.l TILETXT_EMPTY

  dc.l PATTERN_FULL
  dc.l GFX

  dc.l ERIC
  dc.l TILETXT_EMPTY

  dc.l PATTERN_FULL
  dc.l BETA_TESTING

  dc.l Z3K
  dc.l TILETXT_EMPTY

  dc.l PATTERN_FULL
  dc.l TILETXT3

  dc.l PATTERN_FULL
  dc.l TILETXT4

  dc.l PATTERN_FULL
  dc.l TILETXT5

  dc.l SPOLETO
  dc.l TILETXT_EMPTY

  dc.l PATTERN_EMPTY
  dc.l TILETXT_EMPTY

TILE_DATA_END:

TILE_PTR:
  dc.l TILE_DATA

TILE_COUNTER:
    dc.w TILES_TIMEOUT_SECONDS*50

WIDTHTILE equ 9

PATTERN_EMPTY:
PATTERN_EMPTY_1:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

PATTERN_EMPTY_2:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

PATTERN_EMPTY_3:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

PATTERN_EMPTY_4:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

PATTERN_EMPTY_5:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

;--------------------------------------------------
; Patterns
;--------------------------------------------------

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

Z3K:
  dc.b $00,$0F,$38,$90,$00
  dc.b $00,$01,$04,$A0,$00 
  dc.b $00,$02,$08,$C0,$00
  dc.b $00,$04,$04,$A0,$00
  dc.b $00,$0F,$38,$90,$00 

MAZE:
  dc.b $00,$00,$C1,$8F,$00 
  dc.b $00,$A1,$22,$48,$00 
  dc.b $01,$51,$20,$8E,$00 
  dc.b $01,$12,$D1,$08,$00 
  dc.b $01,$12,$13,$CF,$00
  
OZZY:
  dc.b $00,$F3,$CF,$22,$00
  dc.b $00,$90,$41,$14,$00
  dc.b $00,$90,$82,$08,$00
  dc.b $00,$91,$04,$08,$00
  dc.b $00,$F3,$CF,$08,$00 

ERIC:
 dc.b $00,$0F,$3C,$90,$00
 dc.b $00,$08,$24,$B0,$00 
 dc.b $00,$0E,$28,$C0,$00
 dc.b $00,$08,$30,$A0,$00
 dc.b $00,$0F,$2C,$90,$00 

tile_empty:
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0
  dc.b      $0

space_1:
  dc.b      $FE
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
  dc.l      PATTERN_EMPTY

banner:
  lea       BANNER_CURRENT_X(PC),a3
  move.w    (a3),d3
  cmpi.w    #40*5*WIDTHTILE,2(a3)
  beq.s     donotresetbannerx

  ; before drawing tiles fetch the pattern and determine if the file
  ; has to be drawn OR cleared
  move.w    (a3),d0
  move.w    d0,d2
  move.w    d0,d3
  andi.w    #7,d2
  not.w     d2
  andi.w    #7,d2

  lsr.w     #3,d0
  move.l    TILE_POINTER(PC),a0
  move.b    (a0,d0.w),d1
  btst      d2,d1
  bne.s     donotcleartile
  lea       tile_empty(PC),a1
  move.l    a1,a2
  bra.s     drawtile
donotcleartile:
  ; Draw (or clear) the tile
  lea       space_1(PC),a1
  lea       space_2(PC),a2
drawtile:
  bsr.s     blittilecpu

  ; Go to the next X location for next frame
  addq      #1,d3
  cmpi.w    #40,d3                ; check if raw is done, in this case reset X and go to next Y
  bne.s     donotresetbannerx
  move.w    #0,d3
  add.w     #40*WIDTHTILE,2(a3)
  addq.l    #5,TILE_POINTER

donotresetbannerx:
  move.w    d3,(a3)
  rts

blittilecpu:
  ; if we are in NOP mode just print an empty character
  tst.w     TILETEXT_NOP
  beq.s     notiletextnop
  subq      #1,TILETEXT_NOP
  lea       SPACEFONT(PC),a4
  bra.s     tilestartdrawingprocess
notiletextnop

  ; Load address of current text into a0
  movea.l    TILETXT_PTR(PC),a0

  move.b    (a0)+,d0 ; fetch the letter

  ; go to next letter
  move.l    a0,TILETXT_PTR

  sub.b     #65,d0 ; normalize it according to ascii table (A=65, B=66 ... and so on)
  bpl.s     tilevalidfont ; if we got a negative number it means we are at the end of the line, in this case just nop the amount indicated
  lea       SPACEFONT(PC),a4      ; end of line, force print space (which is an empty font)
  add.b     #64,d0
  move.b    d0,TILETEXT_NOP+1
  bra.s     tilestartdrawingprocess
tilevalidfont

  ; a4 will hold the pointer to the font, each font is 3 bytes so we multiply d0 by 3
  mulu      #3,d0
  lea       AFONT(PC),a4
  adda.w    d0,a4

  ; here a4 must hold the address of the letter to print
tilestartdrawingprocess:
  ; Load bitplane pointers and point them to the font location
  lea       SCREEN_0,a0
  move.w    #40*(256-5*WIDTHTILE),d7
  add.w     BANNER_CURRENT_Y,d7
  adda.w    d7,a0
  adda.w    BANNER_CURRENT_X,a0

  ; Start drawing the font with the CPU (cmooooon m68k I know you can do it)
  moveq     #WIDTHTILE-1,d0
blittilecpu_startcycle:
  cmp.w     #WIDTHTILE-2,d0
  bge.s     blitwithnoletters
  tst.w     d0
  beq.s     blitwithnoletters

  move.b    (a1),d7
  move.b    (a4),d6

  btst      #0,d0

  beq.s     donotincrementfont
  addq      #1,a4
  lsl.b     #2,d6
  bra.s     blittilecpu_elaborate
donotincrementfont
  lsr.b     #2,d6
blittilecpu_elaborate:
  andi.b    #%00111100,d6
  not.b     d6
  and.b     d6,d7
  move.b    d7,(a0)

  move.b    (a2),d7
  and.b     d6,d7
  move.b    d7,256*40(a0)
  addq      #1,a1
  addq      #1,a2
  bra.s   blitwithnolettersend
blitwithnoletters:
  move.b    (a1)+,(a0)
  move.b    (a2)+,256*40(a0)
blitwithnolettersend:
  adda.w    #40,a0
  dbra      d0,blittilecpu_startcycle
  rts

TILETXT_PTR:
  dc.l TILETXT_EMPTY
TILETEXT_NOP:
  dc.w 0

; TEXT ON TILES
TILETXT1:
  dc.b 7,"OZZYBOSHI",1,"PROUDLY",1,"PRESENTS",7
  dc.b  40
  dc.b 13,"BOMBTRIANGLES",14
  dc.b  40
  DC.B 4,"A",1,"NEW",1,"PRODUCTION",1,"FOR",1,"FLASHPARTY",5

TILETXT2:
  dc.b  40
  dc.b  7,"THIS",1,"IS",1,"A",1,"TWENTY",1,"KB",1,"INTRO",8
  dc.b  40
  dc.b  10,"MEANT",1,"FOR",1,"UNEXPANDED",10
  dc.b  15,"AMIGA",1,"IOOO",15

GREETINGS_TO:
  dc.b  40
  dc.b  40
  dc.b  14,"GREETINGS",1,"TO",14
  dc.b  40
  dc.b  40

BETA_TESTING:
  dc.b  40
  dc.b  40
  dc.b  5,"BETA",1,"TESTING",1,"ON",1,"REAL",1,"AMIGA",1,"IOOO",4
  dc.b  40
  dc.b  40

GFX:
  dc.b  40
  dc.b  40
  dc.b  17,"GFX",1,"BY",17
  dc.b  40
  dc.b  40

MUSIC:
  dc.b  40
  dc.b  40
  dc.b  16,"MUSIC",1,"BY",16
  dc.b  40
  dc.b  40

CODE:
  dc.b  40
  dc.b  40
  dc.b  17,"CODE",1,"BY",16
  dc.b  40
  dc.b  40

TILETXT3:
  dc.b  14,"GREETINGS",1,"TO",14
  dc.b  40
  dc.b  17,"BIGGUN",17
  dc.b  13,"DIRK",1,"THE",1,"DARING",12
  dc.b  15,"DR",1,"PROCTON",15

TILETXT4:
  dc.b  16,"PELLICUS",16
  dc.b  14,"PRINCE",1,"PHAZE",14
  dc.b  12,"NOVAMIGA",1,"FORUM",14
  dc.b  40
  dc.b  3,"ALL",1,"THE",1,"PEOPLE",1,"KEEPING",1,"AMIGA",1,"ALIVE",3

TILETXT5:
  dc.b  3,"UN",1,"SALUTO",1,"SPECIALE",1,"AI",1,"REDATTORI",1,"DI",3
  dc.b  13,"PASSIONE",1,"AMIGA",13
  dc.b  "E",1,"A",1,"TUTTI",1,"I",1,"PRESENTI",1,"ALLA",1,"MANIFESTAZIONE"
  dc.b  4,"PASSIONE",1,"AMIGA",1,"DAY",1,"TENUTASI",1,"NELLA",3
  dc.b  12,"STUPENDA",1,"CITTA",1,"DI",11

TILETXT_EMPTY:
  dc.b 40
  dc.b 40
  dc.b 40
  dc.b 40
  dc.b 40

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
  dc.b %01000100
  dc.b %01000100
  dc.b %01000100
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
  dc.b %10011001
  dc.b %11011101
  dc.b %10111001
OFONT:
  dc.b %11101010
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
WFONT:
  dc.b %10011001
  dc.b %10011101
  dc.b %11111001
XFONT:
  dc.b %10011001
  dc.b %01100110
  dc.b %10011001
YFONT:
  dc.b %10101010
  dc.b %01000100
  dc.b %01000100
ZFONT:
  dc.b %11100010
  dc.b %00100100
  dc.b %10001110
SPACEFONT:
  dc.b %00000000
  dc.b %00000000
  dc.b %00000000
  even