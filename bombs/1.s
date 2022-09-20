BOMB1_BPL0:
BOMB1_BPL0_VSTART:  dc.b    $80
BOMB1_BPL0_HSTART:  dc.b    $9f
BOMB1_BPL0_VSTOP:   dc.b    $90,$01
                    dc.w $0244,$0244 ; line 1
                    dc.w $0000,$0008 ; line 2
                    dc.w $4002,$42A2 ; line 3
                    dc.w $0860,$0968 ; line 4
                    dc.w $1084,$10A4 ; line 5
                    dc.w $0080,$0080 ; line 6
                    dc.w $0AA8,$0BE8 ; line 7
                    dc.w $0450,$0E78 ; line 8
                    dc.w $05D0,$0AA8 ; line 9
                    dc.w $15D4,$1AAC ; line 10
                    dc.w $0D58,$0E38 ; line 11
                    dc.w $07F0,$0FF8 ; line 12
                    dc.w $0550,$0A28 ; line 13
                    dc.w $0550,$0A28 ; line 14
                    dc.w $0550,$0A28 ; line 15
                    dc.w $0140,$0000 ; line 16
                    dc.w    0,0

BOMB1_BPL1:
BOMB1_BPL1_VSTART:  dc.b    $80
BOMB1_BPL1_HSTART:  dc.b    $9f
BOMB1_BPL1_VSTOP:   dc.b	$90,%10000001
                    dc.w $0000,$0244 ; line 1
                    dc.w $0000,$0000 ; line 2
                    dc.w $0000,$4002 ; line 3
                    dc.w $0020,$0800 ; line 4
                    dc.w $0000,$1004 ; line 5
                    dc.w $0140,$0000 ; line 6
                    dc.w $0550,$0A28 ; line 7
                    dc.w $0BA8,$0450 ; line 8
                    dc.w $0A28,$0080 ; line 9
                    dc.w $0A28,$0080 ; line 10
                    dc.w $02A0,$0000 ; line 11
                    dc.w $0888,$0000 ; line 12
                    dc.w $0AA8,$0000 ; line 13
                    dc.w $0AA8,$0000 ; line 14
                    dc.w $0AA8,$0000 ; line 15
                    dc.w $0080,$0000 ; line 16
                    dc.w    0,0
