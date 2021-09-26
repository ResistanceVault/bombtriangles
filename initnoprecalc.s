SAVE_FILL_TABLE2 MACRO
                        lea                    FILL_TABLE,a0
                        move.l                 FILLTABLES_ADDR_START,a1
                        move.l                 #4*257,d0
                        mulu.w                 \1,d0
                        adda.l                 d0,a1
                        move.w                 AMMXFILLTABLE_CURRENT_ROW,(a1)+
                        move.w                 AMMXFILLTABLE_END_ROW,(a1)+
                        move.w                 #255,d3
.1\@:
                        move.l                 (a0)+,(a1)+
                        dbra                   d3,.1\@
                        ENDM

FILLTABLES_ADDR_START:  dc.l                   0
FILLTABLES_ADDR_END:    dc.l                   0
FILLTABLES_PTR:         dc.l                   0

_ammxmainloop3_init:
                        movem.l                d0-d7/a0-a6,-(sp)
                    
                        movem.l                (sp)+,d0-d7/a0-a6

                        rts
