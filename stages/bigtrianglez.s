; Triangle path cordinate - each chunk is 256 bytes (one long for each of the 64 coordinates)
BIGTRIANGLE_Z_COORDS:
                       ; start of first path
            dc.w                -23,279,-20,277,-18,275,-15,273,-13,271,-10,269,-08,267,-05,265,-03,263
            dc.w                000,261,003,259,005,257,008,255,010,253,013,251,015,249,018,247,020,245,023,243
            dc.w                025,241,028,239,030,237,033,235,035,233,038,231,040,229,043,227,045,225,048,223
            dc.w                050,221,053,219,055,217,058,215,060,213,063,211,065,209,068,207,070,205,073,203
            dc.w                075,201,078,199,080,197,083,195,085,193,088,191,090,189,093,187,095,185,098,183
            dc.w                100,181,103,179,105,177,108,175,110,173,113,171,115,169,118,167,120,165,123,163
            dc.w                125,161,128,159,130,157,133,155,135,153

                       ; start of second path
            dc.w                -23,278,-20,275,-18,273,-15,270,-13,267,-10,264,-08,262,-05,259,-03,256
            dc.w                000,253,003,250,005,248,008,245,010,242,013,239,015,237,018,234,020,231,023,228
            dc.w                025,225,028,223,030,220,033,217,035,214,038,211,040,209,043,206,045,203,048,200
            dc.w                050,198,053,195,055,192,058,189,060,186,063,184,065,181,068,178,070,175,073,173
            dc.w                075,170,078,167,080,164,083,161,085,159,088,156,090,153,093,150,095,148,098,145
            dc.w                100,142,103,139,105,136,108,134,110,131,113,128,115,125,118,122,120,120,123,117
            dc.w                125,114,128,111,130,109,133,106,135,103

                       ; start of thrid path
            dc.w                343,279,340,277,338,275,335,273,333,271,330,269,328,267,325,265,323,263
            dc.w                320,261,318,259,315,257,313,255,310,253,308,251,305,249,303,247,300,245,298,243
            dc.w                295,241,293,239,290,237,288,235,285,233,283,231,280,229,278,227,275,225,273,223
            dc.w                270,221,268,219,265,217,263,215,260,213,258,211,255,209,253,207,250,205,248,203
            dc.w                245,201,243,199,240,197,238,195,235,193,233,191,230,189,228,187,225,185,223,183
            dc.w                220,181,218,179,215,177,213,175,210,173,208,171,205,169,203,167,200,165,198,163
            dc.w                195,161,193,159,190,157,188,155,185,153
                      
                       ; start of fourth path
            dc.w                -22,278,-18,275,-15,273,-12,270,-09,267,-05,264,-02,262,001,259,005,256
            dc.w                008,253,011,250,014,248,018,245,021,242,024,239,028,237,031,234,034,231,037,228
            dc.w                041,225,044,223,047,220,050,217,054,214,057,211,060,209,064,206,067,203,070,200
            dc.w                073,198,077,195,080,192,083,189,087,186,090,184,093,181,096,178,100,175,103,173
            dc.w                106,170,110,167,113,164,116,161,119,159,123,156,126,153,129,150,133,148,136,145
            dc.w                139,142,142,139,146,136,149,134,152,131,155,128,159,125,162,122,165,120,169,117
            dc.w                172,114,175,111,178,109,182,106,185,103

                       ; start of fifth path
            dc.w                -22,278,-19,275,-16,273,-13,270,-11,267,-08,264,-05,262,-02,259,001,256
            dc.w                004,253,007,250,010,248,013,245,015,242,018,239,021,237,024,234,027,231,030,228
            dc.w                033,225,036,223,039,220,041,217,044,214,047,211,050,209,053,206,056,203,059,200
            dc.w                062,198,065,195,068,192,070,189,073,186,076,184,079,181,082,178,085,175,088,173
            dc.w                091,170,094,167,096,164,099,161,102,159,105,156,108,153,111,150,114,148,117,145
            dc.w                120,142,122,139,125,136,128,134,131,131,134,128,137,125,140,122,143,120,146,117
            dc.w                148,114,151,111,154,109,157,106,160,103

                       ; start of sixth path
            dc.w                -22,279,-19,277,-16,275,-13,273,-11,271,-08,269,-05,267,-02,265,001,263
            dc.w                004,261,007,259,010,257,013,255,015,253,018,251,021,249,024,247,027,245,030,243
            dc.w                033,241,036,239,039,237,041,235,044,233,047,231,050,229,053,227,056,225,059,223
            dc.w                062,221,065,219,067,217,070,215,073,213,076,211,079,209,082,207,085,205,088,203
            dc.w                091,201,094,199,096,197,099,195,102,193,105,191,108,189,111,187,114,185,117,183
            dc.w                120,181,122,179,125,177,128,175,131,173,134,171,137,169,140,167,143,165,146,163
            dc.w                148,161,151,159,154,157,157,155,160,153
BIGTRIANGLE_Z_COORDS_END:

BIGTRIANGLE_Z_COORDS_PTR: 
            dc.l                BIGTRIANGLE_Z_COORDS

BIGTRIANGLE_Z_COLOR:
            dc.b                1,2,1,2,3,3
BIGTRIANGLE_Z_COLOR_PTR:
            dc.l                BIGTRIANGLE_Z_COLOR

BIGTRIANGLE_Z:
            movem.l             d0-d6/a0/a1,-(sp)
       
            move.w              #%0100001000000000,BPLCON0POINTER
              ;move.l           #BIGTRIANGLE_Z_COORDS,BIGTRIANGLE_Z_COORDS_PTR

            ENABLE_CLIPPING
                   
            move.l              BIGTRIANGLE_Z_COORDS_PTR(PC),a1
            move.w              BIGTRIANGLE_Z_YPOS(PC),d1
            adda                d1,a1

            move.w              (a1),d0
            move.w              2(a1),d1
            ;move.w #160,d0
            ;move.w #128,d1
            jsr                 LOADIDENTITYANDTRANSLATE   
            move.l              ROTATIONS_ANGLES_64_PTR,a0
            ROTATE              (a0)

            move.w              #0,d0
            move.w              #-25,d1

            move.w              #-25,d6
            move.w              #25,d3

            move.w              #25,d4
            move.w              #25,d5
	
            jsr                 TRIANGLE_NODRAW

            WAITBLITTER
            move.l              BIGTRIANGLE_Z_COLOR_PTR,a0

            STROKE              (a0)
            jsr                 ammx_fill_table_clip
            DISABLE_CLIPPING
                       
            add.w               #4,BIGTRIANGLE_Z_YPOS
            add.l               #2,ROTATIONS_ANGLES_64_PTR

                     ; if last frame of the section blit the triangle on bitplane 3
            cmpi.w              #64*4,BIGTRIANGLE_Z_YPOS
            bne.w               BIGTRIANGLE_Z_EXIT
                       
            WAITBLITTER
            move.w              #$0DFC,$dff040
            move.w              #$0000,$dff042   
            move.l              SCREEN_PTR_0,$dff050                                                                   ; a source
            ;add.w #16,$DFF050
            move.l              #SCREEN_2,$DFF04C
            ;add.w #16,$DFF04C
            move.l              #SCREEN_2,$dff054                                                                      ; d destination 
            ;add.w #16,$DFF054
            move.w              #0,$dff062                                                                             ; b mod
            move.w              #0,$dff064                                                                             ; A MOD
            move.w              #0,$dff066                                                                             ;D mod
            move.w              #$8014,$dff058

            move.w              #0,ANGLE

            add.l               #1,BIGTRIANGLE_Z_COLOR_PTR

            move.w              #0,BIGTRIANGLE_Z_YPOS
            add.l               #256,BIGTRIANGLE_Z_COORDS_PTR

                       
            move.l              ROTATIONS_ANGLES_64_PTR,d0
            move.l              d0,ROTATIONS_ANGLES_64_PTR
            cmpi.l              #ROTATIONS_ANGLES_64_END,ROTATIONS_ANGLES_64_PTR
            bne.s               donotresetrotationangles
            move.l              #ROTATIONS_ANGLES_64,ROTATIONS_ANGLES_64_PTR
           
donotresetrotationangles:


BIGTRIANGLE_Z_EXIT:
            movem.l             (sp)+,d0-d6/a0/a1
            rts