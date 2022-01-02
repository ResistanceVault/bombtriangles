all:
		vasmm68k_mot -devpac -Fhunkexe -quiet -esc  -m68000  -DUSE_CLIPPING -DUSE_DBLBUF  -DUSE_3D -DUSE_MUSICCOUNTER ./r.s  -o ./rliscio -I/usr/local/amiga/os-include && chmod 777 ./rliscio
		vasmm68k_mot -devpac -Fhunkexe -quiet -esc  -m68000  -DUSE_CLIPPING -DUSE_DBLBUF -DDEBUGCOLORS  -DUSE_3D ./r.s  -o ./r -I/usr/local/amiga/os-include && chmod 777 ./r
		vasmm68k_mot -devpac -Fhunkexe -quiet -esc  -m68000  -DUSE_CLIPPING -DUSE_DBLBUF -DEFFECTS  -DUSE_3D ./r.s  -o ./reffect -I/usr/local/amiga/os-include && chmod 777 ./reffect
	./comprimi.sh


zip:
	cd .. && zip -r flash2022.zip ./flash2022 -x "*/.*" -x "flash2022/rliscio" -x "flash2022/reffect" -x "flash2022/r" -x "flash2022/AProcessing2/tests*" -x "flash2022/AProcessing2/fusuae-unit-tester*" -x "flash2022/wolfram*" -x "flash2022/build*" -x "flash2022/rcompresso" -x "flash2022/r" -x "flash2022/wolfram" && cd flash2022