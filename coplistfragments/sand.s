  IFD     BLUESAND
  dc.w    $9e07,$FFFE          ; prossima linea
  dc.w    $180,$006            ; blu a 6
  dc.w    $a007-$0000,$FFFE    ; salto 2 linee
  dc.w    $180,$007            ; blu a 7
  dc.w    $a207-$0000,$FFFE    ; sato 2 linee
  dc.w    $180,$008            ; blu a 8
  dc.w    $a507-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$009            ; blu a 9
  dc.w    $a807-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$00a            ; blu a 10
  dc.w    $ab07-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$00b            ; blu a 11
  dc.w    $ae07-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$00c            ; blu a 12
  dc.w    $b207-$0000,$FFFE    ; salto 4 linee
  dc.w    $180,$00d            ; blu a 13
  dc.w    $b707-$0000,$FFFE    ; salto 7 linee
  dc.w    $180,$00e            ; blu a 14
  dc.w    $be07-$0000,$FFFE    ; salto 6 linee
  dc.w    $180,$00f            ; blu a 15
  dc.w    $c807-$0000,$FFFE    ; salto 10 linee
  dc.w    $180,$11F            ; schiarisco...
  dc.w    $d807-$0000,$FFFE    ; salto 16 linee
  dc.w    $180,$22F            ; schiarisco...
  ELSE
  dc.w    $9e07,$FFFE          ; prossima linea
  dc.w    $180,$540            ; blu a 6
  dc.w    $a007-$0000,$FFFE    ; salto 2 linee
  dc.w    $180,$541            ; blu a 7
  dc.w    $a207-$0000,$FFFE    ; sato 2 linee
  dc.w    $180,$651            ; blu a 8
  dc.w    $a507-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$762            ; blu a 9
  dc.w    $a807-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$873            ; blu a 10
  dc.w    $ab07-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$984            ; blu a 11
  dc.w    $ae07-$0000,$FFFE    ; salto 3 linee
  dc.w    $180,$984            ; blu a 12
  dc.w    $b207-$0000,$FFFE    ; salto 4 linee
  dc.w    $180,$a95            ; blu a 13
  dc.w    $b707-$0000,$FFFE    ; salto 7 linee
  dc.w    $180,$ba6            ; blu a 14
  dc.w    $be07-$0000,$FFFE    ; salto 6 linee
  dc.w    $180,$cb7            ; blu a 15
  dc.w    $c807-$0000,$FFFE    ; salto 10 linee
  dc.w    $180,$dc7            ; schiarisco...
  dc.w    $d807-$0000,$FFFE    ; salto 16 linee
  dc.w    $180,$DC8            ; schiarisco...
  ENDC