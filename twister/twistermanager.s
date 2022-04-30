TWISTERMANAGER:
  moveq          #100,d7                 ; twister height
  moveq          #0,d5                   ; y position
  SETBITPLANE    0,a0
  lea            SIN_TWISTER_TABLE,a1
    ; d6 is a/amp
  moveq          #0,d6

twister_mainloop:
    ;x1=((sin((a/amp)+ang))*32)+150;
;		x2=((sin((a/amp)+ang+90))*32)+150;
;		x3=((sin((a/amp)+ang+90*2))*32)+150;
;		x4=((sin((a/amp)+ang+90*3))*32)+150;

  move.w         4(a1,d6.w),d0
  lsr.w          #6,d0
   ; lsr.w #5,d0
  bset           d0,(a0,d5.w)
  add.w          #40,d5
  addq           #8,d6

  dbra           d7,twister_mainloop
  rts

; sin table in format q2,14 with offset 1 (value ranges 0-2)
SIN_TWISTER_TABLE:
  dc.w           %0100000000000000       ; degrees: 0
  dc.w           %0100000100011101       ; degrees: 1
  dc.w           %0100001000111011       ; degrees: 2
  dc.w           %0100001101011001       ; degrees: 3
  dc.w           %0100010001110110       ; degrees: 4
  dc.w           %0100010110010011       ; degrees: 5
  dc.w           %0100011010110000       ; degrees: 6
  dc.w           %0100011111001100       ; degrees: 7
  dc.w           %0100100011101000       ; degrees: 8
  dc.w           %0100101000000011       ; degrees: 9
  dc.w           %0100101100011101       ; degrees: 10
  dc.w           %0100110000110110       ; degrees: 11
  dc.w           %0100110101001110       ; degrees: 12
  dc.w           %0100111001100101       ; degrees: 13
  dc.w           %0100111101111011       ; degrees: 14
  dc.w           %0101000010010000       ; degrees: 15
  dc.w           %0101000110100100       ; degrees: 16
  dc.w           %0101001010110110       ; degrees: 17
  dc.w           %0101001111000110       ; degrees: 18
  dc.w           %0101010011010110       ; degrees: 19
  dc.w           %0101010111100011       ; degrees: 20
  dc.w           %0101011011101111       ; degrees: 21
  dc.w           %0101011111111001       ; degrees: 22
  dc.w           %0101100100000001       ; degrees: 23
  dc.w           %0101101000000111       ; degrees: 24
  dc.w           %0101101100001100       ; degrees: 25
  dc.w           %0101110000001110       ; degrees: 26
  dc.w           %0101110100001110       ; degrees: 27
  dc.w           %0101111000001011       ; degrees: 28
  dc.w           %0101111100000111       ; degrees: 29
  dc.w           %0110000000000000       ; degrees: 30
  dc.w           %0110000011110110       ; degrees: 31
  dc.w           %0110000111101010       ; degrees: 32
  dc.w           %0110001011011011       ; degrees: 33
  dc.w           %0110001111001001       ; degrees: 34
  dc.w           %0110010010110101       ; degrees: 35
  dc.w           %0110010110011110       ; degrees: 36
  dc.w           %0110011010000100       ; degrees: 37
  dc.w           %0110011101100110       ; degrees: 38
  dc.w           %0110100001000110       ; degrees: 39
  dc.w           %0110100100100011       ; degrees: 40
  dc.w           %0110100111111100       ; degrees: 41
  dc.w           %0110101011010011       ; degrees: 42
  dc.w           %0110101110100101       ; degrees: 43
  dc.w           %0110110001110101       ; degrees: 44
  dc.w           %0110110101000001       ; degrees: 45
  dc.w           %0110111000001001       ; degrees: 46
  dc.w           %0110111011001110       ; degrees: 47
  dc.w           %0110111110001111       ; degrees: 48
  dc.w           %0111000001001101       ; degrees: 49
  dc.w           %0111000100000110       ; degrees: 50
  dc.w           %0111000110111100       ; degrees: 51
  dc.w           %0111001001101110       ; degrees: 52
  dc.w           %0111001100011100       ; degrees: 53
  dc.w           %0111001111000110       ; degrees: 54
  dc.w           %0111010001101100       ; degrees: 55
  dc.w           %0111010100001110       ; degrees: 56
  dc.w           %0111010110101100       ; degrees: 57
  dc.w           %0111011001000110       ; degrees: 58
  dc.w           %0111011011011011       ; degrees: 59
  dc.w           %0111011101101100       ; degrees: 60
  dc.w           %0111011111111001       ; degrees: 61
  dc.w           %0111100010000010       ; degrees: 62
  dc.w           %0111100100000110       ; degrees: 63
  dc.w           %0111100110000101       ; degrees: 64
  dc.w           %0111101000000000       ; degrees: 65
  dc.w           %0111101001110111       ; degrees: 66
  dc.w           %0111101011101001       ; degrees: 67
  dc.w           %0111101101010110       ; degrees: 68
  dc.w           %0111101110111111       ; degrees: 69
  dc.w           %0111110000100011       ; degrees: 70
  dc.w           %0111110010000011       ; degrees: 71
  dc.w           %0111110011011110       ; degrees: 72
  dc.w           %0111110100110100       ; degrees: 73
  dc.w           %0111110110000101       ; degrees: 74
  dc.w           %0111110111010001       ; degrees: 75
  dc.w           %0111111000011001       ; degrees: 76
  dc.w           %0111111001011100       ; degrees: 77
  dc.w           %0111111010011001       ; degrees: 78
  dc.w           %0111111011010010       ; degrees: 79
  dc.w           %0111111100000111       ; degrees: 80
  dc.w           %0111111100110110       ; degrees: 81
  dc.w           %0111111101100000       ; degrees: 82
  dc.w           %0111111110000101       ; degrees: 83
  dc.w           %0111111110100110       ; degrees: 84
  dc.w           %0111111111000001       ; degrees: 85
  dc.w           %0111111111011000       ; degrees: 86
  dc.w           %0111111111101001       ; degrees: 87
  dc.w           %0111111111110110       ; degrees: 88
  dc.w           %0111111111111101       ; degrees: 89
  dc.w           %01000000000000000      ; degrees: 90
  dc.w           %0111111111111101       ; degrees: 91
  dc.w           %0111111111110110       ; degrees: 92
  dc.w           %0111111111101001       ; degrees: 93
  dc.w           %0111111111011000       ; degrees: 94
  dc.w           %0111111111000001       ; degrees: 95
  dc.w           %0111111110100110       ; degrees: 96
  dc.w           %0111111110000101       ; degrees: 97
  dc.w           %0111111101100000       ; degrees: 98
  dc.w           %0111111100110110       ; degrees: 99
  dc.w           %0111111100000111       ; degrees: 100
  dc.w           %0111111011010010       ; degrees: 101
  dc.w           %0111111010011001       ; degrees: 102
  dc.w           %0111111001011100       ; degrees: 103
  dc.w           %0111111000011001       ; degrees: 104
  dc.w           %0111110111010001       ; degrees: 105
  dc.w           %0111110110000101       ; degrees: 106
  dc.w           %0111110100110100       ; degrees: 107
  dc.w           %0111110011011110       ; degrees: 108
  dc.w           %0111110010000011       ; degrees: 109
  dc.w           %0111110000100011       ; degrees: 110
  dc.w           %0111101110111111       ; degrees: 111
  dc.w           %0111101101010110       ; degrees: 112
  dc.w           %0111101011101001       ; degrees: 113
  dc.w           %0111101001110111       ; degrees: 114
  dc.w           %0111101000000000       ; degrees: 115
  dc.w           %0111100110000101       ; degrees: 116
  dc.w           %0111100100000110       ; degrees: 117
  dc.w           %0111100010000010       ; degrees: 118
  dc.w           %0111011111111001       ; degrees: 119
  dc.w           %0111011101101100       ; degrees: 120
  dc.w           %0111011011011011       ; degrees: 121
  dc.w           %0111011001000110       ; degrees: 122
  dc.w           %0111010110101100       ; degrees: 123
  dc.w           %0111010100001110       ; degrees: 124
  dc.w           %0111010001101100       ; degrees: 125
  dc.w           %0111001111000110       ; degrees: 126
  dc.w           %0111001100011100       ; degrees: 127
  dc.w           %0111001001101110       ; degrees: 128
  dc.w           %0111000110111100       ; degrees: 129
  dc.w           %0111000100000110       ; degrees: 130
  dc.w           %0111000001001101       ; degrees: 131
  dc.w           %0110111110001111       ; degrees: 132
  dc.w           %0110111011001110       ; degrees: 133
  dc.w           %0110111000001001       ; degrees: 134
  dc.w           %0110110101000001       ; degrees: 135
  dc.w           %0110110001110101       ; degrees: 136
  dc.w           %0110101110100101       ; degrees: 137
  dc.w           %0110101011010011       ; degrees: 138
  dc.w           %0110100111111100       ; degrees: 139
  dc.w           %0110100100100011       ; degrees: 140
  dc.w           %0110100001000110       ; degrees: 141
  dc.w           %0110011101100110       ; degrees: 142
  dc.w           %0110011010000100       ; degrees: 143
  dc.w           %0110010110011110       ; degrees: 144
  dc.w           %0110010010110101       ; degrees: 145
  dc.w           %0110001111001001       ; degrees: 146
  dc.w           %0110001011011011       ; degrees: 147
  dc.w           %0110000111101010       ; degrees: 148
  dc.w           %0110000011110110       ; degrees: 149
  dc.w           %0110000000000000       ; degrees: 150
  dc.w           %0101111100000111       ; degrees: 151
  dc.w           %0101111000001011       ; degrees: 152
  dc.w           %0101110100001110       ; degrees: 153
  dc.w           %0101110000001110       ; degrees: 154
  dc.w           %0101101100001100       ; degrees: 155
  dc.w           %0101101000000111       ; degrees: 156
  dc.w           %0101100100000001       ; degrees: 157
  dc.w           %0101011111111001       ; degrees: 158
  dc.w           %0101011011101111       ; degrees: 159
  dc.w           %0101010111100011       ; degrees: 160
  dc.w           %0101010011010110       ; degrees: 161
  dc.w           %0101001111000110       ; degrees: 162
  dc.w           %0101001010110110       ; degrees: 163
  dc.w           %0101000110100100       ; degrees: 164
  dc.w           %0101000010010000       ; degrees: 165
  dc.w           %0100111101111011       ; degrees: 166
  dc.w           %0100111001100101       ; degrees: 167
  dc.w           %0100110101001110       ; degrees: 168
  dc.w           %0100110000110110       ; degrees: 169
  dc.w           %0100101100011101       ; degrees: 170
  dc.w           %0100101000000011       ; degrees: 171
  dc.w           %0100100011101000       ; degrees: 172
  dc.w           %0100011111001100       ; degrees: 173
  dc.w           %0100011010110000       ; degrees: 174
  dc.w           %0100010110010011       ; degrees: 175
  dc.w           %0100010001110110       ; degrees: 176
  dc.w           %0100001101011001       ; degrees: 177
  dc.w           %0100001000111011       ; degrees: 178
  dc.w           %0100000100011101       ; degrees: 179
  dc.w           %0100000000000000       ; degrees: 180
  dc.w           %0011111011100010       ; degrees: 181
  dc.w           %0011110111000100       ; degrees: 182
  dc.w           %0011110010100110       ; degrees: 183
  dc.w           %0011101110001001       ; degrees: 184
  dc.w           %0011101001101100       ; degrees: 185
  dc.w           %0011100101001111       ; degrees: 186
  dc.w           %0011100000110011       ; degrees: 187
  dc.w           %0011011100010111       ; degrees: 188
  dc.w           %0011010111111100       ; degrees: 189
  dc.w           %0011010011100010       ; degrees: 190
  dc.w           %0011001111001001       ; degrees: 191
  dc.w           %0011001010110001       ; degrees: 192
  dc.w           %0011000110011010       ; degrees: 193
  dc.w           %0011000010000100       ; degrees: 194
  dc.w           %0010111101101111       ; degrees: 195
  dc.w           %0010111001011011       ; degrees: 196
  dc.w           %0010110101001001       ; degrees: 197
  dc.w           %0010110000111001       ; degrees: 198
  dc.w           %0010101100101001       ; degrees: 199
  dc.w           %0010101000011100       ; degrees: 200
  dc.w           %0010100100010000       ; degrees: 201
  dc.w           %0010100000000110       ; degrees: 202
  dc.w           %0010011011111110       ; degrees: 203
  dc.w           %0010010111111000       ; degrees: 204
  dc.w           %0010010011110011       ; degrees: 205
  dc.w           %0010001111110001       ; degrees: 206
  dc.w           %0010001011110001       ; degrees: 207
  dc.w           %0010000111110100       ; degrees: 208
  dc.w           %0010000011111000       ; degrees: 209
  dc.w           %0010000000000000       ; degrees: 210
  dc.w           %0001111100001001       ; degrees: 211
  dc.w           %0001111000010101       ; degrees: 212
  dc.w           %0001110100100100       ; degrees: 213
  dc.w           %0001110000110110       ; degrees: 214
  dc.w           %0001101101001010       ; degrees: 215
  dc.w           %0001101001100001       ; degrees: 216
  dc.w           %0001100101111011       ; degrees: 217
  dc.w           %0001100010011001       ; degrees: 218
  dc.w           %0001011110111001       ; degrees: 219
  dc.w           %0001011011011100       ; degrees: 220
  dc.w           %0001011000000011       ; degrees: 221
  dc.w           %0001010100101100       ; degrees: 222
  dc.w           %0001010001011010       ; degrees: 223
  dc.w           %0001001110001010       ; degrees: 224
  dc.w           %0001001010111110       ; degrees: 225
  dc.w           %0001000111110110       ; degrees: 226
  dc.w           %0001000100110001       ; degrees: 227
  dc.w           %0001000001110000       ; degrees: 228
  dc.w           %0000111110110010       ; degrees: 229
  dc.w           %0000111011111001       ; degrees: 230
  dc.w           %0000111001000011       ; degrees: 231
  dc.w           %0000110110010001       ; degrees: 232
  dc.w           %0000110011100011       ; degrees: 233
  dc.w           %0000110000111001       ; degrees: 234
  dc.w           %0000101110010011       ; degrees: 235
  dc.w           %0000101011110001       ; degrees: 236
  dc.w           %0000101001010011       ; degrees: 237
  dc.w           %0000100110111001       ; degrees: 238
  dc.w           %0000100100100100       ; degrees: 239
  dc.w           %0000100010010011       ; degrees: 240
  dc.w           %0000100000000110       ; degrees: 241
  dc.w           %0000011101111101       ; degrees: 242
  dc.w           %0000011011111001       ; degrees: 243
  dc.w           %0000011001111010       ; degrees: 244
  dc.w           %0000010111111111       ; degrees: 245
  dc.w           %0000010110001000       ; degrees: 246
  dc.w           %0000010100010110       ; degrees: 247
  dc.w           %0000010010101001       ; degrees: 248
  dc.w           %0000010001000000       ; degrees: 249
  dc.w           %0000001111011100       ; degrees: 250
  dc.w           %0000001101111100       ; degrees: 251
  dc.w           %0000001100100001       ; degrees: 252
  dc.w           %0000001011001011       ; degrees: 253
  dc.w           %0000001001111010       ; degrees: 254
  dc.w           %0000001000101110       ; degrees: 255
  dc.w           %0000000111100110       ; degrees: 256
  dc.w           %0000000110100011       ; degrees: 257
  dc.w           %0000000101100110       ; degrees: 258
  dc.w           %0000000100101101       ; degrees: 259
  dc.w           %0000000011111000       ; degrees: 260
  dc.w           %0000000011001001       ; degrees: 261
  dc.w           %0000000010011111       ; degrees: 262
  dc.w           %0000000001111010       ; degrees: 263
  dc.w           %0000000001011001       ; degrees: 264
  dc.w           %0000000000111110       ; degrees: 265
  dc.w           %0000000000100111       ; degrees: 266
  dc.w           %0000000000010110       ; degrees: 267
  dc.w           %0000000000001001       ; degrees: 268
  dc.w           %0000000000000010       ; degrees: 269
  dc.w           %0000000000000000       ; degrees: 270
  dc.w           %0000000000000010       ; degrees: 271
  dc.w           %0000000000001001       ; degrees: 272
  dc.w           %0000000000010110       ; degrees: 273
  dc.w           %0000000000100111       ; degrees: 274
  dc.w           %0000000000111110       ; degrees: 275
  dc.w           %0000000001011001       ; degrees: 276
  dc.w           %0000000001111010       ; degrees: 277
  dc.w           %0000000010011111       ; degrees: 278
  dc.w           %0000000011001001       ; degrees: 279
  dc.w           %0000000011111000       ; degrees: 280
  dc.w           %0000000100101101       ; degrees: 281
  dc.w           %0000000101100110       ; degrees: 282
  dc.w           %0000000110100011       ; degrees: 283
  dc.w           %0000000111100110       ; degrees: 284
  dc.w           %0000001000101110       ; degrees: 285
  dc.w           %0000001001111010       ; degrees: 286
  dc.w           %0000001011001011       ; degrees: 287
  dc.w           %0000001100100001       ; degrees: 288
  dc.w           %0000001101111100       ; degrees: 289
  dc.w           %0000001111011100       ; degrees: 290
  dc.w           %0000010001000000       ; degrees: 291
  dc.w           %0000010010101001       ; degrees: 292
  dc.w           %0000010100010110       ; degrees: 293
  dc.w           %0000010110001000       ; degrees: 294
  dc.w           %0000010111111111       ; degrees: 295
  dc.w           %0000011001111010       ; degrees: 296
  dc.w           %0000011011111001       ; degrees: 297
  dc.w           %0000011101111101       ; degrees: 298
  dc.w           %0000100000000110       ; degrees: 299
  dc.w           %0000100010010011       ; degrees: 300
  dc.w           %0000100100100100       ; degrees: 301
  dc.w           %0000100110111001       ; degrees: 302
  dc.w           %0000101001010011       ; degrees: 303
  dc.w           %0000101011110001       ; degrees: 304
  dc.w           %0000101110010011       ; degrees: 305
  dc.w           %0000110000111001       ; degrees: 306
  dc.w           %0000110011100011       ; degrees: 307
  dc.w           %0000110110010001       ; degrees: 308
  dc.w           %0000111001000011       ; degrees: 309
  dc.w           %0000111011111001       ; degrees: 310
  dc.w           %0000111110110010       ; degrees: 311
  dc.w           %0001000001110000       ; degrees: 312
  dc.w           %0001000100110001       ; degrees: 313
  dc.w           %0001000111110110       ; degrees: 314
  dc.w           %0001001010111110       ; degrees: 315
  dc.w           %0001001110001010       ; degrees: 316
  dc.w           %0001010001011010       ; degrees: 317
  dc.w           %0001010100101100       ; degrees: 318
  dc.w           %0001011000000011       ; degrees: 319
  dc.w           %0001011011011100       ; degrees: 320
  dc.w           %0001011110111001       ; degrees: 321
  dc.w           %0001100010011001       ; degrees: 322
  dc.w           %0001100101111011       ; degrees: 323
  dc.w           %0001101001100001       ; degrees: 324
  dc.w           %0001101101001010       ; degrees: 325
  dc.w           %0001110000110110       ; degrees: 326
  dc.w           %0001110100100100       ; degrees: 327
  dc.w           %0001111000010101       ; degrees: 328
  dc.w           %0001111100001001       ; degrees: 329
  dc.w           %0010000000000000       ; degrees: 330
  dc.w           %0010000011111000       ; degrees: 331
  dc.w           %0010000111110100       ; degrees: 332
  dc.w           %0010001011110001       ; degrees: 333
  dc.w           %0010001111110001       ; degrees: 334
  dc.w           %0010010011110011       ; degrees: 335
  dc.w           %0010010111111000       ; degrees: 336
  dc.w           %0010011011111110       ; degrees: 337
  dc.w           %0010100000000110       ; degrees: 338
  dc.w           %0010100100010000       ; degrees: 339
  dc.w           %0010101000011100       ; degrees: 340
  dc.w           %0010101100101001       ; degrees: 341
  dc.w           %0010110000111001       ; degrees: 342
  dc.w           %0010110101001001       ; degrees: 343
  dc.w           %0010111001011011       ; degrees: 344
  dc.w           %0010111101101111       ; degrees: 345
  dc.w           %0011000010000100       ; degrees: 346
  dc.w           %0011000110011010       ; degrees: 347
  dc.w           %0011001010110001       ; degrees: 348
  dc.w           %0011001111001001       ; degrees: 349
  dc.w           %0011010011100010       ; degrees: 350
  dc.w           %0011010111111100       ; degrees: 351
  dc.w           %0011011100010111       ; degrees: 352
  dc.w           %0011100000110011       ; degrees: 353
  dc.w           %0011100101001111       ; degrees: 354
  dc.w           %0011101001101100       ; degrees: 355
  dc.w           %0011101110001001       ; degrees: 356
  dc.w           %0011110010100110       ; degrees: 357
  dc.w           %0011110111000100       ; degrees: 358
  dc.w           %0011111011100010       ; degrees: 359
