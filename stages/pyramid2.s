PYRAMID_VERTEX_TOP EQU 30

ANGLE_PYR:
  dc.w             181

PYRAMID_VERTEX_1:
  dc.l             0
PYRAMID_VERTEX_2:
  dc.l             0
PYRAMID_VERTEX_3:
  dc.l             0
PYRAMID_VERTEX_4:
  dc.l             0

PYRCOLOR0 : dc.b 1
PYRCOLOR1 : dc.b 2

OFFBITPLANEMEM:
               dcb.b            40*256,$00

PYRAMID_POINT  MACRO
               moveq            \1,d0
               moveq            \2,d1
               moveq            #0,d2

               jsr              point_execute_transformation_3d
               jsr              point_project_3d

               move.w           d0,(a0)+
               move.w           d1,(a0)+

               ENDM

PYRAMID2:
               movem.l          d0-d2/a0-a1,-(sp)

  ; transformation calc
               moveq            #70,d0
               jsr              LOADIDENTITYANDROTATEX
  ;move.w #270,ANGLE_PYR
               ROTATE           ANGLE_PYR

               lea              PYRAMID_VERTEX_1(PC),a0
               PYRAMID_POINT    #-50,#-50                                ; point 1
               PYRAMID_POINT    #50,#-50                                 ; point 2
               PYRAMID_POINT    #50,#50                                  ; point 3
               PYRAMID_POINT    #-50,#50                                 ; point 4

               VERTEX2D_INIT    1,PYRAMID_VERTEX_1,PYRAMID_VERTEX_1+2
               VERTEX2D_INIT    2,PYRAMID_VERTEX_2,PYRAMID_VERTEX_2+2
               VERTEX2D_INIT    3,#160,#PYRAMID_VERTEX_TOP

               cmpi.w           #270,ANGLE_PYR
               beq.w            PYRAMID2_NOFIRSR

               STROKE           PYRCOLOR0
               lea              OFFBITPLANEMEM,a4
               jsr              BLITTRIANGLE

               cmpi.w           #181,ANGLE_PYR
               beq.s            PYRAMID2_END

PYRAMID2_NOFIRSR:

               VERTEX2D_INIT    1,PYRAMID_VERTEX_3,PYRAMID_VERTEX_3+2
               VERTEX2D_INIT    2,PYRAMID_VERTEX_2,PYRAMID_VERTEX_2+2
               VERTEX2D_INIT    3,#160,#PYRAMID_VERTEX_TOP


               STROKE           PYRCOLOR1
               lea              OFFBITPLANEMEM,a4
               jsr              BLITTRIANGLE

PYRAMID2_END:
               bra.w            update_pyr_angle

               IFD              DEBUGCOLORS
               move.w           #$0AAA,$dff180
               ENDC

               movem.l          (sp)+,d0-d2/a0-a1
               rts

PYRAMID_CLEAR:
  move.w           #181,ANGLE_PYR
  move.l           #CLEAR,CLEARFUNCTION
  rts

update_pyr_angle:
    ; increase angle by one
  add.w            #1,ANGLE_PYR
  cmpi.w           #270,ANGLE_PYR
  bcs.s            increase_angle_by_1_exit_pyr
  move.w           #181,ANGLE_PYR
  move.b PYRCOLOR0,d0
  move.b PYRCOLOR1,PYRCOLOR0
  move.b d0,PYRCOLOR1

increase_angle_by_1_exit_pyr:
  
  IFD              DEBUGCOLORS
  move.w           #$0AAA,$dff180
  ENDC

  movem.l          (sp)+,d0-d2/a0-a1
  rts