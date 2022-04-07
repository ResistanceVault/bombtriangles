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
                         dc.w    0,0


;Spaceship palette, just a note dont uncomment this code
;dc.w    $1a0,$bfc    ; color transparency
;dc.w    $1a2,$f0f    ; color17
;dc.w    $1a4,$f0f    ; color18
;dc.w    $1a6,$000    ; color19
;dc.w    $1a8,$f00    ; color20
;dc.w    $1aa,$f0f    ; color21
;dc.w    $1ac,$f0f    ; color22
;dc.w    $1ae,$fff    ; color23
;dc.w    $1b0,$ddd    ; color24
;dc.w    $1b2,$f0f    ; color25
;dc.w    $1b4,$f0f    ; color26
;dc.w    $1b6,$f0f    ; color27
;dc.w    $1b8,$f0f    ; color28
;dc.w    $1ba,$555    ; color29
;dc.w    $1bc,$888    ; color30
;dc.w    $1be,$bbb    ; color31