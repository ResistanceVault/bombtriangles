PYRAMID_VERTEX_TOP EQU 70

PYRAMID_POINT MACRO
  moveq            \1,d0
  moveq            \2,d1
  moveq            #0,d2

  jsr              point_execute_transformation_3d
  jsr              point_project_3d

  move.w           d0,(a0)+
  move.w           d1,(a0)+

  ENDM

PYRAMID_VERTEX_1:
  dc.l             0
PYRAMID_VERTEX_2:
  dc.l             0
PYRAMID_VERTEX_3:
  dc.l             0
PYRAMID_VERTEX_4:
  dc.l             0

ANGLE_PYR:
  dc.w             180
COLOR_PYR
  dc.w COLOR1
  dc.w COLOR2

CYCLE_PYR
  dc.w 0

PYRAMID:
  movem.l          d0-d3/a0-a1,-(sp)

  ;move.w CYCLE_PYR,d3
  ;bne.s pyr_clear2
  ;move.l           #CLEAR_BPL_1_PYR,CLEARFUNCTION
  ;bra.s pyr_clear2_done
;pyr_clear2:
;  move.l  #CLEAR_BPL_2_PYR,CLEARFUNCTION
;pyr_clear2_done:

  ; transformation calc
  moveq            #70,d0
  jsr              LOADIDENTITYANDROTATEX
  
  ROTATE           ANGLE_PYR


  ; increase angle by one
  add.w            #1,ANGLE_PYR
  cmpi.w           #270,ANGLE_PYR
  bcs.s            increase_angle_by_1_exit_pyr
  move.w           #180,ANGLE_PYR

  
  ;move.l #$DFF182,a0
  ;move.l           $DFF182,d0
  ;move.l  COLOR_PYR,d0
  ;swap d0
  ;move.l d0,$DFF182
  ;move.l d0,COLOR_PYR
  ;move.w #$555,d0
  ;move.w #$AAA,d1
  ;move.w           d1,(a0)+
  ;move.w           d0,(a0)
increase_angle_by_1_exit_pyr:

  move.l           #CLEAR_BPL_1_PYR,CLEARFUNCTION
  lea              PYRAMID_VERTEX_1(PC),a0
  lea              LINEVERTEX_START_FINAL,a1

  PYRAMID_POINT    #-50,#-50                          ; point 1
  PYRAMID_POINT    #50,#-50                           ; point 2
  PYRAMID_POINT    #50,#50                            ; point 3
  PYRAMID_POINT    #-50,#50                           ; point 4

  lea              PYRAMID_VERTEX_1(PC),a0

  ; draw base start

  ; line 1 (point 1 with point 2)
  ;move.l (a0),(a1) ; point 1
  ;move.l 4(a0),4(a1) ; point 2
  ;jsr            ammxlinefill

  ; line 2 (point 2 with point 3)
  ;lea PYRAMID_VERTEX_1(PC),a0
  ;move.l 8(a0),(a1) ; point 3
  ;jsr            ammxlinefill

  ; line 3 (point 3 with point 4)
  ;lea PYRAMID_VERTEX_1(PC),a0
  ;move.l 12(a0),4(a1) ; point 4
  ;jsr            ammxlinefill

  ; line 4 (point 4 with point 1)
  ;lea PYRAMID_VERTEX_1(PC),a0
  ;move.l (a0),(a1) ; point 1
  ;jsr            ammxlinefill

  ; draw base end
  ;WAITBLITTER
  ;STROKE #1
  ;jsr            ammx_fill_table

  WAITBLITTER
  jsr              CLEAR_BPL_2_PYR

  ; draw triangle 1
  ; line 1 : from point 1 to top
  move.l           (a0),(a1)                          ; point 1 already there
  move.w           #160,4(a1)
  move.w           #PYRAMID_VERTEX_TOP,6(a1)
  jsr              ammxlinefill

  ; line 2 : from point 2 to top
  move.l           4(a0),(a1)                         ; point2
  ;move.w #160,4(a1) top already there
  ;move.w #30,6(a1)
  jsr              ammxlinefill



  ; line 3 : from point 1 to point 2
  move.l           (a0),4(a1)                         ; point1
  jsr              ammxlinefill
  ;WAITBLITTER
  ;STROKE #2
  ;jsr              CLEAR_BPL_2_PYR
  jsr              ammx_fill_table_bpl1
  ; end of triangle 1


  ; draw triangle 2
  ; line 1 : from point 2 to top
  move.l           4(a0),(a1)                         ; point 2
  move.w           #160,4(a1)
  move.w           #PYRAMID_VERTEX_TOP,6(a1)
  jsr              ammxlinefill

  ; line 2 : from point 3 to top
  move.l           8(a0),(a1)                         ; point3
  ;move.w #160,4(a1) top already there
  ;move.w #30,6(a1)
  jsr              ammxlinefill

  ; line 3 : from point 2 to point 3
  move.l           4(a0),4(a1)                        ; point2
  jsr              ammxlinefill
  ;STROKE #3
  WAITBLITTER
  jsr              ammx_fill_table_bpl2
  ; end of triangle 2
  
  IFD              DEBUGCOLORS
  move.w           #$0AAA,$dff180
  ENDC

  movem.l          (sp)+,d0-d3/a0-a1
  rts

PYRAMID_CLEAR:
  move.w           #180,ANGLE_PYR
  move.l           #CLEAR,CLEARFUNCTION
  rts

CLEAR_BPL_1_PYR: 
  WAITBLITTER
  move.w           #$0100,$dff040
  move.w           #$0000,$dff042
  move.l           SCREEN_PTR_0,d0
  add.w            #40*70,d0        
  move.l           d0,$dff054
            ;add.w #50*40,$dff054                                                                   ; copy to d channel
  move.w           #$0000,$dff066                     ;D mod
  move.w           #$2314,$dff058
  rts

CLEAR_BPL_2_PYR: 
  WAITBLITTER
  move.w           #$0100,$dff040
  move.w           #$0000,$dff042
  move.l           SCREEN_PTR_1,d0
  add.w            #40*70,d0           
  move.l           d0,$dff054  
            ;add.w #50*40,$dff054                                                                 ; copy to d channel
  move.w           #$0000,$dff066                     ;D mod
  move.w           #$2314,$dff058
  rts
