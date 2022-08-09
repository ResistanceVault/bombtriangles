; Copperlist fragment to display different shades of the sand
; changing color at each scanline

SAND_COL_INDEX EQU $182

  dc.w    $a007,$FFFE
  dc.w    SAND_COL_INDEX,$541
  dc.w    $a207,$FFFE
  dc.w    SAND_COL_INDEX,$651
  dc.w    $a507,$FFFE
  dc.w    SAND_COL_INDEX,$762
  dc.w    $a807,$FFFE
  dc.w    SAND_COL_INDEX,$873
  dc.w    $ab07,$FFFE
  dc.w    SAND_COL_INDEX,$984
  dc.w    $ae07,$FFFE
  dc.w    SAND_COL_INDEX,$984
  dc.w    $b207,$FFFE
  dc.w    SAND_COL_INDEX,$a95
  dc.w    $b707,$FFFE
  dc.w    SAND_COL_INDEX,$ba6
  dc.w    $be07,$FFFE
  dc.w    SAND_COL_INDEX,$cb7

  ; start platform
  dc.w       $18e,COLORCOPPLATFORM1
  dc.w       $c207,$FFFE
  dc.w       $18e,COLORCOPPLATFORM2
  dc.w       $c307,$fffe
  dc.w       $18e,COLORCOPPLATFORM3
  dc.w       $c407,$fffe
  dc.w       $18e,COLORCOPPLATFORM4
  dc.w       $c507,$fffe
  dc.w       $18e,COLORCOPPLATFORM5
  dc.w       $c607,$fffe
  dc.w       $18e,COLORCOPPLATFORM6
  dc.w       $c707,$fffe
  dc.w       $18e,COLORCOPPLATFORM1
  ; end plaform

  dc.w       $c807,$FFFE
  dc.w       SAND_COL_INDEX,$dc7

  dc.w       $ca07,$FFFE
  dc.w       $18e,COLORCOPPLATFORM2
  dc.w       $cb07,$FFFE
  dc.w       $18e,COLORCOPPLATFORM3
  dc.w       $cc07,$FFFE
  dc.w       $18e,COLORCOPPLATFORM4
  dc.w       $cd07,$FFFE
  dc.w       $18e,COLORCOPPLATFORM5
  dc.w       $ce07,$FFFE
  dc.w       $18e,COLORCOPPLATFORM6

  dc.w    $d807,$FFFE
  dc.w    SAND_COL_INDEX,$DC8
