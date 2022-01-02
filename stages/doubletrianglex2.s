DOUBLETRIANGLEX:
  movem.l         d0-d7/a0-a6,-(sp)

  move.w          #%0010001000000000,BPLCON0POINTER
  move.l          #CLEAR,CLEARFUNCTION

  move.l          ROTATION_ANGLES_512_PTR,a0
  move.w          (a0),d0
  add.l           #2,ROTATION_ANGLES_512_PTR

  jsr             LOADIDENTITYANDROTATEX
  VERTEX_INIT     1,#0,#-50,#0
  VERTEX_INIT     2,#50,#50,#0
  VERTEX_INIT     3,#-50,#50,#0
  IFD             DEBUGCOLORS
  move.w          #$00F0,$dff180
  ENDC
  jsr             TRIANGLE3D_NODRAW
  IFD             DEBUGCOLORS
  move.w          #$0AAA,$dff180
  ENDC

  WAITBLITTER
  STROKE          #3
  bsr.w           ammx_fill_table_reversed
  movem.l         (sp)+,d0-d7/a0-a6
  rts

DOUBLETRIANGLEX_CLEAR:
  jsr             RESET_ANGLE_512
  SETBEATDELAY    #17                                               ; set beat delay to 16 for the rolling triangles

  rts