BOMB9_VERTICAL_START equ 112
BOMB9_VERTICAL_STOP  equ BOMB7_VERTICAL_START+31

BOMB9_BPL0:
BOMB9_BPL0_VSTART:  dc.b    BOMB9_VERTICAL_START
BOMB9_BPL0_HSTART:  dc.b    $9c
BOMB9_BPL0_VSTOP:   dc.b    BOMB9_VERTICAL_STOP
                    dc.b    0

                    dc.w    $0000,$0000             ; line 1
                    dc.w    $0000,$0000             ; line 2
                    dc.w    $0011,$0000             ; line 3
                    dc.w    $0000,$0000             ; line 4
                    dc.w    $0080,$0000             ; line 5
                    dc.w    $0020,$0000             ; line 6
                    dc.w    $0004,$0000             ; line 7
                    dc.w    $0080,$0000             ; line 8
                    dc.w    $0408,$0000             ; line 9
                    dc.w    $0000,$0000             ; line 10
                    dc.w    $0002,$0000             ; line 11
                    dc.w    $0900,$0000             ; line 12
                    dc.w    $0000,$0000             ; line 13
                    dc.w    $0000,$0000             ; line 14
                    dc.w    $2090,$0000             ; line 15
                    dc.w    $0000,$0000             ; line 16
                    dc.w    $0402,$0000             ; line 17
                    dc.w    $0000,$0000             ; line 18
                    dc.w    $0080,$0000             ; line 19
                    dc.w    $0010,$0000             ; line 20
                    dc.w    $0200,$0000             ; line 21
                    dc.w    $0000,$0000             ; line 22
                    dc.w    $0001,$0000             ; line 23
                    dc.w    $0000,$0000             ; line 24
                    dc.w    $0210,$0000             ; line 25
                    dc.w    $0000,$0000             ; line 26
                    dc.w    $0000,$0000             ; line 27
                    dc.w    $0004,$0000             ; line 28
                    dc.w    $0000,$0000             ; line 29
                    dc.w    $0000,$0000             ; line 30
                    dc.w    $0000,$0000             ; line 31
                    dc.w    0,0
BOMB9_BPL1:
BOMB9_BPL1_VSTART:  dc.b    BOMB9_VERTICAL_START
BOMB9_BPL1_HSTART:  dc.b    $a4
BOMB9_BPL1_VSTOP:   dc.b    BOMB9_VERTICAL_STOP
                    dc.b    0

                    dc.w    $0000,$0000             ; line 1
                    dc.w    $4000,$0000             ; line 2
                    dc.w    $0000,$0000             ; line 3
                    dc.w    $0200,$0000             ; line 4
                    dc.w    $4000,$0000             ; line 5
                    dc.w    $1000,$0000             ; line 6
                    dc.w    $0200,$0000             ; line 7
                    dc.w    $4000,$0000             ; line 8
                    dc.w    $0028,$0000             ; line 9
                    dc.w    $0800,$0000             ; line 10
                    dc.w    $0000,$0000             ; line 11
                    dc.w    $4002,$0000             ; line 12
                    dc.w    $0100,$0000             ; line 13
                    dc.w    $9008,$0000             ; line 14
                    dc.w    $0000,$0000             ; line 15
                    dc.w    $0440,$0000             ; line 16
                    dc.w    $2004,$0000             ; line 17
                    dc.w    $0000,$0000             ; line 18
                    dc.w    $2240,$0000             ; line 19
                    dc.w    $0000,$0000             ; line 20
                    dc.w    $8000,$0000             ; line 21
                    dc.w    $0420,$0000             ; line 22
                    dc.w    $0000,$0000             ; line 23
                    dc.w    $0800,$0000             ; line 24
                    dc.w    $0000,$0000             ; line 25
                    dc.w    $0100,$0000             ; line 26
                    dc.w    $8010,$0000             ; line 27
                    dc.w    $0800,$0000             ; line 28
                    dc.w    $0000,$0000             ; line 29
                    dc.w    $4000,$0000             ; line 30
                    dc.w    $0000,$0000             ; line 31
                    dc.w    0,0
