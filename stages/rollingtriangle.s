NUMROLLS equ 16

; Variables


XROLLINGANGLE:
  dc.l                ROTATIONS_ANGLES_64_180-2

XDIFF:
  dc.w                0



; Animation function
ROLLINGTRIANGLE:
  ENABLE_CLIPPING

  move.l              #CLEAR_BPL_1,CLEARFUNCTION

  move.w              #-90,d0
  move.w              #128,d1
  jsr                 LOADIDENTITYANDTRANSLATE

  move.w              #15,d0
  add.w               XROLLINGOFFSET,d0
  move.w              #13,d1
  jsr                 TRANSLATE

  move.l              XROLLINGANGLE,a0
  move.w              (a0),ANGLE
  suba.l              #2,a0
  move.l              a0,XROLLINGANGLE

  ROTATE              ANGLE
  
  cmpi.w              #241,ANGLE
  bne.s               rollingtriangle_no_reset_angle
  move.w              #0,ANGLE
  add.w               #30,XROLLINGOFFSET
  move.l              #ROTATIONS_ANGLES_64_180-2,XROLLINGANGLE


rollingtriangle_no_reset_angle:


  move.w              #-15,d0
  move.w              #-26,d1

  move.w              #-30,d6
  moveq              #0,d3

  moveq              #0,d4
  moveq              #0,d5

  jsr                 TRIANGLE_NODRAW

  WAITBLITTER
  move.w              #60,XDIFF
  jsr                 ammx_fill_table_clip_noreset
  move.w              #120,XDIFF
  jsr                 ammx_fill_table_clip_noreset
  move.w              #180,XDIFF
  jsr                 ammx_fill_table_clip_noreset
  move.w              #240,XDIFF
  jsr                 ammx_fill_table_clip_noreset
  move.w              #300,XDIFF
  jsr                 ammx_fill_table_clip_noreset
  move.w              #360,XDIFF
  jsr                 ammx_fill_table_clip_noreset
  STROKE              #1
  jsr                 ammx_fill_table_clip

  cmpi.w              #30*NUMROLLS,XROLLINGOFFSET
  bne.s               noresetxrolling
  sub.w               #60,XROLLINGOFFSET
  sub.w               #2,NUMROLLS
noresetxrolling

  rts

; Clean function
ROLLINGTRIANGLE_CLEAR:
  move.w              #0,ANGLE
  move.w              #0,XDIFF
  move.w              #0,XROLLINGOFFSET
  move.l              #CLEAR,CLEARFUNCTION
  DISABLE_CLIPPING

  rts




ammx_fill_table_clip_noreset:
  movem.l             d0-d7/a0-a6,-(sp)                           ; stack save
  move.w              #1,AMMX_FILL_TABLE_FIRST_DRAW

  lea                 FILL_TABLE,a0

	; Reposition inside the fill table according to the starting row
  move.w              AMMXFILLTABLE_CURRENT_ROW,d6
  move.w              AMMXFILLTABLE_END_ROW,d5
  move.w              d6,d1
  lsl.w               #2,d6
  add.w               d6,a0
	; end of repositioning

  cmp.w               d5,d1
  bgt.s               ammx_fill_table_end_clip_noreset
  sub.w               d1,d5

  lea                 PLOTREFS,a4
  add.w               d1,d1
  move.w              0(a4,d1.w),d1

  IFD                 USE_DBLBUF
  move.l              SCREEN_PTR_0,a5
  ELSE
  lea                 SCREEN_0,a5
  ENDC

  move.w              #40,a6
  move.l              #$013F0000,a1
  move.w              #$7FFF,a2
  move.w              #$8000,a4

ammx_fill_table_nextline_clip_noreset:

  move.w              (a0)+,d6                                    ; start of fill line
	;move.w a2,(a0)+
  move.l              a1,d7
  move.w              (a0)+,d7                                    ; end of fill line
  sub.w               XDIFF,d6
  sub.w               XDIFF,d7
	;move.w a4,(a0)+

  ;sub.w #30,d6
  ;sub.w #30,d7
	
	; clip start
	; if left is negative left is zero
  IFD                 VAMPIRE
  pmaxsw              #0,d6,d6
  ELSE
  btst                #15,d6
  seq                 d0
  ext.w               d0
  and.w               d0,d6
  ENDC
	
	; if right > screen resolution then right = screen resolution
  IFD                 VAMPIRE
  pminsw              #319,d7,d7
  ELSE
  cmpi.w              #319,d7
  sgt                 d0
  moveq               #16,d4
  and.w               d0,d4
  lsr.l               d4,d7
  ENDC
	; clip end
	
  jsr                 ammx_fill_table_single_line_bpl1
  add.w               a6,d1
	
  dbra                d5,ammx_fill_table_nextline_clip_noreset
ammx_fill_table_end_clip_noreset:
	;move.w #-1,AMMXFILLTABLE_END_ROW
  movem.l             (sp)+,d0-d7/a0-a6
  rts