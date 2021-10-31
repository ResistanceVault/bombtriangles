SETBEATDELAY MACRO
            move.w              \1,BEATDELAY+2
            ENDM
            
  include    endfunctions.s


DRAWFUNCTARRAY_START:
  dc.l       BIGTRIANGLE_Z            ; 1
  dc.l       BIGTRIANGLE_Z            ; 2
  dc.l       BIGTRIANGLE_Z            ; 3
  dc.l       BIGTRIANGLE_Z            ; 4
  dc.l       BIGTRIANGLE_Z            ; 5
  dc.l       BIGTRIANGLE_Z            ; 6
  dc.l       TRANSITION1              ; 7
  dc.l       DOUBLETRIANGLEX          ; 8
  dc.l       DOUBLETRIANGLEY          ; 9
  dc.l       ROLLINGTRIANGLE           ; 10
  dc.l       SMALLTRIANGLE           ; 11
  dc.l       MEDIUMTRIANGLE           ; 12
  dc.l       BIGTRIANGLE              ; 13
DRAWFUNCTARRAY_END:

LAST_ITERATION_FUNCTION_START: 
  dc.l       VOID                     ; 1
  dc.l       VOID                     ; 2
  dc.l       VOID                     ; 3
  dc.l       VOID                     ; 4
  dc.l       VOID                     ; 5
  dc.l       LAST_TRIANGLE_CLEAR      ; 6
  dc.l       TRANSITION_CLEAR          ; 7
  dc.l       DOUBLETRIANGLEX_CLEAR    ; 8
  dc.l       DOUBLETRIANGLEY_CLEAR                     ; 9
  dc.l       ROLLINGTRIANGLE_CLEAR                     ; 10
  dc.l       VOID                     ; 11
  dc.l       VOID                     ; 12
  dc.l       VOID                     ; 12

LAST_ITERATION_FUNCTION_END: