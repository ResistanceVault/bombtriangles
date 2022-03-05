COLOR1 = $0FF4
COLOR2 = $0420
COLOR3 = $0C80

COLORCOPPLATFORM1 = $0FF0
COLORCOPPLATFORM2 = $0FD0
COLORCOPPLATFORM3 = $0FC0
COLORCOPPLATFORM4 = $0FA0
COLORCOPPLATFORM5 = $0F80
COLORCOPPLATFORM6 = $0F50
COLORCOPPLATFORM7 = $0F30

_ammxmainloop3_init:
                        ;movem.l                d0-d7/a0-a6,-(sp)
                        ; set palette
  move.w    #COLOR1,$dff182    ; color1
  move.w    #COLOR2,$dff184    ; color2
  move.w    #COLOR3,$dff186    ; color3
  move.w    #COLOR1,$dff188    ; color4
  move.w    #COLOR1,$dff18A    ; color5
  move.w    #COLOR2,$dff18C    ; color6
  move.w    #COLOR3,$dff18E    ; color7
  move.w    #COLOR2,$dff190    ; color8
  move.w    #COLOR3,$dff192    ; color9
  move.w    #COLOR2,$dff194    ; color10
  move.w    #COLOR2,$dff196    ; color11
  move.w    #COLOR3,$dff198    ; color12
  move.w    #COLOR3,$dff19a    ; color13
  move.w    #COLOR3,$dff19c    ; color14
  move.w    #COLOR3,$dff19e    ; color15
                        ;movem.l                (sp)+,d0-d7/a0-a6
  rts
