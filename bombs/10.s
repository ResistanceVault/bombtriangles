BOMB10_VERTICAL_START equ 112
BOMB10_VERTICAL_STOP  equ BOMB10_VERTICAL_START+31

BOMB10_BPL0:
BOMB10_BPL0_VSTART:  dc.b    BOMB10_VERTICAL_START
BOMB10_BPL0_HSTART:  dc.b    $9c
BOMB10_BPL0_VSTOP:   dc.b    BOMB10_VERTICAL_STOP
                     dc.b    0

                    	dc.w $0000,$0000 ; line 1
	dc.w $0800,$0000 ; line 2
	dc.w $6801,$0000 ; line 3
	dc.w $003C,$0000 ; line 4
	dc.w $00BE,$0000 ; line 5
	dc.w $01F9,$0000 ; line 6
	dc.w $0783,$0000 ; line 7
	dc.w $07A0,$0000 ; line 8
	dc.w $0F43,$0002 ; line 9
	dc.w $1201,$0000 ; line 10
	dc.w $2216,$0000 ; line 11
	dc.w $6200,$0100 ; line 12
	dc.w $7000,$0000 ; line 13
	dc.w $3009,$0000 ; line 14
	dc.w $3802,$0000 ; line 15
	dc.w $0700,$0000 ; line 16
	dc.w $0F24,$0000 ; line 17
	dc.w $0F88,$0000 ; line 18
	dc.w $0F80,$0000 ; line 19
	dc.w $0741,$0000 ; line 20
	dc.w $1701,$0000 ; line 21
	dc.w $1780,$0000 ; line 22
	dc.w $13C0,$0000 ; line 23
	dc.w $09FE,$0002 ; line 24
	dc.w $04FF,$0000 ; line 25
	dc.w $183F,$0000 ; line 26
	dc.w $040F,$0000 ; line 27
	dc.w $47CB,$0000 ; line 28
	dc.w $63C0,$0000 ; line 29
	dc.w $0071,$0000 ; line 30
	dc.w $0000,$0000 ; line 31
                     dc.w    0,0
BOMB10_BPL1:
BOMB10_BPL1_VSTART:  dc.b    BOMB10_VERTICAL_START
BOMB10_BPL1_HSTART:  dc.b    $a4
BOMB10_BPL1_VSTOP:   dc.b    BOMB10_VERTICAL_STOP
                     dc.b    0
                     		dc.w $0000,$0000 ; line 1
	dc.w $0000,$0000 ; line 2
	dc.w $8000,$0000 ; line 3
	dc.w $1000,$0000 ; line 4
	dc.w $7000,$0000 ; line 5
	dc.w $9E40,$0000 ; line 6
	dc.w $CF00,$0000 ; line 7
	dc.w $2FCC,$0C00 ; line 8
	dc.w $E214,$0100 ; line 9
	dc.w $8010,$0000 ; line 10
	dc.w $0018,$0000 ; line 11
	dc.w $04DC,$0000 ; line 12
	dc.w $A0C8,$0000 ; line 13
	dc.w $30E0,$0000 ; line 14
	dc.w $10E0,$0000 ; line 15
	dc.w $1154,$0000 ; line 16
	dc.w $1040,$0000 ; line 17
	dc.w $83C0,$0000 ; line 18
	dc.w $13CC,$0000 ; line 19
	dc.w $01EC,$0000 ; line 20
	dc.w $27EC,$2000 ; line 21
	dc.w $83D8,$0000 ; line 22
	dc.w $0378,$0000 ; line 23
	dc.w $EF08,$0000 ; line 24
	dc.w $CF08,$0000 ; line 25
	dc.w $3AF0,$0000 ; line 26
	dc.w $8CE0,$0000 ; line 27
	dc.w $3CC0,$0000 ; line 28
	dc.w $2490,$0000 ; line 29
	dc.w $E400,$0000 ; line 30
	dc.w $0000,$0000 ; line 31
                     dc.w    0,0
