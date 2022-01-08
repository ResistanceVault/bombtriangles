;includes
    include              "AProcessing2/libs/vectors/operations.s"
    include              "AProcessing2/libs/blitter/offbitplanemem.i"

; DEFINES
NUMTRIANGLES           EQU 4                                                           ; How many triangles do we want?? range(0,4)
STARTWALKXPOS          EQU 30                                                          ; Start triangle position X (signed value)
STARTWALKYPOS          EQU 184
LADDERVERTICALPOSITION   equ STARTWALKYPOS+49                                                         ; Start triangle position Y (signed value)

STARTDXCLIMB           EQU 300-60                                                      ; X Position where to start climbing the screen (must be multiple of 30, size of the triangle)
STARTDYCLIMB           EQU 150
STARTDYCLIMBX2         EQU STARTDYCLIMB*2
TIMEDELAY              EQU 510                                                         ; Number of frames before the triangle is rendered
STARTDXDESCEND_OFFSET  EQU 210                                                         ; Offset where the triangles are expected to fall after xreverse walking (must be miltiple of 30)
SECOND_FLOOR_Y         EQU 90                                                          ; Y coordinate of the second floor
STARTSTAGE             EQU 9                                                           ; Number of the first stage
START_SCALE_FACTOR     EQU 0*64                                                        ; Scaling of triangles at start

; DEFINITION OF THE TRIANGLE STRUCTURE
ANGLE_OFFSET           EQU 0
XROLLINGOFFSET_OFFSET  EQU 2
YROLLINGOFFSET_OFFSET  EQU 4
STAGEWALK_OFFSET       EQU 6
XROLLINGANGLE_OFFSET   EQU 8
STROKE_OFFSET          EQU 12
FILL_OFFSET            EQU 13
SLEEP_OFFSET           EQU 14
POSITIONVECTOR_OFFSET  EQU 16
XPOSITIONVECTOR_OFFSET EQU 16
YPOSITIONVECTOR_OFFSET EQU 18
VELOCITYVECTOR_OFFSET  EQU 20
XVELOCITYVECTOR_OFFSET EQU 20
YVELOCITYVECTOR_OFFSET EQU 22
SCALEFACTOR_OFFSET     EQU 24
TRIANGLE_END_OFFSET    EQU 26

; VARIABLES
ACCELLERATIONVECTOR:
  dc.l                   $00000001

; ********************************* ARRAY OF TRIANGLES DEFINITION - START
TRIANGLES:
TRIANGLE_1:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   2                                                             ; STROKE
  dc.b                   2                                                             ; FILL
  dc.w                   TIMEDELAY*0                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
TRIANGLE_2:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   2                                                             ; STROKE
  dc.b                   1                                                             ; FILL
  dc.w                   TIMEDELAY*1                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
TRIANGLE_3:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   3                                                             ; STROKE
  dc.b                   1                                                             ; FILL
  dc.w                   TIMEDELAY*2                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
TRIANGLE_4:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   1                                                             ; STROKE
  dc.b                   3                                                             ; FILL
  dc.w                   TIMEDELAY*3                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
; ********************************* ARRAY OF TRIANGLES DEFINITION - START

;MACROS

; Macro to get current angle and move the pointer to the next
NEXT_WALKING_ANGLE2  MACRO
  move.l                 XROLLINGANGLE_OFFSET(a3),a0
  move.w                 (a0),\1
  subq                   #2,a0
  move.l                 a0,XROLLINGANGLE_OFFSET(a3)
  ENDM

UPDATE_TRANSLATION2  MACRO
  cmpi.w                 \1,ANGLE_OFFSET(a3)
  bne.s                  .walkingtriangle_no_reset_angle
  move.w                 #0,ANGLE_OFFSET(a3)
  add.w                  \3,\2
  move.l                 #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE_OFFSET(a3)
.walkingtriangle_no_reset_angle:
  ENDM

; Entry function
WALKINGTRIANGLE:
  ; For each triangle
  lea                    TRIANGLES(PC),a3
  moveq                  #NUMTRIANGLES-1,d5
walkingtriangle_start:
  tst.w                  SLEEP_OFFSET(a3)
  beq.s                  walkingtriangle_nodelay
  sub.w                  #1,SLEEP_OFFSET(a3)
  bra.s                  walkingtriangle_gotonext
walkingtriangle_nodelay
  bsr.w                  WALKINGTRIANGLE_PROCESS
walkingtriangle_gotonext:
  adda.l                 #TRIANGLE_END_OFFSET,a3
  dbra                   d5,walkingtriangle_start
  rts

; Animation function
WALKINGTRIANGLE_PROCESS:
  movem.l                d5/a3,-(sp)

  STROKE                 STROKE_OFFSET(a3)
  FILL                   FILL_OFFSET(a3)

  ;DEBUG                  1234

    ; call the appropriate routine according to stage
  move.w                 STAGEWALK_OFFSET(a3),d0
  cmpi.w                 #1,d0
  beq.w                  walkingtriangle_ywalk
  cmpi.w                 #2,d0
  beq.w                  walkingtriangle_xwalk_rev
  cmpi.w                 #3,d0
  beq.w                  walkingtriangle_ywalk_desending
  cmpi.w                 #4,d0
  beq.w                  walkingtriangle_xwalk_right
  cmpi.w                 #5,d0
  beq.w                  walkingtriangle_xwalk_right_2
  cmpi.w                 #6,d0
  beq.w                  walkingtriangle_reverse_dive
  cmpi.w                 #7,d0
  beq.w                  walkingfloor1
  cmpi.w                 #8,d0
  beq.w                  teletrasportationstart
  cmpi.w                 #9,d0
  beq.w                  teletrasportationend
  cmpi.w                 #$FFFF,d0
  beq.w                  walkingtriangle_sleep


  ; START OF WALKING ROUTINES

  ; ***************************** START OF FIRST HORIZONTAL WALKING
  ; Calculate the origin point which is the lower right vertex of the triangle
  ; This is important because the triangle must rotate around this vertex
  ; To calculate this point:
  ; - the X position is the start walking position X coord * num revolutions
  ; - the Y position is the Y start walking position Y coord
  ; Pseudocode:
  ; - resetMatrix();
  ; - translate(STARTWALKXPOS+XROLLINGOFFSET,STARTWALKYPOS)
  moveq                  #STARTWALKXPOS,d0
  add.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ; Put the angle into the ANGLE variable - then point to the next angle;
  ; Data is taken from the XROLLINGANGLE table
  NEXT_WALKING_ANGLE2    ANGLE_OFFSET(a3)

  ; Rotate around right-bottom vertex
  ROTATE                 ANGLE_OFFSET(a3)
  
  ; each time angle is 241 I have a full revolution aroung the vertex, in this case:
  ; - reset the angle
  ; - reset the angle pointer
  ; add the length of the triangle to the XROLLINGOFFSET
  UPDATE_TRANSLATION2    #241,XROLLINGOFFSET_OFFSET(a3),#30

; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                 #STARTDXCLIMB,XROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing
  cmpi.w                 #325,ANGLE_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing
  move.w                 #1,STAGEWALK_OFFSET(a3)
  move.w                 #359,ANGLE_OFFSET(a3)
  START_LADDERS
  
walkingtriangle_no_vertical_climbing:

  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT          1,#-15,#-26
  VERTEX2D_INIT          2,#-30,#0
  VERTEX2D_INIT          3,#0,#0

  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT

  movem.l                (sp)+,d5/a3
  rts
  ; ***************************** END OF FIRST HORIZONTAL WALKING





; ***************************** START IMPLEMENTATION OF Y CLIMBING ------------------
walkingtriangle_ywalk:
                    ; Translate
  move.w                 #STARTWALKXPOS+STARTDXCLIMB,d0
  move.w                 #STARTWALKYPOS-15,d1
  move.w                 YROLLINGOFFSET_OFFSET(a3),d2
  lsr.w                  #1,d2
  sub.w                  d2,d1
  jsr                    LOADIDENTITYANDTRANSLATE

                    ; move triangle UP
  addq                   #1,YROLLINGOFFSET_OFFSET(a3)

                    ; when the triangle reaches thetop, stop the ladder
  cmpi.w                 #STARTDYCLIMBX2,YROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_horizontal_climbing

  move.w                 #0,XROLLINGOFFSET_OFFSET(a3)                                  ; next stage must start with this value to 30
  move.w                 #0,ANGLE_OFFSET(a3)                                           ; next stage must start with this value to zero
  move.w                 #STARTDYCLIMB-1,YROLLINGOFFSET_OFFSET(a3)
  move.w                 #2,STAGEWALK_OFFSET(a3)
  STOP_LADDERS

walkingtriangle_no_horizontal_climbing:

                    ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT          1,#0,#0
  VERTEX2D_INIT          2,#0,#30
  VERTEX2D_INIT          3,#-26,#15

  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
  ;moveq #0,d0
  ;moveq #0,d1
  ;moveq #0,d6
  ;moveq #30,d3
  ;move.w #-26,d4
  ;move.w #15,d5
  ;STROKE #1
  ;jsr TRIANGLE
  movem.l                (sp)+,d5/a3
  rts
; ***************************** END IMPLEMENTATION OF Y CLIMBING ------------------




; ***************************** START IMPLEMENTATION OF X REVERSE ------------------
walkingtriangle_xwalk_rev:
                    ; Translate
  move.w                 #STARTWALKXPOS+STARTDXCLIMB,d0
  sub.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS+15,d1
  sub.w                  YROLLINGOFFSET_OFFSET(a3),d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ; Add 1 to angle
  addq                   #1,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  bcs.s                  .increase_angle_by_1_exit
  move.w                 #0,ANGLE_OFFSET(a3)
  .increase_angle_by_1_exit:
  ROTATE                 ANGLE_OFFSET(a3)


  ;,UPDATE_TRANSLATION    #241,XROLLINGOFFSET,#30
  cmpi.w                 #30,ANGLE_OFFSET(a3)
  bne.s                  .walkingtriangle_no_reset_angle
  move.w                 #270,ANGLE_OFFSET(a3)
  add.w                  #30,XROLLINGOFFSET_OFFSET(a3)
.walkingtriangle_no_reset_angle:

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 3 to start vertical descending for next frame
  cmpi.w                 #STARTDXDESCEND_OFFSET,XROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_descending
  tst.w                  ANGLE_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_descending
  move.w                 #3,STAGEWALK_OFFSET(a3)
walkingtriangle_no_vertical_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT          1,#0,#0
  VERTEX2D_INIT          2,#0,#-30
  VERTEX2D_INIT          3,#-26,#-15

  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
  movem.l                (sp)+,d5/a3
  rts

; ***************************** END IMPLEMENTATION OF X REVERSE ------------------


; ***************************** START IMPLEMENTATION OF Y DESCENDING ON LEFT SCREEN ------------------
walkingtriangle_ywalk_desending:
  move.w                  XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                  YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w                   #6,d0
  asr.w                   #6,d1
  sub.w                   #13,d0
  sub.w                   #15,d1

  jsr                     LOADIDENTITYANDTRANSLATE

  ; when hitting bottom border stop
  cmpi.w                  #SECOND_FLOOR_Y,d1
  ble.s                   notdownborder
  move.w                  #4,STAGEWALK_OFFSET(a3)
  ; new velocity
  move.l                  a3,a0
  adda.w                  #VELOCITYVECTOR_OFFSET,a0
  move.w                  #1*32,d0
  move.w                  #-1*64,d1
  CREATE2DVECTOR a0
notdownborder;

  ; Add 2 to angle
  add.w                  #2,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  bcs.s                  .increase_angle_by_1_exit
  move.w                 #0,ANGLE_OFFSET(a3)
.increase_angle_by_1_exit:

  ROTATE                 ANGLE_OFFSET(a3)

  ; add accelleration to velocity
  lea                    ACCELLERATIONVECTOR(PC),a0
  move.l                 a3,a1
  adda.w                 #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; add velocity to position
  move.l                 a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  move.l                 a3,a1
  adda.w                 #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; when hitting left border stop
  cmpi.w                 #30,XPOSITIONVECTOR_OFFSET(a3)
  bne.s                  notleftborder
  move.w                 #4,STAGEWALK_OFFSET(a3)
notleftborder;

  ; Draw triangle
  VERTEX2D_INIT          1,#13,#15
  VERTEX2D_INIT          2,#13,#-15
  VERTEX2D_INIT          3,#-13,#0
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
  movem.l                (sp)+,d5/a3
  rts
; ***************************** END IMPLEMENTATION OF Y DESCENDING ON LEFT SCREEN ------------------


  ; ***************************** START IMPLEMENTATION OF X WALKING TO RIGHT second floor  ------------------
walkingtriangle_xwalk_right:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w                  #6,d0
  asr.w                  #6,d1
  sub.w                  #13,d0
  sub.w                  #15,d1
  jsr                    LOADIDENTITYANDTRANSLATE
  
  ; save d1 for later comparison
  move.w                 d1,d7
  
  ; Sub 3 to angle
  sub.w                  #3,ANGLE_OFFSET(a3)
  bpl.s                  .decrease_angle_by_3_exit
  move.w                 #357,ANGLE_OFFSET(a3)
.decrease_angle_by_3_exit:

  ROTATE                 ANGLE_OFFSET(a3)

  ; add accelleration to velocity
  lea                    ACCELLERATIONVECTOR(PC),a0
  move.l                 a3,a1
  adda.w                 #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; add velocity to position
  move.l                 a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  move.l                 a3,a1
  adda.w                 #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; when hitting bottom border stop
  cmpi.w                 #SECOND_FLOOR_Y,d7
  ble.s                  notdownborder2
  move.w                 #5,STAGEWALK_OFFSET(a3)
  move.w                 #122,XPOSITIONVECTOR_OFFSET(a3)
  move.w                 #98,YPOSITIONVECTOR_OFFSET(a3)
  move.w                 #0,ANGLE_OFFSET(a3)
notdownborder2;

  ; Draw triangle
  VERTEX2D_INIT          1,#13,#15
  VERTEX2D_INIT          2,#13,#-15
  VERTEX2D_INIT          3,#-13,#0
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
  movem.l                (sp)+,d5/a3
  rts
  ; ***************************** END IMPLEMENTATION OF X WALKING TO RIGHT second floor  ------------------

  ; ***************************** START IMPLEMENTATION OF X WALKING TO RIGHT second floor part 2 ------------------
walkingtriangle_xwalk_right_2:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ROTATE                 ANGLE_OFFSET(a3)

  ; Sub 1 to angle
  subq                   #1,ANGLE_OFFSET(a3)
  bpl.s                  .decrease_angle_by_1_noreset ; if we go negative reset to 359 degrees
  move.w                 #359,ANGLE_OFFSET(a3)
  bra.s                 .decrease_angle_by_1_exit
.decrease_angle_by_1_noreset

  ; every 120 degrees of rotation move the center of the coordinates 30pix right to walk
  cmpi.w                 #240,ANGLE_OFFSET(a3)
  bne.s                  .decrease_angle_by_1_exit
  move.w                 #0,ANGLE_OFFSET(a3)
  add.w                  #30,XPOSITIONVECTOR_OFFSET(a3)
  cmpi.w                 #212,XPOSITIONVECTOR_OFFSET(a3)
  bne.s                  .decrease_angle_by_1_exit
  move.w                 #6,STAGEWALK_OFFSET(a3)
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  lsl.w                  #6,d0
  move.w                 d0,XPOSITIONVECTOR_OFFSET(a3)
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d0
  lsl.w                  #6,d0
  move.w                 d0,YPOSITIONVECTOR_OFFSET(a3)

  ; new velocity
  move.l                 a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  move.w #1*15,d0
  move.w #-1*90,d1
  CREATE2DVECTOR a0

.decrease_angle_by_1_exit:

  ; Draw triangle
  VERTEX2D_INIT          1,#-15,#-26
  VERTEX2D_INIT          2,#-30,#0
  VERTEX2D_INIT          3,#0,#0
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT

  movem.l                (sp)+,d5/a3
  rts
  ; ***************************** END IMPLEMENTATION OF X WALKING TO RIGHT second floor part 2 ------------------


walkingtriangle_reverse_dive:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w                  #6,d0
  asr.w                  #6,d1
  sub.w                  #15,d0
  sub.w                  #12,d1
  move.w                 d1,d7
  
  jsr                    LOADIDENTITYANDTRANSLATE

  ROTATE                 ANGLE_OFFSET(a3)

  ; Add 5 to angle
  addq                    #5,ANGLE_OFFSET(a3)
  cmpi.w                  #360,ANGLE_OFFSET(a3)
  blt.s                   .increase_angle_by_5_noreset
  sub.w                   #360,ANGLE_OFFSET(a3)
.increase_angle_by_5_noreset

  ; add accelleration to velocity
  lea ACCELLERATIONVECTOR(PC),a0
  move.l                  a3,a1
  adda.w                  #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; add velocity to position
  move.l                  a3,a0
  adda.w                  #VELOCITYVECTOR_OFFSET,a0
  move.l                  a3,a1
  adda.w                  #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  cmpi.w                  #124,d7
  ble.s                   .noendoffall
  move.w                  #7,STAGEWALK_OFFSET(a3)
   ; new velocity
  move.l                  a3,a0
  adda.w                  #VELOCITYVECTOR_OFFSET,a0
  move.w #-1*94,d0
  move.w #-1*32,d1
  CREATE2DVECTOR a0
.noendoffall:

  ; Draw triangle
  VERTEX2D_INIT          1,#-15+15,#-26+12
  VERTEX2D_INIT          2,#-30+15,#0+12
  VERTEX2D_INIT          3,#0+15,#0+12
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT

  movem.l                (sp)+,d5/a3
  rts

walkingfloor1:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w #6,d0
  asr.w #6,d1
  sub.w #15,d0
  sub.w #12,d1
  move.w d0,d6
  move.w d1,d7
  jsr                    LOADIDENTITYANDTRANSLATE

  ROTATE                 ANGLE_OFFSET(a3)

  ; Add 5 to angle
  addq                    #5,ANGLE_OFFSET(a3)
  cmpi.w                  #360,ANGLE_OFFSET(a3)
  blt.s .increase_angle_by_5_noreset_2
  sub.w                 #360,ANGLE_OFFSET(a3)
.increase_angle_by_5_noreset_2

  ; add accelleration to velocity
  lea ACCELLERATIONVECTOR(PC),a0
  move.l                  a3,a1
  adda.w                  #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; add velocity to position
  move.l                  a3,a0
  adda.w                  #VELOCITYVECTOR_OFFSET,a0
  move.l                  a3,a1
  adda.w                  #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  cmpi.w #124,d7
  ble.s .noendoffall2
  cmpi.w #125,d6
  bgt.s .noendoffall2
  move.w                 #8,STAGEWALK_OFFSET(a3)
.noendoffall2:

  ; Draw triangle
  VERTEX2D_INIT          1,#-15+15,#-26+12
  VERTEX2D_INIT          2,#-30+15,#0+12
  VERTEX2D_INIT          3,#0+15,#0+12
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
  movem.l                (sp)+,d5/a3
  rts

  ; ***************************** START IMPLEMENTATION OF TELETRANSPORTATION START ------------------
teletrasportationstart:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w                  #6,d0
  asr.w                  #6,d1
  sub.w                  #15,d0
  sub.w                  #12,d1
  move.w                 d0,d6
  move.w                 d1,d7
  jsr                    LOADIDENTITYANDTRANSLATE

  sub.w                  #1,SCALEFACTOR_OFFSET(a3)
  move.w                 SCALEFACTOR_OFFSET(a3),d0
  move.w                 d0,d1
  tst.w                  d0
  bne.w                  .noscale
  move.w                 #9,STAGEWALK_OFFSET(a3)
  move.w                 #0,XROLLINGOFFSET_OFFSET(a3)
  move.l                 #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE_OFFSET(a3)
  move.w                 #64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET),XPOSITIONVECTOR_OFFSET(a3)
  move.w                 #64*(STARTWALKYPOS+15-STARTDYCLIMB),YPOSITIONVECTOR_OFFSET(a3)
  move.w                 #0,XVELOCITYVECTOR_OFFSET(a3)
  move.w                 #0,YVELOCITYVECTOR_OFFSET(a3)
.noscale
  jsr                    SCALE

  ROTATE                 ANGLE_OFFSET(a3)

  ; Draw triangle
  VERTEX2D_INIT          1,#-15+15,#-26+12
  VERTEX2D_INIT          2,#-30+15,#0+12
  VERTEX2D_INIT          3,#0+15,#0+12
  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT

  movem.l                (sp)+,d5/a3
  rts

  ; ***************************** END IMPLEMENTATION OF TELETRANSPORTATION START ------------------


teletrasportationend:
  moveq                  #STARTWALKXPOS,d0
  add.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ROTATE                 ANGLE_OFFSET(a3)

  addq                   #1,SCALEFACTOR_OFFSET(a3)
  move.w                 SCALEFACTOR_OFFSET(a3),d0
  move.w                 d0,d1
  cmpi.w                 #1*64,d0
  bne.w                  .noscale2
  move.w                 #0,STAGEWALK_OFFSET(a3)
    ; reset initial values
  move.w                 #30,YROLLINGOFFSET_OFFSET(a3)
.noscale2
  jsr                    SCALE

  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT          1,#-15,#-26
  VERTEX2D_INIT          2,#-30,#0
  VERTEX2D_INIT          3,#0,#0

  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
  DEBUG 1235

  movem.l                (sp)+,d5/a3
  rts

walkingtriangle_sleep:
  movem.l                (sp)+,d5/a3
  rts



