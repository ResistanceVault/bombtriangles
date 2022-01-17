  include             "P6112-options.i"

  SECTION             CiriCop,CODE_C

  include             "AProcessing2/libs/ammxmacros.i"
DEBUG MACRO
  clr.w                  $100
  move.w                 #$\1,d3
  ENDM

DEBUG2 MACRO
  clr.w                  $101
  move.w                 #$\1,d3
  ENDM


Inizio:

  bsr.w                 Save_all

;*****************************************************************************
;	FACCIAMO PUNTARE I BPLPOINTERS NELLA COPPELIST AI NOSTRI BITPLANES
;*****************************************************************************
  MOVE.L              #SCREEN_2,d0
  LEA                 BPLPOINTERS2,A1
  move.w              d0,6(a1)
  swap                d0
  move.w              d0,2(a1)

	; sprite 0 init
  MOVE.L              #LADDER_1,d0		
  LEA                 SpritePointers,a1                                              ; SpritePointers is in copperlist
  move.w              d0,6(a1)
  swap                d0
  move.w              d0,2(a1)
  ; Sprite 1 init
  MOVE.L              #LADDER_2,d0		
  addq.w              #8,a1
  move.w              d0,6(a1)
  swap                d0
  move.w              d0,2(a1)

   ; Sprite 2 init
  jsr                 drawtopstep

  move.w              #$0888,$dff1a2                                                 ; ladder color 1
  move.w              #$0AAA,$dff1a4                                                 ; ladder color 2
  move.w              #$0BCD,$dff1a6                                                 ; ladder color 3

  move.w              #$0888,$dff1a8                                                 ; ladder color 1
  move.w              #$0AAA,$dff1aa                                                 ; ladder color 2
  move.w              #$0BCD,$dff1ac                                                 ; ladder color 3

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
  ;move                #%1000011111100000,$96(a6)                                     ;Master,Copper,Blitter,Bitplanes


mouse:
  cmpi.b              #$ff,$dff006                                                   ; Siamo alla linea 255?
  bne.s               mouse                                                          ; Se non ancora, non andare avanti

    ;move	#$00F0,$180(a6)
  jsr                 P61_Music                                                      ;and call the playroutine manually.
	;move	#$003,$180(a6)

  IFD                 DEBUGCOLORS
  move.w              #$0F00,$dff180
  ENDC

  jsr                 ammxmainloop3
	
  lea                 BPLPOINTERS,a0
  move.w              d0,6(a0)
  swap                d0
  move.w              d0,2(a0)
  swap                d0

  lea                 BPLPOINTERS1,a0
  add.l               #256*40,d0
  move.w              d0,6(a0)
  swap                d0
  move.w              d0,2(a0)

  IFD                 DEBUGCOLORS
  move                #$003,$180(a6)
  ENDC

  IFD                 EFFECTS
  jsr                 muovicopper                                                    ; barra rossa sotto linea $ff
	;jsr	CopperDestSin	; Routine di scorrimento destra/sinistra
  jsr                 scrollcolors                                                   ; scorrimento ciclico dei colori
  ENDC
Aspetta:
  cmpi.b              #$ff,$dff006                                                   ; Siamo alla linea 255?
  beq.s               Aspetta                                                        ; Se si, non andare avanti, aspetta la linea

  btst                #6,$bfe001                                                     ; tasto sinistro del mouse premuto?
  bne.s               mouse                                                          ; se no, torna a mouse:
exit_demo:
  WAITBLITTER
  bsr                 P61_End
  bsr                 Restore_all
  clr.l               d0
  rts                                                                                ; USCITA DAL PROGRAMMA

;---------------------------------------------------------------
Save_all
  Move.b              #$87,$bfd100                                                   ; stop drive
  Move.l              $00000004,a6
  Jsr                 -132(a6)
  Move.l              $6c,SaveIRQ
  Move.w              $dff01c,Saveint
  Or.w                #$c000,Saveint
  Move.w              $dff002,SaveDMA
  Or.w                #$8100,SaveDMA
  Rts
Restore_all:
  Move.l              SaveIRQ,$6c
  Move.w              #$7fff,$dff09a	
  Move.w              Saveint,$dff09a
  Move.w              #$7fff,$dff096
  Move.w              SaveDMA,$dff096
  Move.l              $00000004,a6
  Lea                 Name,a1
  Moveq               #0,d0
  Jsr                 -552(a6)
  Move.l              d0,a0
  Move.l              38(a0),$dff080
  Clr.w               $dff088
  Move.l              d0,a1
  Jsr                 -414(a6)
  Jsr                 -138(a6)
  Rts
;---------------------------------------------------------------
Saveint:Dc.w 0
SaveDMA:Dc.w 0
SaveIRQ:Dc.l 0
Name:DC.B "graphics.library",0
  Even
;----------------------------------------------------------------  

Playrtn:
  include             "P6112-Play.i"



; **************************************************************************
; *		BARRA A SCORRIMENTO ORIZZONTALE (Lezione3h.s)		   *
; **************************************************************************
  IFD                 EFFECTS
                                                                       ; TORNIAMO AL LOOP mouse
; **************************************************************************
; *		BARRA ROSSA SOTTO LA LINEA $FF (Lezione3f.s)		   *
; **************************************************************************

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
				; la barra scedera'

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


  include             "AProcessing2/libs/rasterizers/globaloptions.s"
  include             "AProcessing2/libs/matrix/matrix.s"
  include             "AProcessing2/libs/matrix/scale.s"

  ;include             "AProcessing2/libs/rasterizers/3dglobals.i"
  ;include             "AProcessing2/libs/rasterizers/processingfill.s"
  include             "AProcessing2/libs/rasterizers/processing_table_plotrefs.s"
  ;include             "AProcessing2/libs/rasterizers/clipping.s"
  include             "AProcessing2/libs/trigtables.i"
  include             "AProcessing2/libs/rasterizers/point.s"
  ;include             "AProcessing2/libs/rasterizers/triangle.s"
  ;include             "AProcessing2/libs/rasterizers/rectangle.s"
  include             "AProcessing2/libs/rasterizers/processing_bitplanes_fast.s"
  include             "AProcessing2/libs/blitter/lines.s"
  include             "AProcessing2/libs/blitter/triangle.s"

  include             "initnoprecalc.s"
  include             "schedule.s"
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

Module1:
  incbin              "P61.chippy_nr.399"                                            ; usecode $945A
  even



  end

