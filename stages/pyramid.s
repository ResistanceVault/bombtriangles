PYRAMID_POINT MACRO
  move.w \1,d0
  move.w \2,d1
  moveq #0,d2

  jsr point_execute_transformation_3d
	jsr point_project_3d

  move.w d0,(a0)+
  move.w d1,(a0)+

  ENDM

PYRAMID_VERTEX_1:
  dc.l 0
PYRAMID_VERTEX_2:
  dc.l 0
PYRAMID_VERTEX_3:
  dc.l 0
PYRAMID_VERTEX_4:
  dc.l 0

PYRAMID:
  movem.l        d0-d7/a0-a6,-(sp)

  ; transformation calc
  move.w         #70,d0
  jsr            LOADIDENTITYANDROTATEX

  IFND LOL
  
  ROTATE         ANGLE
  bsr.w          increase_angle_by_1

  lea PYRAMID_VERTEX_1(PC),a0
  lea LINEVERTEX_START_FINAL,a1

  PYRAMID_POINT #-50,#-50 ; point 1
  PYRAMID_POINT #50,#-50  ; point 2
  PYRAMID_POINT #50,#50  ; point 3
  PYRAMID_POINT #-50,#50   ; point 4

  lea PYRAMID_VERTEX_1(PC),a0

  ; line 1 (point 1 with point 2)
  move.l (a0),(a1) ; point 1
  move.l 4(a0),4(a1) ; point 2
  jsr            ammxlinefill

  ; line 2 (point 2 with point 3)
  lea PYRAMID_VERTEX_1(PC),a0
  move.l 8(a0),(a1) ; point 3
  jsr            ammxlinefill

  ; line 3 (point 3 with point 4)
  lea PYRAMID_VERTEX_1(PC),a0
  move.l 12(a0),4(a1) ; point 4
  jsr            ammxlinefill

  ; line 4 (point 4 with point 1)
  lea PYRAMID_VERTEX_1(PC),a0
  move.l (a0),(a1) ; point 1
  jsr            ammxlinefill

  ; draw base
  WAITBLITTER
  STROKE #1
  jsr            ammx_fill_table

  ; draw triangle 1
  ; line 1 : from point 1 to top
  ;move.l (a0),(a1) ; point 1 already there
  move.w #160,4(a1)
  move.w #30,6(a1)
  jsr            ammxlinefill

  ; line 2 : from point 2 to top
  move.l 4(a0),(a1) ; point2
  ;move.w #160,4(a1) top already there
  ;move.w #30,6(a1)
  jsr            ammxlinefill

  ; line 3 : from point 1 to point 2
  move.l (a0),4(a1) ; point1
  jsr            ammxlinefill
  STROKE #2
  jsr            ammx_fill_table
  ; end of triangle 1

  ; draw triangle 2
  ; line 1 : from point 2 to top
  move.l 4(a0),(a1) ; point 2
  move.w #160,4(a1)
  move.w #30,6(a1)
  jsr            ammxlinefill

  ; line 2 : from point 3 to top
  move.l 8(a0),(a1) ; point3
  ;move.w #160,4(a1) top already there
  ;move.w #30,6(a1)
  jsr            ammxlinefill

  ; line 3 : from point 2 to point 3
  move.l 4(a0),4(a1) ; point2
  jsr            ammxlinefill
  STROKE #3
  jsr            ammx_fill_table
  ; end of triangle 1


  ENDC

  IFD LOL
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
  ENDC


  IFD            DEBUGCOLORS
  move.w         #$0AAA,$dff180
  ENDC

  movem.l        (sp)+,d0-d7/a0-a6
  rts

PYRAMID_CLEAR:
  move.w #0,ANGLE
  rts