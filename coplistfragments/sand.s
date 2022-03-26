; Copperlist fragment to display different shades of the sand
; changing color0 at each scanline

  ;dc.w    $9e07,$FFFE          ; moved on copperlists.s
  ;dc.w    $180,$540
  dc.w    $a007-$0000,$FFFE
  dc.w    $180,$541
  dc.w    $a207-$0000,$FFFE
  dc.w    $180,$651
  dc.w    $a507-$0000,$FFFE
  dc.w    $180,$762
  dc.w    $a807-$0000,$FFFE
  dc.w    $180,$873
  dc.w    $ab07-$0000,$FFFE
  dc.w    $180,$984
  dc.w    $ae07-$0000,$FFFE
  dc.w    $180,$984
  dc.w    $b207-$0000,$FFFE
  dc.w    $180,$a95
  dc.w    $b707-$0000,$FFFE
  dc.w    $180,$ba6
  dc.w    $be07-$0000,$FFFE
  dc.w    $180,$cb7

  ; start platform
  dc.w       $18e,COLORCOPPLATFORM1
  dc.w       $c207-$0000,$FFFE
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
  dc.w       $18e,COLOR3
  ; end plaform

  dc.w    $c807-$0000,$FFFE
  dc.w    $180,$dc7
  dc.w    $d807-$0000,$FFFE
  dc.w    $180,$DC8
