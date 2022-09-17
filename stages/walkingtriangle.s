; DEFINES
NUMTRIANGLES           EQU 5                                                           ; How many triangles do we want?? range(0,4)
STARTWALKXPOS          EQU 30                                                          ; Start triangle position X (signed value)
STARTWALKYPOS          EQU 184
LADDERVERTICALPOSITION   equ STARTWALKYPOS+49                                          ; Start triangle position Y (signed value)

STARTDXCLIMB           EQU 300-60                                                      ; X Position where to start climbing the screen (must be multiple of 30, size of the triangle)
STARTDYCLIMB           EQU 150
STARTDYCLIMBX2         EQU STARTDYCLIMB*2
TIMEDELAY              EQU 600                                                         ; Number of frames before the triangle is rendered
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
STAGEPOINTER_OFFSET    EQU 26
COUNTER_OFFSET         EQU 30
TRIANGLE_END_OFFSET    EQU 32

SPACESHIP_LOCATION_LOAD_X   EQU 122
SPACESHIP_LOCATION_LOAD_Y   EQU 160
SPACESHIP_LOCATION_UNLOAD_X EQU 68
SPACESHIP_LOCATION_UNLOAD_Y EQU 195



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
  dc.b                   1                                                             ; FILL
  dc.w                   TIMEDELAY*0                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
  dc.l                   teletrasportationend                                          ; STAGE_POINTER
  dc.w                   -1                                                            ; GENERAL PURPOSE COUNTER
TRIANGLE_2:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   1                                                             ; STROKE
  dc.b                   2                                                             ; FILL
  dc.w                   TIMEDELAY*1                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
  dc.l                   teletrasportationend                                          ; STAGE_POINTER
  dc.w                   -1                                                            ; GENERAL PURPOSE COUNTER
TRIANGLE_3:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   2                                                             ; STROKE
  dc.b                   3                                                             ; FILL
  dc.w                   TIMEDELAY*2                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
  dc.l                   teletrasportationend                                          ; STAGE_POINTER
  dc.w                   -1                                                            ; GENERAL PURPOSE COUNTER
TRIANGLE_4:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   2                                                             ; STROKE
  dc.b                   0                                                             ; FILL
  dc.w                   TIMEDELAY*3                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
  dc.l                   teletrasportationend                                          ; STAGE_POINTER
  dc.w                   -1                                                            ; GENERAL PURPOSE COUNTER
TRIANGLE_5:
  dc.w                   0                                                             ; ANGLE
  dc.w                   0                                                             ; XROLLINGOFFSET
  dc.w                   30                                                            ; YROLLINGOFFSET
  dc.w                   STARTSTAGE                                                    ; STAGE
  dc.l                   ROTATIONS_ANGLES_64_180-2                                     ; XROLLINGANGLE
  dc.b                   1                                                             ; STROKE
  dc.b                   1                                                             ; FILL
  dc.w                   TIMEDELAY*4                                                   ; SLEEP
  dc.w                   64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET)         ; POSITIONVECTOR X
  dc.w                   64*(STARTWALKYPOS+15-STARTDYCLIMB)                            ; POSITIONVECTOR Y
  dc.w                   0                                                             ; VELOCITYVECTOR X
  dc.w                   0                                                             ; VELOCITYVECTOR Y
  dc.w                   START_SCALE_FACTOR                                            ; SCALE_FACTOR
  dc.l                   teletrasportationend                                          ; STAGE_POINTER
  dc.w                   -1                                                            ; GENERAL PURPOSE COUNTER

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

SETSTAGE MACRO
  move.l #\1,STAGEPOINTER_OFFSET(a3)
  ENDM

  IFD                 DEBUGCOLORS
DBGTRIGCOLS:
    dc.w $0F00
    dc.w $0333
    dc.w $0666
    dc.w $0999
    dc.w $0CCC
  ENDC

; Entry function
WALKINGTRIANGLE:
  ; For each triangle
  lea                    TRIANGLES(PC),a3
  moveq                  #NUMTRIANGLES-1,d5
walkingtriangle_start:
  IFD                    DEBUGCOLORS
  lea                    DBGTRIGCOLS,a0
  lsl.w                  #1,d5
  move.w                 (a0,d5.w),$dff180
  lsr.w                  #1,d5
  ENDC
  tst.w                  SLEEP_OFFSET(a3)
  beq.s                  walkingtriangle_nodelay
  subq                   #1,SLEEP_OFFSET(a3)
  bra.s                  walkingtriangle_gotonext
walkingtriangle_nodelay
  movem.l                d5/a3,-(sp)
  STROKE                 STROKE_OFFSET(a3)
  FILL                   FILL_OFFSET(a3)
  move.l                 STAGEPOINTER_OFFSET(a3),a0
  jsr                    (a0)
  movem.l                (sp)+,d5/a3
walkingtriangle_gotonext:
  adda.l                 #TRIANGLE_END_OFFSET,a3
  dbra                   d5,walkingtriangle_start
  rts

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
walkingtriangle_xwalk:
  moveq                  #STARTWALKXPOS,d0
  add.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ; Put the angle into the ANGLE variable - then point to the next angle;
  ; Data is taken from the XROLLINGANGLE table
  NEXT_WALKING_ANGLE2    ANGLE_OFFSET(a3)

  ; Rotate around right-bottom vertex
  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG

  ; each time angle is 241 I have a full revolution aroung the vertex, in this case:
  ; - reset the angle
  ; - reset the angle pointer
  ; add the length of the triangle to the XROLLINGOFFSET
  UPDATE_TRANSLATION2    #241,XROLLINGOFFSET_OFFSET(a3),#30

; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                 #STARTDXCLIMB/2,XROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing
  move.w                 #1,STAGEWALK_OFFSET(a3)
  SETSTAGE               compress
  move.w                 #-2*64,YVELOCITYVECTOR_OFFSET(a3)
  move.l                 #0,POSITIONVECTOR_OFFSET(a3)
  move.w                 #64,SCALEFACTOR_OFFSET(a3)
  IFD LADDERS
  START_LADDERS
  ENDC

walkingtriangle_no_vertical_climbing:

  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT_I        1,FFF1,FFE6  ; -15,-26
  VERTEX2D_INIT_I        2,FFE2,0000  ; -30,0
  VERTEX2D_INIT_I        3,0000,0000  ;   0,0

  jsr                    TRIANGLE_BLIT

  rts
  ; ***************************** END OF FIRST HORIZONTAL WALKING

   ; ***************************** START OF FIRST HORIZONTAL WALKING
  ; Calculate the origin point which is the lower right vertex of the triangle
  ; This is important because the triangle must rotate around this vertex
  ; To calculate this point:
  ; - the X position is the start walking position X coord * num revolutions
  ; - the Y position is the Y start walking position Y coord
  ; Pseudocode:
  ; - resetMatrix();
  ; - translate(STARTWALKXPOS+XROLLINGOFFSET,STARTWALKYPOS)
walkingtriangle_xwalk2:
  moveq                  #STARTWALKXPOS,d0
  add.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ; Put the angle into the ANGLE variable - then point to the next angle;
  ; Data is taken from the XROLLINGANGLE table
  NEXT_WALKING_ANGLE2    ANGLE_OFFSET(a3)

  ; Rotate around right-bottom vertex
  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG

  ; each time angle is 241 I have a full revolution aroung the vertex, in this case:
  ; - reset the angle
  ; - reset the angle pointer
  ; add the length of the triangle to the XROLLINGOFFSET
  UPDATE_TRANSLATION2    #241,XROLLINGOFFSET_OFFSET(a3),#30

; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                 #STARTDXCLIMB,XROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing2
  cmpi.w                 #326,ANGLE_OFFSET(a3)
  bne.s                  walkingtriangle_no_vertical_climbing2
  move.w                 #1,STAGEWALK_OFFSET(a3)
  SETSTAGE               bigspaceship_activation
  move.w                 #64,SCALEFACTOR_OFFSET(a3)
  move.w                 #359,ANGLE_OFFSET(a3)
  IFD LADDERS
  START_LADDERS
  ENDC

walkingtriangle_no_vertical_climbing2:

  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT_I        1,FFF1,FFE6  ; -15,-26
  VERTEX2D_INIT_I        2,FFE2,0000  ; -30,0
  VERTEX2D_INIT_I        3,0000,0000  ;   0,0

  jsr                    TRIANGLE_BLIT

  rts
  ; ***************************** END OF FIRST HORIZONTAL WALKING

  ; ***************************** START IMPLEMENTATION OF BIG SPACESHIP ACTIVATION ------------------
BIGSPACESHIP_SHEAR:
  dc.w  0
BIGSPACESHIP_COLORSTABLE_PTR:
  dc.l BIGSPACESHIP_COLORSTABLE

bigspaceship_activation:
  ; Translate
  move.w                 #STARTWALKXPOS+STARTDXCLIMB-13,d0
  move.w                 #STARTWALKYPOS,d1
  move.w                 YROLLINGOFFSET_OFFSET(a3),d2
  lsr.w                  #1,d2
  sub.w                  d2,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  move.w                 BIGSPACESHIP_SHEAR,d0
  moveq                  #0,d1
  sub.w                  #1,BIGSPACESHIP_SHEAR
  jsr                    SHEAR_REG

  ; ray is descending
  move.w                 #1,TWISTERFLAG
  cmpi.w                 #TWISTER_SPR_NUM_ROWS,TWISTER_MASK_ROWS_COUNTER
  beq.s                  bigspaceship_activation_nextstage
  subi.w                 #1,TWISTERDECR
  tst.w                  TWISTERDECR
  bne.s                  bigspaceship_activation_draw
  move.w                 #TWISTER_INC_SPEED,TWISTERDECR
  addi.w                 #1,TWISTER_MASK_ROWS_COUNTER
  bra.s                  bigspaceship_activation_draw
bigspaceship_activation_nextstage:
  SETSTAGE               walkingtriangle_ywalk
bigspaceship_activation_draw:

  VERTEX2D_INIT_I        1,000D,FFF1 ;   13,-15
  VERTEX2D_INIT_I        2,000D,000F ;   13,15
  VERTEX2D_INIT_I        3,FFF3,0000 ;   -13,0

  jsr                    TRIANGLE_BLIT

  IFD EFFECTS
  bsr.w                  cyclebigspaceshipcolors
  ENDC

  rts
; ***************************** END IMPLEMENTATION OF BIG SPACESHIP ACTIVATION ------------------

TWISTERFLAG:
  dc.w 0
MIRRORFLAG:
  dc.w %0000000001000000

; ***************************** START IMPLEMENTATION OF Y CLIMBING ------------------
walkingtriangle_ywalk:
  ; Translate
  move.w                 #STARTWALKXPOS+STARTDXCLIMB-13,d0
  move.w                 #STARTWALKYPOS,d1
  move.w                 YROLLINGOFFSET_OFFSET(a3),d2
  lsr.w                  #1,d2
  sub.w                  d2,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  ; start shear

  move.w                 BIGSPACESHIP_SHEAR,d0
  moveq                  #0,d1
  add.w                  #1,BIGSPACESHIP_SHEAR
  tst                    BIGSPACESHIP_SHEAR
  ble.s                  shearnotzero
  moveq                  #0,d0
shearnotzero:
  jsr                     SHEAR_REG

  ; Scale on X to point the triangle to the right - start

  ; Add 1 to angle
  addq                   #2,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  bcs.s                  .increase_angle_by_1_exitlol
  move.w                 #0,ANGLE_OFFSET(a3)
.increase_angle_by_1_exitlol:
  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG
norotate:

  move.w                 MIRRORFLAG,d0
  moveq                  #%0000000001000000,d1
  cmpi.w                 #%1111111110111110,d0
  beq.s                  donotmirror
  subq.w                 #1,MIRRORFLAG
donotmirror:
  jsr                    SCALE_REG
noinverttrigend:
  ; Scale on X to point the triangle to the right - end

  ; move triangle UP 1 pixel
  addq                   #1,YROLLINGOFFSET_OFFSET(a3)

   IFD EFFECTS
  bsr.w                  cyclebigspaceshipcolors
  ENDC

  ; when the triangle reaches the top, go to next stage
  cmpi.w                 #STARTDYCLIMBX2,YROLLINGOFFSET_OFFSET(a3)
  bne.s                  walkingtriangle_no_horizontal_climbing

  move.w                 #0,XROLLINGOFFSET_OFFSET(a3)                                  ; next stage must start with this value to 30
  move.w                 #0,ANGLE_OFFSET(a3)                                           ; next stage must start with this value to zero
  move.w                 #STARTDYCLIMB-1,YROLLINGOFFSET_OFFSET(a3)
  move.w                 #0,TWISTERFLAG
  move.w                 #%0000000001000000,MIRRORFLAG
  move.w                 #0,BIGSPACESHIP_SHEAR
  IFD EFFECTS
  ;move.w                 #$0f00,2+BIGSPACESHIP_ACTIVE_COLORS
  move.l                 #BIGSPACESHIP_COLORSTABLE,BIGSPACESHIP_COLORSTABLE_PTR
  ENDC
  SETSTAGE               walkingtriangle_xwalk_rev
  IFD LADDERS
  STOP_LADDERS
  ENDC

walkingtriangle_no_horizontal_climbing:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT_I        1,000D,FFF1 ;   13,-15
  VERTEX2D_INIT_I        2,000D,000F ;   13,15
  VERTEX2D_INIT_I        3,FFF3,0000 ;  -13,0

  jsr                    TRIANGLE_BLIT

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

  ; move twister down one pixel
  tst.w                  TWISTERFLAG ; make sure the twister is not going up
  bne.s                  donotdecreasetwister
  cmp.w                  #0,TWISTER_MASK_ROWS_COUNTER
  beq.s                  donotdecreasetwister
  subq.w                 #1,TWISTERDECR ; we dont want to decrement each frame
  bne.s                  donotdecreasetwister
  subq.w                 #1,TWISTER_MASK_ROWS_COUNTER
  move.w                 #TWISTER_DEC_SPEED,TWISTERDECR
donotdecreasetwister:

  ; Add 1 to angle
  addq                   #1,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  bcs.s                  .increase_angle_by_1_exit
  move.w                 #0,ANGLE_OFFSET(a3)
  .increase_angle_by_1_exit:
  move.w                 ANGLE_OFFSET(a3),d0
  jsr ROTATE_REG

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
  SETSTAGE               walkingtriangle_ywalk_desending
walkingtriangle_no_vertical_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT_I        1,0000,0000
  VERTEX2D_INIT_I        2,0000,FFE2
  VERTEX2D_INIT_I        3,FFE6,FFF1

  jsr                    TRIANGLE_BLIT
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
  SETSTAGE                walkingtriangle_xwalk_right
  ; new velocity
  move.l                  a3,a0
  adda.w                  #VELOCITYVECTOR_OFFSET,a0
  moveq                   #1*32,d0
  moveq                   #-1*64,d1
  CREATE2DVECTOR          a0
notdownborder;

  ; Add 2 to angle
  addq                   #2,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  bcs.s                  .increase_angle_by_1_exit
  move.w                 #0,ANGLE_OFFSET(a3)
.increase_angle_by_1_exit:

  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG

  ; add accelleration to velocity
  lea                    ACCELLERATIONVECTOR(PC),a0
  movea.l                a3,a1
  adda.w                 #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; add velocity to position
  movea.l                a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  movea.l                a3,a1
  adda.w                 #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; when hitting left border stop
  cmpi.w                 #30,XPOSITIONVECTOR_OFFSET(a3)
  bne.s                  notleftborder
  move.w                 #4,STAGEWALK_OFFSET(a3)
notleftborder;

  ; Draw triangle
  VERTEX2D_INIT_I        1,000D,000F  ; 13,15
  VERTEX2D_INIT_I        2,000D,FFF1  ; 13,-15
  VERTEX2D_INIT_I        3,FFF3,0000  ; -13,0

  jsr                    TRIANGLE_BLIT
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

  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG

  ; add accelleration to velocity
  lea                    ACCELLERATIONVECTOR(PC),a0
  movea.l                a3,a1
  adda.w                 #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; add velocity to position
  movea.l                a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  movea.l                a3,a1
  adda.w                 #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; when hitting bottom border stop
  cmpi.w                 #SECOND_FLOOR_Y,d7
  ble.s                  notdownborder2
  SETSTAGE               walkingtriangle_xwalk_right_2
  move.w                 #122,XPOSITIONVECTOR_OFFSET(a3)
  move.w                 #98,YPOSITIONVECTOR_OFFSET(a3)
  move.w                 #0,ANGLE_OFFSET(a3)

notdownborder2;

  ; Draw triangle
  VERTEX2D_INIT_I        1,000D,000F     ; 13,15
  VERTEX2D_INIT_I        2,000D,FFF1     ; 13,-15
  VERTEX2D_INIT_I        3,FFF3,0000     ; -13,0
  jsr                    TRIANGLE_BLIT
  rts
  ; ***************************** END IMPLEMENTATION OF X WALKING TO RIGHT second floor  ------------------

  ; ***************************** START IMPLEMENTATION OF X WALKING TO RIGHT second floor part 2 ------------------
SAVE_X: dc.w 0
SAVE_ANGLE: dc.w 0
walkingtriangle_xwalk_right_2:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w d0,SAVE_X
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  jsr                    LOADIDENTITYANDTRANSLATE

  move.w                 ANGLE_OFFSET(a3),d0
  move.w                 d0,SAVE_ANGLE
  jsr                    ROTATE_REG

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
  SETSTAGE               walkingtriangle_reverse_dive
  SPACESHIP_SET_NEW_DESTINATION2 SPACESHIP_LOCATION_LOAD_X,SPACESHIP_LOCATION_LOAD_Y
  ; bomb is blowing up
  jsr                    BOMB_EXPLODE
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  lsl.w                  #6,d0
  move.w                 d0,XPOSITIONVECTOR_OFFSET(a3)
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d0
  lsl.w                  #6,d0
  move.w                 d0,YPOSITIONVECTOR_OFFSET(a3)

  ; new velocity
  move.l                 a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  moveq                  #1*15,d0
  moveq                  #-1*90,d1
  CREATE2DVECTOR         a0

.decrease_angle_by_1_exit:

  ; Draw triangle
  VERTEX2D_INIT_I        1,FFF1,FFE6 ;#-15,#-26
  VERTEX2D_INIT_I        2,FFE2,0000 ;#-30,#0
  VERTEX2D_INIT_I        3,0000,0000 ; #0,#0
  jsr                    TRIANGLE_BLIT

  move.w                 SAVE_X,d6
  cmpi.w                 #$b6,d6
  bne.s                  nobombred
  cmpi.w                 #320,SAVE_ANGLE
  bne.s                  nobombred
  jsr                    BOMB_RED
nobombred:

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

  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG

  ; Add 5 to angle
  addq                   #5,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  blt.s                  .increase_angle_by_5_noreset
  sub.w                  #360,ANGLE_OFFSET(a3)
.increase_angle_by_5_noreset

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

  cmpi.w                 #124,d7
  ble.s                  .noendoffall
  SETSTAGE               walkingfloor1
  ; bomb is ON
  jsr                    BOMB_ON
  SPACESHIP_RAY_ON

   ; new velocity
  move.l                 a3,a0
  adda.w                 #VELOCITYVECTOR_OFFSET,a0
  moveq                  #-1*94,d0
  moveq                  #-1*32,d1
  CREATE2DVECTOR         a0
.noendoffall:

  ; Draw triangle
  VERTEX2D_INIT_I        1,0000,FFF2 ; #-15+15,#-26+12
  VERTEX2D_INIT_I        2,FFF1,000C ; #-30+15,#0+12
  VERTEX2D_INIT_I        3,000F,000C ;  #0+15,#0+12
  jsr                    TRIANGLE_BLIT

  rts

walkingfloor1:
  move.w                 XPOSITIONVECTOR_OFFSET(a3),d0
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d1
  asr.w                  #6,d0
  asr.w                  #6,d1
  sub.w                  #15,d0
  sub.w                  #12,d1
  move.w                 d0,d6
  move.w                 d1,d7
  jsr                    LOADIDENTITYANDTRANSLATE

  move.w                 ANGLE_OFFSET(a3),d0
  jsr                    ROTATE_REG

  ; Add 5 to angle
  addq                   #5,ANGLE_OFFSET(a3)
  cmpi.w                 #360,ANGLE_OFFSET(a3)
  blt.s                  .increase_angle_by_5_noreset_2
  sub.w                  #360,ANGLE_OFFSET(a3)
.increase_angle_by_5_noreset_2

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

  cmpi.w                 #124,d7
  ble.s                  .noendoffall2
  cmpi.w                 #125,d6
  bgt.s                  .noendoffall2
  SETSTAGE               teletrasportationstart
.noendoffall2:

  ; Draw triangle
  VERTEX2D_INIT_I        1,0000,FFF2  ; #-15+15,#-26+12
  VERTEX2D_INIT_I        2,FFF1,000C  ; #-30+15,#0+12
  VERTEX2D_INIT_I        3,000F,000C  ; #0+15,#0+12
  jsr                    TRIANGLE_BLIT
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

  subq                   #1,SCALEFACTOR_OFFSET(a3)
  move.w                 SCALEFACTOR_OFFSET(a3),d0
  move.w                 d0,d1
  bne.w                  .noscale
  SETSTAGE               teletrasportationwait
  SPACESHIP_RAY_OFF
  SPACESHIP_SET_NEW_DESTINATION2 SPACESHIP_LOCATION_UNLOAD_X,SPACESHIP_LOCATION_UNLOAD_Y
  move.w                 #0,XROLLINGOFFSET_OFFSET(a3)
  move.l                 #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE_OFFSET(a3)
  move.w                 #64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET),XPOSITIONVECTOR_OFFSET(a3)
  move.w                 #64*(STARTWALKYPOS+15-STARTDYCLIMB),YPOSITIONVECTOR_OFFSET(a3)
  move.w                 #0,XVELOCITYVECTOR_OFFSET(a3)
  move.w                 #0,YVELOCITYVECTOR_OFFSET(a3)
.noscale
  jsr                    SCALE_REG

  move.w                 ANGLE_OFFSET(a3),d0
  jsr ROTATE_REG

  ; Draw triangle
  VERTEX2D_INIT_I        1,0000,FFF2   ;#-15+15,#-26+12
  VERTEX2D_INIT_I        2,FFF1,000C   ;#-30+15,#0+12
  VERTEX2D_INIT_I        3,000F,000C   ;#0+15,#0+12
  jsr                    TRIANGLE_BLIT

  rts

  ; ***************************** END IMPLEMENTATION OF TELETRANSPORTATION START ------------------


  ; ***************************** START IMPLEMENTATION OF TELETRANSPORTATIN WAIT - WAIT FOR THE SPACESHIP TO REACH TARGET
teletrasportationwait:
  tst.w                  SPACESHIPDIRECTIONVECTOR+2
  bne.s                  wait4spaceship
  SETSTAGE               teletrasportationend
  SPACESHIP_RAY_ON
wait4spaceship:
  rts
  ; ***************************** END IMPLEMENTATION OF TELETRANSPORTATIN WAIT - WAIT FOR THE SPACESHIP TO REACH TARGET

teletrasportationend:
  moveq                  #STARTWALKXPOS-15,d0
  add.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS-13,d1
  jsr                    LOADIDENTITYANDTRANSLATE

  addq                   #1,SCALEFACTOR_OFFSET(a3)
  move.w                 SCALEFACTOR_OFFSET(a3),d0
  move.w                 d0,d1
  cmpi.w                 #1*64,d0
  bne.w                  .noscale2
  SETSTAGE               walkingtriangle_xwalk
  SPACESHIP_RAY_OFF
  ; reset initial values
  move.w                 #30,YROLLINGOFFSET_OFFSET(a3)
.noscale2
  jsr SCALE_REG

  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  VERTEX2D_INIT_I        1,0000,FFEC  ;#0,#-13
  VERTEX2D_INIT_I        2,FFF1,000C  ;#-15,#13
  VERTEX2D_INIT_I        3,000F,000C  ;#15,#13

  jsr                    TRIANGLE_BLIT

  rts

compress:

  moveq                   #STARTWALKXPOS-15,d0
  add.w                   XROLLINGOFFSET_OFFSET(a3),d0
  move.w                  #STARTWALKYPOS,d1

  jsr                     LOADIDENTITYANDTRANSLATE

  DEBUG 1234

  addi.w                  #1,COUNTER_OFFSET(a3)
  andi.w                  #$0007,COUNTER_OFFSET(a3)
  seq                     d7
  ext.w                   d7

  move.w                  SCALEFACTOR_OFFSET(a3),d0
  move.w                  d0,d1
  subi.w                  #64,d0
  neg d0
  addi.w                  #64,d0
  add.w                   d7,SCALEFACTOR_OFFSET(a3)

  cmp.w                   #$55,d0
  bne.s                   noendcompress
  SETSTAGE                bounce
  move.w                  #64,SCALEFACTOR_OFFSET(a3)
  move.w                  #-1,COUNTER_OFFSET(a3)
noendcompress:

  jsr                     SCALE_REG

  ; Centered triangle
  VERTEX2D_INIT_I         1,0000,FFE6  ;#0,#-26
  VERTEX2D_INIT_I        2,FFF1,0000  ;#-15,0
  VERTEX2D_INIT_I        3,000F,0000  ;#15,0

  jsr                    TRIANGLE_BLIT
  rts

bounce:
  ; add gravity
  lea                     ACCELLERATIONVECTOR(PC),a0

  move.l                  a3,a1
  adda.w                  #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; velocity vector is UP
  move.l                  a1,a0
  move.l                  a3,a1
  adda.w                  #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  moveq                   #STARTWALKXPOS-15,d0
  add.w                   XROLLINGOFFSET_OFFSET(a3),d0
  move.w                  #STARTWALKYPOS-13,d1

  move.w                  XPOSITIONVECTOR_OFFSET(a3),d2
  move.w                  YPOSITIONVECTOR_OFFSET(a3),d3
  bpl.s                   bounceend ; if d3 < 0 we are done with the bouncing

  asr.w                   #6,d2
  asr.w                   #6,d3
  add.w                   d2,d0
  add.w                   d3,d1
bounceground:
  jsr                     LOADIDENTITYANDTRANSLATE

  moveq                   #64,d0
  move.w                  SCALEFACTOR_OFFSET(a3),d1
  jsr                     SCALE_REG
  move.w                  COUNTER_OFFSET(a3),d0
  add.w                   d0,SCALEFACTOR_OFFSET(a3)
  cmp.w                   #-64,SCALEFACTOR_OFFSET(a3)
  bne.s                   donotinvertbouncingscaling
  neg.w                   COUNTER_OFFSET(a3)
donotinvertbouncingscaling

  ; Centered triangle
  VERTEX2D_INIT_I         1,0000,FFEC  ;#0,#-13
  VERTEX2D_INIT_I        2,FFF1,000C  ;#-15,#13
  VERTEX2D_INIT_I        3,000F,000C  ;#15,#13

  jsr                    TRIANGLE_BLIT

  rts

bounceend:
  moveq                  #0,d3
  move.w                 #0,XPOSITIONVECTOR_OFFSET(a3)         ; POSITIONVECTOR X
  move.w                 #0,YPOSITIONVECTOR_OFFSET(a3)         ; POSITIONVECTOR Y
  move.w                 #64,SCALEFACTOR_OFFSET(a3)
  move.w                 #-2*64,YVELOCITYVECTOR_OFFSET(a3)
  move.w                 #-1,COUNTER_OFFSET(a3)
  SETSTAGE               bounce2
  bra.s                  bounceground

; Second bounce
bounce2:
  ; add gravity
  lea                    ACCELLERATIONVECTOR(PC),a0
  move.l                 a3,a1
  adda.w                 #VELOCITYVECTOR_OFFSET,a1
  ADD2DVECTOR

  ; velocity vector is UP
  move.l                 a1,a0
  move.l                 a3,a1
  adda.w                 #POSITIONVECTOR_OFFSET,a1
  ADD2DVECTOR

  moveq                  #STARTWALKXPOS-15,d0
  add.w                  XROLLINGOFFSET_OFFSET(a3),d0
  move.w                 #STARTWALKYPOS-13,d1

  move.w                 XPOSITIONVECTOR_OFFSET(a3),d2
  move.w                 YPOSITIONVECTOR_OFFSET(a3),d3
  bpl.s                  bounceend2 ; if d3 < 0 we are done with the bouncing

  asr.w                  #6,d2
  asr.w                  #6,d3
  add.w                  d2,d0
  add.w                  d3,d1
bounceground2:
  jsr                    LOADIDENTITYANDTRANSLATE

  moveq                  #64,d0
  move.w                 SCALEFACTOR_OFFSET(a3),d1
  jsr                    SCALE_REG
  move.w                 COUNTER_OFFSET(a3),d0
  add.w                  d0,SCALEFACTOR_OFFSET(a3)
  cmp.w                  #-64,SCALEFACTOR_OFFSET(a3)
  bne.s                  donotinvertbouncingscaling2
  neg.w                  COUNTER_OFFSET(a3)
donotinvertbouncingscaling2

  ; Centered triangle
  VERTEX2D_INIT_I        1,0000,FFEC  ;#0,#-13
  VERTEX2D_INIT_I        2,FFF1,000C  ;#-15,#13
  VERTEX2D_INIT_I        3,000F,000C  ;#15,#13

  jsr                    TRIANGLE_BLIT

  rts

bounceend2:
  moveq                  #0,d3
  move.w                 #64*(STARTWALKXPOS+STARTDXCLIMB-STARTDXDESCEND_OFFSET),XPOSITIONVECTOR_OFFSET(a3)         ; POSITIONVECTOR X
  move.w                 #64*(STARTWALKYPOS+15-STARTDYCLIMB),YPOSITIONVECTOR_OFFSET(a3)                           ; POSITIONVECTOR Y
  move.w                 #0,YVELOCITYVECTOR_OFFSET(a3)
  move.w                 #-1,COUNTER_OFFSET(a3)
  SETSTAGE               walkingtriangle_xwalk2
  bra.s                  bounceground2

  IFD EFFECTS
cyclebigspaceshipcolors:
  rts
  ENDC