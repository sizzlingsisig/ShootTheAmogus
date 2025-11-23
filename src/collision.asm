;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module collision
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _playSound
	.globl _checkCollision
	.globl _addScore
	.globl _incrementEnemiesKilled
	.globl _incrementWave
	.globl _checkBulletEnemyCollisions
	.globl _checkPlayerEnemyCollisions
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
;src/collision.c:9: void checkBulletEnemyCollisions(void)
;	---------------------------------
; Function checkBulletEnemyCollisions
; ---------------------------------
_checkBulletEnemyCollisions::
	add	sp, #-11
;src/collision.c:12: for (i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,	#9
	ld	(hl), #0x00
00123$:
;src/collision.c:14: if (bullets[i].y == 0)
	ldhl	sp,	#9
	ld	a, (hl)
	ld	d, #0x00
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
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
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00119$
;src/collision.c:17: for (j = 0; j < MAX_ENEMIES; j++)
	ld	(hl), #0x00
00122$:
;src/collision.c:19: Enemy *e = &enemies[j];
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_enemies)
	ld	c, a
	ld	a, h
	adc	a, #>(_enemies)
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
;src/collision.c:20: if (!e->isActive || e->deathTimer > 0)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00117$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00117$
;src/collision.c:24: e->x + 2, e->y + 2, 12, 12))
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	c
	inc	c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
;src/collision.c:23: if (checkCollision(bullets[i].x + 1, bullets[i].y + 1, 6, 6,
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	add	a, #0x02
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	a
	ldhl	sp,	#8
	ld	(hl), a
	pop	de
	push	de
	ld	a, (de)
	inc	a
	ld	h, #0x0c
	push	hl
	inc	sp
	ld	h, #0x0c
	push	hl
	inc	sp
	ld	h, c
	push	hl
	inc	sp
	push	bc
	inc	sp
	ld	h, #0x06
	push	hl
	inc	sp
	ld	h, #0x06
	push	hl
	inc	sp
	ldhl	sp,	#14
	ld	e, (hl)
	call	_checkCollision
	or	a, a
	jp	Z, 00117$
;src/collision.c:26: bullets[i].y = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/collision.c:27: move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00191$:
	ldhl	sp,	#0
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00191$
	pop	de
	push	de
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	pop	hl
	ld	(hl), #0xc8
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
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xc8
;src/collision.c:29: e->health--;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
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
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	dec	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/collision.c:30: e->hitFlashTimer = 6;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	inc	sp
	inc	sp
	ld	(hl), #0x06
	push	hl
;src/collision.c:32: if (e->health == 0)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00119$
;src/collision.c:34: playSound(SOUND_ENEMY_DEATH);
	ld	a, #0x05
	call	_playSound
;src/collision.c:36: if (e->type == ENEMY_TYPE_BOSS)
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
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
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00111$
;src/collision.c:38: addScore(100);
	ld	de, #0x0064
	call	_addScore
;src/collision.c:39: incrementWave();
	call	_incrementWave
	jr	00112$
00111$:
;src/collision.c:41: else if (e->type == ENEMY_TYPE_FLYING || e->type == ENEMY_TYPE_TARGETING)
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00106$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00107$
00106$:
;src/collision.c:43: addScore(20);
	ld	de, #0x0014
	call	_addScore
;src/collision.c:44: incrementEnemiesKilled();
	call	_incrementEnemiesKilled
	jr	00112$
00107$:
;src/collision.c:48: addScore(10);
	ld	de, #0x000a
	call	_addScore
;src/collision.c:49: incrementEnemiesKilled();
	call	_incrementEnemiesKilled
00112$:
;src/collision.c:52: e->deathTimer = 12;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
;src/collision.c:55: break;
	jr	00119$
00117$:
;src/collision.c:17: for (j = 0; j < MAX_ENEMIES; j++)
	ldhl	sp,	#10
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jp	C, 00122$
00119$:
;src/collision.c:12: for (i = 0; i < MAX_BULLETS; i++)
	ldhl	sp,	#9
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jp	C, 00123$
;src/collision.c:59: }
	add	sp, #11
	ret
;src/collision.c:61: void checkPlayerEnemyCollisions(void)
;	---------------------------------
; Function checkPlayerEnemyCollisions
; ---------------------------------
_checkPlayerEnemyCollisions::
	add	sp, #-8
;src/collision.c:63: if (player.invincibilityTimer > 0)
	ld	a, (#(_player + 6) + 0)
	ldhl	sp,#7
	ld	(hl), a
	or	a, a
;src/collision.c:64: return;
;src/collision.c:67: for (i = 0; i < MAX_ENEMIES; i++)
	jp	NZ, 00117$
	ldhl	sp,	#7
	ld	(hl), #0x00
00116$:
;src/collision.c:69: Enemy *e = &enemies[i];
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ld	de, #_enemies
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/collision.c:70: if (!e->isActive || e->deathTimer > 0)
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00114$
	pop	de
	push	de
	ld	hl, #0x000d
	add	hl, de
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
	or	a, a
	jp	NZ, 00114$
;src/collision.c:74: e->x + 2, e->y + 2, 12, 12))
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	add	a, #0x02
	ld	(hl+), a
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x02
	ld	(hl), a
;src/collision.c:73: if (checkCollision(player.x + 2, player.y + 2, 12, 12,
	ld	a, (#(_player + 1) + 0)
	ldhl	sp,#6
	ld	(hl), a
	inc	(hl)
	inc	(hl)
	ld	a, (#_player + 0)
	add	a, #0x02
	ld	h, #0x0c
	push	hl
	inc	sp
	ld	h, #0x0c
	push	hl
	inc	sp
	ldhl	sp,	#6
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#8
	ld	h, (hl)
	push	hl
	inc	sp
	ld	h, #0x0c
	push	hl
	inc	sp
	ld	h, #0x0c
	push	hl
	inc	sp
	ldhl	sp,	#12
	ld	e, (hl)
	call	_checkCollision
	or	a, a
	jr	Z, 00114$
;src/collision.c:76: game.lives--;
	ld	bc, #_game+0
	ld	a, (bc)
	dec	a
	ld	(bc), a
;src/collision.c:77: playSound(SOUND_HIT);
	ld	a, #0x04
	call	_playSound
;src/collision.c:78: player.invincibilityTimer = INVINCIBILITY_TIME;
	ld	hl, #(_player + 6)
	ld	(hl), #0x3c
;src/collision.c:80: if (e->type == ENEMY_TYPE_BOSS)
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	sub	a, #0x05
	jr	NZ, 00110$
;src/collision.c:82: e->health--;
	pop	de
	push	de
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	ld	(bc), a
;src/collision.c:83: e->hitFlashTimer = 6;
	pop	de
	push	de
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x06
;src/collision.c:85: if (e->health == 0)
	ld	a, (bc)
	or	a, a
	jr	NZ, 00107$
;src/collision.c:87: e->deathTimer = 12;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
;src/collision.c:88: incrementWave();
	call	_incrementWave
;src/collision.c:89: playSound(SOUND_ENEMY_DEATH);
	ld	a, #0x05
	call	_playSound
	jr	00117$
00107$:
;src/collision.c:93: playSound(SOUND_HIT);
	ld	a, #0x04
	call	_playSound
	jr	00117$
00110$:
;src/collision.c:98: e->deathTimer = 12;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
;src/collision.c:100: return;
	jr	00117$
00114$:
;src/collision.c:67: for (i = 0; i < MAX_ENEMIES; i++)
	ldhl	sp,	#7
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jp	C, 00116$
00117$:
;src/collision.c:103: }
	add	sp, #8
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
