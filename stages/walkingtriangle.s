; DEFINES
STARTWALKXPOS EQU 94                                                ; Start triangle position X (signed value)
STARTWALKYPOS EQU 128+13                                            ; Start triangle position Y (signed value)

STARTDXCLIMB  EQU 210                                               ; X Position where to start climbing the screen (must be multiple of 30, size of the triangle)
STARTDYCLIMB  EQU 90

; VARIABLES
YROLLINGOFFSET:
  dc.w                  30                                          ; Increment by 30 while climbing

ANGLE_YWALK:
  dc.w                  359

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

; Animation function
WALKINGTRIANGLE:
  ENABLE_CLIPPING

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

  ; Calculate the origin point which is the lower right vertex of the triangle
  ; This is important because the triangle must rotate around this vertex
  ; To calculate this point:
  ; - the X position is the start walking position X coord * num revolutions
  ; - the Y position is the Y start walking position Y coord
  ; Pseudocode:
  ; - resetMatrix();
  ; - translate(STARTWALKXPOS+XROLLINGOFFSET,STARTWALKYPOS)
  move.w                #STARTWALKXPOS,d0
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
  cmpi.w                #241,ANGLE
  bne.s                 walkingtriangle_no_reset_angle
  move.w                #0,ANGLE
  add.w                 #30,XROLLINGOFFSET
  move.l                #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE
walkingtriangle_no_reset_angle:

; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                #STARTDXCLIMB,XROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_climbing
  cmpi.w                #325,ANGLE
  bne.s                 walkingtriangle_no_vertical_climbing
  move.w                #1,STAGEWALK
  ;if (angle>=30 && numrevolutions>1)
  ;  {
  ;    angle-=0.5;
  ;        stagewalk =1;
;
 ;   }
walkingtriangle_no_vertical_climbing:

  ; Triangle calculation (notice the third vertex is the origin, important to rotate around this point)
  moveq                 #-15,d0                                     ; vertex 1 (X)
  moveq                 #-26,d1                                     ; vertex 2 (Y)
  moveq                 #-30,d6                                     ; vertex 2 (X)
  moveq                 #0,d3                                       ; vertex 2 (Y)
  moveq                 #0,d4                                       ; vertex 3 (X)
  moveq                 #0,d5                                       ; vertex 3 (Y)
  jsr                   TRIANGLE_NODRAW

  WAITBLITTER

  ; Color 1
  STROKE                #1

  ; Draw the triangle
  jsr                   ammx_fill_table_clip
  rts

; ---- START IMPLEMENTATION OF Y CLIMBING ------------------
walkingtriangle_ywalk:
  move.w                #STARTWALKXPOS,d0
  add.w                 #STARTDXCLIMB,d0
  move.w                #STARTWALKYPOS,d1
  sub.w                 YROLLINGOFFSET,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  ROTATE                ANGLE_YWALK

  ; ANGLE_YWALK UPDATE
  add.w                 #-1,ANGLE_YWALK
  cmp.w                 #180+60,ANGLE_YWALK
  bne.w                 walkingtriangle_ywalk_noreset
  move.w                #359,ANGLE_YWALK
  add.w                 #30,YROLLINGOFFSET
walkingtriangle_ywalk_noreset:

; If got N revolutions and the angle is >= 360-30 SET the stage to 2 to start horizontal climbing for next frame
  cmpi.w                #STARTDYCLIMB,YROLLINGOFFSET
  bne.s                 walkingtriangle_no_horizontal_climbing
  cmpi.w                #331,ANGLE_YWALK
  bne.s                 walkingtriangle_no_horizontal_climbing
  move.w                #30,XROLLINGOFFSET                          ; next stage must start with this value to 30
  move.w                #0,ANGLE                                    ; next stage must start with this value to zero
  move.w                #2,STAGEWALK
walkingtriangle_no_horizontal_climbing:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  moveq                 #0,d0                                       ; vertex 1 (X)
  moveq                 #0,d1                                       ; vertex 2 (Y)
  moveq                 #0,d6                                       ; vertex 2 (X)
  moveq                 #30,d3                                      ; vertex 2 (Y)
  moveq                 #-26,d4                                     ; vertex 3 (X)
  moveq                 #15,d5                                      ; vertex 3 (Y)
  jsr                   TRIANGLE_NODRAW
  WAITBLITTER
  STROKE                #1
  ; Draw the triangle
  jsr                   ammx_fill_table_clip
  rts

; ---- START IMPLEMENTATION OF X REVERSE CLIMBING ------------------
walkingtriangle_xwalk_rev:
  move.w                #STARTWALKXPOS,d0
  add.w                 #STARTDXCLIMB,d0
  sub.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  sub.w                 YROLLINGOFFSET,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  ROTATE                ANGLE

  bsr.w                 decrease_angle_by_1

  cmpi.w                #241,ANGLE
  bne.s                 walkingtriangle_xwalk_noanglereset
  move.w                #359,ANGLE
  add.w                 #30,XROLLINGOFFSET
walkingtriangle_xwalk_noanglereset:

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 3 to start vertical descending for next frame
  cmpi.w                #STARTDXCLIMB,XROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_descending
  cmpi.w                #331,ANGLE
  bne.s                 walkingtriangle_no_vertical_descending
  move.w                #3,STAGEWALK
  sub.w #30,YROLLINGOFFSET
  move.w #0,ANGLE
walkingtriangle_no_vertical_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  moveq                 #0,d0                                       ; vertex 1 (X)
  moveq                 #0,d1                                       ; vertex 2 (Y)
  moveq                 #30,d6                                      ; vertex 2 (X)
  moveq                 #0,d3                                       ; vertex 2 (Y)
  moveq                 #15,d4                                      ; vertex 3 (X)
  moveq                 #26,d5                                      ; vertex 3 (Y)
  jsr                   TRIANGLE_NODRAW

  WAITBLITTER
  STROKE                #1
  ; Draw the triangle
  jsr                   ammx_fill_table_clip
  rts

; ---- START IMPLEMENTATION OF Y DESCENDING ON LEFT SCREEN ------------------
walkingtriangle_ywalk_desending:
  move.w                #STARTWALKXPOS,d0
  add.w                 #STARTDXCLIMB,d0
  sub.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  sub.w                 YROLLINGOFFSET,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  ROTATE ANGLE

  bsr.w decrease_angle_by_1

  cmpi.w                #241,ANGLE
  bne.s                 walkingtriangle_ywalkdescent_noanglereset
  move.w                #359,ANGLE
  sub.w #30,YROLLINGOFFSET
walkingtriangle_ywalkdescent_noanglereset:

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 0 to start horizontal for next frame
  cmpi.w                #0,YROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_left_descending
  cmpi.w                #330,ANGLE
  bne.s                 walkingtriangle_no_vertical_left_descending
  move.w                #4,STAGEWALK
  move.w #30,XROLLINGOFFSET
  move.w #0,ANGLE
walkingtriangle_no_vertical_left_descending:

  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  moveq                 #0,d0                                       ; vertex 1 (X)
  moveq                 #0,d1                                       ; vertex 2 (Y)
  moveq                 #0,d6                                      ; vertex 2 (X)
  moveq                 #-30,d3                                       ; vertex 2 (Y)
  moveq                 #26,d4                                      ; vertex 3 (X)
  moveq                 #-15,d5                                      ; vertex 3 (Y)
  jsr                   TRIANGLE_NODRAW

  WAITBLITTER
  STROKE                #1
  ; Draw the triangle
  jsr                   ammx_fill_table_clip
  rts

  ; ---- START IMPLEMENTATION OF X WALKING TO RIGHT ------------------
walkingtriangle_xwalk_right:
  move.w                #STARTWALKXPOS,d0
  ;add.w                 #STARTDXCLIMB,d0
  add.w                 XROLLINGOFFSET,d0
  move.w                #STARTWALKYPOS,d1
  jsr                   LOADIDENTITYANDTRANSLATE
  ROTATE ANGLE

  bsr.w decrease_angle_by_1

  cmpi.w                #241,ANGLE
  bne.s                 walkingtriangle_xwalkright_noanglereset
  move.w                #359,ANGLE
  add.w #30,XROLLINGOFFSET
walkingtriangle_xwalkright_noanglereset:

  ; If got N revolutions and the angle is >= 360-30 SET the stage to 1 to start vertical climbing for next frame
  cmpi.w                #STARTDXCLIMB,XROLLINGOFFSET
  bne.s                 walkingtriangle_no_vertical_climbing_2
  cmpi.w                #325,ANGLE
  bne.s                 walkingtriangle_no_vertical_climbing_2
  move.w                #1,STAGEWALK
  move.w                #30,YROLLINGOFFSET
  move.w #359,ANGLE_YWALK
walkingtriangle_no_vertical_climbing_2:
  
  ; Triangle calculation (notice the first vertex is the origin, important to rotate around this point)
  moveq                 #-15,d0                                     ; vertex 1 (X)
  moveq                 #-26,d1                                     ; vertex 2 (Y)
  moveq                 #-30,d6                                     ; vertex 2 (X)
  moveq                 #0,d3                                       ; vertex 2 (Y)
  moveq                 #0,d4                                       ; vertex 3 (X)
  moveq                 #0,d5                                       ; vertex 3 (Y)
  jsr                   TRIANGLE_NODRAW
  WAITBLITTER
  STROKE                #1
  ; Draw the triangle
  jsr                   ammx_fill_table_clip
  rts

