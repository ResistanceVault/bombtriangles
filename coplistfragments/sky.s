    dc.w    $180
SKY_COLOR_1:
    dc.w    $006

    dc.w    $3007,$FFFE
    dc.w    $180
SKY_COLOR_2:
    dc.w    $007

    dc.w    $3207,$FFFE
    dc.w    $180
SKY_COLOR_3:
            dc.w  $008
    dc.w    $3507,$FFFE    ; jump 3 scanlines
    dc.w    $180
SKY_COLOR_4:
    dc.w    $009

    dc.w    $3807,$FFFE    ; salto 3 linee
    dc.w    $180
SKY_COLOR_5:
            dc.w $00a            ; blu a 10
    dc.w    $3b07,$FFFE    ; salto 3 linee
    dc.w    $180
SKY_COLOR_6:    dc.w $00b            ; blu a 11

BIGSPACESHIP_ACTIVE_COLORS:
            dc.w       $182,$fff
            dc.w       $184,$ddd
            dc.w       $186,$bbb
            dc.w       $188,$888

    dc.w    $3e07,$FFFE    ; salto 3 linee
    dc.w    $180
SKY_COLOR_7: dc.w $00c            ; blu a 12

    dc.w    $4207,$FFFE    ; salto 4 linee
    include "coplistfragments/pyramidcolors.s"
    dc.w    $180
SKY_COLOR_8:    dc.w $00d            ; blu a 13
    dc.w    $4707,$FFFE    ; salto 7 linee
    dc.w    $180
SKY_COLOR_9:    dc.w $00e            ; blu a 14
        IFD LOL

    dc.w    $4e07,$FFFE    ; salto 6 linee
    dc.w    $180,
SKY_COLOR_10:    dc.w $00f            ; blu a 15
    dc.w    $4807,$FFFE    ; salto 10 linee
    dc.w    $180
SKY_COLOR_11:    dc.w $11F            ; schiarisco...
    dc.w    $4807,$FFFE    ; salto 16 linee
    dc.w    $180
SKY_COLOR_12: dc.w  $22F            ; schiarisco...
    ENDC