PYRAMID:
  movem.l        d0-d7/a0-a6,-(sp)

  move.w         #70,d0
  jsr            LOADIDENTITYANDROTATEX
  VERTEX_INIT    1,#-50,#-50,#0
  VERTEX_INIT    2,#50,#-50,#0
  VERTEX_INIT    3,#-50,#50,#0
  VERTEX_INIT    4,#50,#50,#0
  IFD            DEBUGCOLORS
  move.w         #$00F0,$dff180
  ENDC
  ROTATE         ANGLE
  bsr.w          increase_angle_by_1

  jsr            FOURSIDEPOLYGON3D_NODRAW

  STROKE         #3
  WAITBLITTER
    jsr            ammx_fill_table


  ;point 3
  move.w         #-50,d0
  move.w         #50,d1
  move.w         0,d2

  jsr            point_execute_transformation_3d
  jsr            point_project_3d

  lea            LINEVERTEX_START_FINAL,a0
  move.w         #160,(a0)+
  move.w         #30,(a0)+
  move.w         d0,(a0)
  move.w         d1,2(a0)
  jsr            ammxlinefill

  ;point 4
  move.w         #50,d0
  move.w         #50,d1
  move.w         0,d2

  jsr            point_execute_transformation_3d
  jsr            point_project_3d
  move.w         d0,(a0)
  move.w         d1,2(a0)
  jsr            ammxlinefill
  STROKE         #2
  jsr            ammx_fill_table
  ; end of first triangle

  ; start of second triangle
  ;point 2
  move.w         #-50,d0
  move.w         #-50,d1
  move.w         0,d2

  jsr            point_execute_transformation_3d
  jsr            point_project_3d

  lea            LINEVERTEX_START_FINAL,a0
  move.w         #160,(a0)+
  move.w         #30,(a0)+
  move.w         d0,(a0)
  move.w         d1,2(a0)
  jsr            ammxlinefill

  ;point 3
  move.w         #-50,d0
  move.w         #50,d1
  move.w         0,d2

  jsr            point_execute_transformation_3d
  jsr            point_project_3d
  move.w         d0,(a0)
  move.w         d1,2(a0)
  jsr            ammxlinefill
  STROKE         #1
  jsr            ammx_fill_table

  ; end of second triangle


  IFD            DEBUGCOLORS
  move.w         #$0AAA,$dff180
  ENDC

  movem.l        (sp)+,d0-d7/a0-a6
  rts

PYRAMID_CLEAR:
  move.w #0,ANGLE
  rts