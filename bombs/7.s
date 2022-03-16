BOMB7_VERTICAL_START equ 112
BOMB7_VERTICAL_STOP equ BOMB7_VERTICAL_START+31

BOMB7_BPL0:
BOMB7_BPL0_VSTART:  dc.b    BOMB7_VERTICAL_START
BOMB7_BPL0_HSTART:  dc.b    $90
BOMB7_BPL0_VSTOP:   dc.b    BOMB7_VERTICAL_STOP
                    dc.b    $00

                    dc.w    $0000,$0000      ; line 1
                    dc.w    $0002,$0001      ; line 2
                    dc.w    $0007,$0000      ; line 3
                    dc.w    $0007,$0000      ; line 4
                    dc.w    $0007,$0019      ; line 5
                    dc.w    $000B,$0036      ; line 6
                    dc.w    $001F,$002C      ; line 7
                    dc.w    $001F,$0033      ; line 8
                    dc.w    $003F,$0024      ; line 9
                    dc.w    $003F,$0048      ; line 10
                    dc.w    $003F,$0048      ; line 11
                    dc.w    $001F,$0063      ; line 12
                    dc.w    $00CF,$003C      ; line 13
                    dc.w    $00EF,$0118      ; line 14
                    dc.w    $007F,$01BC      ; line 15
                    dc.w    $003F,$00E6      ; line 16
                    dc.w    $003F,$0000      ; line 17
                    dc.w    $001F,$0021      ; line 18
                    dc.w    $000F,$0012      ; line 19
                    dc.w    $0007,$001A      ; line 20
                    dc.w    $0007,$0001      ; line 21
                    dc.w    $0000,$0001      ; line 22
                    dc.w    $0000,$0000      ; line 23
                    dc.w    $0001,$0000      ; line 24
                    dc.w    $0001,$0000      ; line 25
                    dc.w    $0001,$0000      ; line 26
                    dc.w    $0000,$0000      ; line 27
                    dc.w    $0000,$0000      ; line 28
                    dc.w    $0000,$0000      ; line 29
                    dc.w    $0000,$0000      ; line 30
                    dc.w    $0000,$0000      ; line 31
                    dc.w    0,0
BOMB7_BPL1:
BOMB7_BPL1_VSTART:  dc.b    BOMB7_VERTICAL_START
BOMB7_BPL1_HSTART:  dc.b    $98
BOMB7_BPL1_VSTOP:   dc.b    BOMB7_VERTICAL_STOP
                    dc.b    0

                    dc.w    $0000,$0000      ; line 1
                    dc.w    $0000,$C000      ; line 2
                    dc.w    $C000,$2000      ; line 3
                    dc.w    $E000,$D000      ; line 4
                    dc.w    $E000,$3000      ; line 5
                    dc.w    $F400,$0800      ; line 6
                    dc.w    $EE00,$1000      ; line 7
                    dc.w    $DE00,$2700      ; line 8
                    dc.w    $FF00,$8180      ; line 9
                    dc.w    $FF00,$0180      ; line 10
                    dc.w    $FF00,$3280      ; line 11
                    dc.w    $FF00,$0880      ; line 12
                    dc.w    $FE00,$0500      ; line 13
                    dc.w    $FC00,$0600      ; line 14
                    dc.w    $F800,$4800      ; line 15
                    dc.w    $F000,$3C00      ; line 16
                    dc.w    $F800,$0600      ; line 17
                    dc.w    $F800,$0600      ; line 18
                    dc.w    $D000,$2C00      ; line 19
                    dc.w    $E000,$9000      ; line 20
                    dc.w    $B000,$4800      ; line 21
                    dc.w    $7000,$9800      ; line 22
                    dc.w    $E000,$7000      ; line 23
                    dc.w    $A000,$4000      ; line 24
                    dc.w    $6000,$8000      ; line 25
                    dc.w    $A000,$C000      ; line 26
                    dc.w    $F000,$0000      ; line 27
                    dc.w    $1800,$2000      ; line 28
                    dc.w    $0800,$0000      ; line 29
                    dc.w    $1000,$0000      ; line 30
                    dc.w    $0000,$0000      ; line 31
                    dc.w    0,0
