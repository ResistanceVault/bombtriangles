SHEARDEFAULT equ 32

SHEARX:
  dc.w           SHEARDEFAULT
SHEARX_TREMBLE:
  dc.w           2

SHEARTRIANGLE:
  cmpi.w #1,MUSICCOUNTER
  bne.s dontchangeshear
  neg.w SHEARX
dontchangeshear:
  move.w         #160,d0
  move.w         #128,d1

  jsr            LOADIDENTITYANDTRANSLATE  

  move.w         SHEARX,d0
  move.w         SHEARX_TREMBLE,d1
  add.w          d1,d0
  neg            d1
  move.w         d0,SHEARX
  move.w         d1,SHEARX_TREMBLE
  move.w         #%0000000000000000,d1
  jsr            SHEAR

  move.w         #0,d0
  move.w         #-25,d1

  move.w         #-25,d6
  move.w         #65,d3

  move.w         #25,d4
  move.w         #65,d5

  jsr            TRIANGLE_NODRAW

  WAITBLITTER
  STROKE         #1

  jsr            ammx_fill_table
  
  rts

SHEARTRIANGLE_CLEAR:
  move.w #SHEARDEFAULT,SHEARX
  rts