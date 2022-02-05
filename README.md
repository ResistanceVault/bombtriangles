# Flashparty 2022 intro compo entry

This is a new repo for flashparty 2022.
The main idea here is to produce a small intro (executable <64k).
I'd like the theme to be something like 2d figures dancing at maze chiptune.
Inside there is the library I wrote for drawing/filling/rotating 2d figures, for now the demo only features 2 filled triangles,
the first one on bitplane 1 the second on bitplane 2, the intersecting area generated another triangle and to my eyes it's a nice effect.

I'd like to target an A1000, so staying under 512k of chip ram is mandatory. For this reason i must precalculate as less as possibile and the code must be quick to fit into a 68k at 50fps.

Right now the music it's reported to do not work on my friend's A1000 but works for me with fsuae... dunno...

### Problems
What I need now

- [x] fix the exit problem (THX Kristoff)
- [x] fix the music problem
- [ ] migrate to pretracker
- [ ] tiles at 3 playfields?
- [ ] ideas on how to syncronize rotation with the music
- [ ] ideas on general how to proceed

### How to build

You just need vasm to build the whole project, shrinkler compress it, the final executable for now it's about 15k, this means we have space to add more stuff.

Devpac also compiles the project on a real amiga, just feed r.s to devpac and click assemble, it will work (or at least it works on my stock A600).

The makefile will produce this files:
1. r (for debug, the copper effect are stripped and the background color is used to evaluate performances)
2. reffect (color debug is turned off and copper effects are in place)
3. rcompressed (just reffect compressed with shrinkler)

### Size matters
Compressed with shrinkler: 15380 bytes
Compressed with shrinkler: 126244 bytes

Looking for Resistance members willing to help me




