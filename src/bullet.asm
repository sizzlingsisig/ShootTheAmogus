;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module bullet
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _playSound
	.globl _bullets
	.globl _initBullets
	.globl _fireBullet
	.globl _updateBullets
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_bullets::
	.ds 48
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
;src/bullet.c:10: void initBullets(void)
;	---------------------------------
; Function initBullets
; ---------------------------------
_initBullets::
	dec	sp
;src/bullet.c:13: for (i = 0; i < MAX_BULLETS; i++)
	ld	c, #0x00
00104$:
;src/bullet.c:15: bullets[i].x = 0;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_bullets)
	ld	e, a
	ld	a, h
	adc	a, #>(_bullets)
	ld	d, a
	xor	a, a
	ld	(de), a
;src/bullet.c:16: bullets[i].y = 0;
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x00
;src/bullet.c:17: set_sprite_tile(24 + i, 0);
	ld	a, c
	add	a, #0x18
	ldhl	sp,	#0
	ld	(hl), a
	ld	b, (hl)
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), #0x00
;src/bullet.c:18: bullets[i].spritids[0] = 24 + i;
	inc	de
	inc	de
	inc	de
	inc	de
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/bullet.c:19: move_sprite(24 + i, OFFSCREEN_X, OFFSCREEN_Y);
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/bullet.c:13: for (i = 0; i < MAX_BULLETS; i++)
	inc	c
	ld	a, c
	sub	a, #0x06
	jr	C, 00104$
;src/bullet.c:21: }
	inc	sp
	ret
;src/bullet.c:24: UINT8 fireBullet(void)
;	---------------------------------
; Function fireBullet
; ---------------------------------
_fireBullet::
	add	sp, #-6
;src/bullet.c:27: for (i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,	#5
	ld	(hl), #0x00
00104$:
;src/bullet.c:29: if (bullets[i].y == 0)
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x03
00129$:
	ldhl	sp,	#3
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00129$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_bullets
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	or	a, a
	jr	NZ, 00105$
;src/bullet.c:31: bullets[i].x = player.x + BULLET_OFFSET_X;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (#_player + 0)
	add	a, #0x0c
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/bullet.c:32: bullets[i].y = player.y + BULLET_OFFSET_Y;
	ld	a, (#(_player + 1) + 0)
	ldhl	sp,#5
	ld	(hl), a
	inc	(hl)
	inc	(hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;src/bullet.c:33: playSound(SOUND_SHOOT);
	ld	a, #0x02
	call	_playSound
;src/bullet.c:34: return 1;
	ld	a, #0x01
	jr	00106$
00105$:
;src/bullet.c:27: for (i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,	#5
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00104$
;src/bullet.c:37: return 0;
	xor	a, a
00106$:
;src/bullet.c:38: }
	add	sp, #6
	ret
;src/bullet.c:41: void updateBullets(void)
;	---------------------------------
; Function updateBullets
; ---------------------------------
_updateBullets::
	add	sp, #-8
;src/bullet.c:44: for (i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,	#7
	ld	(hl), #0x00
00109$:
;src/bullet.c:46: if (bullets[i].y > 0)
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl, #_bullets
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00110$
;src/bullet.c:48: bullets[i].x += BULLET_SPEED;
;src/bullet.c:50: if (bullets[i].x >= SCREEN_WIDTH)
	dec	hl
	dec	hl
	pop	bc
	push	bc
	ld	a, (bc)
	add	a, #0x04
	ld	(bc), a
	ld	a, (bc)
	ld	(hl), a
;src/bullet.c:53: move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
;src/bullet.c:50: if (bullets[i].x >= SCREEN_WIDTH)
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0xa0
	jr	C, 00102$
;src/bullet.c:52: bullets[i].y = 0;
	dec	hl
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
;src/bullet.c:53: move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00136$:
	ldhl	sp,	#3
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00136$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xc8
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xc8
;src/bullet.c:53: move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);
	jr	00110$
00102$:
;src/bullet.c:57: move_sprite(bullets[i].spritids[0], bullets[i].x, bullets[i].y);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00137$:
	ldhl	sp,	#1
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00137$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;src/bullet.c:57: move_sprite(bullets[i].spritids[0], bullets[i].x, bullets[i].y);
00110$:
;src/bullet.c:44: for (i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,	#7
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jp	C, 00109$
;src/bullet.c:61: }
	add	sp, #8
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
