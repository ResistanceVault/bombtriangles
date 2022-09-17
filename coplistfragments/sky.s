SKY_COL_INDEX EQU $182

    dc.w    SKY_COL_INDEX
SKY_COLOR_1:
    dc.w    $006

    dc.w    $3007,$FFFE
    dc.w    SKY_COL_INDEX
SKY_COLOR_2:
    dc.w    $007

    dc.w    $3407,$FFFE
    dc.w    SKY_COL_INDEX
SKY_COLOR_3:
            dc.w  $008

;    dc.w    $3807,$FFFE
;BIGSPACESHIP_ACTIVE_COLORS:
;    dc.w       $18a,$f00 ; was 182

    dc.w    $3907,$FFFE    ; jump 3 scanlines
    dc.w    SKY_COL_INDEX
SKY_COLOR_4:
    dc.w    $009


    dc.w    $3e07,$FFFE
    dc.w    SKY_COL_INDEX
SKY_COLOR_5:
    dc.w    $00a


    dc.w    $4307,$FFFE
    dc.w    SKY_COL_INDEX
SKY_COLOR_6:
    dc.w $00b            ; blu to 12
