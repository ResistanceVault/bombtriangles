    dc.w    $180,$006
    dc.w    $3007,$FFFE
    dc.w    $180,$007
    dc.w    $3207,$FFFE
    dc.w    $180,$008
    dc.w    $3507,$FFFE    ; salto 3 linee
    dc.w    $180,$009            ; blu a 9
    dc.w    $3807,$FFFE    ; salto 3 linee
    dc.w    $180,$00a            ; blu a 10
    dc.w    $3b07,$FFFE    ; salto 3 linee
    dc.w    $180,$00b            ; blu a 11
    dc.w    $3e07,$FFFE    ; salto 3 linee
    dc.w    $180,$00c            ; blu a 12
    dc.w    $4207,$FFFE    ; salto 4 linee
    include "coplistfragments/pyramidcolors.s"
    dc.w    $180,$00d            ; blu a 13
    dc.w    $4707,$FFFE    ; salto 7 linee
    dc.w    $180,$00e            ; blu a 14
        IFD LOL

    dc.w    $4e07,$FFFE    ; salto 6 linee
    dc.w    $180,$00f            ; blu a 15
    dc.w    $4807,$FFFE    ; salto 10 linee
    dc.w    $180,$11F            ; schiarisco...
    dc.w    $4807,$FFFE    ; salto 16 linee
    dc.w    $180,$22F            ; schiarisco...
    ENDC