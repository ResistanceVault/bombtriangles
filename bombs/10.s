BOMB10_VERTICAL_START equ 112
BOMB10_VERTICAL_STOP  equ BOMB7_VERTICAL_START+31

BOMB10_BPL0:
BOMB10_BPL0_VSTART:  dc.b    BOMB10_VERTICAL_START
BOMB10_BPL0_HSTART:  dc.b    $9c
BOMB10_BPL0_VSTOP:   dc.b    BOMB10_VERTICAL_STOP
                     dc.b    0

                     dc.w    $0000,$0000              ; line 1
                     dc.w    $0000,$0000              ; line 2
                     dc.w    $0000,$0000              ; line 3
                     dc.w    $0002,$0002              ; line 4
                     dc.w    $0020,$0020              ; line 5
                     dc.w    $0200,$0200              ; line 6
                     dc.w    $0000,$0000              ; line 7
                     dc.w    $0000,$0000              ; line 8
                     dc.w    $0002,$0002              ; line 9
                     dc.w    $0820,$0820              ; line 10
                     dc.w    $0100,$0100              ; line 11
                     dc.w    $0000,$0000              ; line 12
                     dc.w    $0010,$0010              ; line 13
                     dc.w    $0000,$0000              ; line 14
                     dc.w    $2000,$2000              ; line 15
                     dc.w    $0042,$0042              ; line 16
                     dc.w    $0000,$0000              ; line 17
                     dc.w    $0000,$0000              ; line 18
                     dc.w    $0208,$0208              ; line 19
                     dc.w    $0000,$0000              ; line 20
                     dc.w    $0000,$0000              ; line 21
                     dc.w    $0000,$0000              ; line 22
                     dc.w    $2102,$2102              ; line 23
                     dc.w    $0010,$0010              ; line 24
                     dc.w    $0000,$0000              ; line 25
                     dc.w    $0000,$0000              ; line 26
                     dc.w    $0091,$0091              ; line 27
                     dc.w    $0000,$0000              ; line 28
                     dc.w    $0000,$0000              ; line 29
                     dc.w    $0000,$0000              ; line 30
                     dc.w    $0000,$0000              ; line 31
                     dc.w    0,0
BOMB10_BPL1:
BOMB10_BPL1_VSTART:  dc.b    BOMB10_VERTICAL_START
BOMB10_BPL1_HSTART:  dc.b    $a4
BOMB10_BPL1_VSTOP:   dc.b    BOMB10_VERTICAL_STOP
                     dc.b    0
                     dc.w    $8000,$8000              ; line 1
                     dc.w    $0000,$0000              ; line 2
                     dc.w    $0400,$0400              ; line 3
                     dc.w    $1000,$1000              ; line 4
                     dc.w    $0100,$0100              ; line 5
                     dc.w    $0000,$0000              ; line 6
                     dc.w    $0400,$0400              ; line 7
                     dc.w    $8000,$8000              ; line 8
                     dc.w    $0000,$0000              ; line 9
                     dc.w    $1000,$1000              ; line 10
                     dc.w    $0208,$0208              ; line 11
                     dc.w    $0000,$0000              ; line 12
                     dc.w    $1000,$1000              ; line 13
                     dc.w    $8000,$8000              ; line 14
                     dc.w    $0104,$0104              ; line 15
                     dc.w    $0000,$0000              ; line 16
                     dc.w    $0020,$0020              ; line 17
                     dc.w    $0000,$0000              ; line 18
                     dc.w    $2200,$2200              ; line 19
                     dc.w    $0000,$0000              ; line 20
                     dc.w    $0020,$0020              ; line 21
                     dc.w    $0000,$0000              ; line 22
                     dc.w    $0400,$0400              ; line 23
                     dc.w    $0000,$0000              ; line 24
                     dc.w    $0000,$0000              ; line 25
                     dc.w    $0040,$0040              ; line 26
                     dc.w    $2400,$2400              ; line 27
                     dc.w    $0000,$0000              ; line 28
                     dc.w    $0000,$0000              ; line 29
                     dc.w    $2000,$2000              ; line 30
                     dc.w    $0000,$0000              ; line 31
                     dc.w    0,0
