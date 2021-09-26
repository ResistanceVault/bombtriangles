all:
		vasmm68k_mot -devpac -Fhunkexe -quiet -esc  -m68000  -DUSE_DBLBUF -DDEBUGCOLORS  -DUSE_3D ./r.s  -o ./r -I/usr/local/amiga/os-include && chmod 777 ./r
		vasmm68k_mot -devpac -Fhunkexe -quiet -esc  -m68000  -DUSE_DBLBUF -DEFFECTS  -DUSE_3D ./r.s  -o ./reffect -I/usr/local/amiga/os-include && chmod 777 ./reffect
	./comprimi.sh
