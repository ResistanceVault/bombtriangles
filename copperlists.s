; **************************************************************************
; *				SUPER COPPERLIST			   *
; **************************************************************************

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
  dc.w       $104,0                                                    ; BplCon2
  dc.w       $108,0                                                    ; Bpl1Mod
  dc.w       $10a,0                                                    ; Bpl2Mod

  ; sprite fix
  ;dc.w $144,0
  ;dc.w $146,0

; Il BPLCON0 per uno schermo a 3 bitplanes: (8 colori)

		    ; 5432109876543210
  dc.w       $100
BPLCON0POINTER:
  dc.w       %0011001000000000                                         ; bits 13 e 12 accesi!! (3 = %011)

;	Facciamo puntare i bitplanes direttamente mettendo nella copperlist
;	i registri $dff0e0 e seguenti qua di seguito con gli indirizzi
;	dei bitplanes che saranno messi dalla routine POINTBP

BPLPOINTERS:
  dc.w       $e0,$0000,$e2,$0000                                       ;primo	 bitplane - BPL0PT
BPLPOINTERS1:
  dc.w       $e4,$0000,$e6,$0000                                       ;secondo bitplane - BPL1PT
BPLPOINTERS2:
  dc.w       $e8,$0000,$ea,$0000                                       ;terzo	 bitplane - BPL2PT


  IFD        EFFECTS
;	L'effetto di Lezione3e.s spostato piu' in ALTO

  dc.w       $3a07,$fffe                                               ; aspettiamo la linea 154 ($9a in esadecimale)
  dc.w       $180                                                      ; REGISTRO COLOR0
col1:
  dc.w       $0f0                                                      ; VALORE DEL COLOR 0 (che sara' modificato)
  dc.w       $3b07,$fffe                                               ; aspettiamo la linea 155 (non sara' modificata)
  dc.w       $180                                                      ; REGISTRO COLOR0 (non sara' modificato)
col2:
  dc.w       $0d0                                                      ; VALORE DEL COLOR 0 (sara' modificato)
  dc.w       $3c07,$fffe                                               ; aspettiamo la linea 156 (non modificato,ecc.)
  dc.w       $180                                                      ; REGISTRO COLOR0
col3:
  dc.w       $0b0                                                      ; VALORE DEL COLOR 0
  dc.w       $3d07,$fffe                                               ; aspettiamo la linea 157
  dc.w       $180                                                      ; REGISTRO COLOR0
col4:
  dc.w       $090                                                      ; VALORE DEL COLOR 0
  dc.w       $3e07,$fffe                                               ; aspettiamo la linea 158
  dc.w       $180                                                      ; REGISTRO COLOR0
col5:
  dc.w       $070                                                      ; VALORE DEL COLOR 0
  dc.w       $3f07,$fffe                                               ; aspettiamo la linea 159
  dc.w       $180                                                      ; REGISTRO COLOR0
col6:
  dc.w       $050                                                      ; VALORE DEL COLOR 0
  dc.w       $4007,$fffe                                               ; aspettiamo la linea 160
  dc.w       $180                                                      ; REGISTRO COLOR0
col7:
  dc.w       $030                                                      ; VALORE DEL COLOR 0
  dc.w       $4107,$fffe                                               ; aspettiamo la linea 161
  dc.w       $180                                                      ; color0... (ora avete capito i commenti,
col8:				; posso anche smettere di metterli da qua!)
  dc.w       $030
  dc.w       $4207,$fffe                                               ; linea 162
  dc.w       $180
col9:
  dc.w       $050
  dc.w       $4307,$fffe                                               ;  linea 163
  dc.w       $180
col10:
  dc.w       $070
  dc.w       $4407,$fffe                                               ;  linea 164
  dc.w       $180
col11:
  dc.w       $090
  dc.w       $4507,$fffe                                               ;  linea 165
  dc.w       $180
col12:
  dc.w       $0b0
  dc.w       $4607,$fffe                                               ;  linea 166
  dc.w       $180
col13:
  dc.w       $0d0
  dc.w       $4707,$fffe                                               ;  linea 167
  dc.w       $180
col14:
  dc.w       $0f0
  dc.w       $4807,$fffe                                               ;  linea 168

  dc.w       $180,$0000                                                ; Decidiamo il colore NERO per la parte
				; di schermo sotto l'effetto


  dc.w       $0180,$000                                                ; color0
  ENDC
	;dc.w	$0182,$550	; color1	; ridefiniamo il colore della
	;dc.w	$0184,$0F00	; color2	; scritta COMMODORE! GIALLA!
	;dc.w	$0186,$00F0	; color3
	;dc.w	$0188,$990	; color4
	;dc.w	$018a,$220	; color5
	;dc.w	$018c,$770	; color6
	;dc.w	$018e,$440	; color7

  IFD        EFFECTS
  dc.w       $7007,$fffe                                               ; Aspettiamo la fine della scritta COMMODORE

;	Gli 8 colori della figura sono definiti qui:

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
  dc.w       $180,$200                                                 ; dopo il quale comincia il ROSSO

;	    WAIT FISSI (poi grigio) - WAIT DA CAMBIARE (seguiti dal rosso)

  dc.w       $9207,$fffe,$180,$222,$9231,$fffe,$180,$300               ; linea 3
  dc.w       $9307,$fffe,$180,$333,$9331,$fffe,$180,$400               ; linea 4
  dc.w       $9407,$fffe,$180,$444,$9431,$fffe,$180,$500               ; linea 5
  dc.w       $9507,$fffe,$180,$555,$9531,$fffe,$180,$600               ; ....
  dc.w       $9607,$fffe,$180,$666,$9631,$fffe,$180,$700
  dc.w       $9707,$fffe,$180,$777,$9731,$fffe,$180,$800
  dc.w       $9807,$fffe,$180,$888,$9831,$fffe,$180,$900
  dc.w       $9907,$fffe,$180,$999,$9931,$fffe,$180,$a00
  dc.w       $9a07,$fffe,$180,$aaa,$9a31,$fffe,$180,$b00
  dc.w       $9b07,$fffe,$180,$bbb,$9b31,$fffe,$180,$c00
  dc.w       $9c07,$fffe,$180,$ccc,$9c31,$fffe,$180,$d00
  dc.w       $9d07,$fffe,$180,$ddd,$9d31,$fffe,$180,$e00
  dc.w       $9e07,$fffe,$180,$eee,$9e31,$fffe,$180,$f00
  dc.w       $9f07,$fffe,$180,$fff,$9f31,$fffe,$180,$e00
  dc.w       $a007,$fffe,$180,$eee,$a031,$fffe,$180,$d00
  dc.w       $a107,$fffe,$180,$ddd,$a131,$fffe,$180,$c00
  dc.w       $a207,$fffe,$180,$ccc,$a231,$fffe,$180,$b00
  dc.w       $a307,$fffe,$180,$bbb,$a331,$fffe,$180,$a00
  dc.w       $a407,$fffe,$180,$aaa,$a431,$fffe,$180,$900
  dc.w       $a507,$fffe,$180,$999,$a531,$fffe,$180,$800
  dc.w       $a607,$fffe,$180,$888,$a631,$fffe,$180,$700
  dc.w       $a707,$fffe,$180,$777,$a731,$fffe,$180,$600
  dc.w       $a807,$fffe,$180,$666,$a831,$fffe,$180,$500
  dc.w       $a907,$fffe,$180,$555,$a931,$fffe,$180,$400
  dc.w       $aa07,$fffe,$180,$444,$aa31,$fffe,$180,$301
  dc.w       $ab07,$fffe,$180,$333,$ab31,$fffe,$180,$202
  dc.w       $ac07,$fffe,$180,$222,$ac31,$fffe,$180,$103
  dc.w       $ad07,$fffe,$180,$113,$ad31,$fffe,$180,$004

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

;	Effetto della lezione3f.s

  dc.w       $ffdf,$fffe                                               ; ATTENZIONE! WAIT ALLA FINE LINEA $FF!
				; i wait dopo questo sono sotto la linea
				; $FF e ripartono da $00!!

  dc.w       $0107,$FFFE                                               ; una barretta fissa verde SOTTO la linea $FF!
  dc.w       $180,$010
  dc.w       $0207,$FFFE
  dc.w       $180,$020
  dc.w       $0307,$FFFE
  dc.w       $180,$030
  dc.w       $0407,$FFFE
  dc.w       $180,$040
  dc.w       $0507,$FFFE
  dc.w       $180,$030
  dc.w       $0607,$FFFE
  dc.w       $180,$020
  dc.w       $0707,$FFFE
  dc.w       $180,$010
  dc.w       $0807,$FFFE
  dc.w       $180,$000

  ;dc.w       $188,$630
  dc.w       $182,$FF4
  dc.w       $184,$420
  dc.w       $186,$C80

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
