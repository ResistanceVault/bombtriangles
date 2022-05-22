TWISTER_START_ANGLE:
  dc.l           0
TWISTERMANAGER:
  moveq          #100,d7                  ; twister height
  moveq          #0,d5                    ; y position
  lea            SIN_TWISTER_TABLE(PC),a1 ; Load addr of twister sin table into a1

  ; fetch start angle and add to bitplane
  adda.l TWISTER_START_ANGLE,a1
  addq.l #2,TWISTER_START_ANGLE
  cmpi.l #720,TWISTER_START_ANGLE
  bcs.s alessio
  move.l #0,TWISTER_START_ANGLE
alessio:
  ;adda.l #300*2,a1

  moveq.l        #0,d6                    ; d6 is a/amp
  moveq.l        #0,d2                    ; reset d2, important to have upper part clean

; start of the twister mainloop
;this loop will iterate each vertical position of the twister (twister height)
twister_mainloop:
    ;x1=((sin((a/amp)+ang))*32)+150;
;		x2=((sin((a/amp)+ang+90))*32)+150;
;		x3=((sin((a/amp)+ang+90*2))*32)+150;
;		x4=((sin((a/amp)+ang+90*3))*32)+150;
  SETBITPLANE    0,a0                     ; Twister will be plotted on bitplane 0
                                          ; since a0 will be later changed we need
                                          ; to reload at each cyce

  move.w         (a1),d0                  ; fetch sin(a/amp), put the result into d0
                                          ; d0 will hold a value from 0 to 32 because
                                          ; the sin table will be multiplied and offsetted
                                          ; by the value of 16

  move.w         d0,d2                    ; since the d0 value exceeds 8 (witch is the module)
  lsr.w          #3,d2                    ; of bset we must first divide by 8 into a tmp reg
  adda.l         d2,a0                    ; and addr to base addr to figure out where to bset

  andi.w         #7,d0                    ; take the reminder of d0/8
  not.b          d0                       ; not it (becase how bset works)

  bset           d0,(a0,d5.w)             ; plot the point
  addi.w         #40,d5                   ; d5 will be incremented by 40 to go to next line

  addq           #2,a1                    ; go to next point into sin table (since we are using dc.w)

  ; now we are going to update the sin table pointer BUT first we must check if we
  ; are at the end of the table, if this is the case we cant add because we are going
  ; out of bounds, in this case reset to the first element
  cmp.l          #SIN_TWISTER_TABLE_END,a1
  bcs.s          SIN_TWISTER_PTR_END
  lea            SIN_TWISTER_TABLE(PC),a1 ; Load addr of twister sin table into a1
SIN_TWISTER_PTR_END:
  dbra           d7,twister_mainloop
  rts

; sin table in format q2,14 with offset 1 (value ranges 0-2)
SIN_TWISTER_TABLE:
	dc.w 16 ; degrees: 0
	dc.w 16 ; degrees: 1
	dc.w 16 ; degrees: 2
	dc.w 16 ; degrees: 3
	dc.w 17 ; degrees: 4
	dc.w 17 ; degrees: 5
	dc.w 17 ; degrees: 6
	dc.w 17 ; degrees: 7
	dc.w 18 ; degrees: 8
	dc.w 18 ; degrees: 9
	dc.w 18 ; degrees: 10
	dc.w 19 ; degrees: 11
	dc.w 19 ; degrees: 12
	dc.w 19 ; degrees: 13
	dc.w 19 ; degrees: 14
	dc.w 20 ; degrees: 15
	dc.w 20 ; degrees: 16
	dc.w 20 ; degrees: 17
	dc.w 20 ; degrees: 18
	dc.w 21 ; degrees: 19
	dc.w 21 ; degrees: 20
	dc.w 21 ; degrees: 21
	dc.w 21 ; degrees: 22
	dc.w 22 ; degrees: 23
	dc.w 22 ; degrees: 24
	dc.w 22 ; degrees: 25
	dc.w 23 ; degrees: 26
	dc.w 23 ; degrees: 27
	dc.w 23 ; degrees: 28
	dc.w 23 ; degrees: 29
	dc.w 24 ; degrees: 30
	dc.w 24 ; degrees: 31
	dc.w 24 ; degrees: 32
	dc.w 24 ; degrees: 33
	dc.w 24 ; degrees: 34
	dc.w 25 ; degrees: 35
	dc.w 25 ; degrees: 36
	dc.w 25 ; degrees: 37
	dc.w 25 ; degrees: 38
	dc.w 26 ; degrees: 39
	dc.w 26 ; degrees: 40
	dc.w 26 ; degrees: 41
	dc.w 26 ; degrees: 42
	dc.w 26 ; degrees: 43
	dc.w 27 ; degrees: 44
	dc.w 27 ; degrees: 45
	dc.w 27 ; degrees: 46
	dc.w 27 ; degrees: 47
	dc.w 27 ; degrees: 48
	dc.w 28 ; degrees: 49
	dc.w 28 ; degrees: 50
	dc.w 28 ; degrees: 51
	dc.w 28 ; degrees: 52
	dc.w 28 ; degrees: 53
	dc.w 28 ; degrees: 54
	dc.w 29 ; degrees: 55
	dc.w 29 ; degrees: 56
	dc.w 29 ; degrees: 57
	dc.w 29 ; degrees: 58
	dc.w 29 ; degrees: 59
	dc.w 29 ; degrees: 60
	dc.w 29 ; degrees: 61
	dc.w 30 ; degrees: 62
	dc.w 30 ; degrees: 63
	dc.w 30 ; degrees: 64
	dc.w 30 ; degrees: 65
	dc.w 30 ; degrees: 66
	dc.w 30 ; degrees: 67
	dc.w 30 ; degrees: 68
	dc.w 30 ; degrees: 69
	dc.w 31 ; degrees: 70
	dc.w 31 ; degrees: 71
	dc.w 31 ; degrees: 72
	dc.w 31 ; degrees: 73
	dc.w 31 ; degrees: 74
	dc.w 31 ; degrees: 75
	dc.w 31 ; degrees: 76
	dc.w 31 ; degrees: 77
	dc.w 31 ; degrees: 78
	dc.w 31 ; degrees: 79
	dc.w 31 ; degrees: 80
	dc.w 31 ; degrees: 81
	dc.w 31 ; degrees: 82
	dc.w 31 ; degrees: 83
	dc.w 31 ; degrees: 84
	dc.w 31 ; degrees: 85
	dc.w 31 ; degrees: 86
	dc.w 31 ; degrees: 87
	dc.w 31 ; degrees: 88
	dc.w 31 ; degrees: 89
	dc.w 32 ; degrees: 90
	dc.w 31 ; degrees: 91
	dc.w 31 ; degrees: 92
	dc.w 31 ; degrees: 93
	dc.w 31 ; degrees: 94
	dc.w 31 ; degrees: 95
	dc.w 31 ; degrees: 96
	dc.w 31 ; degrees: 97
	dc.w 31 ; degrees: 98
	dc.w 31 ; degrees: 99
	dc.w 31 ; degrees: 100
	dc.w 31 ; degrees: 101
	dc.w 31 ; degrees: 102
	dc.w 31 ; degrees: 103
	dc.w 31 ; degrees: 104
	dc.w 31 ; degrees: 105
	dc.w 31 ; degrees: 106
	dc.w 31 ; degrees: 107
	dc.w 31 ; degrees: 108
	dc.w 31 ; degrees: 109
	dc.w 31 ; degrees: 110
	dc.w 30 ; degrees: 111
	dc.w 30 ; degrees: 112
	dc.w 30 ; degrees: 113
	dc.w 30 ; degrees: 114
	dc.w 30 ; degrees: 115
	dc.w 30 ; degrees: 116
	dc.w 30 ; degrees: 117
	dc.w 30 ; degrees: 118
	dc.w 29 ; degrees: 119
	dc.w 29 ; degrees: 120
	dc.w 29 ; degrees: 121
	dc.w 29 ; degrees: 122
	dc.w 29 ; degrees: 123
	dc.w 29 ; degrees: 124
	dc.w 29 ; degrees: 125
	dc.w 28 ; degrees: 126
	dc.w 28 ; degrees: 127
	dc.w 28 ; degrees: 128
	dc.w 28 ; degrees: 129
	dc.w 28 ; degrees: 130
	dc.w 28 ; degrees: 131
	dc.w 27 ; degrees: 132
	dc.w 27 ; degrees: 133
	dc.w 27 ; degrees: 134
	dc.w 27 ; degrees: 135
	dc.w 27 ; degrees: 136
	dc.w 26 ; degrees: 137
	dc.w 26 ; degrees: 138
	dc.w 26 ; degrees: 139
	dc.w 26 ; degrees: 140
	dc.w 26 ; degrees: 141
	dc.w 25 ; degrees: 142
	dc.w 25 ; degrees: 143
	dc.w 25 ; degrees: 144
	dc.w 25 ; degrees: 145
	dc.w 24 ; degrees: 146
	dc.w 24 ; degrees: 147
	dc.w 24 ; degrees: 148
	dc.w 24 ; degrees: 149
	dc.w 24 ; degrees: 150
	dc.w 23 ; degrees: 151
	dc.w 23 ; degrees: 152
	dc.w 23 ; degrees: 153
	dc.w 23 ; degrees: 154
	dc.w 22 ; degrees: 155
	dc.w 22 ; degrees: 156
	dc.w 22 ; degrees: 157
	dc.w 21 ; degrees: 158
	dc.w 21 ; degrees: 159
	dc.w 21 ; degrees: 160
	dc.w 21 ; degrees: 161
	dc.w 20 ; degrees: 162
	dc.w 20 ; degrees: 163
	dc.w 20 ; degrees: 164
	dc.w 20 ; degrees: 165
	dc.w 19 ; degrees: 166
	dc.w 19 ; degrees: 167
	dc.w 19 ; degrees: 168
	dc.w 19 ; degrees: 169
	dc.w 18 ; degrees: 170
	dc.w 18 ; degrees: 171
	dc.w 18 ; degrees: 172
	dc.w 17 ; degrees: 173
	dc.w 17 ; degrees: 174
	dc.w 17 ; degrees: 175
	dc.w 17 ; degrees: 176
	dc.w 16 ; degrees: 177
	dc.w 16 ; degrees: 178
	dc.w 16 ; degrees: 179
	dc.w 16 ; degrees: 180
	dc.w 15 ; degrees: 181
	dc.w 15 ; degrees: 182
	dc.w 15 ; degrees: 183
	dc.w 14 ; degrees: 184
	dc.w 14 ; degrees: 185
	dc.w 14 ; degrees: 186
	dc.w 14 ; degrees: 187
	dc.w 13 ; degrees: 188
	dc.w 13 ; degrees: 189
	dc.w 13 ; degrees: 190
	dc.w 12 ; degrees: 191
	dc.w 12 ; degrees: 192
	dc.w 12 ; degrees: 193
	dc.w 12 ; degrees: 194
	dc.w 11 ; degrees: 195
	dc.w 11 ; degrees: 196
	dc.w 11 ; degrees: 197
	dc.w 11 ; degrees: 198
	dc.w 10 ; degrees: 199
	dc.w 10 ; degrees: 200
	dc.w 10 ; degrees: 201
	dc.w 10 ; degrees: 202
	dc.w 9 ; degrees: 203
	dc.w 9 ; degrees: 204
	dc.w 9 ; degrees: 205
	dc.w 8 ; degrees: 206
	dc.w 8 ; degrees: 207
	dc.w 8 ; degrees: 208
	dc.w 8 ; degrees: 209
	dc.w 7 ; degrees: 210
	dc.w 7 ; degrees: 211
	dc.w 7 ; degrees: 212
	dc.w 7 ; degrees: 213
	dc.w 7 ; degrees: 214
	dc.w 6 ; degrees: 215
	dc.w 6 ; degrees: 216
	dc.w 6 ; degrees: 217
	dc.w 6 ; degrees: 218
	dc.w 5 ; degrees: 219
	dc.w 5 ; degrees: 220
	dc.w 5 ; degrees: 221
	dc.w 5 ; degrees: 222
	dc.w 5 ; degrees: 223
	dc.w 4 ; degrees: 224
	dc.w 4 ; degrees: 225
	dc.w 4 ; degrees: 226
	dc.w 4 ; degrees: 227
	dc.w 4 ; degrees: 228
	dc.w 3 ; degrees: 229
	dc.w 3 ; degrees: 230
	dc.w 3 ; degrees: 231
	dc.w 3 ; degrees: 232
	dc.w 3 ; degrees: 233
	dc.w 3 ; degrees: 234
	dc.w 2 ; degrees: 235
	dc.w 2 ; degrees: 236
	dc.w 2 ; degrees: 237
	dc.w 2 ; degrees: 238
	dc.w 2 ; degrees: 239
	dc.w 2 ; degrees: 240
	dc.w 2 ; degrees: 241
	dc.w 1 ; degrees: 242
	dc.w 1 ; degrees: 243
	dc.w 1 ; degrees: 244
	dc.w 1 ; degrees: 245
	dc.w 1 ; degrees: 246
	dc.w 1 ; degrees: 247
	dc.w 1 ; degrees: 248
	dc.w 1 ; degrees: 249
	dc.w 0 ; degrees: 250
	dc.w 0 ; degrees: 251
	dc.w 0 ; degrees: 252
	dc.w 0 ; degrees: 253
	dc.w 0 ; degrees: 254
	dc.w 0 ; degrees: 255
	dc.w 0 ; degrees: 256
	dc.w 0 ; degrees: 257
	dc.w 0 ; degrees: 258
	dc.w 0 ; degrees: 259
	dc.w 0 ; degrees: 260
	dc.w 0 ; degrees: 261
	dc.w 0 ; degrees: 262
	dc.w 0 ; degrees: 263
	dc.w 0 ; degrees: 264
	dc.w 0 ; degrees: 265
	dc.w 0 ; degrees: 266
	dc.w 0 ; degrees: 267
	dc.w 0 ; degrees: 268
	dc.w 0 ; degrees: 269
	dc.w 0 ; degrees: 270
	dc.w 0 ; degrees: 271
	dc.w 0 ; degrees: 272
	dc.w 0 ; degrees: 273
	dc.w 0 ; degrees: 274
	dc.w 0 ; degrees: 275
	dc.w 0 ; degrees: 276
	dc.w 0 ; degrees: 277
	dc.w 0 ; degrees: 278
	dc.w 0 ; degrees: 279
	dc.w 0 ; degrees: 280
	dc.w 0 ; degrees: 281
	dc.w 0 ; degrees: 282
	dc.w 0 ; degrees: 283
	dc.w 0 ; degrees: 284
	dc.w 0 ; degrees: 285
	dc.w 0 ; degrees: 286
	dc.w 0 ; degrees: 287
	dc.w 0 ; degrees: 288
	dc.w 0 ; degrees: 289
	dc.w 0 ; degrees: 290
	dc.w 1 ; degrees: 291
	dc.w 1 ; degrees: 292
	dc.w 1 ; degrees: 293
	dc.w 1 ; degrees: 294
	dc.w 1 ; degrees: 295
	dc.w 1 ; degrees: 296
	dc.w 1 ; degrees: 297
	dc.w 1 ; degrees: 298
	dc.w 2 ; degrees: 299
	dc.w 2 ; degrees: 300
	dc.w 2 ; degrees: 301
	dc.w 2 ; degrees: 302
	dc.w 2 ; degrees: 303
	dc.w 2 ; degrees: 304
	dc.w 2 ; degrees: 305
	dc.w 3 ; degrees: 306
	dc.w 3 ; degrees: 307
	dc.w 3 ; degrees: 308
	dc.w 3 ; degrees: 309
	dc.w 3 ; degrees: 310
	dc.w 3 ; degrees: 311
	dc.w 4 ; degrees: 312
	dc.w 4 ; degrees: 313
	dc.w 4 ; degrees: 314
	dc.w 4 ; degrees: 315
	dc.w 4 ; degrees: 316
	dc.w 5 ; degrees: 317
	dc.w 5 ; degrees: 318
	dc.w 5 ; degrees: 319
	dc.w 5 ; degrees: 320
	dc.w 5 ; degrees: 321
	dc.w 6 ; degrees: 322
	dc.w 6 ; degrees: 323
	dc.w 6 ; degrees: 324
	dc.w 6 ; degrees: 325
	dc.w 7 ; degrees: 326
	dc.w 7 ; degrees: 327
	dc.w 7 ; degrees: 328
	dc.w 7 ; degrees: 329
	dc.w 7 ; degrees: 330
	dc.w 8 ; degrees: 331
	dc.w 8 ; degrees: 332
	dc.w 8 ; degrees: 333
	dc.w 8 ; degrees: 334
	dc.w 9 ; degrees: 335
	dc.w 9 ; degrees: 336
	dc.w 9 ; degrees: 337
	dc.w 10 ; degrees: 338
	dc.w 10 ; degrees: 339
	dc.w 10 ; degrees: 340
	dc.w 10 ; degrees: 341
	dc.w 11 ; degrees: 342
	dc.w 11 ; degrees: 343
	dc.w 11 ; degrees: 344
	dc.w 11 ; degrees: 345
	dc.w 12 ; degrees: 346
	dc.w 12 ; degrees: 347
	dc.w 12 ; degrees: 348
	dc.w 12 ; degrees: 349
	dc.w 13 ; degrees: 350
	dc.w 13 ; degrees: 351
	dc.w 13 ; degrees: 352
	dc.w 14 ; degrees: 353
	dc.w 14 ; degrees: 354
	dc.w 14 ; degrees: 355
	dc.w 14 ; degrees: 356
	dc.w 15 ; degrees: 357
	dc.w 15 ; degrees: 358
	dc.w 15 ; degrees: 359
SIN_TWISTER_TABLE_END: