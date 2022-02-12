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

	; Facciamo puntare gli sprite a ZERO, per eliminarli, o ce li troviamo
	; in giro impazziti a disturbare!!!
SpritePointers:
  dc.w       $120,$0000,$122,$0000,$124,$0000,$126,$0000,$128,$0000
  dc.w       $12a,$0000,$12c,$0000,$12e,$0000,$130,$0000,$132,$0000
  dc.w       $134,$0000,$136,$0000,$138,$0000,$13a,$0000,$13c,$0000
  dc.w       $13e,$0000

  dc.w       $8e,$2c81                                                 ; DiwStrt	(registri con valori normali)
  dc.w       $90,$2cc1                                                 ; DiwStop
  dc.w       $92,$0038                                                 ; DdfStart
  dc.w       $94,$00d0                                                 ; DdfStop
  dc.w       $102,0                                                    ; BplCon1
  dc.w       $104,$0040 ; Playfield 2 priority over Playfield 1 ON                                                    ; BplCon2
  dc.w       $108,0                                                    ; Bpl1Mod
  dc.w       $10a,0                                                    ; Bpl2Mod

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

  ;dc.w       $180,$0000
COLORTEST EQU $194
;COLORTEST EQU $180
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


  dc.w       $0180,$000                                                ; color0
  ENDC


  IFD        EFFECTS
  dc.w       $7007,$fffe                                               ; Aspettiamo la fine della scritta COMMODORE

  dc.w       $0180,$000                                                ; color0
	;dc.w	$0182,$475	; color1
	;dc.w	$0184,$fff	; color2
	;dc.w	$0186,$ccc	; color3
	;dc.w	$0188,$999	; color4
	;dc.w	$018a,$232	; color5
	;dc.w	$018c,$777	; color6
	;dc.w	$018e,$444	; color7

;	EFFETTO DELLA LEZIONE3h.s
  dc.w       $9007,$fffe                                               ; aspettiamo l'inizio della linea
  dc.w       $180,$000                                                 ; grigio al minimo, ossia NERO!!!
CopBar:
  dc.w       $9031,$fffe                                               ; wait che cambiamo ($9033,$9035,$9037...)
  dc.w       $180,$100                                                 ; colore rosso
  dc.w       $9107,$fffe                                               ; wait che non cambiamo (Inizio linea)
  dc.w       $180,$111                                                 ; colore GRIGIO (parte dall'inizio linea fino
  dc.w       $9131,$fffe                                               ; a questo WAIT, che noi cambiaremo...
  dc.w       $180,$000                                                 ; dopo il quale comincia il ROSSO

;	    WAIT FISSI (poi grigio) - WAIT DA CAMBIARE (seguiti dal rosso)
  IFD LOL
  dc.w       $9231,$fffe,$196,$300               ; linea 3
  dc.w       $9331,$fffe,$196,$400               ; linea 4
  dc.w       $9431,$fffe,$196,$500               ; linea 5
  dc.w       $9531,$fffe,$196,$600               ; ....
  dc.w       $9631,$fffe,$196,$700
  dc.w       $9731,$fffe,$196,$800
  dc.w       $9831,$fffe,$196,$900
  dc.w       $9931,$fffe,$196,$a00
  dc.w       $9a31,$fffe,$196,$b00
  dc.w       $9b31,$fffe,$196,$c00
  dc.w       $9c31,$fffe,$196,$d00
  dc.w       $9d31,$fffe,$196,$e00
  dc.w       $9e31,$fffe,$196,$f00
  dc.w       $9f31,$fffe,$196,$e00
  dc.w       $a031,$fffe,$196,$d00
  dc.w       $a131,$fffe,$196,$c00
  dc.w       $a231,$fffe,$196,$b00
  dc.w       $a331,$fffe,$196,$a00
  dc.w       $a431,$fffe,$196,$900
  dc.w       $a531,$fffe,$196,$800
  dc.w       $a631,$fffe,$196,$700
  dc.w       $a731,$fffe,$196,$600
  dc.w       $a831,$fffe,$196,$500
  dc.w       $a931,$fffe,$196,$400
  dc.w       $aa31,$fffe,$196,$301
  dc.w       $ab31,$fffe,$196,$202
  dc.w       $ac31,$fffe,$196,$103
  dc.w       $ad31,$fffe,$196,COLOR2
  ENDC

  dc.w       $ae07,$FFFE                                               ; prossima linea
  dc.w       $180,$006                                                 ; blu a 6
  dc.w       $b007,$FFFE                                               ; salto 2 linee
  dc.w       $180,$007                                                 ; blu a 7
  dc.w       $b207,$FFFE                                               ; sato 2 linee
  dc.w       $180,$008                                                 ; blu a 8
  dc.w       $b507,$FFFE                                               ; salto 3 linee
  dc.w       $180,$009                                                 ; blu a 9
  dc.w       $b807,$FFFE                                               ; salto 3 linee
  dc.w       $180,$00a                                                 ; blu a 10
  dc.w       $bb07,$FFFE                                               ; salto 3 linee
  dc.w       $180,$00b                                                 ; blu a 11
  dc.w       $be07,$FFFE                                               ; salto 3 linee
  dc.w       $180,$00c                                                 ; blu a 12
  dc.w       $c207,$FFFE                                               ; salto 4 linee
  dc.w       $180,$00d                                                 ; blu a 13
  dc.w       $c707,$FFFE                                               ; salto 7 linee
  dc.w       $180,$00e                                                 ; blu a 14
  dc.w       $ce07,$FFFE                                               ; salto 6 linee
  dc.w       $180,$00f                                                 ; blu a 15
  dc.w       $d807,$FFFE                                               ; salto 10 linee
  dc.w       $180,$11F                                                 ; schiarisco...
  dc.w       $e807,$FFFE                                               ; salto 16 linee
  dc.w       $180,$22F                                                 ; schiarisco...

  dc.w       $eA07,$FFFE                                               ; una barretta fissa verde SOTTO la linea $FF!
  dc.w       $180,$010
  dc.w       $eB07,$FFFE
  dc.w       $180,$020
  dc.w       $eC07,$FFFE
  dc.w       $180,$030
  dc.w       $ED07,$FFFE
  dc.w       $180,$040
  dc.w       $EE07,$FFFE
  dc.w       $180,$030
  dc.w       $EF07,$FFFE
  dc.w       $180,$020
  dc.w       $F007,$FFFE
  dc.w       $180,$010
  dc.w       $F107,$FFFE
  dc.w       $180,$000
  ENDC

  ; Bitplanes Tile Pointers
  dc.w       $fddf,$FFFE                                               ; aspetto la linea $79
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


  dc.w       $FFFF,$FFFE                                               ; End of copperlist
