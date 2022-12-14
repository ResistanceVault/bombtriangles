start	



	lea	player(pc),a6
	lea	myPlayer,a0
	lea	mySong,a1
	lea	song0,a2
	add.l	(0,a6),a6
	jsr	(a6)		; songInit returns in D0 needed chipmem size

	lea	player(pc),a6
	lea	myPlayer,a0
	lea	chipmem,a1
	lea	mySong,a2
	add.l	(4,a6),a6
	jsr	(a6)		; playerInit

	lea	player(pc),a6
	lea	myPlayer,a0
	moveq	#64,d0			; volume (0-64)
	add.l	(24,a6),a6
	jsr	(a6)		; setVolume


loop	btst	#6,$bfe001
	beq	.exit
	btst	#10,$dff016
	beq	playfx
	beq	nextsong
	jsr	waitVbl
	lea	player(pc),a6
	lea	myPlayer,a0
	add.l	(8,a6),a6
	jsr	(a6)		; playerTick
	bra	loop
.exit	rts

playfx	add.l	#1,currentFx
	cmp.l	#15,currentFx
	blt	.ok
	clr.l	currentFx
.ok	lea	player(pc),a6
	lea	myPlayer,a0
	moveq	#3,d0			; channel (0-3)
	move.l	currentFx(pc),d1 	; fx
	moveq	#50,d2			; duration (frames to mute music on channel)
	moveq	#64,d3			; volume (0-64)
	add.l	(16,a6),a6
	jsr	(a6)		; playFx
waitR	btst	#10,$dff016
	beq	waitR
	bra	loop

nextsong
	add.l	#1,currentSong
	cmp.l	#14,currentSong
	blt	.ok
	clr.l	currentSong
.ok	lea	player(pc),a6
	lea	myPlayer,a0
	add.l	(20,a6),a6
	jsr	(a6)		; stop

	lea	player(pc),a6
	lea	myPlayer,a0
	move.l	currentSong,d0
	add.l	(12,a6),a6
	jsr	(a6)		; start song
	bra	waitR
		

currentSong	dc.l	0
currentFx	dc.l	0

waitVbl	
.0	move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0
	beq	.0

.1	move.l	$dff004,d0
	and.l	#$1ff00,d0
	cmp.l	#303<<8,d0
	bne	.1
	rts

	incdir  "hd0:sources/"
player	incbin	"player.bin"
song0	incbin	"tinyus.prt"

	section bss,bss
mySong	ds.w	2048/2
myPlayer	ds.l	8*1024/4

	section	chip,bss_c
chipmem	ds.b	128*1024 ; in a real production you should use the returned size of songInit()
