SPACESHIP1_BPL0:
SPACESHIP1_BPL0_VSTART:  dc.b    $30
SPACESHIP1_BPL0_HSTART   dc.b    $90
SPACESHIP1_BPL0_VSTOP    dc.b    $3a,$00
                         dc.w    $0300,$0300      ; line 1
                         dc.w    $0E30,$0E30      ; line 2
                         dc.w    $1C70,$1C78      ; line 3
                         dc.w    $0820,$0830      ; line 4
                         dc.w    $31C4,$31F8      ; line 5
                         dc.w    $7FFE,$7FFE      ; line 6
                         dc.w    $C71F,$C7E3      ; line 7
                         dc.w    $C71F,$C7E3      ; line 8
                         dc.w    $5800,$5800      ; line 9
                         dc.w    $2000,$2000      ; line 10
SPACESHIP1_BPL0_RAY:     dc.w    $0000,$0000      ; line 11
                         dc.w    $0000,$0000      ; line 12
                         dc.w    $0000,$0000      ; line 13
                         dc.w    $0000,$0000      ; line 14
                         dc.w    $0000,$0000      ; line 15
                         dc.w    $0000,$0000      ; line 16
                         dc.w    $0000,$0000      ; line 17
                         dc.w    $0000,$0000      ; line 18
                         dc.w    $0000,$0000      ; line 19
                         dc.w    $0000,$0000      ; line 20
                         dc.w    $0000,$0000      ; line 21
                         dc.w    $0000,$0000      ; line 22
                         dc.w    $0000,$0000      ; line 23
                         dc.w    $0000,$0000      ; line 24
                         dc.w    $0000,$0000      ; line 25
                         dc.w    $0000,$0000      ; line 26
                         dc.w    $0000,$0000      ; line 27
                         dc.w    $0000,$0000      ; line 28
                         dc.w    $0000,$0000      ; line 29
                         dc.w    $0000,$0000      ; line 30
                         dc.w    0,0
SPACESHIP1_BPL1:
SPACESHIP1_BPL1_VSTART   dc.b    $30
SPACESHIP1_BPL1_HSTART   dc.b    $90
SPACESHIP1_BPL1_VSTOP    dc.b    $3a,%10000000
                         dc.w    $0300,$00C0      ; line 1
                         dc.w    $0E30,$01F0      ; line 2
                         dc.w    $1C78,$03F8      ; line 3
                         dc.w    $3BFC,$0430      ; line 4
                         dc.w    $31FC,$0FFC      ; line 5
                         dc.w    $0000,$0000      ; line 6
                         dc.w    $C7FC,$3FFC      ; line 7
                         dc.w    $C7FC,$3FFC      ; line 8
                         dc.w    $5BDE,$3800      ; line 9
                         dc.w    $218C,$1000      ; line 10
SPACESHIP1_BPL1_RAY:     dc.w    $0540,$0540      ; line 11
                         dc.w    $0280,$0280      ; line 12
                         dc.w    $0540,$0540      ; line 13
                         dc.w    $0AA0,$0AA0      ; line 14
                         dc.w    $0540,$0540      ; line 15
                         dc.w    $0AA0,$0AA0      ; line 16
                         dc.w    $1550,$1550      ; line 17
                         dc.w    $0AA0,$0AA0      ; line 18
                         dc.w    $1550,$1550      ; line 19
                         dc.w    $2AA8,$2AA8      ; line 20
                         dc.w    $1550,$1550      ; line 21
                         dc.w    $2AA8,$2AA8      ; line 22
                         dc.w    $5554,$5554      ; line 23
                         dc.w    $2AAA,$2AAA      ; line 24
                         dc.w    $5555,$5555      ; line 25
                         dc.w    $AAAA,$AAAA      ; line 26
                         dc.w    $5555,$5555      ; line 27
                         dc.w    $AAAA,$AAAA      ; line 28
                         dc.w    $5555,$5555      ; line 29
                         dc.w    $AAAA,$AAAA      ; line 30
                         dc.w    0,0
