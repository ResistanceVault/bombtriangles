COLOR1            = $0FF4
COLOR2            = $0420
COLOR3            = $0C80

COLORCOPPLATFORM1 = $0FF0
COLORCOPPLATFORM2 = $0FD0
COLORCOPPLATFORM3 = $0FC0
COLORCOPPLATFORM4 = $0FA0
COLORCOPPLATFORM5 = $0F80
COLORCOPPLATFORM6 = $0F50
COLORCOPPLATFORM7 = $0F30

_ammxmainloop3_init:
                        ; set palette
  lea       $dff182,a0
  move.w    #COLOR1,(a0)+    ; color1
  move.w    #COLOR2,(a0)+    ; color2
  move.w    #COLOR3,(a0)+    ; color3
  move.w    #COLOR1,(a0)+    ; color4
  move.w    #COLOR1,(a0)+    ; color5
  move.w    #COLOR2,(a0)+    ; color6
  move.w    #COLOR3,(a0)+    ; color7
  move.w    #COLOR2,(a0)+    ; color8
  move.w    #COLOR3,(a0)+    ; color9
  move.w    #COLOR2,(a0)+    ; color10
  move.w    #COLOR2,(a0)+    ; color11
  move.w    #COLOR3,(a0)+    ; color12
  move.w    #COLOR3,(a0)+    ; color13
  move.w    #COLOR3,(a0)+    ; color14
  move.w    #COLOR3,(a0)+    ; color15


    ;move.w    $1a0,$bfc    ; color transparency
    ; start of sprite colors
  lea        $dff1a2,a0
  move.l     #$0a200ff0,(a0)+
  ;move.w    #$a20,(a0)+        ; color17
  ;move.w    #$ff0,(a0)+        ; color18

  move.l     #$00000f00,(a0)+
  ;move.w    #$000,(a0)+        ; color19
  ;move.w    #$f00,(a0)+        ; color20

  move.l    #$0c000800,(a0)+
  ;move.w    #$c00,(a0)+        ; color21
  ;move.w    #$800,(a0)+        ; color22

  move.l    #$0fff0ddd,(a0)+
  ;move.w    #$fff,(a0)+        ; color23
  ;move.w    #$ddd,(a0)+        ; color24

  move.l    #$0f0a0fe0,(a0)+    ; color25 ; sprites 4 and 5 (bomb) color 1 and 2

  move.l    #$0f060f0f,(a0)+
  ;move.w    #$f06,(a0)+        ; color27 ; sprites 4 and 5 (bomb) color 3
  ;move.w    #$f0f,(a0)+        ; color28
  move.l    #$05550888,(a0)+
  ;move.w    #$555,(a0)+        ; color29
  ;move.w    #$888,(a0)+        ; color30
  
  move.w    #$bbb,(a0)+        ; color31
  rts
