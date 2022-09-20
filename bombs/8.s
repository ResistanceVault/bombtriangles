BOMB8_VERTICAL_START equ 112
BOMB8_VERTICAL_STOP equ BOMB8_VERTICAL_START+31

BOMB8_BPL0:
BOMB8_BPL0_VSTART:  dc.b    BOMB8_VERTICAL_START
BOMB8_BPL0_HSTART:  dc.b    $9c
BOMB8_BPL0_VSTOP:   dc.b    BOMB8_VERTICAL_STOP
                    dc.b    0

                    dc.w $0000,$0000 ; line 1
	dc.w $0000,$0000 ; line 2
	dc.w $0004,$0002 ; line 3
	dc.w $0000,$000E ; line 4
	dc.w $0000,$0000 ; line 5
	dc.w $0300,$0083 ; line 6
	dc.w $0600,$0196 ; line 7
	dc.w $0418,$0318 ; line 8
	dc.w $000E,$067F ; line 9
	dc.w $0006,$04F7 ; line 10
	dc.w $0037,$018F ; line 11
	dc.w $106C,$699F ; line 12
	dc.w $104D,$0E3F ; line 13
	dc.w $110F,$08FF ; line 14
	dc.w $0013,$006F ; line 15
	dc.w $0077,$006F ; line 16
	dc.w $00F3,$04EF ; line 17
	dc.w $088F,$079B ; line 18
	dc.w $080F,$143F ; line 19
	dc.w $0C0F,$021F ; line 20
	dc.w $0419,$021F ; line 21
	dc.w $0031,$00F7 ; line 22
	dc.w $0181,$0061 ; line 23
	dc.w $00E1,$0411 ; line 24
	dc.w $0800,$0783 ; line 25
	dc.w $0C04,$0303 ; line 26
	dc.w $0607,$0180 ; line 27
	dc.w $0000,$0000 ; line 28
	dc.w $0000,$0000 ; line 29
	dc.w $0000,$0000 ; line 30
	dc.w $0000,$0000 ; line 31
                    dc.w    0,0
BOMB8_BPL1:
BOMB8_BPL1_VSTART:  dc.b    BOMB8_VERTICAL_START
BOMB8_BPL1_HSTART:  dc.b    $a4
BOMB8_BPL1_VSTOP:   dc.b    BOMB8_VERTICAL_STOP
                    dc.b    0

                   dc.w $0000,$0000 ; line 1
	dc.w $0000,$0000 ; line 2
	dc.w $0000,$0000 ; line 3
	dc.w $0000,$0000 ; line 4
	dc.w $E180,$0600 ; line 5
	dc.w $3880,$C100 ; line 6
	dc.w $0800,$7280 ; line 7
	dc.w $0000,$1E00 ; line 8
	dc.w $0C00,$CC00 ; line 9
	dc.w $3840,$F000 ; line 10
	dc.w $7C60,$F280 ; line 11
	dc.w $7420,$B340 ; line 12
	dc.w $F000,$B540 ; line 13
	dc.w $F800,$FC00 ; line 14
	dc.w $F000,$F800 ; line 15
	dc.w $DF0C,$EFF0 ; line 16
	dc.w $F000,$FC80 ; line 17
	dc.w $A000,$F880 ; line 18
	dc.w $E600,$1880 ; line 19
	dc.w $EC00,$D080 ; line 20
	dc.w $7800,$F180 ; line 21
	dc.w $7800,$7980 ; line 22
	dc.w $1800,$1B80 ; line 23
	dc.w $0800,$0F00 ; line 24
	dc.w $0000,$0620 ; line 25
	dc.w $0030,$8340 ; line 26
	dc.w $8060,$0180 ; line 27
	dc.w $01C0,$0200 ; line 28
	dc.w $0000,$0000 ; line 29
	dc.w $0000,$0000 ; line 30
	dc.w $0000,$0000 ; line 31
                    dc.w    0,0
