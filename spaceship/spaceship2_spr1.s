SPACESHIP2_BPL0:
SPACESHIP2_BPL0_VSTART:  dc.b    $00
SPACESHIP2_BPL0_HSTART:  dc.b    $92
SPACESHIP2_BPL0_VSTOP:   dc.b    $00,$00

                         ; Start of spaceship data
SPACESHIP2_BPL0_DATA:    dc.w    $03C0,$03C0     ; line 1
                         dc.w    $0020,$0420     ; line 2
                         dc.w    $04C0,$0BC0     ; line 3
                         dc.w    $1960,$27E0     ; line 4
                         dc.w    $60B8,$1FF8     ; line 5
                         dc.w    $FE80,$017F     ; line 6
                         dc.w    $1E70,$1E60     ; line 7
                         dc.w    $0640,$0220     ; line 8
                         dc.w    $0380,$0140     ; line 9
                         dc.w    $0100,$0080     ; line 10

SPACESHIP2_BPL0_BOMB:
                         ; Start of bomb data
                         ;dc.w    $0840,$0210    ; line 1
                         ;dc.w    $00A4,$2500    ; line 2
                         ;dc.w    $9540,$02A9    ; line 3
                         ;dc.w    $23A0,$05C4    ; line 4
                         ;dc.w    $01C8,$1380    ; line 5
                         ;dc.w    $24C0,$0024    ; line 6
                         dc.w    $0060,$0010     ; line 7
                         dc.w    $0660,$0618     ; line 8
                         dc.w    $0C60,$0C18     ; line 9
                         dc.w    $08E0,$081C     ; line 10
                         dc.w    $08C4,$083C     ; line 11
                         dc.w    $01CC,$003C     ; line 12
                         dc.w    $0788,$0078     ; line 13
                         dc.w    $1F18,$00F8     ; line 14
                         dc.w    $0C30,$03F0     ; line 15
                         dc.w    $00C0,$03C0     ; line 16

                         dc.w    0,0
SPACESHIP2_BPL1:
SPACESHIP2_BPL1_VSTART:  dc.b    $0
SPACESHIP2_BPL1_HSTART:  dc.b    $92
SPACESHIP2_BPL1_VSTOP:   dc.b    $0,%10000000

                         ; Start of spaceship data
SPACESHIP2_BPL1_DATA :   dc.w    $03C0,$0340     ; line 1
                         dc.w    $0420,$0420     ; line 2
                         dc.w    $0FC0,$0FF0     ; line 3
                         dc.w    $3FE0,$3FFC     ; line 4
                         dc.w    $FFFB,$7FFC     ; line 5
                         dc.w    $FFFF,$FFFF     ; line 6
                         dc.w    $019C,$0010     ; line 7
                         dc.w    $05EC,$0460     ; line 8
                         dc.w    $02C0,$02C0     ; line 9
                         dc.w    $0180,$0180     ; line 10

SPACESHIP2_BPL1_BOMB:
                         ; Start of bomb data
                         ;dc.w    $0000,$0000    ; line 1
                         ;dc.w    $0000,$0000    ; line 2
                         ;dc.w    $0000,$0000    ; line 3
                         ;dc.w    $0000,$0000    ; line 4
                         ;dc.w    $0000,$0000    ; line 5
                         ;dc.w    $03C0,$0000    ; line 6
                         dc.w    $0FF0,$0000     ; line 7
                         dc.w    $1FF8,$0000     ; line 8
                         dc.w    $1FF8,$0000     ; line 9
                         dc.w    $3FFC,$0000     ; line 10
                         dc.w    $3FF8,$0000     ; line 11
                         dc.w    $3FF0,$0000     ; line 12
                         dc.w    $1FF0,$0000     ; line 13
                         dc.w    $1FE0,$0000     ; line 14
                         dc.w    $0FC0,$0000     ; line 15
                         dc.w    $0300,$0000     ; line 16

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