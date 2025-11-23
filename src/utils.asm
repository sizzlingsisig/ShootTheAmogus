;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module utils
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gbt_update
	.globl _wait_vbl_done
	.globl _simpleRand
	.globl _initRand
	.globl _moveSprite4
	.globl _hideSprite4
	.globl _waitFrames
	.globl _checkCollision
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_randSeed:
	.ds 2
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
;src/utils.c:7: UINT8 simpleRand(void)
;	---------------------------------
; Function simpleRand
; ---------------------------------
_simpleRand::
;src/utils.c:9: randSeed = (randSeed * 1103515245U + 12345U) & 0x7FFFU;
	ld	a, (_randSeed)
	ld	c, a
	ld	hl, #_randSeed + 1
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc, #0x3039
	add	hl, bc
	ld	a, l
	ld	(_randSeed), a
	ld	a, h
	and	a, #0x7f
	ld	(#_randSeed + 1),a
;src/utils.c:10: return (UINT8)(randSeed >> 8);
	ld	a, (_randSeed + 1)
;src/utils.c:11: }
	ret
;src/utils.c:13: void initRand(UINT16 seed)
;	---------------------------------
; Function initRand
; ---------------------------------
_initRand::
	ld	hl, #_randSeed
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/utils.c:15: randSeed = seed;
;src/utils.c:16: }
	ret
;src/utils.c:18: void moveSprite4(UINT8 sprite1, UINT8 sprite2, UINT8 sprite3, UINT8 sprite4,
;	---------------------------------
; Function moveSprite4
; ---------------------------------
_moveSprite4::
	add	sp, #-4
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/utils.c:21: move_sprite(sprite1, x, y);
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	c, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#3
	ld	b, (hl)
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;src/utils.c:22: move_sprite(sprite2, x + SPRITE_SIZE, y);
	ldhl	sp,	#8
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
	ld	b, c
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#2
	ld	d, (hl)
	xor	a, a
	ld	l, d
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), b
;src/utils.c:23: move_sprite(sprite3, x, y + SPRITE_SIZE);
	ld	a, e
	add	a, #0x08
	ld	b, a
	ldhl	sp,	#1
	ld	(hl), b
	ldhl	sp,	#6
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/utils.c:24: move_sprite(sprite4, x + SPRITE_SIZE, y + SPRITE_SIZE);
	ldhl	sp,	#7
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl), b
	inc	hl
	ld	(hl), c
;src/utils.c:24: move_sprite(sprite4, x + SPRITE_SIZE, y + SPRITE_SIZE);
;src/utils.c:25: }
	add	sp, #4
	pop	hl
	add	sp, #5
	jp	(hl)
;src/utils.c:27: void hideSprite4(UINT8 base)
;	---------------------------------
; Function hideSprite4
; ---------------------------------
_hideSprite4::
	ld	e, a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, e
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/utils.c:30: move_sprite(base + 1, OFFSCREEN_X, OFFSCREEN_Y);
	ld	d, e
	inc	d
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, d
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/utils.c:31: move_sprite(base + 2, OFFSCREEN_X, OFFSCREEN_Y);
	ld	d, e
	inc	d
	inc	d
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, d
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/utils.c:32: move_sprite(base + 3, OFFSCREEN_X, OFFSCREEN_Y);
	inc	e
	inc	e
	inc	e
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/utils.c:32: move_sprite(base + 3, OFFSCREEN_X, OFFSCREEN_Y);
;src/utils.c:33: }
	ret
;src/utils.c:35: void waitFrames(UINT8 frames)
;	---------------------------------
; Function waitFrames
; ---------------------------------
_waitFrames::
	ld	c, a
;src/utils.c:38: for (i = 0; i < frames; i++)
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	ret	NC
;src/utils.c:40: wait_vbl_done();
	call	_wait_vbl_done
;src/utils.c:41: gbt_update();
	push	bc
	call	_gbt_update
	pop	bc
;src/utils.c:38: for (i = 0; i < frames; i++)
	inc	b
;src/utils.c:43: }
	jr	00103$
;src/utils.c:45: UINT8 checkCollision(UINT8 x1, UINT8 y1, UINT8 w1, UINT8 h1,
;	---------------------------------
; Function checkCollision
; ---------------------------------
_checkCollision::
	add	sp, #-5
	ld	d, a
	ldhl	sp,	#4
	ld	(hl), e
;src/utils.c:48: return (x1 < x2 + w2 && x1 + w1 > x2 &&
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, d
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00103$
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00103$
;src/utils.c:49: y1 < y2 + h2 && y1 + h1 > y2);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00103$
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	C, 00104$
00103$:
	xor	a, a
	jr	00105$
00104$:
	ld	a, #0x01
00105$:
;src/utils.c:50: }
	add	sp, #5
	pop	hl
	add	sp, #6
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
