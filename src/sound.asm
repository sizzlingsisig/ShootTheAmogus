;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module sound
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gbt_stop
	.globl _playSound
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/sound.c:6: void playSound(SoundType type)
;	---------------------------------
; Function playSound
; ---------------------------------
_playSound::
	ld	c, a
;src/sound.c:8: switch (type)
	ld	a, #0x05
	sub	a, c
	ret	C
	ld	b, #0x00
	ld	hl, #00116$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00116$:
	.dw	00107$
	.dw	00101$
	.dw	00102$
	.dw	00105$
	.dw	00103$
	.dw	00104$
;src/sound.c:10: case SOUND_JUMP:
00101$:
;src/sound.c:11: NR10_REG = 0x16;
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;src/sound.c:12: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;src/sound.c:13: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;src/sound.c:14: NR13_REG = 0x00;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;src/sound.c:15: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;src/sound.c:16: break;
	ret
;src/sound.c:17: case SOUND_SHOOT:
00102$:
;src/sound.c:18: NR10_REG = 0x06;
	ld	a, #0x06
	ldh	(_NR10_REG + 0), a
;src/sound.c:19: NR11_REG = 0x60;
	ld	a, #0x60
	ldh	(_NR11_REG + 0), a
;src/sound.c:20: NR12_REG = 0x83;
	ld	a, #0x83
	ldh	(_NR12_REG + 0), a
;src/sound.c:21: NR13_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR13_REG + 0), a
;src/sound.c:22: NR14_REG = 0x87;
	ld	a, #0x87
	ldh	(_NR14_REG + 0), a
;src/sound.c:23: break;
	ret
;src/sound.c:24: case SOUND_HIT:
00103$:
;src/sound.c:25: NR10_REG = 0x26;
	ld	a, #0x26
	ldh	(_NR10_REG + 0), a
;src/sound.c:26: NR11_REG = 0x50;
	ld	a, #0x50
	ldh	(_NR11_REG + 0), a
;src/sound.c:27: NR12_REG = 0xF4;
	ld	a, #0xf4
	ldh	(_NR12_REG + 0), a
;src/sound.c:28: NR13_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR13_REG + 0), a
;src/sound.c:29: NR14_REG = 0xC5;
	ld	a, #0xc5
	ldh	(_NR14_REG + 0), a
;src/sound.c:30: break;
	ret
;src/sound.c:31: case SOUND_ENEMY_DEATH:
00104$:
;src/sound.c:32: NR10_REG = 0x36;
	ld	a, #0x36
	ldh	(_NR10_REG + 0), a
;src/sound.c:33: NR11_REG = 0x60;
	ld	a, #0x60
	ldh	(_NR11_REG + 0), a
;src/sound.c:34: NR12_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR12_REG + 0), a
;src/sound.c:35: NR13_REG = 0x30;
	ld	a, #0x30
	ldh	(_NR13_REG + 0), a
;src/sound.c:36: NR14_REG = 0xC4;
	ld	a, #0xc4
	ldh	(_NR14_REG + 0), a
;src/sound.c:37: break;
	ret
;src/sound.c:38: case SOUND_GAME_OVER:
00105$:
;src/sound.c:40: gbt_stop();
	jp	_gbt_stop
;src/sound.c:42: }
00107$:
;src/sound.c:43: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
