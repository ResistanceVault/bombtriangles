;includes
    include              "AProcessing2/libs/vectors/operations.s"

; DEFINES
STARTWALKXPOS          EQU 30                                                          ; Start triangle position X (signed value)
STARTWALKYPOS          EQU 184                                                         ; Start triangle position Y (signed value)

STARTDXCLIMB           EQU 300-60                                                      ; X Position where to start climbing the screen (must be multiple of 30, size of the triangle)
STARTDYCLIMB           EQU 150
STARTDYCLIMBX2         EQU STARTDYCLIMB*2
TIMEDELAY              EQU 360                                                         ; Number of frames before the triangle is rendered
STARTDXDESCEND_OFFSET  EQU 180

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
TRIANGLE_END_OFFSET    EQU 24

; VARIABLES
ACCELLERATIONVECTOR:
  dc.l                   $00000001

; ********************************* ARRAY OF TRIANGLES DEFINITION - START
TRIANGLES:
TRIANGLE_1:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   0                                                             ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   2                                                             ; STROKE
  dc.b                   2                                                             ; FILL
  dc.w                   TIMEDELAY*0                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
TRIANGLE_2:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   0                                                             ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   2                                                             ; STROKE
  dc.b                   1                                                             ; FILL
  dc.w                   TIMEDELAY*1                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
TRIANGLE_3:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   0                                                             ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   3                                                             ; STROKE
  dc.b                   1                                                             ; FILL
  dc.w                   TIMEDELAY*2                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
TRIANGLE_4:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   0                                                             ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   1                                                             ; STROKE
  dc.b                   3                                                             ; FILL
  dc.w                   TIMEDELAY*3                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
; ********************************* ARRAY OF TRIANGLES DEFINITION - START


STAGEWALK: ; 0 => X right walk 1 => Climb the screen on the right side
  dc.w                   0

;MACROS

DEBUG MACRO
  clr.w                  $100
  move.w                 #$\1,d3
  ENDM

; Macro to get current angle and move the pointer to the next
NEXT_WALKING_ANGLE  MACRO
  move.l                 XROLLINGANGLE(PC),a0
  move.w                 (a0),\1
  subq                   #2,a0
  move.l                 a0,XROLLINGANGLE
  ENDM

UPDATE_TRANSLATION  MACRO
  cmpi.w                 \1,ANGLE
  bne.s                  .walkingtriangle_no_reset_angle
  move.w                 #0,ANGLE
  add.w                  \3,\2
  move.l                 #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE
.walkingtriangle_no_reset_angle:
  ENDM

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
  moveq                  #4-1,d5
walkingtriangle_start:
  tst.w                  SLEEP_OFFSET(a3)
  beq.s                  walkingtriangle_nodelay
  sub.w                  #1,SLEEP_OFFSET(a3)
  bra.s                  walkingtriangle_gotonext
walkingtriangle_nodelay
  bsr.w                  WALKINGTRIANGLE_PROCESS
walkingtriangle_gotonext:
  adda.l #24,a3
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
  move.w                 XROLLINGOFFSET_OFFSET(a3),d0
  cmpi.w                 #STARTDXCLIMB,XROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing
  cmpi.w                 #325,ANGLE_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing
  move.w                 #1,STAGEWALK_OFFSET(a3)
  move.w                 #359,ANGLE_OFFSET(a3)
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
  scs                    d3                                                            ; d3 will hold FF if 1 is shifted out otherwise 0
  andi.w                 #1,d3
  addq                   #1,d3
  move.w                 d3,LADDER_RIGHT_MOVE
  sub.w                  d2,d1
  jsr                    LOADIDENTITYANDTRANSLATE

                    ; move triangle UP
  add.w                  #1,YROLLINGOFFSET_OFFSET(a3)

                    ; when the triangle reaches thetop, stop the ladder
  cmpi.w                 #STARTDYCLIMBX2,YROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_horizontal_climbing

  move.w                 #0,XROLLINGOFFSET_OFFSET(a3)                                  ; next stage must start with this value to 30
  move.w                 #0,ANGLE_OFFSET(a3)                                           ; next stage must start with this value to zero
  move.w                 #0,LADDER_RIGHT_MOVE
  move.w                 #STARTDYCLIMB,YROLLINGOFFSET_OFFSET(a3)
  move.w                 #2,STAGEWALK_OFFSET(a3)

                    ; restore ladder sprites
  MOVE.L                 #LADDER_1,d0		
  LEA                    SpritePointers,a1                                             ; SpritePointers is in copperlist
  move.w                 d0,6(a1)
  swap                   d0
  move.w                 d0,2(a1)
  LEA                    LADDER_NO_VSTART2,a1 
  move.b                 #LADDERVERTICALPOSITION-LADDERHEIGHT-LADDERSPACING*0,(a1)+
  move.b                 #LADDERHORIZONTALPOSITION+LADDERHORIZONTALSPACING,(a1)+
  move.b                 #LADDERVERTICALPOSITION-LADDERSPACING*0,(a1)+
  move.b                 #$01,(a1)
walkingtriangle_no_horizontal_climbing:

                    ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT          1,#0,#0
  VERTEX2D_INIT          2,#0,#30
  VERTEX2D_INIT          3,#-26,#15

  lea                    OFFBITPLANEMEM,a4
  jsr                    TRIANGLE_BLIT
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
  add.w                  #1,ANGLE_OFFSET(a3)
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


; ---- START IMPLEMENTATION OF Y DESCENDING ON LEFT SCREEN ------------------
walkingtriangle_ywalk_desending:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w                   #6,d0
  asr.w                   #6,d1
  sub.w #13,d0
  sub.w #15,d1
      ; when hitting bottom border stop
  cmpi.w #200,d1
  ble.s notdownborder
  move.w                 #4,STAGEWALK_OFFSET(a3)
notdownborder;
  jsr                    LOADIDENTITYANDTRANSLATE

  ; Add 1 to angle
  add.w                  #2,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  bcs.s                  .increase_angle_by_1_exit
  move.w                 #0,ANGLE_OFFSET(a3)
.increase_angle_by_1_exit:

  ROTATE                 ANGLE_OFFSET(a3)

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

  ; when hitting left border stop
  cmpi.w #30,XPOSITIONVECTOR_OFFSET(a3)
  bne.s notleftborder
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


  ;moveq                  #STARTWALKXPOS,d0
  ;add.w                  #STARTDXCLIMB,d0
  ;sub.w                  XROLLINGOFFSET,d0
  ;move.w                 #STARTWALKYPOS,d1
  ;sub.w                  YROLLINGOFFSET,d1
  ;jsr                    LOADIDENTITYANDTRANSLATE
  ;ROTATE                 ANGLE

  ;bsr.w                  decrease_angle_by_1

  ;UPDATE_TRANSLATION     #240,YROLLINGOFFSET,#-30

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 0 to start horizontal for next frame
  ;cmpi.w                 #0,YROLLINGOFFSET
  ;bne.s                  walkingtriangle_no_vertical_left_descending
  ;cmpi.w                 #330,ANGLE
  ;bne.s                  walkingtriangle_no_vertical_left_descending
  ;move.w                 #4,STAGEWALK
  ;move.w                 #30,XROLLINGOFFSET
  ;move.w                 #0,ANGLE
;walkingtriangle_no_vertical_left_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
;  VERTEX2D_INIT          1,#0,#0
;  VERTEX2D_INIT          2,#0,#-30
;  VERTEX2D_INIT          3,#26,#-15

;  lea                    OFFBITPLANEMEM,a4
;  jsr                    TRIANGLE_BLIT
;  movem.l                (sp)+,d5/a0
;  rts

  ; ---- START IMPLEMENTATION OF X WALKING TO RIGHT ------------------
walkingtriangle_xwalk_right:
  movem.l                (sp)+,d5/a3
  rts
  ;moveq                  #STARTWALKXPOS,d0
  ;add.w                  XROLLINGOFFSET,d0
  ;move.w                 #STARTWALKYPOS,d1
  ;jsr                    LOADIDENTITYANDTRANSLATE
  ;NEXT_WALKING_ANGLE     ANGLE
  ;ROTATE                 ANGLE

  ;bsr.w                 decrease_angle_by_1

  ;UPDATE_TRANSLATION     #241,XROLLINGOFFSET,#30

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  ;cmpi.w                 #STARTDXCLIMB,XROLLINGOFFSET
  ;bne.s                  walkingtriangle_no_vertical_climbing_2
  ;cmpi.w                 #325,ANGLE
  ;bne.s                  walkingtriangle_no_vertical_climbing_2
  ;move.w                 #1,STAGEWALK
  ;move.w                 #30,YROLLINGOFFSET
  ;move.w                 #359,ANGLE
;walkingtriangle_no_vertical_climbing_2:
  
  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  ;VERTEX2D_INIT          1,#-15,#-26
  ;VERTEX2D_INIT          2,#-30,#0
  ;VERTEX2D_INIT          3,#0,#0

  ;lea                    OFFBITPLANEMEM,a4
  ;jsr                    TRIANGLE_BLIT
  movem.l                (sp)+,d5/a3
  rts

walkingtriangle_sleep:
  movem.l                (sp)+,d5/a3
  rts



