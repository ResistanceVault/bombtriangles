EXIT:
  jmp             exit_demo

LAST_TRIANGLE_CLEAR:
  SETBEATDELAY    #2
  rts

TRANSITION_CLEAR:
  bsr.w           CLEAR_BPL_4
  bsr.w           CLEAR_BPL_3
  rts

