BOMB9_VERTICAL_START equ 112
BOMB9_VERTICAL_STOP  equ BOMB9_VERTICAL_START+31

BOMB9_BPL0:
BOMB9_BPL0_VSTART:  dc.b    BOMB9_VERTICAL_START
BOMB9_BPL0_HSTART:  dc.b    $9c
BOMB9_BPL0_VSTOP:   dc.b    BOMB9_VERTICAL_STOP
                    dc.b    0

                   dc.w $0000,$0000 ; line 1
	dc.w $0000,$0000 ; line 2
	dc.w $0419,$0000 ; line 3
	dc.w $183E,$0100 ; line 4
	dc.w $1100,$020C ; line 5
	dc.w $0180,$0400 ; line 6
	dc.w $0A04,$0100 ; line 7
	dc.w $1800,$0200 ; line 8
	dc.w $005E,$0040 ; line 9
	dc.w $00B8,$0006 ; line 10
	dc.w $0010,$042C ; line 11
	dc.w $040E,$003E ; line 12
	dc.w $001C,$0150 ; line 13
	dc.w $0038,$0F38 ; line 14
	dc.w $3238,$2F38 ; line 15
	dc.w $3003,$0D43 ; line 16
	dc.w $3013,$0413 ; line 17
	dc.w $0006,$0046 ; line 18
	dc.w $0226,$01E0 ; line 19
	dc.w $0706,$0004 ; line 20
	dc.w $00E0,$00A0 ; line 21
	dc.w $01F1,$0030 ; line 22
	dc.w $00F2,$0012 ; line 23
	dc.w $0360,$0009 ; line 24
	dc.w $0000,$0001 ; line 25
	dc.w $4000,$1003 ; line 26
	dc.w $0040,$0003 ; line 27
	dc.w $0400,$0000 ; line 28
	dc.w $0038,$0200 ; line 29
	dc.w $0002,$0800 ; line 30
	dc.w $0000,$0000 ; line 31
                    dc.w    0,0
BOMB9_BPL1:
BOMB9_BPL1_VSTART:  dc.b    BOMB9_VERTICAL_START
BOMB9_BPL1_HSTART:  dc.b    $a4
BOMB9_BPL1_VSTOP:   dc.b    BOMB9_VERTICAL_STOP
                    dc.b    0

                  	dc.w $0000,$0000 ; line 1
	dc.w $E100,$0000 ; line 2
	dc.w $F000,$0000 ; line 3
	dc.w $F000,$0600 ; line 4
	dc.w $0060,$0000 ; line 5
	dc.w $0070,$3180 ; line 6
	dc.w $8250,$F8C0 ; line 7
	dc.w $D000,$FC40 ; line 8
	dc.w $7B80,$3000 ; line 9
	dc.w $0380,$4800 ; line 10
	dc.w $0380,$0000 ; line 11
	dc.w $0D30,$0C00 ; line 12
	dc.w $7CA0,$7C24 ; line 13
	dc.w $5C7C,$5D80 ; line 14
	dc.w $0D70,$0980 ; line 15
	dc.w $4E70,$4040 ; line 16
	dc.w $4000,$4020 ; line 17
	dc.w $4500,$4500 ; line 18
	dc.w $5B90,$4B80 ; line 19
	dc.w $3D80,$3980 ; line 20
	dc.w $7870,$1800 ; line 21
	dc.w $6260,$0300 ; line 22
	dc.w $0200,$0040 ; line 23
	dc.w $1880,$9800 ; line 24
	dc.w $0180,$4000 ; line 25
	dc.w $230C,$F060 ; line 26
	dc.w $1038,$10C0 ; line 27
	dc.w $0270,$0180 ; line 28
	dc.w $0860,$0180 ; line 29
	dc.w $18E0,$0100 ; line 30
	dc.w $00E0,$0000 ; line 31
	dc.w $0000,$0000 ; line 32
                    dc.w    0,0
