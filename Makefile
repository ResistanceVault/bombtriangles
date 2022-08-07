all:
		vasmm68k_mot -kick1hunks -devpac -Fhunkexe -quiet -esc  -m68000 -DPRT -DSQRT_FAKE -DCOPPLATFORM -DMATRIX_STACK_SIZE=0 -DUSE_OR_BLIT -DUSE_BPL_SECTION -DUSE_DBLBUF -DUSE_MUSICCOUNTER ./r.s  -o ./rliscio -I/usr/local/amiga/os-include && chmod 777 ./rliscio
		vasmm68k_mot -kick1hunks -devpac -Fhunkexe -quiet -esc  -m68000 -DPRT -DSQRT_FAKE -DCOPPLATFORM -DMATRIX_STACK_SIZE=0 -DUSE_OR_BLIT -DUSE_BPL_SECTION -DUSE_DBLBUF -DDEBUGCOLORS   ./r.s  -o ./r -I/usr/local/amiga/os-include && chmod 777 ./r
		vasmm68k_mot -kick1hunks -devpac -Fhunkexe -quiet -esc  -m68000 -DPRT -DSQRT_FAKE -DCOPPLATFORM -DMATRIX_STACK_SIZE=0 -DUSE_OR_BLIT -DUSE_BPL_SECTION -DUSE_DBLBUF -DEFFECTS   ./r.s  -o ./reffect -I/usr/local/amiga/os-include && chmod 777 ./reffect
	./comprimi.sh


zip:
	cd .. && rm -f flash2022.zip && zip -r flash2022.zip ./flash2022 -x "flash2022/sketchbook*" -x "*/.*" -x "flash2022/rliscio" -x "flash2022/reffect" -x "flash2022/r" -x "flash2022/AProcessing/tests*" -x "flash2022/AProcessing/fusuae-unit-tester*" -x "flash2022/wolfram*" -x "flash2022/build*" -x "flash2022/rcompresso" -x "flash2022/r" -x "flash2022/*.adf" -x "flash2022/wolfram" -x "flash2022/assets/pretracker*" && cd flash2022