#include <exec/types.h>
#ifndef  __GNUC__
	#include <inline/dos_protos.h>
	#include <inline/exec_protos.h>
#else
	#include <inline/dos.h>
	#include <inline/exec.h>
	
#endif
#include <exec/execbase.h>
#include <exec/memory.h>
#include <hardware/custom.h>

//>>> PLAYER START
typedef unsigned int u32;

typedef u32(*SONGINIT)(void *player,void *song, void *sf);
typedef void(*PLAYERINIT)(void* player, void* chipram, void *song);
typedef void(*PLAYERTICK)(void* player);
typedef void (*STARTSONG)(void *player,int subsongIndex);
typedef void (*STOP)(void *player);
typedef void (*PLAYFX)(void *_player,int voiceNum,int sfxNum,int duration,int volume);
typedef void (*SETVOLUME)(void *_player,int volume);

struct PlayerJumpTable {
	u32 asmSongInit;
	u32 asmPlayerInit;
	u32 asmPlayerTick;
	u32 asmStartSong;
	u32 asmPlaySfx;
	u32 asmStop;
	u32 asmSetVolume;

	u32 cSongInit;
	u32 cPlayerInit;
	u32 cPlayerTick;
	u32 cStartSong;
	u32 cPlaySfx;
	u32 cStop;
	u32 cSetVolume;
};

u32 songInit(void* binary, void* player,void* song, void* sf) {
	return ((SONGINIT)((u32)((struct PlayerJumpTable*)binary)->cSongInit + (u32)binary))(player,song, sf);
}

void playerInit(void* binary, void* player, void* chipram, void *song) {
	((PLAYERINIT)((u32)((struct PlayerJumpTable*)binary)->cPlayerInit + (u32)binary))(player, chipram, song);
}

void playerTick(void* binary, void* player) {
	((PLAYERTICK)((u32)((struct PlayerJumpTable*)binary)->cPlayerTick + (u32)binary))(player);
}

void startSong(void *binary,void *player,int subsongIndex)
{
	((STARTSONG)((u32)((struct PlayerJumpTable*)binary)->cStartSong  + (u32)binary))(player, subsongIndex);
}

void stop(void *binary,void *player)
{
	((STOP)((u32)((struct PlayerJumpTable*)binary)->cStop + (u32)binary))(player);
}

void playFx(void *binary,void *player,int voiceNum,int sfxNum,int duration,int volume) 
{
	((PLAYFX)((u32)((struct PlayerJumpTable*)binary)->cPlaySfx + (u32)binary))(player, voiceNum,sfxNum,duration, volume);
} 

void setVolume(void *binary,void *player,int volume)
{
	((SETVOLUME)((u32)((struct PlayerJumpTable*)binary)->cSetVolume + (u32)binary))(player, volume);
}
//<<< PLAYER END


#define INCBIN_STR2(x) #x
#define INCBIN_STR(x) INCBIN_STR2(x)
#define INCBIN(name, file) \
    __asm__(".pushsection .rodata\n" \
            ".global incbin_" INCBIN_STR(name) "_start\n" \
            ".type incbin_" INCBIN_STR(name) "_start, @object\n" \
            ".balign 2\n" \
            "incbin_" INCBIN_STR(name) "_start:\n" \
            ".incbin \"" file "\"\n" \
            \
            ".global incbin_" INCBIN_STR(name) "_end\n" \
            ".type incbin_" INCBIN_STR(name) "_end, @object\n" \
            ".balign 1\n" \
            "incbin_" INCBIN_STR(name) "_end:\n" \
            ".byte 0\n" \
			".popsection\n" \
    ); \
    extern const __attribute__((aligned(2))) char incbin_ ## name ## _start[1024*1024]; \
	extern const void* incbin_ ## name ## _end;\
    const void* name=&incbin_ ## name ## _start;
INCBIN(song0, "tinyus.prt")
INCBIN(playerBinary, "player.bin")
typedef unsigned short u16;

void pnkWaitLine(u16 line)
{
	while (1)
	{
		volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
		vpos=((vpos>>8)&511);
		if (vpos==line)
			break;
	}
}
inline u16 pnkGetLine(){
	volatile ULONG vpos=*(volatile ULONG*)0xDFF004;
	u16 y=(u16)((vpos>>8)&511);
	return y;
}

#define pnkLog(...) {KPrintF(__VA_ARGS__);}

struct ExecBase *SysBase;

static short songStruct[2 * 1024 / 2];
static int myPlayer[8 * 1024 / 4];

inline short pnkMouseLeft(){return !((*(volatile UBYTE*)0xbfe001)&64);}	
inline short pnkMouseRight(){return !((*(volatile UWORD*)0xdff016)&(1<<10));}

int main()
{
	SysBase=*((struct ExecBase **)4UL);

	u32 chipMemSize = songInit(playerBinary, myPlayer,songStruct, song0);
	if (!chipMemSize)
		return -1;

	KPrintF("ChipmemSize=%ld\n", chipMemSize);

	u32* chipmem=AllocMem(chipMemSize,MEMF_CHIP);

	playerInit(playerBinary,  myPlayer, chipmem, songStruct);

	short buttonLeft=0;
	short buttonLeftPrev=0;
	short buttonRight=0;
	short buttonRightPrev=0;

	volatile struct Custom *hw=(struct Custom*)0xdff000;  
	hw->intena=0x7fff;//disable all interrupts
	hw->intreq=0x7fff;//Clear any interrupts that were pending

	while(1)
	{
		pnkWaitLine(100);
		playerTick(playerBinary, myPlayer);

		buttonLeftPrev=buttonLeft;
		buttonLeft=pnkMouseLeft();

		buttonRightPrev=buttonRight;
		buttonRight=pnkMouseRight();

		//press left mouse button to start next song
		if(buttonLeft && buttonLeftPrev==0)
		{
			static int currentSong=0;
			stop(playerBinary,myPlayer);
			startSong(playerBinary,myPlayer,(++currentSong)%14);
		}

		//press right mouse button to play next sound fx
		if(buttonRight && buttonRightPrev==0)
		{
			static int currentFx=0;
			playFx(playerBinary,myPlayer,3,(++currentFx)%14,50,64);
		}
	}

	return 0;
}
