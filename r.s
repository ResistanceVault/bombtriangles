  ; Place addr in d0 and the copperlist pointer addr in a1 before calling
POINTINCOPPERLIST MACRO
  move.w              d0,6(a1)
  swap                d0
  move.w              d0,2(a1)
  ENDM

  IFD                 P61
  include             "P6112-options.i"
  ENDC

  SECTION             CiriCop,CODE_C

  include             "AProcessing/libs/ammxmacros.i"

SKY_COLOR_SHADES    equ     128

Inizio:
  bsr.w               Save_all

  ; Build trigonometric table
  lea                 SIN_Q5_11(PC),a0
  lea                 ROT_X_MATRIX_Q5_11(PC),a1
  bsr.w               PRECALC_BY_SIN

  IFD                 PRT
SONG_FRAMES         equ       6240
  lea	player,a6
	lea	myPlayer,a0
	lea	mySong,a1
	lea	song0,a2
	add.l	0(a6),a6
	jsr	(a6)		; songInit returns in D0 needed chipmem size

	lea	player,a6
	lea	myPlayer,a0
	lea	chipmem,a1
	lea	mySong,a2
	add.l	4(a6),a6
	jsr	(a6)		; playerInit

	lea	player,a6
	lea	myPlayer,a0
	moveq	#64,d0			; volume (0-64)
	add.l	24(a6),a6
	jsr	(a6)		; setVolume
  ENDC

  ; draw sand
  ;lea                 SANDDOWN,a3
  ;moveq               #11,d4
  ;jsr                 BLITLINEOFTILES

  ;lea                 SANDTOP,a3
  ;moveq               #11,d4
  ;jsr                 BLITLINEOFTILES

  ; prepare table for first round of angles - start
  lea ROTATIONS_ANGLES_64,a0
	moveq #0,d0
	moveq #2-1,d6
.loop2rot
	moveq #64-1,d7
.looprot
	add.l 	#%101101000,d0
	move.l d0,d1
  ;add.l #%100000,d1
	lsr.w #6,d1
	move.w d1,(a0)+
	dbra d7,.looprot
	move.l #180*64,d0
	dbra d6,.loop2rot
  move.w #0,ROTATIONS_ANGLES_64_180-2
	; prepare table for first round of angles - end

  ; prepare sin table for twister - start
  lea SIN_TABLE,a0
  lea SIN_TWISTER_TABLE,a1
  lea SIN_TWISTER_TABLE_END,a2
	move.w #360-1,d7
.loop:
	move.w (a0)+,d0
	lsl.w #3,d0
	
	add.w #%0100000000000000,d0
	
	lsr.w #8,d0
	lsr.w #2,d0

  move.w d0,(a1)+
  move.w d0,(a2)+
	
	dbra d7,.loop
  ; prepare sin table for twister - end


  lea                  SANDTOP,a0
  moveq                #20-1,d4
  moveq                #0,d0
  moveq                #11,d1
  bsr.w                BLIT_TILES

  ; draw top of pyramids
  moveq               #0,d0
  moveq               #1,d1
  bsr.w               BLITTOPPYRAMID

  moveq               #12,d0
  moveq               #4,d1
  bsr.w               BLITTOPPYRAMID

  IFD STARS
  ; stars start
  moveq #80-1,d7
  lea SCREEN_2+40*1+20,a0
  move.l d7,d6
startstarfield:
  add.w d7,d6
  divs.w d7,d6
  swap d6
  ;andi.l #$7,d6
  bset d6,(a0)
  bset d6,40*224*1(a0)
  bset d6,40*224*2(a0)
  addq  #2,a0
  dbra d7,startstarfield
; endstartfield
  ENDC

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

  ; Start drawing full pyramid tiles
  lea                 TILEFULL,a0
  moveq               #6-1,d4
  moveq               #1,d0
  moveq               #5,d1
  bsr.w               BLIT_TILES

  moveq #4-1,d6
  moveq               #8-1,d4
  moveq               #0,d0
  moveq               #6,d1
tiles_vloop:

  bsr.w               BLIT_TILES
  addq    #1,d1
  addq #1,d4

  dbra d6,tiles_vloop

  ; Triangle crop pyramid
  IFD CROP
  lea VERTEX_LIST_2D_1,a4
  moveq #0,d1
  move.l         d1,(a4)+
  move.l         #$00300000,(a4)+
  move.l         #$00300030,(a4)+
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT

  lea            $dff040,a4
  move.w         #$09f0,(a4)+ ; bltcon0 D=A
  move.w         d1,(a4)+ ; bltcon1 set to zero

  lea            $dff064,a4
  move.w         d1,(a4)+ ; AMOD
  move.w         d1,(a4)+ ; DMOD

  move.l         SCREEN_PTR_0,$dff050 ; APTR
  move.l         #SCREEN_2+40*224*1,$dff054 ; DPTR
  ENDC



; left slope tile (trashing the full tile)
  moveq               #0,d0
  moveq               #5,d1
  lea                 TILELEFTSLOPE,a0
  bsr.w               BLIT_TILE

    ;IFD BLIT_PYR


  ; right slopes start
  moveq               #5-1,d6
  moveq               #7,d0
  moveq               #5,d1
  lea                 TILERIGHTSLOPE,a0
rightslopesstart:
  bsr.w               BLIT_TILE
  addq                #1,d0
  addq                #1,d1
  dbra                d6,rightslopesstart
      ;ENDC


  ; start blitting platform 1
  moveq               #14-1,d4
  moveq               #16,d6
tileplatform1:
  move.l              d6,d0
  move.w              #51*40,d1
  bsr.w               BLIT_PLATFORM
  subq                #1,d6
  dbra                d4,tileplatform1

; start blitting platform 2
  moveq               #8-1,d4
  moveq               #12,d6
tileplatform2:
  move.l              d6,d0
  move.w              #99*40,d1
  bsr.w               BLIT_PLATFORM
  subq                #1,d6
  dbra                d4,tileplatform2

; start blitting platform 3
  moveq               #2-1,d4
  moveq               #2,d6
tileplatform3:
  move.l              d6,d0
  move.w              #107*40,d1
  bsr.w               BLIT_PLATFORM
  subq                #1,d6
  dbra                d4,tileplatform3

; start blitting platform 4
  moveq               #2-1,d4
  moveq               #15,d6
tileplatform4:
  move.l              d6,d0
  move.w              #147*40,d1
  bsr.w               BLIT_PLATFORM
  subq                #1,d6
  dbra                d4,tileplatform4

; start blitting platform 5
  moveq               #3-1,d4
  moveq               #8,d6
tileplatform5:
  move.l              d6,d0
  move.w              #155*40,d1
  bsr.w               BLIT_PLATFORM
  subq                #1,d6
  dbra                d4,tileplatform5

  jsr               DRAWBIGSPACESHIP

  move.w #$0F00,d0
  move.w #$00F0,d1
  moveq  #64-1,d7
  lea BIGSPACESHIP_COLORSTABLE,a0
  jsr buildcolortable

  ; build sky shades
  jsr               buildskyshades

  IFD LOL
  move.w #%00001110,d0
  jsr DOUBLE_BYTE
  move.w d0,(a0)
  move.w #%00110000,d0
  jsr DOUBLE_BYTE
  move.w d0,2(a0)

  ;move.w #%0000001100000000,0*40(a0) ; row 1
  move.w #%0000111000110000,1*40(a0) ; row 2
  move.w #%0001110001110000,2*40(a0) ; row 3
  move.w #%0011101111101100,3*40(a0) ; row 4
  move.w #%0011000111000000,4*40(a0) ; row 5
  move.w #%0111111111111110,5*40(a0) ; row 6
  move.w #%1100011100000011,6*40(a0) ; row 7
  move.w #%1100011100000011,7*40(a0) ; row 8
  move.w #%0101101111011110,8*40(a0) ; row 9
  move.w #%0010000110001100,9*40(a0) ; row 10

  ;second bpl
  lea SCREEN_2+1*40*224,a0
  move.w #%0000000011000000,(a0)     ; row 1
  move.w #%0000000111110000,1*40(a0) ; row 2
  move.w #%0000001111110000,2*40(a0) ; row 3
  move.w #%0000010000100000,3*40(a0) ; row 4
  move.w #%0000111111000100,4*40(a0) ; row 5
  move.w #%0111111111111110,5*40(a0) ; row 6
  move.w #%0011111100011111,6*40(a0) ; row 7
  move.w #%0011111100011111,7*40(a0) ; row 8
  move.w #%0011100000000000,8*40(a0) ; row 9
  move.w #%0001000000000000,9*40(a0) ; row 10

  ;third bpl
  lea SCREEN_2+2*40*224,a0
  move.w #%0000000000000000,(a0)     ; row 1
  move.w #%0000000000000000,1*40(a0) ; row 2
  move.w #%0000000000001000,2*40(a0) ; row 3
  move.w #%0011001111011100,3*40(a0) ; row 4
  move.w #%0000000000111100,4*40(a0) ; row 5
  move.w #%0111111111111110,5*40(a0) ; row 6
  move.w #%0000000011111111,6*40(a0) ; row 7
  move.w #%0000000011111111,7*40(a0) ; row 8
  move.w #%0000001111011110,8*40(a0) ; row 9
  move.w #%0000000110001100,9*40(a0) ; row 10
  ENDC

;dc.w    $1a0,$bfc    ; color transparency
;dc.w    $1a2,$fff    ; color17
;dc.w    $1a4,$ddd    ; color18
;dc.w    $1a6,$bbb    ; color19
;dc.w    $1a8,$888    ; color20
;dc.w    $1aa,$f00    ; color21
;dc.w    $1ac,$555    ; color22
;dc.w    $1ae,$000    ; color23
;dc.w    $1b0,$f0f    ; color24
;dc.w    $1b2,$f0f    ; color25
;dc.w    $1b4,$f0f    ; color26
;dc.w    $1b6,$f0f    ; color27
;dc.w    $1b8,$f0f    ; color28
;dc.w    $1ba,$f0f    ; color29
;dc.w    $1bc,$f0f    ; color30
;dc.w    $1be,$f0f    ; color31
  ; draw big spaceship start

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
  MOVE.L              #SANDTWISTER_1,d0
  LEA                 SpritePointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 1 init
  MOVE.L              #SANDTWISTER_2,d0
  LEA                 SpritePointers+8,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

	; Sprite 0 init
  IFD LADDERS
  MOVE.L              #LADDER_1,d0
  LEA                 SpritePointers,a1                                              ; SpritePointers is in copperlist
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 1 init
  MOVE.L              #LADDER_2,d0
  addq.w              #8,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 2 init
  jsr                 drawtopstep
  ENDC

  ; Sprite 4 init - bomb first 2 bitplanes of attached sprite
  move.l              #BOMB1_BPL0,d0
  lea                 Sprite4pointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 5 init - bomb first 2 bitplanes of attached sprite
  move.l              #BOMB1_BPL1,d0
  lea                 Sprite5pointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 6 init - spaceship first 2 bitplanes of attached sprite
  move.l              #SPACESHIP1_BPL0,d0
  lea                 Sprite6pointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; Sprite 7 init - bomb first 2 bitplanes of attached sprite
  move.l              #SPACESHIP1_BPL1,d0
  lea                 Sprite7pointers,a1
  bsr.w               POINTINCOPPERLIST_FUNCT

  ; At the start of the demo the ray of the spaceship must be off
  move.l              #$00000000,SPACESHIP1_BPL1_RAY
  move.w              #SPACESHIP_SPRITE_HEIGHT_NO_RAY,SPACESHIP_SPRITE_HEIGHT

  lea                 $dff000,a6
  move                #$7ff,$96(a6)                                                  ;Disable DMAs
  move                #%1000011111100000,$96(a6)                                     ;Master,Copper,Blitter,Bitplanes
  move                #$7fff,$9a(a6)                                                 ;Disable IRQs
  move                #$e000,$9a(a6)                                                 ;Master and lev6
					;NO COPPER-IRQ!
  moveq               #0,d0
  move                d0,$106(a6)                                                    ;Disable AGA/ECS-stuff
  move                d0,$1fc(a6)

  move.l              #COPPERLIST,$80(a6)                                            ; Copperlist point
  move.w              d0,$88(a6)                                                     ; Copperlist start

  move.w              d0,$1fc(a6)                                                    ; FMODE - NO AGA
  move.w              #$c00,$106(a6)                                                 ; BPLCON3 - NO AGA

  IFD                 P61
  lea                 Module1,a0
  sub.l               a1,a1
  sub.l               a2,a2
  moveq               #0,d0

  jsr                 P61_Init
  ENDC

  jsr                 _ammxmainloop3_init

; START OF MAIN LOOP
mouse:
  cmpi.b              #$ff,$dff006                                                   ; Siamo alla linea 255?
  bne.s               mouse                                                          ; Se non ancora, non andare avanti
;.loop; Wait for vblank
;	move.l $dff004,d0
;	and.l #$1ff00,d0
;	cmp.l #303<<8,d0
;	bne.b .loop

  IFD                 P61
  jsr                 P61_Music                                                      ;and call the playroutine manually.
  ENDC

  IFD                 DEBUGCOLORS
  move.w              #$0FF0,$dff180
  ENDC

  jsr                 ammxmainloop3

  IFD                 DEBUGCOLORS
  move                #$003,$dff180
  ENDC

  ; Play music tick with pretracker
  subi.w              #1,FRAMECOUNTER
  IFD                 PRT
  ; start over the song after FRAMECOUNTER reaches zero
  bne.s               framecounterdonotreset
  lea	                player,a6
  lea	                myPlayer,a0
  add.l	              20(a6),a6
  jsr	                (a6)		        ; stop
  lea	                player,a6
  lea	                myPlayer,a0
  moveq	              #0,d0
  add.l	              12(a6),a6
  jsr	(a6)		                        ; start song
  move.w              #SONG_FRAMES,FRAMECOUNTER
framecounterdonotreset:
  lea	player,a6
  lea	myPlayer,a0
  add.l	8(a6),a6
  jsr	(a6)		; playerTick
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
  bne.w               mouse                                                          ; se no, torna a mouse:
exit_demo:
  WAITBLITTER
  IFD                 P61
  bsr.w               P61_End
  ENDC
  bsr.w               Restore_all
  clr.l               d0
  rts                                                                                ; USCITA DAL PROGRAMMA

FRAMECOUNTER:
  IFD                PRT
  dc.w               SONG_FRAMES
  ELSE
  dc.w               1
  ENDC

POINTINCOPPERLIST_FUNCT:
  POINTINCOPPERLIST
  rts

; blit a platform into background - origin is at top left
; d0 : x position (trashed)
; d1 : y position (trashed)
BLIT_PLATFORM:
  lea              PLATFORM,a0
  lea              SCREEN_2,a1
; add vertical position
  adda.l           d1,a1
  lsl.w            #1,d0
  adda.l           d0,a1
  moveq            #3-1,d7
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
  lea              SCREEN_2,a1
  mulu.w           #40*16,d1
  adda.l           d1,a1
  adda.l           #40*10,a1
  lsl.w            #1,d0
  adda.l           d0,a1
  lea              PYRAMIDTOP,a0
  moveq            #3-1,d7
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

; blit tiles
; blit a series of tiles using blit tile
; a0 - address of the tile
; d4 - number of tiles to blit minus 1 (trashed)
; d0 - x position
; d1 - y position
BLIT_TILES:
  movem.l          d0-d1/d4,-(sp)
tilefullstart:
  bsr.s            BLIT_TILE
  addq             #1,d0
  dbra             d4,tilefullstart
  movem.l          (sp)+,d0-d1/d4
  rts

; blit a tile into background - origin is at top left
; a0 : pointer to tile
; d0 : x position
; d1 : y position
; trashes:
;  - a1
;  - d7
BLIT_TILE:
  movem.l           d0/d1/a0,-(sp)
  lea               SCREEN_2,a1
  ; add vertical position
  mulu.w            #40*16,d1
  adda.l            d1,a1
  lsl.w             #1,d0
  adda.l            d0,a1
  moveq             #3-1,d7
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
  movem.l          (sp)+,d0/d1/a0
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

  move.l	4.w,a6		; ExecBase in A6
	JSR	-$84(a6)	; FORBID - Disabilita il Multitasking
	JSR	-$78(A6)	; DISABLE - Disabilita anche gli interrupt
				;	    del sistema operativo
  ; set new intena
  MOVE.L	#$7FFF7FFF,$dff09A	; DISABILITA GLI INTERRUPTS & INTREQS

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

  IFD                 P61
Playrtn:
  include             "P6112-Play.i"
  ENDC

  IFD                 EFFECTS

muovicopper:
  LEA                 BARRA,a0
  TST.B               SuGiu                                                          ; Dobbiamo salire o scendere?
  beq.w               VAIGIU
  cmpi.b              #$0a,(a0)                                                      ; siamo arrivati alla linea $0a+$ff? (265)
  beq.s               MettiGiu                                                       ; se si, siamo in cima e dobbiamo scendere
  moveq               #10-1,d7
movecopper_startloop:
  subq.b              #1,(a0)
  addq                #8,a0
  dbra                d7,movecopper_startloop
  rts

MettiGiu:
  clr.b               SuGiu                                                          ; Azzerando SuGiu, al TST.B SuGiu il BEQ
  rts                                                                                ; fara' saltare alla routine VAIGIU, e

VAIGIU:
  cmpi.b              #$2c,8*9(a0)                                                   ; check if we are at line$2c?
  beq.s               MettiSu                                                        ; if yes we are at the bottom and must go up
  moveq #10-1,d7
godown_loop:
  addq.b              #1,(a0)
  addq                #8,a0
  dbra                d7,godown_loop
  rts

MettiSu:
  move.b              #$ff,SuGiu                                                     ; Quando la label SuGiu non e' a zero,
  rts                                                                                ; significa che dobbiamo risalire.

SuGiu:
  dc.b                0,0

; ************************
; *		Color cycling		   *
; ************************
  IFND        NOGREENGLOW
scrollcolors:
  moveq               #13-1,d7
  lea                 col1,a4
scrollcolors_startcycle
  move.w              8(a4),(a4)
  addq.l              #8,a4
  dbra                d7,scrollcolors_startcycle
  move.w              col1,col14
  rts
  ENDC
  ENDC

  include             "AProcessing/libs/rasterizers/globaloptions.s"
  include             "AProcessing/libs/matrix/matrixcommon.s"
  include             "AProcessing/libs/matrix/matrixreg.s"
  include             "AProcessing/libs/matrix/rotatereg.s"
  ;include             "AProcessing/libs/matrix/scale.s"
  include             "AProcessing/libs/matrix/scalereg.s"
  ;include             "AProcessing/libs/matrix/shear.s"
  include             "AProcessing/libs/matrix/shearreg.s"
  ;include             "AProcessing/libs/trigtables.i"
  include             "AProcessing/libs/precalc/precalc_by_sin.s"
  include             "AProcessing/libs/precalc/precalc_col_table.s"
  include             "AProcessing/libs/precalc/double_byte.s"
  include             "AProcessing/libs/trigtables_sin.i"
ROT_Z_MATRIX_Q5_11: ; cos -sin sin cos
ROT_X_MATRIX_Q5_11: ; cos -sin sin cos
  dcb.b 361*8,$00
  include             "AProcessing/libs/matrix/pointreg.s"
  include             "AProcessing/libs/rasterizers/processing_bitplanes_fast.s"
  include             "AProcessing/libs/blitter/lines.s"
  include             "AProcessing/libs/blitter/triangle.s"

  include             "initnoprecalc.s"
  include             "ammxmainloopnoprecalc.s"
  include             "sky/skyshades.s"

  include             "copperlists.s"

SCREEN_2:
  IFD DEBUGCOLORS
  dcb.b 40*224*1,$0
  ELSE
  dcb.b 40*224*1,$FF
  ENDC
  dcb.b 40*224*2,$00

SKY_COLORSTABLE_INCREMENT:
  dc.w 2
SKY_COLORSTABLE_COUNTER:
  dc.w 0

SKY_COLORSTABLE_0:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_1:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_2:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_3:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_4:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_5:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_6:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_7:
  dcb.w SKY_COLOR_SHADES,$00
SKY_COLORSTABLE_8:
  dcb.w SKY_COLOR_SHADES,$00

  IFD LADDERS
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
  ENDC

; start of bomb sprites
  include             "bombs/0.s"
  include             "bombs/1.s"
  include             "bombs/2.s"
  ;include             "bombs/3.s"
  include             "bombs/4.s"
  include             "bombs/7.s"
  include             "bombs/8.s"
  include             "bombs/9.s"
  include             "bombs/10.s"

; start of spaceship sprites
  include             "spaceship/spaceship_spr1_ray.s"
  include             "spaceship/spaceship_spr_diffs.s"
  include             "spaceship/bigspaceship.s"

; background tiles
;SANDDOWN:             incbin "assets/tiles/sanddown.raw"
SANDTOP:              incbin "assets/tiles/sandtop.raw"
TILEFULL:             ;incbin "assets/tiles/full.raw"
                      incbin "assets/tiles/ciao.raw" ; col1 and 6 swapped

TILELEFTSLOPE:        ;incbin "assets/tiles/leftslope.raw"
                       incbin "assets/tiles/ciao3.raw"

TILERIGHTSLOPE:       ;incbin "assets/tiles/rightslope.raw"
                      incbin "assets/tiles/ciao4.raw"

PYRAMIDTOP:           ;incbin "assets/brush/pyramidtop112x54.raw"
                      incbin "assets/tiles/ciao2.raw" ; col1 and 6 swapped
  IFD COPPLATFORM
PLATFORM:             dcb.b 2*16*3,$FF
  ELSE
PLATFORM:             incbin "assets/brush/platform16x5.raw"
  ENDC

  IFD                 P61
Module1:
  incbin              "P61.chippy_nr.399"                                            ; usecode $945A
  even
  ENDC

  IFD                 PRT
player:	incbin	"pretracker/player.bin"
song0:  incbin 	"pretracker/mA2E_-_Kittys_Market_Stroll.prt"
  ENDC

  IFD                 PRT
  section bss,bss
mySong:	ds.w	2048/2
myPlayer:	ds.l	8*1024/4

	section	chip,bss_c
chipmem   dcb.b $7892,$00
  ENDC
  end

