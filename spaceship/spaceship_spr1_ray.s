SPACESHIP1_BPL0:
SPACESHIP1_BPL0_VSTART:  dc.b    $30
SPACESHIP1_BPL0_HSTART   dc.b    $90
SPACESHIP1_BPL0_VSTOP    dc.b    $3a,$00
                         dc.w    $03C0,$03C0      ; line 1
                         dc.w    $0020,$0420      ; line 2
                         dc.w    $04C0,$0BC0      ; line 3
                         dc.w    $1960,$27E0      ; line 4
                         dc.w    $60B8,$1FF8      ; line 5
                         dc.w    $FE80,$017F      ; line 6
                         dc.w    $1E70,$1E60      ; line 7
                         dc.w    $0640,$0220      ; line 8
                         dc.w    $0380,$0140      ; line 9
                         dc.w    $0100,$0080      ; line 10
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
                         dc.w    $03C0,$0340      ; line 1
                         dc.w    $0420,$0420      ; line 2
                         dc.w    $0FC0,$0FF0      ; line 3
                         dc.w    $3FE0,$3FFC      ; line 4
                         dc.w    $FFFB,$7FFC      ; line 5
                         dc.w    $FFFF,$FFFF      ; line 6
                         dc.w    $019C,$0010      ; line 7
                         dc.w    $05EC,$0460      ; line 8
                         dc.w    $02C0,$02C0      ; line 9
                         dc.w    $0180,$0180      ; line 10
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