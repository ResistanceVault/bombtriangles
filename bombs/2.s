BOMB2_BPL0:
BOMB2_BPL0_VSTART:  dc.b    $7f
BOMB2_BPL0_HSTART:  dc.b    $a0
BOMB2_BPL0_VSTOP:   dc.b    $8f,$00
                    dc.w    $0808,$0140      ; line 1
                    dc.w    $0220,$0080      ; line 2
                    dc.w    $0080,$0948      ; line 3
                    dc.w    $0220,$0080      ; line 4
                    dc.w    $1004,$0140      ; line 5
                    dc.w    $0040,$00C0      ; line 6
                    dc.w    $0270,$0000      ; line 7
                    dc.w    $0660,$0618      ; line 8
                    dc.w    $0C60,$0C18      ; line 9
                    dc.w    $08E0,$081C      ; line 10
                    dc.w    $08C4,$083C      ; line 11
                    dc.w    $01CC,$003C      ; line 12
                    dc.w    $0788,$0078      ; line 13
                    dc.w    $1F18,$00F8      ; line 14
                    dc.w    $0C30,$03F0      ; line 15
                    dc.w    $00C0,$03C0      ; line 16
                    dc.w    0,0
BOMB2_BPL1:
BOMB2_BPL1_VSTART:  dc.b    $7f
BOMB2_BPL1_HSTART:  dc.b    $a0
BOMB2_BPL1_VSTOP:   dc.b    $8f,%10000000
                    dc.w    $0000,$0000      ; line 1
                    dc.w    $0000,$0000      ; line 2
                    dc.w    $0000,$0000      ; line 3
                    dc.w    $0000,$0000      ; line 4
                    dc.w    $0000,$0000      ; line 5
                    dc.w    $0380,$0000      ; line 6
                    dc.w    $0DE0,$0000      ; line 7
                    dc.w    $1FF8,$0000      ; line 8
                    dc.w    $1FF8,$0000      ; line 9
                    dc.w    $3FFC,$0000      ; line 10
                    dc.w    $3FF8,$0000      ; line 11
                    dc.w    $3FF0,$0000      ; line 12
                    dc.w    $1FF0,$0000      ; line 13
                    dc.w    $1FE0,$0000      ; line 14
                    dc.w    $0FC0,$0000      ; line 15
                    dc.w    $0300,$0000      ; line 16
                    dc.w    0,0
