; **************************************************************************
; *				SUPER COPPERLIST			   *
; **************************************************************************

; Single playfield mode
COPSET2BPL MACRO
  dc.w       $100
  dc.w       %0010001000000000
  ENDM

COPSET3BPL MACRO
  dc.w       $100
  dc.w       %0011001000000000
  ENDM

; Double playfield modes
COPSET23BPL MACRO
  dc.w       $100
  dc.w       $5600
  ENDM

  SECTION    GRAPHIC,DATA_C

COPPERLIST:

; Sprites pointer init
SpritePointers:
Sprite0pointers:
  dc.w       $120,$0000,$122,$0000

Sprite1pointers:
  dc.w       $124,$0000,$126,$0000

Sprite2pointers:
  dc.w       $128,$0000,$12a,$0000

Sprite3pointers:
  dc.w       $12c,$0000,$12e,$0000

Sprite4pointers:
  dc.w       $130,$0000,$132,$0000

Sprite5pointers:
  dc.w       $134,$0000,$136,$0000

Sprite6pointers;
  dc.w       $138,$0000,$13a,$0000

Sprite7pointers:
  dc.w       $13c,$0000,$13e,$0000

; other stuff
  dc.w       $8e,$2c81                                                 ; DiwStrt	(registri con valori normali)
  dc.w       $90,$2cc1                                                 ; DiwStop
  dc.w       $92,$0038                                                 ; DdfStart
  dc.w       $94,$00d0                                                 ; DdfStop
  dc.w       $102,0
                                                      ; BplCon1
  ; BplCon2
  ; Playfield 2 priority over Playfield 1 ON
  ; Sprites max priority over playfields
  dc.w       $104,$0064

  dc.w       $108,0                                                    ; Bpl1Mod
  dc.w       $10a,0


; Set dual playfield mode, activating PLAYFIELD 1 with bitplanes 1 3 5 and PLAYFIELD 2 with bitplanes 2 4
; Bitplanes 2 4 are double buffered and will be used to paint stuff, PLAYFIELD 1 will contain static image.
  COPSET23BPL

; Bitplanes Pointers
BPLPTR1:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2:
  dc.w       $e4,$0000,$e6,$0000                                       ;second bitplane - BPL1PT
BPLPTR3:
  dc.w       $e8,$0000,$ea,$0000                                       ;third	 bitplane - BPL2PT
BPLPTR4:
  dc.w       $ec,$0000,$ee,$0000                                       ;fourth bitplane - BPL3PT
BPLPTR5:
  dc.w       $f0,$0000,$f2,$0000                                       ;fifth	 bitplane - BPL4PT

  ; wait for the top of the screen and set big spaceship colors
  dc.w       $2B07,$FFFE
  include    "coplistfragments/bigspaceshipcolors.s"
  dc.w       $180,0 ; background always black to hide left right borders                                                    ; Bpl2Mod


  IFD EFFECTS
  include "coplistfragments/sky.s"
  dc.w    $4207,$FFFE    ; salto 4 linee
  include "coplistfragments/pyramidcolors.s"
  include   "coplistfragments/sky3.s"
  ELSE
  dc.w       $4207,$FFFE
  include "coplistfragments/pyramidcolors.s"
  ENDC

COLORTEST EQU $194
OFFSETTEST EQU $1000
  IFD        EFFECTS
;	L'effetto di Lezione3e.s spostato piu' in ALTO

  dc.w       $3a07+OFFSETTEST,$fffe                                               ; aspettiamo la linea 154 ($9a in esadecimale)
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0
col1:
  dc.w       $0f0                                                      ; VALORE DEL COLOR 0 (che sara' modificato)
  dc.w       $3b07+OFFSETTEST,$fffe                                               ; aspettiamo la linea 155 (non sara' modificata)
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0 (non sara' modificato)
col2:
  dc.w       $0d0                                                      ; VALORE DEL COLOR 0 (sara' modificato)
  dc.w       $3c07+OFFSETTEST,$fffe                                               ; aspettiamo la linea 156 (non modificato,ecc.)
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0
col3:
  dc.w       $0b0                                                      ; VALORE DEL COLOR 0
  dc.w       $3d07+OFFSETTEST,$fffe                                               ; aspettiamo la linea 157
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0
col4:
  dc.w       $090                                                      ; VALORE DEL COLOR 0
  dc.w       $3e07+OFFSETTEST,$fffe                                               ; aspettiamo la linea 158
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0
col5:
  dc.w       $070                                                      ; VALORE DEL COLOR 0
  dc.w       $3f07+OFFSETTEST,$fffe                                               ; aspettiamo la linea 159
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0
col6:
  dc.w       $050                                                      ; VALORE DEL COLOR 0
  dc.w       $4007+OFFSETTEST,$fffe                                               ; aspettiamo la linea 160
  dc.w       COLORTEST                                                      ; REGISTRO COLOR0
col7:
  dc.w       $030                                                      ; VALORE DEL COLOR 0
  dc.w       $4107+OFFSETTEST,$fffe                                               ; aspettiamo la linea 161
  dc.w       COLORTEST                                                      ; color0... (ora avete capito i commenti,
col8:				; posso anche smettere di metterli da qua!)
  dc.w       $030
  dc.w       $4207+OFFSETTEST,$fffe                                               ; linea 162
  dc.w       COLORTEST
col9:
  dc.w       $050
  dc.w       $4307+OFFSETTEST,$fffe                                               ;  linea 163
  dc.w       COLORTEST
col10:
  dc.w       $070
  dc.w       $4407+OFFSETTEST,$fffe                                               ;  linea 164
  dc.w       COLORTEST
col11:
  dc.w       $090
  dc.w       $4507+OFFSETTEST,$fffe                                               ;  linea 165
  dc.w       COLORTEST
col12:
  dc.w       $0b0
  dc.w       $4607+OFFSETTEST,$fffe                                               ;  linea 166
  dc.w       COLORTEST
col13:
  dc.w       $0d0
  dc.w       $4707+OFFSETTEST,$fffe                                               ;  linea 167
  dc.w       COLORTEST
col14:
  dc.w       $0f0
  dc.w       $4807,$fffe                                               ;  linea 168

  dc.w       COLORTEST,COLOR2                                                ; Decidiamo il colore NERO per la parte
				; di schermo sotto l'effetto

  include   "coplistfragments/sky4.s"

  ENDC

  IFD COPPLATFORM
  dc.w       $5F07,$fffe
  dc.w       $18e,COLORCOPPLATFORM1
  dc.w       $6207,$fffe
  dc.w       $18e,COLORCOPPLATFORM2
  dc.w       $6307,$fffe
  dc.w       $18e,COLORCOPPLATFORM3
  dc.w       $6407,$fffe
  dc.w       $18e,COLORCOPPLATFORM4
  dc.w       $6507,$fffe
  dc.w       $18e,COLORCOPPLATFORM5
  dc.w       $6607,$fffe
  dc.w       $18e,COLORCOPPLATFORM6
  dc.w       $6707,$fffe
  dc.w       $18e,COLOR3

  IFD EFFECTS
  include   "coplistfragments/sky5.s"
  ENDC

  dc.w       $8F07,$fffe
  dc.w       $18e,COLORCOPPLATFORM1
  dc.w       $9207,$fffe
  dc.w       $18e,COLORCOPPLATFORM2
  dc.w       $9307,$fffe
  dc.w       $18e,COLORCOPPLATFORM3
  dc.w       $9407,$fffe
  dc.w       $18e,COLORCOPPLATFORM4
  dc.w       $9507,$fffe
  dc.w       $18e,COLORCOPPLATFORM5
  dc.w       $9607,$fffe
  dc.w       $18e,COLORCOPPLATFORM6

  dc.w       $9707,$fffe
  dc.w       $18e,COLORCOPPLATFORM1
  dc.w       $9A07,$fffe
  dc.w       $18e,COLORCOPPLATFORM2
  dc.w       $9B07,$fffe
  dc.w       $18e,COLORCOPPLATFORM3
  dc.w       $9C07,$fffe
  dc.w       $18e,COLORCOPPLATFORM4
  dc.w       $9D07,$fffe
  dc.w       $18e,COLORCOPPLATFORM5
  dc.w       $9E07,$fffe
  dc.w       $18e,COLORCOPPLATFORM6
  IFD        EFFECTS
  dc.w       SKY_COL_INDEX,$540
  ENDC

  dc.w       $9F07,$fffe
  dc.w       $18e,COLOR3

  ENDC

  ; sand
  IFD EFFECTS
  include    "coplistfragments/sand.s"

  dc.w       $eC07,$FFFE
  dc.w       $182,$ba6 ; continue with last color of sandtop

  IFD GREENBAR
  dc.w       $eC07-$0000,$FFFE
  dc.w       $180,$030
  dc.w       $182,$ba6 ; continue with last color of sandtop
  dc.w       $ED07-$0000,$FFFE
  dc.w       $180,$040
  dc.w       $EE07-$0000,$FFFE
  dc.w       $180,$030
  dc.w       $EF07-$0000,$FFFE
  dc.w       $180,$020
  dc.w       $F007-$0000,$FFFE
  dc.w       $180,$010
  dc.w       $F107-$0000,$FFFE
  dc.w       $180,$000
  ENDC
  ENDC




  ; Bitplanes Tile Pointers
  dc.w       $fddf,$FFFE                                               ; aspetto la linea $79
  dc.w       $182,COLOR1
  dc.w       $184,COLOR2
  dc.w       $186,COLOR3
  COPSET2BPL

BPLPTR1_TILE:
  dc.w       $e0,$0000,$e2,$0000                                       ;first	 bitplane - BPL0PT
BPLPTR2_TILE:
  dc.w       $e4,$0000,$e6,$0000

  dc.w       $ffdf,$fffe    ; wait line 255

  IFD        EFFECTS
BARRA:
  dc.w       $0907,$FFFE                                               ; aspetto la linea $79
  dc.w       $180,$300                                                 ; inizio la barra rossa: rosso a 3
  dc.w       $0a07,$FFFE                                               ; linea seguente
  dc.w       $180,$600                                                 ; rosso a 6
  dc.w       $0b07,$FFFE
  dc.w       $180,$900                                                 ; rosso a 9
  dc.w       $0c07,$FFFE
  dc.w       $180,$c00                                                 ; rosso a 12
  dc.w       $0d07,$FFFE
  dc.w       $180,$f00                                                 ; rosso a 15 (al massimo)
  dc.w       $0e07,$FFFE
  dc.w       $180,$c00                                                 ; rosso a 12
  dc.w       $0f07,$FFFE
  dc.w       $180,$900                                                 ; rosso a 9
  dc.w       $1007,$FFFE
  dc.w       $180,$600                                                 ; rosso a 6
  dc.w       $1107,$FFFE
  dc.w       $180,$300                                                 ; rosso a 3
  dc.w       $1207,$FFFE
  dc.w       $180,$000                                                 ; colore NERO
  ENDC

; Copperlist end
  dc.w       $FFFF,$FFFE                                               ; End of copperlist
