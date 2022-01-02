SETBEATDELAY MACRO
  move.w     \1,BEATDELAY+2
  ENDM
            
  include    endfunctions.s


DRAWFUNCTARRAY_START:
  dc.l      WALKINGTRIANGLE
  dc.l       TRANSITION1              ; 7

DRAWFUNCTARRAY_END:

LAST_ITERATION_FUNCTION_START: 
  dc.l       VOID                     ; 1


  dc.l       VOID    ; 10

LAST_ITERATION_FUNCTION_END: