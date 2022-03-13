BOMB4_BPL0:
BOMB4_BPL0_VSTART:  dc.b    $7f
BOMB4_BPL0_HSTART:  dc.b    $a0
BOMB4_BPL0_VSTOP:   dc.b    $8f,$00
                    dc.w    $0000,$0000      ; line 1
                    dc.w    $0000,$0000      ; line 2
                    dc.w    $0040,$0040      ; line 3
                    dc.w    $0080,$0080      ; line 4
                    dc.w    $0100,$0100      ; line 5
                    dc.w    $0100,$0100      ; line 6
                    dc.w    $0000,$0000      ; line 7
                    dc.w    $0000,$0000      ; line 8
                    dc.w    $0200,$0200      ; line 9
                    dc.w    $0400,$0400      ; line 10
                    dc.w    $0000,$0000      ; line 11
                    dc.w    $0000,$0000      ; line 12
                    dc.w    $0000,$0000      ; line 13
                    dc.w    $0000,$0000      ; line 14
                    dc.w    $0000,$0000      ; line 15
                    dc.w    $0000,$0000      ; line 16
                    dc.w    0,0
BOMB4_BPL1:
BOMB4_BPL1_VSTART:  dc.b    $7f
BOMB4_BPL1_HSTART:  dc.b    $a0
BOMB4_BPL1_VSTOP:   dc.b    $8f,%10000000
                    dc.w    $0000,$0000      ; line 1
                    dc.w    $0000,$0000      ; line 2
                    dc.w    $0000,$0000      ; line 3
                    dc.w    $0000,$0000      ; line 4
                    dc.w    $0000,$0000      ; line 5
                    dc.w    $0000,$0000      ; line 6
                    dc.w    $0180,$0000      ; line 7
                    dc.w    $07E0,$0000      ; line 8
                    dc.w    $0FF0,$0000      ; line 9
                    dc.w    $0FF0,$0000      ; line 10
                    dc.w    $1FF8,$0000      ; line 11
                    dc.w    $1FF8,$0000      ; line 12
                    dc.w    $0FF0,$0000      ; line 13
                    dc.w    $0FF0,$0000      ; line 14
                    dc.w    $07E0,$0000      ; line 15
                    dc.w    $0180,$0000      ; line 16
                    dc.w    0,0
