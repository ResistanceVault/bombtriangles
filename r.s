  include        "P6112-options.i"

  SECTION        CiriCop,CODE_C

  include        "AProcessing2/libs/ammxmacros.i"


Inizio:

.loop; Wait for vblank
  move.l         $dff004,d0
  and.l          #$1ff00,d0
  cmp.l          #303<<8,d0
  bne.b          .loop
  bsr            Save_all

;*****************************************************************************
;	FACCIAMO PUNTARE I BPLPOINTERS NELLA COPPELIST AI NOSTRI BITPLANES
;*****************************************************************************
  MOVE.L         #SCREEN_2,d0
  LEA            BPLPOINTERS2,A1
  move.w         d0,6(a1)
  swap           d0
  move.w         d0,2(a1)

  MOVE.L         #SCREEN_3,d0
  LEA            BPLPOINTERS3,A1
  move.w         d0,6(a1)
  swap           d0
  move.w         d0,2(a1)

	; test per vedere se lo sprite si elimina

  lea            $dff000,a6
  move           #$7ff,$96(a6)                                                 ;Disable DMAs
  move           #%1000011111000000,$96(a6)                                    ;Master,Copper,Blitter,Bitplanes
  move           #$7fff,$9a(a6)                                                ;Disable IRQs
  move           #$e000,$9a(a6)                                                ;Master and lev6
					;NO COPPER-IRQ!
  moveq          #0,d0
  move           d0,$106(a6)                                                   ;Disable AGA/ECS-stuff
  move           d0,$1fc(a6)

  move.l         #COPPERLIST,$dff080                                           ; Puntiamo la nostra COP
  move.w         d0,$dff088                                                    ; Facciamo partire la COP

  move.w         #0,$dff1fc                                                    ; FMODE - Disattiva l'AGA
  move.w         #$c00,$dff106                                                 ; BPLCON3 - Disattiva l'AGA

  lea            Module1,a0
  sub.l          a1,a1
  sub.l          a2,a2
  moveq          #0,d0

  jsr            P61_Init

  jsr            _ammxmainloop3_init
  move           #%1000011111000000,$96(a6)                                    ;Master,Copper,Blitter,Bitplanes


mouse:
  cmpi.b         #$ff,$dff006                                                  ; Siamo alla linea 255?
  bne.s          mouse                                                         ; Se non ancora, non andare avanti
;.loop; Wait for vblank
;	move.l $dff004,d0
;	and.l #$1ff00,d0
;	cmp.l #303<<8,d0
;	bne.b .loop

    ;move	#$00F0,$180(a6)
  jsr            P61_Music                                                     ;and call the playroutine manually.
	;move	#$003,$180(a6)

  IFD            DEBUGCOLORS
  move.w         #$0F00,$dff180
  ENDC

  jsr            ammxmainloop3
	
  lea            BPLPOINTERS,a0
  move.w         d0,6(a0)
  swap           d0
  move.w         d0,2(a0)
  swap           d0

  lea            BPLPOINTERS1,a0
  add.l          #256*40,d0
  move.w         d0,6(a0)
  swap           d0
  move.w         d0,2(a0)
  swap           d0

  IFD            DEBUGCOLORS
  move           #$003,$180(a6)
  ENDC

  IFD            EFFECTS
  jsr            muovicopper                                                   ; barra rossa sotto linea $ff
	;jsr	CopperDestSin	; Routine di scorrimento destra/sinistra
  jsr            scrollcolors                                                  ; scorrimento ciclico dei colori
  ENDC
Aspetta:
  cmpi.b         #$ff,$dff006                                                  ; Siamo alla linea 255?
  beq.s          Aspetta                                                       ; Se si, non andare avanti, aspetta la linea
				; seguente, altrimenti MuoviCopper viene
				; rieseguito
;.loopend ; Wait to exit vblank row (for faster processors like 68040)
;	move.l $dff004,d0
;	and.l #$1ff00,d0
;	cmp.l #303<<8,d0
;	beq.b .loopend

  btst           #6,$bfe001                                                    ; tasto sinistro del mouse premuto?
  bne.s          mouse                                                         ; se no, torna a mouse:
exit_demo:
  WAITBLITTER
  bsr            P61_End
  bsr            Restore_all
  clr.l          d0
  rts                                                                          ; USCITA DAL PROGRAMMA

;---------------------------------------------------------------
Save_all
  Move.b         #$87,$bfd100                                                  ; stop drive
  Move.l         $00000004,a6
  Jsr            -132(a6)
  Move.l         $6c,SaveIRQ
  Move.w         $dff01c,Saveint
  Or.w           #$c000,Saveint
  Move.w         $dff002,SaveDMA
  Or.w           #$8100,SaveDMA
  Rts
Restore_all:
  Move.l         SaveIRQ,$6c
  Move.w         #$7fff,$dff09a	
  Move.w         Saveint,$dff09a
  Move.w         #$7fff,$dff096
  Move.w         SaveDMA,$dff096
  Move.l         $00000004,a6
  Lea            Name,a1
  Moveq          #0,d0
  Jsr            -552(a6)
  Move.l         d0,a0
  Move.l         38(a0),$dff080
  Clr.w          $dff088
  Move.l         d0,a1
  Jsr            -414(a6)
  Jsr            -138(a6)
  Rts
;---------------------------------------------------------------
Saveint:Dc.w 0
SaveDMA:Dc.w 0
SaveIRQ:Dc.l 0
Name:DC.B "graphics.library",0
  Even
;----------------------------------------------------------------  

Playrtn:
  include        "P6112-Play.i"



; **************************************************************************
; *		BARRA A SCORRIMENTO ORIZZONTALE (Lezione3h.s)		   *
; **************************************************************************
  IFD            EFFECTS
CopperDestSin:
  CMPI.W         #85,DestraFlag                                                ; VAIDESTRA eseguita 85 volte?
  BNE.S          VAIDESTRA                                                     ; se non ancora, rieseguila
  CMPI.W         #85,SinistraFlag                                              ; VAISINISTRA eseguita 85 volte?
  BNE.S          VAISINISTRA                                                   ; se non ancora, rieseguila
  CLR.W          DestraFlag                                                    ; la routine VAISINISTRA e' stata eseguita
  CLR.W          SinistraFlag                                                  ; 85 volte, riparti
  RTS                                                                          ; TORNIAMO AL LOOP mouse


VAIDESTRA:			; questa routine sposta la barra verso DESTRA
  lea            CopBar+1,A0                                                   ; Mettiamo in A0 l'indirizzo del primo XX
  move.w         #29-1,D2                                                      ; dobbiamo cambiare 29 wait (usiamo un DBRA)
DestraLoop:
  addq.b         #2,(a0)                                                       ; aggiungiamo 2 alla coordinata X del wait
  ADD.W          #16,a0                                                        ; andiamo al prossimo wait da cambiare
  dbra           D2,DestraLoop                                                 ; ciclo eseguito d2 volte
  addq.w         #1,DestraFlag                                                 ; segnamo che abbiamo eseguito VAIDESTRA
  RTS                                                                          ; TORNIAMO AL LOOP mouse


VAISINISTRA:			; questa routine sposta la barra verso SINISTRA
  lea            CopBar+1,A0
  move.w         #29-1,D2                                                      ; dobbiamo cambiare 29 wait
SinistraLoop:
  subq.b         #2,(a0)                                                       ; sottraiamo 2 alla coordinata X del wait
  ADD.W          #16,a0                                                        ; andiamo al prossimo wait da cambiare
  dbra           D2,SinistraLoop                                               ; ciclo eseguito d2 volte
  addq.w         #1,SinistraFlag                                               ; Annotiamo lo spostamento
  RTS                                                                          ; TORNIAMO AL LOOP mouse


DestraFlag:		; In questa word viene tenuto il conto delle volte
  dc.w           0                                                             ; che e' stata eseguita VAIDESTRA

SinistraFlag:		; In questa word viene tenuto il conto delle volte
  dc.w           0                                                             ; che e' stata eseguita VAISINISTRA

; **************************************************************************
; *		BARRA ROSSA SOTTO LA LINEA $FF (Lezione3f.s)		   *
; **************************************************************************

muovicopper:
  LEA            BARRA,a0
  TST.B          SuGiu                                                         ; Dobbiamo salire o scendere?
  beq.w          VAIGIU
  cmpi.b         #$0a,(a0)                                                     ; siamo arrivati alla linea $0a+$ff? (265)
  beq.s          MettiGiu                                                      ; se si, siamo in cima e dobbiamo scendere
  subq.b         #1,(a0)
  subq.b         #1,8(a0)                                                      ; ora cambiamo gli altri wait: la distanza
  subq.b         #1,8*2(a0)                                                    ; tra un wait e l'altro e' di 8 bytes
  subq.b         #1,8*3(a0)
  subq.b         #1,8*4(a0)
  subq.b         #1,8*5(a0)
  subq.b         #1,8*6(a0)
  subq.b         #1,8*7(a0)                                                    ; qua dobbiamo modificare tutti i 9 wait della
  subq.b         #1,8*8(a0)                                                    ; barra rossa ogni volta per farla salire!
  subq.b         #1,8*9(a0)
  rts

MettiGiu:
  clr.b          SuGiu                                                         ; Azzerando SuGiu, al TST.B SuGiu il BEQ
  rts                                                                          ; fara' saltare alla routine VAIGIU, e
				; la barra scedera'

VAIGIU:
  cmpi.b         #$2c,8*9(a0)                                                  ; siamo arrivati alla linea $2c?
  beq.s          MettiSu                                                       ; se si, siamo in fondo e dobbiamo risalire
  addq.b         #1,(a0)
  addq.b         #1,8(a0)                                                      ; ora cambiamo gli altri wait: la distanza
  addq.b         #1,8*2(a0)                                                    ; tra un wait e l'altro e' di 8 bytes
  addq.b         #1,8*3(a0)
  addq.b         #1,8*4(a0)
  addq.b         #1,8*5(a0)
  addq.b         #1,8*6(a0)
  addq.b         #1,8*7(a0)                                                    ; qua dobbiamo modificare tutti i 9 wait della
  addq.b         #1,8*8(a0)                                                    ; barra rossa ogni volta per farla scendere!
  addq.b         #1,8*9(a0)
  rts

MettiSu:
  move.b         #$ff,SuGiu                                                    ; Quando la label SuGiu non e' a zero,
  rts                                                                          ; significa che dobbiamo risalire.


SuGiu:
  dc.b           0,0

; **************************************************************************
; *		SCORRIMENTO CICLICO DEI COLORI (Lezione3E.s)		   *
; **************************************************************************

scrollcolors:	
  move.w         col2,col1                                                     ; col2 copiato in col1
  move.w         col3,col2                                                     ; col3 copiato in col2
  move.w         col4,col3                                                     ; col4 copiato in col3
  move.w         col5,col4                                                     ; col5 copiato in col4
  move.w         col6,col5                                                     ; col6 copiato in col5
  move.w         col7,col6                                                     ; col7 copiato in col6
  move.w         col8,col7                                                     ; col8 copiato in col7
  move.w         col9,col8                                                     ; col9 copiato in col8
  move.w         col10,col9                                                    ; col10 copiato in col9
  move.w         col11,col10                                                   ; col11 copiato in col10
  move.w         col12,col11                                                   ; col12 copiato in col11
  move.w         col13,col12                                                   ; col13 copiato in col12
  move.w         col14,col13                                                   ; col14 copiato in col13
  move.w         col1,col14                                                    ; col1 copiato in col14
  rts
  ENDC


  include        "AProcessing2/libs/rasterizers/globaloptions.s"
  include        "AProcessing2/libs/matrix/matrix.s"
  include        "AProcessing2/libs/matrix/shear.s"

  include        "AProcessing2/libs/rasterizers/3dglobals.i"
  include        "AProcessing2/libs/rasterizers/processingfill.s"
  include        "AProcessing2/libs/rasterizers/processing_table_plotrefs.s"
  include        "AProcessing2/libs/rasterizers/clipping.s"
  include        "AProcessing2/libs/trigtables.i"
  include        "AProcessing2/libs/rasterizers/point.s"
  include        "AProcessing2/libs/rasterizers/triangle.s"
  include        "AProcessing2/libs/rasterizers/triangle3d.s"
  include        "AProcessing2/libs/rasterizers/foursidepolygon3d.s"
  include        "AProcessing2/libs/rasterizers/processing_bitplanes_fast.s"
  include        "AProcessing2/libs/blitter/lines.s"

  include        "initnoprecalc.s"
  include        "schedule.s"
  include        "ammxmainloopnoprecalc.s"


  include        "copperlists.s"

SCREEN_2
  dcb.b          40*256,$00

SCREEN_3
  dcb.b          40*256,$00

Module1:
  incbin         "P61.chippy_nr.399"                                           ; usecode $945A
  even

  end

