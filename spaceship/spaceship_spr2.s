;SPACESHIP2_BPL0:
;SPACESHIP2_BPL0_VSTART:  dc.b    $30
;SPACESHIP2_BPL0_HSTART   dc.b    $90
;SPACESHIP2_BPL0_VSTOP    dc.b    $3a,$00
;                        dc.w $0300,$0300 ; line 1
;                        dc.w $0E30,$0E30 ; line 2
;                        dc.w $1C70,$1C78 ; line 3
;                        dc.w $0400,$0418 ; line 4
;                        dc.w $31C4,$31F8 ; line 5
;                        dc.w $7FFE,$7FFE ; line 6
;                        dc.w $C71F,$C7E3 ; line 7
;                        dc.w $C71F,$C7E3 ; line 8
;                        dc.w $0016,$0016 ; line 9
;                        dc.w $0008,$0008 ; line 10
;                         dc.w    0,0
;SPACESHIP2_BPL1:
;SPACESHIP2_BPL1_VSTART   dc.b    $30
;SPACESHIP2_BPL1_HSTART   dc.b    $90
;SPACESHIP2_BPL1_VSTOP    dc.b    $3a,%10000000
;	dc.w $0300,$00C0 ; line 1
;	dc.w $0E30,$01F0 ; line 2
;	dc.w $1C78,$03F8 ; line 3
;	dc.w $3DFC,$0218 ; line 4
;	dc.w $31FC,$0FFC ; line 5
;	dc.w $0000,$0000 ; line 6
;	dc.w $C7FC,$3FFC ; line 7
;	dc.w $C7FC,$3FFC ; line 8
;	dc.w $7BD6,$000E ; line 9
;	dc.w $3188,$0004 ; line 10
                         dc.w    0,0


;Spaceship changes, just a note dont uncomment this code
; Bpl1
;dc.w $0820,$0830 ; line 4 -> dc.w $0400,$0418 ; line 4
;dc.w $5800,$5800 ; line 9 -> dc.w $0016,$0016 ; line 9
;dc.w $2000,$2000 ; line 10 -> dc.w $0008,$0008 ; line 10
; Bpl2
;dc.w $3BFC,$0430 ; line 4 -> dc.w $3DFC,$0218 ; line 4
;dc.w $5BDE,$3800 ; line 9 -> dc.w $7BD6,$000E ; line 9
;dc.w $218C,$1000 ; line 10 -> dc.w $3188,$0004 ; line 10

SPACESHIP1_DIFF:
    dc.w $0820,$0830
    dc.w $5800,$5800
    dc.w $2000,$2000

    dc.w $3BFC,$0430
    dc.w    $5BDE,$3800      ; line 9
    dc.w    $218C,$1000      ; line 10

SPACESHIP2_DIFF:
    dc.w $0400,$0418
    dc.w $0016,$0016 ; line 9
    dc.w $0008,$0008 ; line 10

    dc.w $3DFC,$0218
    dc.w $7BD6,$000E ; line 9
	dc.w $3188,$0004 ; line 10
SPACESHIP_DIFF_END: