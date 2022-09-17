SPRITES_VSTART		   equ  $2C

TWISTER_SPR_START_VPOS equ	3+SPRITES_VSTART ; Vertical position of the sprite where to start plotting twister
TWISTER_SPR_Y_STEP	   equ   5 ; Space between each row in pixel
TWISTER_SPR_NUM_ROWS   equ  32 ; How many rows in a twister?

; Full vertical height of the sprite in pixels
TWISTER_SPR_HEIGHT	   equ  TWISTER_SPR_NUM_ROWS+(TWISTER_SPR_NUM_ROWS*TWISTER_SPR_Y_STEP)

  IFD TWISTER_ON_BPL
TWISTER_HEIGHT 	 equ 	35
TWISTER_Y_STEP	 equ	5*40
  ENDC

TWISTER_INC_SPEED equ   3 ; high values means go slow
TWISTER_DEC_SPEED equ   6 ; high values means go slow

TWISTERDECR:
  	dc.w 10

TWISTER_TRIGSTEP:
  	dc.w 		 64
TWISTER_MASK_ROWS_COUNTER:
  	;dc.w		 TWISTER_SPR_NUM_ROWS-TWISTER_SPR_NUM_ROWS
    dc.w 0

TWISTER_START_ANGLE:
  	dc.l           0

	IFD TWISTER_ON_BPL
TWISTER_ANGLE_STEP:
  	dc.w 		 	 0
	ENDC

	include 		 "twister/twistertables.i"

TWISTERMANAGER:
  lea          TWISTER_START_ANGLE(PC),a0
	lea          SIN_TWISTER_TABLE(PC),a1     ; Load addr of twister sin table into a1
	adda.w 		   (a0),a1   ; Go to the lookup table position corresponding to the angle

	; go to the next angle
  move.w       (a0),d0
	addq  		   #8,d0
  cmpi.w 		   #720,d0
  bcs.s 		   twister_angle_dont_reset
  moveq 		   #0,d0
twister_angle_dont_reset:
  move.w       d0,(a0)

	; point twister sprite data into a0 and a2
	lea 		     SANDTWISTER_2_DATA(PC),a2
	lea 		     SANDTWISTER_1_DATA(PC),a0

	; save TWISTER_MASK_ROWS_COUNTER into d6 for comparisin within iteration
	move.w		   TWISTER_MASK_ROWS_COUNTER(PC),d6

  ; reset d5 we will use it for counting plotted rows
  moveq          #0,d5

	moveq        #TWISTER_SPR_NUM_ROWS-1,d7       ; iterate for each twister row
twister_for_each_row:
	moveq.l		   #0,d4					; clean d4

	; do not show twister for lines where d7>TWISTER_MASK_ROWS_COUNTER
	cmp.w 		   d6,d5
  bcc.s        blanktwisterrow

	move.w       (a1),d0                      ; fetch sin(a/amp), put the result into d0
                                          	; d0 will hold a value from 0 to 32 because
                                          	; the sin table will be multiplied and offsetted
                                          	; by the value of 16

  bset 		     d0,d4

	;		x2=((sin((a/amp)+ang+90))*32)+150;
	move.w       90*2(a1),d0
	bset 		     d0,d4

	;		x3=((sin((a/amp)+ang+90*2))*32)+150;
	move.w       180*2(a1),d0
	bset 		     d0,d4

	;		x4=((sin((a/amp)+ang+90*3))*32)+150;
	move.w       270*2(a1),d0
	bset 		     d0,d4
blanktwisterrow:
  addq         #1,d5

	; plot the sand grains into the sprite
	move.w		   d4,2(a2)
	swap 		     d4
	move.w		   d4,2(a0)

	; go to next twister row
	adda.l		   #4*(TWISTER_SPR_Y_STEP+1),a0
	adda.l		   #4*(TWISTER_SPR_Y_STEP+1),a2

	; go to next point into sin table
	adda.w       TWISTER_TRIGSTEP(PC),a1

	; now we are going to update the sin table pointer BUT first we must check if we
	; are at the end of the table, if this is the case we cant add because we are going
	; out of bounds, in this case reset to the first element
	cmp.l        #SIN_TWISTER_TABLE_END,a1
	bcs.s        SIN_TWISTER_PTR_END
	move.l 		   a1,a4
	suba.l		     #SIN_TWISTER_TABLE_END,a4
	lea          SIN_TWISTER_TABLE(PC),a1 ; Load addr of twister sin table into a1
	add.l		     a4,a1
	SIN_TWISTER_PTR_END:

	; cycle
	dbra         d7,twister_for_each_row
	rts

	IFD TWISTER_ON_BPL
TWISTERMANAGER2:
  moveq          #TWISTER_HEIGHT,d7       ; twister height into d7
  moveq          #0,d5                    ; y position
  lea            SIN_TWISTER_TABLE(PC),a1 ; Load addr of twister sin table into a1

  ; fetch start angle and add to bitplane
  adda.l 		 TWISTER_START_ANGLE,a1
  addq.l 		 #2,TWISTER_START_ANGLE
  cmpi.l 		 #720,TWISTER_START_ANGLE
  bcs.s 		 TWISTER_ANGLE_NORESET
  move.l 		 #0,TWISTER_START_ANGLE
TWISTER_ANGLE_NORESET:

  moveq.l        #0,d6                    ; d6 is a/amp
  moveq.l        #0,d2                    ; reset d2, important to have upper part clean

  ;Get addr of the top of the twister
  SETBITPLANE    0,a3
  ;add.l			 #50*40,a3
  add.l			 #30,a3

; start of the twister mainloop
;this loop will iterate each vertical position of the twister (twister height)
twister_mainloop:
    ;x1=((sin((a/amp)+ang))*32)+150;


  moveq 		 #0,d4							  ; this register will hold the final bitmap of the line containing the sand grains

  move.w         (a1),d0                  ; fetch sin(a/amp), put the result into d0
                                          ; d0 will hold a value from 0 to 32 because
                                          ; the sin table will be multiplied and offsetted
                                          ; by the value of 16


  bset d0,d4
  ;move.w         d0,d2                    ; since the d0 value exceeds 8 (witch is the module)
  ;lsr.w          #3,d2                    ; of bset we must first divide by 8 into a tmp reg
  ;adda.l         d2,a0                    ; and addr to base addr to figure out where to bset



  ;andi.w         #7,d0                    ; take the reminder of d0/8
  ;not.b          d0                       ; not it (becase how bset works)

  ;bset           d0,(a0,d5.w)             ; plot the point
  ;bset           d0,40(a0,d5.w)
  ;bset           d0,80(a0,d5.w)
  ;bset           d0,120(a0,d5.w)
  ;adda.l #256*40,a0
  ;bset           d0,(a0,d5.w)             ; plot the point
  ;bset           d0,40(a0,d5.w)
  ;bset           d0,80(a0,d5.w)
  ;bset           d0,120(a0,d5.w)

  ;		x2=((sin((a/amp)+ang+90))*32)+150;
  move.w         90*2(a1),d0
  bset 			 d0,d4

  ;		x3=((sin((a/amp)+ang+90*2))*32)+150;
  move.w         180*2(a1),d0
  bset 			 d0,d4

  ;		x4=((sin((a/amp)+ang+90*3))*32)+150;
  move.w         270*2(a1),d0
  bset d0,d4


  or.l d4,(a3,d5.w)
  ;or.l d4,40(a3,d5.w)
  ;or.l d4,80(a3,d5.w)
  ;or.l d4,120(a3,d5.w)


  addi.w         #TWISTER_Y_STEP,d5       ; d5 will be incremented to go to next line

  adda.w         TWISTER_TRIGSTEP,a1      ; go to next point into sin table (since we are using dc.w)

  ; now we are going to update the sin table pointer BUT first we must check if we
  ; are at the end of the table, if this is the case we cant add because we are going
  ; out of bounds, in this case reset to the first element
  ;cmp.l          #SIN_TWISTER_TABLE_END,a1
  ;bcs.s          SIN_TWISTER_PTR_END
  ;nop
  ;move.l 		 a1,a4
  ;sub.l			 #SIN_TWISTER_TABLE_END,a4
  ;lea            SIN_TWISTER_TABLE(PC),a1 ; Load addr of twister sin table into a1
  ;add.l			 a4,a1
;SIN_TWISTER_PTR_END:
  dbra           d7,twister_mainloop
  rts
  ENDC

; The twister is made of 2 sprites side by side, this is the first one (left one)
SANDTWISTER_1:
SANDTWISTER_1_VSTART0;
  dc.b                TWISTER_SPR_START_VPOS
SANDTWISTER_1_HSTART0:
  dc.b                $B8
SANDTWISTER_1_VSTOP0:
  IFGT TWISTER_SPR_START_VPOS+TWISTER_SPR_HEIGHT-255
  dc.b                TWISTER_SPR_START_VPOS+TWISTER_SPR_HEIGHT-255,$02
  ELSE
  dc.b                TWISTER_SPR_START_VPOS+TWISTER_SPR_HEIGHT,$00
  ENDC
SANDTWISTER_1_DATA:
  dcb.l 			  TWISTER_SPR_HEIGHT,$00000000
  dc.w                0,0

; The twister is made of 2 sprites side by side, this is the second one (right one)
SANDTWISTER_2:
SANDTWISTER_2_VSTART0;
  dc.b                TWISTER_SPR_START_VPOS
SANDTWISTER_2_HSTART0:
  dc.b                $B8+8
SANDTWISTER_2_VSTOP0:
  IFGT TWISTER_SPR_START_VPOS+TWISTER_SPR_HEIGHT-255
  dc.b                TWISTER_SPR_START_VPOS+TWISTER_SPR_HEIGHT-255,$02
  ELSE
  dc.b                TWISTER_SPR_START_VPOS+TWISTER_SPR_HEIGHT,$00
  ENDC
SANDTWISTER_2_DATA:
  dcb.l 			  TWISTER_SPR_HEIGHT,$00000000
  dc.w                0,0
