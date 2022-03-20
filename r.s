  ; Place addr in d0 and the copperlist pointer addr in a1 before calling
POINTINCOPPERLIST MACRO
  move.w              d0,6(a1)
  swap                d0
  move.w              d0,2(a1)
  ENDM

  include             "P6112-options.i"

  SECTION             CiriCop,CODE_C

  include             "AProcessing/libs/ammxmacros.i"

Inizio:

  bsr.w               Save_all

  ; draw sand
  ;lea                 SANDDOWN,a3
  ;moveq               #11,d4
  ;jsr                 BLITLINEOFTILES

  lea                 SANDTOP,a3
  moveq               #11,d4
  jsr                 BLITLINEOFTILES

  ; draw top of pyramids
  moveq #0,d0
  moveq #1,d1
  jsr                 BLITTOPPYRAMID

  moveq #12,d0
  moveq #4,d1
  jsr                 BLITTOPPYRAMID

  ; stars start
  moveq #10-1,d7
  lea SCREEN_2+40*1+20,a0
startstarfield:
  move.w d7,d6
  neg.w d6
  lsr.w #2,d6
  add.l #19,a0
  bset d6,(a0)
  bset d6,40*224*1(a0)
  bset d6,40*224*2(a0)
  dbra d7,startstarfield
; endstartfield

;*****************************************************************************
;	Init bitplane pointers in copperlist
;*****************************************************************************
  move.l              #SCREEN_2,d0
  lea                 BPLPTR1,A1
  bsr.w               POINTINCOPPERLIST_FUNCT

  move.l              #SCREEN_2+40*224*1,d0
  lea                 BPLPTR3,A1
  bsr.w               POINTINCOPPERLIST_FUNCT

  move.l              #SCREEN_2+40*224*2,d0
  lea                 BPLPTR5,A1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; full tiles
  moveq #6-1,d4
  moveq #1,d6
tilefullstart:
  move.l d6,d0
  moveq #5,d1
  lea TILEFULL,a0
  jsr BLIT_TILE
  addq #1,d6
  dbra d4,tilefullstart

  moveq #8-1,d4
  moveq #0,d6
tilefullstart2:
  move.l d6,d0
  moveq #6,d1
  lea TILEFULL,a0
  jsr BLIT_TILE
  addq #1,d6
  dbra d4,tilefullstart2

  moveq #9-1,d4
  moveq #0,d6
tilefullstart3:
  move.l d6,d0
  moveq #7,d1
  lea TILEFULL,a0
  jsr BLIT_TILE
  addq #1,d6
  dbra d4,tilefullstart3

  moveq #10-1,d4
  moveq #0,d6
tilefullstart4:
  move.l d6,d0
  moveq #8,d1
  lea TILEFULL,a0
  jsr BLIT_TILE
  addq #1,d6
  dbra d4,tilefullstart4

  moveq #11-1,d4
  moveq #0,d6
tilefullstart5:
  move.l d6,d0
  moveq #9,d1
  lea TILEFULL,a0
  jsr BLIT_TILE
  addq #1,d6
  dbra d4,tilefullstart5


  ; slopes start
  moveq #7,d0
  moveq #5,d1
  lea TILERIGHTSLOPE,a0
  jsr BLIT_TILE

  moveq #8,d0
  moveq #6,d1
  lea TILERIGHTSLOPE,a0
  jsr BLIT_TILE

  moveq #9,d0
  moveq #7,d1
  lea TILERIGHTSLOPE,a0
  jsr BLIT_TILE

  moveq #10,d0
  moveq #8,d1
  lea TILERIGHTSLOPE,a0
  jsr BLIT_TILE

  moveq #11,d0
  moveq #9,d1
  lea TILERIGHTSLOPE,a0
  jsr BLIT_TILE

  ; start blitting platform 1
  moveq #13-1,d4
  moveq #15,d6
tileplatform1:
  move.l d6,d0
  move.w #51*40,d1
  jsr BLIT_PLATFORM
  subq #1,d6
  dbra d4,tileplatform1

; start blitting platform 2
  moveq #8-1,d4
  moveq #12,d6
tileplatform2:
  move.l d6,d0
  move.w #99*40,d1
  jsr BLIT_PLATFORM
  subq #1,d6
  dbra d4,tileplatform2

  ; Init active playfield with same data, we will change this later in gameloop
  IFD LOL
  move.l              #SCREEN_3,d0
  lea                 BPLPTR2,A1
  bsr.w               POINTINCOPPERLIST_FUNCT

  move.l              #SCREEN_4,d0
  lea                 BPLPTR2,A1
  bsr.w               POINTINCOPPERLIST_FUNCT
  ENDC

  ; Init tiles bitplanes
  move.l              #SCREEN_0+40*(255-9*5),d0
  lea                 BPLPTR1_TILE,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  move.l              #SCREEN_1+40*(255-9*5),d0
  lea                 BPLPTR2_TILE,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

	; Sprite 0 init
  MOVE.L              #LADDER_1,d0
  LEA                 SpritePointers,a1                                              ; SpritePointers is in copperlist
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 1 init
  MOVE.L              #LADDER_2,d0
  addq.w              #8,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 2 init
  jsr                 drawtopstep

  ; Sprite 4 init - bomb first 2 bitplanes of attached sprite
  move.l              #BOMB1_BPL0,d0
  lea                 Sprite4pointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 5 init - bomb first 2 bitplanes of attached sprite
  move.l              #BOMB1_BPL1,d0
  lea                 Sprite5pointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT                                                ; ladder color 3

  lea                 $dff000,a6
  move                #$7ff,$96(a6)                                                  ;Disable DMAs
  move                #%1000011111100000,$96(a6)                                     ;Master,Copper,Blitter,Bitplanes
  move                #$7fff,$9a(a6)                                                 ;Disable IRQs
  move                #$e000,$9a(a6)                                                 ;Master and lev6
					;NO COPPER-IRQ!
  moveq               #0,d0
  move                d0,$106(a6)                                                    ;Disable AGA/ECS-stuff
  move                d0,$1fc(a6)

  move.l              #COPPERLIST,$dff080                                            ; Puntiamo la nostra COP
  move.w              d0,$dff088                                                     ; Facciamo partire la COP

  move.w              #0,$dff1fc                                                     ; FMODE - Disattiva l'AGA
  move.w              #$c00,$dff106                                                  ; BPLCON3 - Disattiva l'AGA

  lea                 Module1,a0
  sub.l               a1,a1
  sub.l               a2,a2
  moveq               #0,d0

  jsr                 P61_Init

  jsr                 _ammxmainloop3_init

mouse:
  cmpi.b              #$ff,$dff006                                                   ; Siamo alla linea 255?
  bne.s               mouse                                                          ; Se non ancora, non andare avanti

  jsr                 P61_Music                                                      ;and call the playroutine manually.

  IFD                 DEBUGCOLORS
  move.w              #$0F00,$dff180
  ENDC

  jsr                 ammxmainloop3

  IFD                 DEBUGCOLORS
  move                #$003,$180(a6)
  ENDC

  IFD                 EFFECTS
  jsr                 muovicopper                                                    ; barra rossa sotto linea $ff
  jsr                 scrollcolors                                                   ; scorrimento ciclico dei colori
  ENDC
Aspetta:
  cmpi.b              #$ff,$dff006                                                   ; Siamo alla linea 255?
  beq.s               Aspetta                                                        ; Se si, non andare avanti, aspetta la linea

  lea                 BPLPTR2,a1
  move.l              SCREEN_PTR_0,d0
  POINTINCOPPERLIST

  lea                 BPLPTR4,a1
  move.l              SCREEN_PTR_1,d0
  POINTINCOPPERLIST

  btst                #6,$bfe001                                                     ; tasto sinistro del mouse premuto?
  bne.s               mouse                                                          ; se no, torna a mouse:
exit_demo:
  WAITBLITTER
  bsr.w               P61_End
  bsr.w               Restore_all
  clr.l               d0
  rts                                                                                ; USCITA DAL PROGRAMMA

POINTINCOPPERLIST_FUNCT:
  POINTINCOPPERLIST
  rts

; blit a platform into background - origin is at top left
; d0 : x position (trashed)
; d1 : y position (trashed)
BLIT_PLATFORM:
  lea PLATFORM,a0
  lea SCREEN_2,a1
  ; add vertical position
  adda.l d1,a1
  lsl.w #1,d0
  adda.l d0,a1
  moveq #3-1,d7
blitplatform_startloop:
  WAITBLITTER
  move.w           #$09F0,$dff040
  move.w           #$0000,$dff042
  move.l           a0,$dff050            ; copy from a channel
  move.l           a1,$dff054            ; copy to d channel
  move.w           #$0000,$dff064               ; A mod
  move.w           #38,$dff066                  ; D mod
  move.l           #$FFFFFFFF,$DFF044 ; mask
  move.w           #$0201,$dff058
  adda.l           #10,a0
  adda.l           #224*40,a1
  dbra             d7,blitplatform_startloop
  rts

BLITTOPPYRAMID:
  lea SCREEN_2,a1
  mulu.w #40*16,d1
  adda.l d1,a1
  adda.l #40*10,a1
  lsl.w #1,d0
  adda.l d0,a1
  lea PYRAMIDTOP,a0
  moveq #3-1,d7
blittoputamid_startloop:
  WAITBLITTER
  move.w           #$09F0,$dff040
  move.w           #$0000,$dff042
  move.l           a0,$dff050          ; copy from a channel
  move.l           a1,$dff054            ; copy to d channel
  move.w           #$0000,$dff064               ; A mod
  move.w           #40-14,$dff066               ; D mod
  move.l           #$FFFFFFFF,$DFF044           ; mask
  move.w           #$0D87,$dff058
  adda.l           #756,a0
  adda.l           #224*40,a1
  dbra             d7,blittoputamid_startloop
  rts

; blit a tile into background - origin is at top left
; a0 : pointer to tile (trashed)
; d0 : x position (trashed)
; d1 : y position (trashed)
BLIT_TILE:
  lea SCREEN_2,a1
  ; add vertical position
  mulu.w #40*16,d1
  adda.l d1,a1
  lsl.w #1,d0
  adda.l d0,a1
  moveq #3-1,d7
blittile_startloop:
  WAITBLITTER
  move.w           #$09F0,$dff040
  move.w           #$0000,$dff042
  move.l           a0,$dff050            ; copy from a channel
  move.l           a1,$dff054            ; copy to d channel
  move.w           #$0000,$dff064               ; A mod
  move.w           #38,$dff066                  ; D mod
  move.l           #$FFFFFFFF,$DFF044 ; mask
  move.w           #$0401,$dff058
  adda.l           #32,a0
  adda.l           #224*40,a1
  dbra             d7,blittile_startloop
  rts

; print a line of tiles horizontally
; a3 : pointer to the tile
; d4.w : tile row number
BLITLINEOFTILES:
  moveq               #16-1,d6
  moveq               #0,d3
blitlineoftiles_start:
  move.l              d3,d0
  move.w              d4,d1
  move.l              a3,a0
  jsr                 BLIT_TILE
  addq                #1,d3
  dbra                d6,blitlineoftiles_start
  rts

;---------------------------------------------------------------
Save_all:
  move.b              #$87,$bfd100                                                   ; stop drive
  move.l              $00000004,a6
  jsr                 -132(a6)
  move.l              $6c,SaveIRQ
  move.w              $dff01c,Saveint
  or.w                #$c000,Saveint
  move.w              $dff002,SaveDMA
  or.w                #$8100,SaveDMA
  rts
Restore_all:
  move.l              SaveIRQ,$6c
  move.w              #$7fff,$dff09a	
  move.w              Saveint,$dff09a
  move.w              #$7fff,$dff096
  move.w              SaveDMA,$dff096
  move.l              $00000004,a6
  lea                 Name,a1
  moveq               #0,d0
  jsr                 -552(a6)
  move.l              d0,a0
  move.l              38(a0),$dff080
  clr.w               $dff088
  move.l              d0,a1
  jsr                 -414(a6)
  jsr                 -138(a6)
  rts
;---------------------------------------------------------------
Saveint:              dc.w 0
SaveDMA:              dc.w 0
SaveIRQ:              dc.l 0
Name:                 dc.b "graphics.library",0
  even
;----------------------------------------------------------------  

Playrtn:
  include             "P6112-Play.i"

  IFD                 EFFECTS

muovicopper:
  LEA                 BARRA,a0
  TST.B               SuGiu                                                          ; Dobbiamo salire o scendere?
  beq.w               VAIGIU
  cmpi.b              #$0a,(a0)                                                      ; siamo arrivati alla linea $0a+$ff? (265)
  beq.s               MettiGiu                                                       ; se si, siamo in cima e dobbiamo scendere
  subq.b              #1,(a0)
  subq.b              #1,8(a0)                                                       ; ora cambiamo gli altri wait: la distanza
  subq.b              #1,8*2(a0)                                                     ; tra un wait e l'altro e' di 8 bytes
  subq.b              #1,8*3(a0)
  subq.b              #1,8*4(a0)
  subq.b              #1,8*5(a0)
  subq.b              #1,8*6(a0)
  subq.b              #1,8*7(a0)                                                     ; qua dobbiamo modificare tutti i 9 wait della
  subq.b              #1,8*8(a0)                                                     ; barra rossa ogni volta per farla salire!
  subq.b              #1,8*9(a0)
  rts

MettiGiu:
  clr.b               SuGiu                                                          ; Azzerando SuGiu, al TST.B SuGiu il BEQ
  rts                                                                                ; fara' saltare alla routine VAIGIU, e

VAIGIU:
  cmpi.b              #$2c,8*9(a0)                                                   ; siamo arrivati alla linea $2c?
  beq.s               MettiSu                                                        ; se si, siamo in fondo e dobbiamo risalire
  addq.b              #1,(a0)
  addq.b              #1,8(a0)                                                       ; ora cambiamo gli altri wait: la distanza
  addq.b              #1,8*2(a0)                                                     ; tra un wait e l'altro e' di 8 bytes
  addq.b              #1,8*3(a0)
  addq.b              #1,8*4(a0)
  addq.b              #1,8*5(a0)
  addq.b              #1,8*6(a0)
  addq.b              #1,8*7(a0)                                                     ; qua dobbiamo modificare tutti i 9 wait della
  addq.b              #1,8*8(a0)                                                     ; barra rossa ogni volta per farla scendere!
  addq.b              #1,8*9(a0)
  rts

MettiSu:
  move.b              #$ff,SuGiu                                                     ; Quando la label SuGiu non e' a zero,
  rts                                                                                ; significa che dobbiamo risalire.

SuGiu:
  dc.b                0,0

; **************************************************************************
; *		SCORRIMENTO CICLICO DEI COLORI (Lezione3E.s)		   *
; **************************************************************************
scrollcolors:
  move.w              col2,col1                                                      ; col2 copiato in col1
  move.w              col3,col2                                                      ; col3 copiato in col2
  move.w              col4,col3                                                      ; col4 copiato in col3
  move.w              col5,col4                                                      ; col5 copiato in col4
  move.w              col6,col5                                                      ; col6 copiato in col5
  move.w              col7,col6                                                      ; col7 copiato in col6
  move.w              col8,col7                                                      ; col8 copiato in col7
  move.w              col9,col8                                                      ; col9 copiato in col8
  move.w              col10,col9                                                     ; col10 copiato in col9
  move.w              col11,col10                                                    ; col11 copiato in col10
  move.w              col12,col11                                                    ; col12 copiato in col11
  move.w              col13,col12                                                    ; col13 copiato in col12
  move.w              col14,col13                                                    ; col14 copiato in col13
  move.w              col1,col14                                                     ; col1 copiato in col14
  rts
  ENDC

  include             "AProcessing/libs/rasterizers/globaloptions.s"
  include             "AProcessing/libs/matrix/matrix.s"
  include             "AProcessing/libs/matrix/scale.s"
  include             "AProcessing/libs/trigtables.i"
  include             "AProcessing/libs/matrix/point.s"
  include             "AProcessing/libs/rasterizers/processing_bitplanes_fast.s"
  include             "AProcessing/libs/blitter/lines.s"
  include             "AProcessing/libs/blitter/triangle.s"

  include             "initnoprecalc.s"
  include             "ammxmainloopnoprecalc.s"

  include             "copperlists.s"

PRINT_CELING_ROW MACRO
  dcb.b               7*1,$00
  dcb.b               25*1,$FF
  dcb.b               8*1,$00
  ENDM

PRINT_LINE MACRO
  dcb.b               40*\1,\2     ; 1
  ENDM

PRINT_LEFT_LINE MACRO
  dc.w 0
  dc.l $FFFFFFFF
  dcb.b 34,$00
  ENDM

PRINT_RIGHT_LINE MACRO
  dc.l 0
  dc.l 0
  dcb.b 19,$FF
  dc.b 0
  dc.l 0
  dc.l 0
  dc.l 0
  ENDM

PRINT_RIGHT_LINE_1ST_FLOOR MACRO
  dc.l 0
  dc.l 0
  dc.l 0
  dc.l 0
  dcb.b 14,$00
  dc.w $FF00
  dc.l 0
  dc.l 0
  ENDM

PRINT_RIGHT_LINE_1ST_FLOOR_2 MACRO
  dc.l 0
  dc.l 0
  dc.l 0
  dc.l $FFFF
  dcb.b 14,$00
  dc.w $0000
  dc.l 0
  dc.l 0
  ENDM

  IFD LOL

SCREEN_2
  PRINT_LINE 1,$00     ; 1
  PRINT_LINE 50,$00    ; 51

  ;ceiling start
  PRINT_CELING_ROW ; 52
  PRINT_CELING_ROW ; 53
  PRINT_CELING_ROW ; 54
  ;ceiling end
  PRINT_LINE 45,$00   ; 99
  PRINT_RIGHT_LINE    ; 106
  PRINT_RIGHT_LINE ; 107
  PRINT_RIGHT_LINE ; 108
  PRINT_LINE 3,$00    ; 105
  PRINT_LEFT_LINE     ; 102
  PRINT_LEFT_LINE
  PRINT_LEFT_LINE

  PRINT_LINE 38,$00
  PRINT_RIGHT_LINE_1ST_FLOOR
  PRINT_RIGHT_LINE_1ST_FLOOR
  PRINT_RIGHT_LINE_1ST_FLOOR

  PRINT_LINE 3,$00     ; 1
  PRINT_RIGHT_LINE_1ST_FLOOR_2

  PRINT_LINE 50,$00    ; 163
  PRINT_LINE 62,$00    ; 163

SCREEN_3:
  dcb.b                  40*256,$00

SCREEN_4:
  dcb.b                  40*256,$00
  ENDC

SCREEN_2: ;incbin "assets/bombjack_result.raw"
  dcb.b 40*224*3,$00

LADDER_1:
LADDER_1_VSTART0;
  dc.b                LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*2
LADDER_1_HSTART0:
  dc.b                LADDERHORIZONTALPOSITION
LADDER_1_VSTOP0:
  dc.b                LADDERVERTICALPOSITION-LADDERSPACING*2,$00
  dc.w                $FFFF,$FFFF                                                    ; line 1
  dc.w                $FFFF,$FFFF                                                    ; line 2
  dc.w                $FFFF,$FFFF                                                    ; line 3

LADDER_1_VSTART1:
  dc.b                LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*1
LADDER_1_HSTART1:
  dc.b                LADDERHORIZONTALPOSITION
LADDER_1_VSTOP1:
  dc.b                LADDERVERTICALPOSITION-LADDERSPACING*1,$00
  dc.w                $FFFF,$FFFF                                                    ; line 1
  dc.w                $FFFF,$FFFF                                                    ; line 2
  dc.w                $FFFF,$FFFF                                                    ; line 3

LADDER_1_VSTART2:
  dc.b                LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*0
LADDER_1_HSTART2:
  dc.b                LADDERHORIZONTALPOSITION
LADDER_1_VSTOP2:
  dc.b                LADDERVERTICALPOSITION-LADDERSPACING*0,$00
  dc.w                $FFFF,$FFFF                                                    ; line 1
  dc.w                $FFFF,$FFFF                                                    ; line 2
  dc.w                $FFFF,$FFFF                                                    ; line 3

; END OF SPRITE
  dc.w                0,0

LADDER_2:
LADDER_2_VSTART0:
  dc.b                LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*3
LADDER_2_HSTART:
  dc.b                LADDERHORIZONTALPOSITION+LADDERHORIZONTALSPACING
LADDER_2_VSTOP0:
  dc.b                LADDERVERTICALPOSITION-LADDERSPACING*3,$01
  dc.w                $FFFF,$FFFF                                                    ; line 1
  dc.w                $FFFF,$FFFF                                                    ; line 2
  dc.w                $FFFF,$FFFF                                                    ; line 3

LADDER_2_VSTART1:
  dc.b                LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*2
LADDER_2_HSTART1:
  dc.b                LADDERHORIZONTALPOSITION+LADDERHORIZONTALSPACING
LADDER_2_VSTOP1:
  dc.b                LADDERVERTICALPOSITION-LADDERSPACING*2,$01
  dc.w                $FFFF,$FFFF                                                    ; line 1
  dc.w                $FFFF,$FFFF                                                    ; line 2
  dc.w                $FFFF,$FFFF                                                    ; line 3

LADDER_2_VSTART2:
  dc.b                LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*1
LADDER_2_HSTART2:
  dc.b                LADDERHORIZONTALPOSITION+LADDERHORIZONTALSPACING
LADDER_2_VSTOP2:
  dc.b                LADDERVERTICALPOSITION-LADDERSPACING*1,$01
  dc.w                $FFFF,$FFFF                                                    ; line 1
  dc.w                $FFFF,$FFFF                                                    ; line 2
  dc.w                $FFFF,$FFFF                                                    ; line 3

  ; END OF SPRITE
  dc.w                0,0

; start of bomb sprites
  include             "bombs/1.s"
  include             "bombs/2.s"
  include             "bombs/3.s"
  include             "bombs/4.s"
  include             "bombs/7.s"
  include             "bombs/8.s"
  include             "bombs/9.s"
  include             "bombs/10.s"

; background tiles
SANDDOWN:             incbin "assets/tiles/sanddown.raw"
SANDTOP:              incbin "assets/tiles/sandtop.raw"
TILEFULL:             incbin "assets/tiles/full.raw"
TILERIGHTSLOPE:       incbin "assets/tiles/rightslope.raw"
PYRAMIDTOP:           incbin "assets/brush/pyramidtop112x54.raw"
  IFD COPPLATFORM
PLATFORM: dcb.b 2*16*3,$FF
  ELSE
PLATFORM:             incbin "assets/brush/platform16x5.raw"
  ENDC
Module1:
  incbin              "P61.chippy_nr.399"                                            ; usecode $945A
  even
  end

