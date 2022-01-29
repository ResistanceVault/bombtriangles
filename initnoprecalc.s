COLOR1 = $0FF4
COLOR2 = $0420
COLOR3 = $0C80


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
  move.w    #COLOR2,$dff190    ; color7
  move.w    #COLOR3,$dff192    ; color8
  move.w    #COLOR2,$dff194    ; color9
  move.w    #COLOR2,$dff196    ; color10
  move.w    #COLOR3,$dff198    ; color11
  move.w    #COLOR3,$dff19a    ; color12
  move.w    #COLOR3,$dff19c    ; color13
  move.w    #COLOR3,$dff19e    ; color14
                        ;movem.l                (sp)+,d0-d7/a0-a6
  rts
