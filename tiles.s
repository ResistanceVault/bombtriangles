SET_TILES MACRO
  move.w #0,BANNER_CURRENT_X
  move.w #0,BANNER_CURRENT_Y
  move.l \1,TILE_POINTER
  ENDM
TILES_TIMEOUT_SECONDS equ 10

TILE_DATA:
    dc.l EMPTYTILEPATTERN
    dc.l TILETXT_EMPTY

    dc.l PATTERN_FULL
    dc.l TILETXT1
    
    dc.l PA2022
    dc.l TILETXT_EMPTY

    dc.l EMPTYTILEPATTERN
    dc.l TILETXT_EMPTY

    dc.l SPOLETO
    dc.l TILETXT_EMPTY

    dc.l EMPTYTILEPATTERN
    dc.l TILETXT_EMPTY

    dc.l PATTERN_FULL
    dc.l TILETXT2
TILE_DATA_END:

TILE_PTR:
    dc.l TILE_DATA

TILE_COUNTER:
    dc.w TILES_TIMEOUT_SECONDS*50
    
WIDTHTILE equ 9

EMPTYTILEPATTERN:
EMPTYTILEPATTERN_1:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

EMPTYTILEPATTERN_2:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

EMPTYTILEPATTERN_3:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

EMPTYTILEPATTERN_4:
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0
  dc.b      0

EMPTYTILEPATTERN_5:
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
  ; if we are in NOP mode just print an empty character
  tst.w TILETEXT_NOP
  beq.s notiletextnop
  subq #1,TILETEXT_NOP
  lea       WFONT,a4
  bra.s     tilestartdrawingprocess
notiletextnop

  ; Load address of current text into a0
  movea.l    TILETXT_PTR,a0

  move.b    (a0),d0 ; fetch the letter

  ; go to next letter
  addq      #1,a0
  move.l    a0,TILETXT_PTR

  sub.b     #65,d0 ; normalize it according to ascii table (A=65, B=66 ... and so on)
  bpl.s     tilevalidfont ; if we got a negative number it means we are at the end of the line, in this case just nop the amount indicated
  lea       WFONT,a4      ; end of line, force print W (which is an empty font)
  add.b     #64,d0
  move.b    d0,TILETEXT_NOP+1
  bra.s     tilestartdrawingprocess
tilevalidfont

  ; a4 will hold the pointer to the font, each font is 3 bytes so we multiply d0 by 3
  mulu      #3,d0
  lea       AFONT,a4
  adda.w    d0,a4

  ; here a4 must hold the address of the letter to print
  
tilestartdrawingprocess:
  ; Load bitplane pointers and point them to the font location
  lea       SCREEN_0,a0
  ;lea       SCREEN_00,a3
  move.w    #40*(256-5*WIDTHTILE),d7
  add.w     BANNER_CURRENT_Y,d7
  adda.w    d7,a0
  adda.w    BANNER_CURRENT_X,a0

  ;adda.w    d7,a3
  ;adda.w    BANNER_CURRENT_X,a3

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
;  move.b d7,(a3)
  move.b d7,(a0)
  
  move.b (a2),d7
 ;   move.b AFONT,d6
  ;lsr.b #2,d6
  ;andi.b #$C,d6
  ;not.b d6
  and.b d6,d7
;  move.b d7,256*40(a3)
  move.b d7,256*40(a0)
  addq #1,a1
  addq #1,a2
  bra.w blitwithnolettersend
blitwithnoletters:
;  move.b    (a1),(a3)
;  move.b    (a2),256*40(a3)
  move.b    (a1)+,(a0)
  move.b    (a2)+,256*40(a0)
blitwithnolettersend:
  adda.w    #40,a0
;  adda.w    #40,a3
  dbra      d0,blittilecpu_startcycle
  rts

TILETXT_PTR:
  dc.l TILETXT1
TILETEXT_NOP:
  dc.w 0

; TEXT ON TILES, USE THE W AS SPACES!!!!!!!!!!!!!!!!!!!!!!!!!!!!
TILETXT1:
  dc.b  40
  DC.B "ABCDEFGHIJKLMNOPQRSTUVWXYZ",14
  DC.B "ALESSIO",33
  DC.B "GARZI",35
  DC.B "A",39

TILETXT2:
  dc.b  13,"PASSIONEWAMIGA",13
  dc.b  17,"OPPURE",17
  dc.b  15,"FLASHPARTY",15
  dc.b  40
  dc.b  "QUESTOWEWUNWBELWDILEMMA",17


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