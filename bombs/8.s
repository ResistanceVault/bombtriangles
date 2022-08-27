BOMB8_VERTICAL_START equ 112
BOMB8_VERTICAL_STOP equ BOMB7_VERTICAL_START+31

BOMB8_BPL0:
BOMB8_BPL0_VSTART:  dc.b    BOMB8_VERTICAL_START
BOMB8_BPL0_HSTART:  dc.b    $9c
BOMB8_BPL0_VSTOP:   dc.b    BOMB8_VERTICAL_STOP
                    dc.b    0
                    IFD LOL
                    dc.w    $0000,$0000      ; line 1
                    dc.w    $0080,$0000      ; line 2
                    dc.w    $00C0,$0000      ; line 3
                    dc.w    $0040,$0000      ; line 4
                    dc.w    $0060,$0000      ; line 5
                    dc.w    $0060,$0000      ; line 6
                    dc.w    $0030,$0000      ; line 7
                    dc.w    $0038,$0000      ; line 8
                    dc.w    $003C,$0000      ; line 9
                    dc.w    $0016,$0008      ; line 10
                    dc.w    $0013,$000C      ; line 11
                    dc.w    $0E11,$000E      ; line 12
                    dc.w    $03F4,$000F      ; line 13
                    dc.w    $00C6,$003F      ; line 14
                    dc.w    $0073,$000F      ; line 15
                    dc.w    $0019,$0007      ; line 16
                    dc.w    $0073,$000F      ; line 17
                    dc.w    $03C7,$003F      ; line 18
                    dc.w    $1FE3,$001F      ; line 19
                    dc.w    $0031,$000F      ; line 20
                    dc.w    $0069,$0017      ; line 21
                    dc.w    $00DC,$0023      ; line 22
                    dc.w    $01B4,$0043      ; line 23
                    dc.w    $03C5,$0002      ; line 24
                    dc.w    $0785,$0002      ; line 25
                    dc.w    $0E07,$0000      ; line 26
                    dc.w    $1806,$0000      ; line 27
                    dc.w    $3006,$0000      ; line 28
                    dc.w    $0004,$0000      ; line 29
                    dc.w    $0000,$0000      ; line 30
                    dc.w    $0000,$0000      ; line 31
                    ENDC
                    dc.w    0,0
BOMB8_BPL1:
BOMB8_BPL1_VSTART:  dc.b    BOMB8_VERTICAL_START
BOMB8_BPL1_HSTART:  dc.b    $a4
BOMB8_BPL1_VSTOP:   dc.b    BOMB8_VERTICAL_STOP
                    dc.b    0
                    IFD LOL
                    dc.w    $0004,$0000      ; line 1
                    dc.w    $000C,$0000      ; line 2
                    dc.w    $0018,$0000      ; line 3
                    dc.w    $1030,$0000      ; line 4
                    dc.w    $1070,$0000      ; line 5
                    dc.w    $31E0,$0000      ; line 6
                    dc.w    $33C0,$0000      ; line 7
                    dc.w    $6780,$0000      ; line 8
                    dc.w    $6B00,$0400      ; line 9
                    dc.w    $F606,$0800      ; line 10
                    dc.w    $EC38,$1000      ; line 11
                    dc.w    $C9E0,$3000      ; line 12
                    dc.w    $8E40,$7180      ; line 13
                    dc.w    $2180,$FE00      ; line 14
                    dc.w    $6700,$F800      ; line 15
                    dc.w    $F200,$FC00      ; line 16
                    dc.w    $FB00,$FC00      ; line 17
                    dc.w    $F180,$FE00      ; line 18
                    dc.w    $B4C0,$FB00      ; line 19
                    dc.w    $17E0,$F800      ; line 20
                    dc.w    $4470,$B800      ; line 21
                    dc.w    $E40C,$1800      ; line 22
                    dc.w    $B602,$0800      ; line 23
                    dc.w    $9A00,$0400      ; line 24
                    dc.w    $0E00,$0000      ; line 25
                    dc.w    $0600,$0000      ; line 26
                    dc.w    $0600,$0000      ; line 27
                    dc.w    $0300,$0000      ; line 28
                    dc.w    $0300,$0000      ; line 29
                    dc.w    $0100,$0000      ; line 30
                    dc.w    $0100,$0000      ; line 31
                    ENDC
                    dc.w    0,0
