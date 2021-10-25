; Variables
XROLLINGOFFSET:
  dc.w                0

XROLLINGANGLE:
  dc.l ROTATION_ANGLES_512_END-2

; Animation function
ROLLINGTRIANGLE:
  ENABLE_CLIPPING

  LOADIDENTITY

  move.w              #0,d0
  move.w              #128,d1
  jsr                 TRANSLATE

  move.w              #15,d0
  add.w               XROLLINGOFFSET,d0
  move.w              #13,d1
  jsr                 TRANSLATE

  move.l XROLLINGANGLE,a0
  move.w (a0),ANGLE
  suba.l #4,a0
    move.l a0,XROLLINGANGLE


  ROTATE              ANGLE
  
  ;bsr.w               decrease_angle_by_1
  cmpi.w              #241,ANGLE
  bne.s               rollingtriangle_no_reset_angle
  move.w              #0,ANGLE
  add.w               #30,XROLLINGOFFSET
    move.l #ROTATION_ANGLES_512_END-2,XROLLINGANGLE


rollingtriangle_no_reset_angle:


  move.w              #-15,d0
  move.w              #-26,d1

  move.w              #-30,d6
  move.w              #0,d3

  move.w              #0,d4
  move.w              #0,d5

  WAITBLITTER
  jsr                 TRIANGLE

  LOADIDENTITY

  move.w              #-60,d0
  move.w              #128,d1
  jsr                 TRANSLATE

  move.w              #15,d0
  add.w               XROLLINGOFFSET,d0
  move.w              #13,d1
  jsr                 TRANSLATE
  ROTATE ANGLE

    move.w              #-15,d0
  move.w              #-26,d1

  move.w              #-30,d6
  move.w              #0,d3

  move.w              #0,d4
  move.w              #0,d5
  jsr                 TRIANGLE

  DISABLE_CLIPPING
  rts

; Clean function
ROLLINGTRIANGLE_CLEAR:
  move.w              #0,ANGLE
  move.w              #0,XROLLINGOFFSET
  rts