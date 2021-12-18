; DEFINES
STARTWALKXPOS EQU 30                                                   ; Start triangle position X (signed value)
STARTWALKYPOS EQU 128+30                                               ; Start triangle position Y (signed value)

STARTDXCLIMB  EQU 300-30                                               ; X Position where to start climbing the screen (must be multiple of 30, size of the triangle)
STARTDYCLIMB  EQU 150

TIMEDELAY     EQU 360

; VARIABLES
YROLLINGOFFSET:
  dc.w                  30                                             ; Increment by 30 while climbing

;ANGLE_YWALK:
 ; dc.w                  359

STROKEDATA:
  dc.w                  0
FILLDATA:
  dc.w                  0

TRIANGLES:
TRIANGLE_1:
  dc.w                  0                                              ; ANGLE
  dc.w                  0                                              ; XROLLINGOFFSET
  dc.w                  30                                             ; YROLLINGOFFSET
  dc.w                  0                                              ; STAGE
  dc.l                  ROTATIONS_ANGLES_64_180-2                      ;XROLLINGANGLE
  dc.b                  1                                              ; STROKE
  dc.b                  2                                              ; FILL
  dc.w                  TIMEDELAY*0                                    ; SLEEP
TRIANGLE_2:
  dc.w                  0                                              ; ANGLE
  dc.w                  0                                              ; XROLLINGOFFSET
  dc.w                  30                                             ; YROLLINGOFFSET
  dc.w                  0                                              ; STAGE
  dc.l                  ROTATIONS_ANGLES_64_180-2                      ;XROLLINGANGLE
  dc.b                  2                                              ; STROKE
  dc.b                  1                                              ; FILL
  dc.w                  TIMEDELAY*1                                    ; SLEEP
TRIANGLE_3:
  dc.w                  0                                              ; ANGLE
  dc.w                  0                                              ; XROLLINGOFFSET
  dc.w                  30                                             ; YROLLINGOFFSET
  dc.w                  0                                              ; STAGE
  dc.l                  ROTATIONS_ANGLES_64_180-2                      ;XROLLINGANGLE
  dc.b                  3                                              ; STROKE
  dc.b                  1                                              ; FILL
  dc.w                  TIMEDELAY*2                                    ; SLEEP
TRIANGLE_4:
  dc.w                  0                                              ; ANGLE
  dc.w                  0                                              ; XROLLINGOFFSET
  dc.w                  30                                             ; YROLLINGOFFSET
  dc.w                  0                                              ; STAGE
  dc.l                  ROTATIONS_ANGLES_64_180-2                      ;XROLLINGANGLE
  dc.b                  1                                              ; STROKE
  dc.b                  3                                              ; FILL
  dc.w                  TIMEDELAY*3                                    ; SLEEP

WALKINGTRIANGLE:
  ; For each triangle
  lea                   TRIANGLES(PC),a0
  moveq                 #4-1,d5
walkingtriangle_start:
  move.w                0(a0),ANGLE
  move.w                2(a0),XROLLINGOFFSET
  move.w                4(a0),YROLLINGOFFSET
  move.w                6(a0),STAGEWALK
  move.l                8(a0),XROLLINGANGLE
  move.b                12(a0),STROKEDATA
  move.b                13(a0),FILLDATA
  tst.w                 14(a0)
  beq.s                 walkingtriangle_nodelay
  sub.w                 #1,14(a0)
  bra.s                 walkingtriangle_gotonext
walkingtriangle_nodelay
  bsr.w                 WALKINGTRIANGLE_PROCESS
walkingtriangle_gotonext:
  move.w                ANGLE,(a0)+
  move.w                XROLLINGOFFSET,(a0)+
  move.w                YROLLINGOFFSET,(a0)+
  move.w                STAGEWALK,(a0)+
  move.l                XROLLINGANGLE,(a0)+
  move.b                STROKEDATA,(a0)+
  move.b                FILLDATA,(a0)+
  adda.w                #2,a0
  dbra                  d5,walkingtriangle_start
  
  rts

STAGEWALK: ; 0 => X right walk 1 => Climb the screen on the right side
  dc.w                  0

;MACROS

; Macro to get current angle and move the pointer to the next
NEXT_WALKING_ANGLE  MACRO
  move.l                XROLLINGANGLE(PC),a0
  move.w                (a0),\1
  subq                  #2,a0
  move.l                a0,XROLLINGANGLE
  ENDM

UPDATE_TRANSLATION MACRO
  cmpi.w                \1,ANGLE
  bne.s                 .walkingtriangle_no_reset_angle
  move.w                #0,ANGLE
  add.w                 \3,\2
  move.l                #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE
.walkingtriangle_no_reset_angle:
  ENDM

; Animation function
WALKINGTRIANGLE_PROCESS:
  movem.l               d5/a0,-(sp)
  ;ENABLE_CLIPPING

  STROKE                STROKEDATA
  FILL                  FILLDATA

    ; call the appropriate routine according to stage
  move.w                STAGEWALK(PC),d0
  cmpi.w                #1,d0
  beq.w                 walkingtriangle_ywalk
  cmpi.w                #2,d0
  beq.w                 walkingtriangle_xwalk_rev
  cmpi.w                #3,d0
  beq.w                 walkingtriangle_ywalk_desending
  cmpi.w                #4,d0
  beq.w                 walkingtriangle_xwalk_right

  ; START OF FIRST HORIZONTAL WALKING
  ; Calculate the origin point which is the lower right vertex of the triangle
  ; This is important because the triangle must rotate around this vertex
  ; To calculate this point:
  ; - the X position is the start walking position X coord * num revolutions
  ; - the Y position is the Y start walking position Y coord
  ; Pseudocode:
  ; - resetMatrix();
  ; - translate(STARTWALKXPOS+XROLLINGOFFSET,STARTWALKYPOS)
  moveq                 #STARTWALKXPOS,d0
  add.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  jsr                   LOADIDENTITYANDTRANSLATE

  ; Put the angle into the ANGLE variable - then point to the next angle;
  ; Data is taken from the XROLLINGANGLE table
  NEXT_WALKING_ANGLE    ANGLE

  ; Rotate around right-bottom vertex
  ROTATE                ANGLE
  
  ; each time angle is 241 I have a full revolution aroung the vertex, in this case:
  ; - reset the angle
  ; - reset the angle pointer
  ; add the length of the triangle to the XROLLINGOFFSET
  UPDATE_TRANSLATION    #241,XROLLINGOFFSET,#30

; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                #STARTDXCLIMB,XROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_climbing
  cmpi.w                #325,ANGLE
  bne.s                 walkingtriangle_no_vertical_climbing
  move.w                #1,STAGEWALK
  move.w                #359,ANGLE
walkingtriangle_no_vertical_climbing:
  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT         1,#-15,#-26
  VERTEX2D_INIT         2,#-30,#0
  VERTEX2D_INIT         3,#0,#0

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT

  ;bsr.w                 DRAWCANVAS
  movem.l               (sp)+,d5/a0
  rts

; ---- START IMPLEMENTATION OF Y CLIMBING ------------------
walkingtriangle_ywalk:
  moveq                 #STARTWALKXPOS,d0
  add.w                 #STARTDXCLIMB,d0
  move.w                #STARTWALKYPOS,d1
  sub.w                 YROLLINGOFFSET,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  ROTATE                ANGLE

  bsr.w                 decrease_angle_by_1

  UPDATE_TRANSLATION    #240,YROLLINGOFFSET,#30

  cmpi.w                #STARTDYCLIMB,YROLLINGOFFSET
  bne.s                 walkingtriangle_no_horizontal_climbing
  cmpi.w                #330,ANGLE
  bne.s                 walkingtriangle_no_horizontal_climbing
  move.w                #30,XROLLINGOFFSET                             ; next stage must start with this value to 30
  move.w                #0,ANGLE                                       ; next stage must start with this value to zero
  move.w                #2,STAGEWALK
walkingtriangle_no_horizontal_climbing:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT         1,#0,#0
  VERTEX2D_INIT         2,#0,#30
  VERTEX2D_INIT         3,#-26,#15

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT
  movem.l               (sp)+,d5/a0
  rts

; ---- START IMPLEMENTATION OF X REVERSE CLIMBING ------------------
walkingtriangle_xwalk_rev:
  moveq                 #STARTWALKXPOS,d0
  add.w                 #STARTDXCLIMB,d0
  sub.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  sub.w                 YROLLINGOFFSET,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  NEXT_WALKING_ANGLE    ANGLE
  ROTATE                ANGLE

  ;bsr.w                 decrease_angle_by_1

  UPDATE_TRANSLATION    #241,XROLLINGOFFSET,#30

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 3 to start vertical descending for next frame
  cmpi.w                #STARTDXCLIMB,XROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_descending
  cmpi.w                #325,ANGLE
  bne.s                 walkingtriangle_no_vertical_descending
  move.w                #3,STAGEWALK
  sub.w                 #30,YROLLINGOFFSET
  move.w                #0,ANGLE
  ;move.l                #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE
walkingtriangle_no_vertical_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT         1,#0,#0
  VERTEX2D_INIT         2,#30,#0
  VERTEX2D_INIT         3,#15,#26

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT
  movem.l               (sp)+,d5/a0
  rts

; ---- START IMPLEMENTATION OF Y DESCENDING ON LEFT SCREEN ------------------
walkingtriangle_ywalk_desending:
  moveq                 #STARTWALKXPOS,d0
  add.w                 #STARTDXCLIMB,d0
  sub.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  sub.w                 YROLLINGOFFSET,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  ROTATE                ANGLE

  bsr.w                 decrease_angle_by_1

  UPDATE_TRANSLATION    #240,YROLLINGOFFSET,#-30

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 0 to start horizontal for next frame
  cmpi.w                #0,YROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_left_descending
  cmpi.w                #330,ANGLE
  bne.s                 walkingtriangle_no_vertical_left_descending
  move.w                #4,STAGEWALK
  move.w                #30,XROLLINGOFFSET
  move.w                #0,ANGLE
walkingtriangle_no_vertical_left_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT         1,#0,#0
  VERTEX2D_INIT         2,#0,#-30
  VERTEX2D_INIT         3,#26,#-15

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT
  movem.l               (sp)+,d5/a0
  rts

  ; ---- START IMPLEMENTATION OF X WALKING TO RIGHT ------------------
walkingtriangle_xwalk_right:
  moveq                 #STARTWALKXPOS,d0
  add.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  NEXT_WALKING_ANGLE    ANGLE
  ROTATE                ANGLE

  ;bsr.w                 decrease_angle_by_1

  UPDATE_TRANSLATION    #241,XROLLINGOFFSET,#30

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                #STARTDXCLIMB,XROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_climbing_2
  cmpi.w                #325,ANGLE
  bne.s                 walkingtriangle_no_vertical_climbing_2
  move.w                #1,STAGEWALK
  move.w                #30,YROLLINGOFFSET
  move.w                #359,ANGLE
walkingtriangle_no_vertical_climbing_2:
  
  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT         1,#-15,#-26
  VERTEX2D_INIT         2,#-30,#0
  VERTEX2D_INIT         3,#0,#0

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT
  movem.l               (sp)+,d5/a0
  rts

DRAWCANVAS:
  rts
  RESETMATRIX
  VERTEX2D_INIT         1,#310,#100
  VERTEX2D_INIT         2,#300,#255
  VERTEX2D_INIT         3,#319,#255

  STROKE                #1
  FILL                  #3

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT

  VERTEX2D_INIT         1,#310,#255
  VERTEX2D_INIT         2,#300,#100
  VERTEX2D_INIT         3,#319,#100

  STROKE                #2
  FILL                  #1

  lea                   OFFBITPLANEMEM,a4
  jsr                   TRIANGLE_BLIT
  rts

