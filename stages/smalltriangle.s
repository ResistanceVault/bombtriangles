SMALLTRIANGLE:
            ;move.l              #CLEAR,CLEARFUNCTION

            move.w              ANGLE,d0
            jsr                 LOADIDENTITYANDROTATEY
            VERTEX_INIT         1,#0,#-10,#0
            VERTEX_INIT         2,#10,#10,#0
            VERTEX_INIT         3,#-10,#10,#0
            jsr                 TRIANGLE3D_NODRAW
            bsr.w               increase_angle_by_1

            ;move.w              #$0555,$dff182
            ;WAITBLITTER
            ;bsr.w               CLEAR_BPL_4
            ;bsr.w               CLEAR_BPL_3
            WAITBLITTER
            STROKE              #3
            jsr                 ammx_fill_table
            rts