EXIT:
  jmp             exit_demo

LAST_TRIANGLE_CLEAR:
  SETBEATDELAY    #2
  rts

TRANSITION_CLEAR:
  bsr.w           CLEAR_BPL_4
  bsr.w           CLEAR_BPL_3
  rts

DOUBLETRIANGLEX_CLEAR:
  jsr             RESET_ANGLE_512
  SETBEATDELAY    #10
  rts

DOUBLETRIANGLEY_CLEAR:
  jsr             RESET_ANGLE_512
  move.l          #CLEAR,CLEARFUNCTION
  rts

