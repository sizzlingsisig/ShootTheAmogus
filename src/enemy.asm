;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module enemy
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _getEnemySpeed
	.globl _getWaveNumber
	.globl _hideSprite4
	.globl _moveSprite4
	.globl _simpleRand
	.globl _enemies
	.globl _initEnemies
	.globl _spawnEnemy
	.globl _spawnBossEnemy
	.globl _updateBossPhysics
	.globl _updateEnemyPhysics
	.globl _updateEnemyAnimation
	.globl _drawEnemy
	.globl _countActiveEnemies
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_enemies::
	.ds 80
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
;src/enemy.c:8: void initEnemies(void)
;	---------------------------------
; Function initEnemies
; ---------------------------------
_initEnemies::
;src/enemy.c:11: for (i = 0; i < MAX_ENEMIES; i++)
	ld	c, #0x00
00102$:
;src/enemy.c:13: enemies[i].isActive = 0;
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
	ld	e, a
	ld	a, h
	adc	a, #>(_enemies)
	ld	d, a
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x00
;src/enemy.c:14: enemies[i].spriteBase = 8 + (i * 4);
	ld	hl, #0x000a
	add	hl, de
	ld	a, c
	add	a, a
	add	a, a
	add	a, #0x08
;src/enemy.c:15: hideSprite4(enemies[i].spriteBase);
	ld	(hl), a
	push	bc
	call	_hideSprite4
	pop	bc
;src/enemy.c:11: for (i = 0; i < MAX_ENEMIES; i++)
	inc	c
	ld	a, c
	sub	a, #0x04
	jr	C, 00102$
;src/enemy.c:17: }
	ret
;src/enemy.c:19: void spawnEnemy(UINT8 index)
;	---------------------------------
; Function spawnEnemy
; ---------------------------------
_spawnEnemy::
	add	sp, #-15
	ld	c, a
;src/enemy.c:21: Enemy *e = &enemies[index];
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ld	de, #_enemies
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#1
;src/enemy.c:23: e->x = ENEMY_START_X + (simpleRand() % 60);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	call	_simpleRand
	ld	e, #0x3c
	call	__moduchar
	ldhl	sp,#14
	ld	(hl), c
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00a0
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/enemy.c:24: e->isActive = 1;
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x01
;src/enemy.c:25: e->animCounter = 0;
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/enemy.c:26: e->currentFrame = 0;
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/enemy.c:27: e->deathTimer = 0;
	pop	de
	push	de
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/enemy.c:28: e->hitFlashTimer = 0;
	pop	de
	push	de
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/enemy.c:29: e->health = 1;
	pop	de
	push	de
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x01
;src/enemy.c:30: e->maxHealth = 2;
	pop	de
	push	de
	ld	hl, #0x000f
	add	hl, de
	ld	(hl), #0x02
;src/enemy.c:32: UINT8 wave = getWaveNumber();
	call	_getWaveNumber
;src/enemy.c:33: UINT8 availableTypes = 1;
	ld	e, #0x01
;src/enemy.c:34: if (wave >= 5) {
	cp	a, #0x05
	jr	C, 00107$
;src/enemy.c:35: availableTypes = 4;
	ld	e, #0x04
	jr	00108$
00107$:
;src/enemy.c:36: } else if (wave >= 4) {
	cp	a, #0x04
	jr	C, 00104$
;src/enemy.c:37: availableTypes = 3;
	ld	e, #0x03
	jr	00108$
00104$:
;src/enemy.c:38: } else if (wave >= 3) {
	sub	a, #0x03
	jr	C, 00108$
;src/enemy.c:39: availableTypes = 2;
	ld	e, #0x02
00108$:
;src/enemy.c:42: UINT8 spawnType = simpleRand() % availableTypes;
	push	de
	call	_simpleRand
	pop	de
;src/enemy.c:47: e->type = ENEMY_TYPE_GROUND;
	call	__moduchar
	ldhl	sp,	#4
	ld	(hl), c
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
;src/enemy.c:48: e->y = ENEMY_START_Y;
	pop	de
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src/enemy.c:49: e->isJumping = 0;
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
;src/enemy.c:50: e->velocityY = 0;
	pop	de
	push	de
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
;src/enemy.c:51: e->jumpTimer = 30 + (simpleRand() % 50);
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
;src/enemy.c:44: switch (spawnType)
	ldhl	sp,	#4
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #00148$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00148$:
	.dw	00109$
	.dw	00110$
	.dw	00111$
	.dw	00112$
;src/enemy.c:46: case 0: // Ground
00109$:
;src/enemy.c:47: e->type = ENEMY_TYPE_GROUND;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:48: e->y = ENEMY_START_Y;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x69
;src/enemy.c:49: e->isJumping = 0;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:50: e->velocityY = 0;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:51: e->jumpTimer = 30 + (simpleRand() % 50);
	call	_simpleRand
	ld	e, #0x32
	call	__moduchar
	ld	a, c
	add	a, #0x1e
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:52: break;
	jp	00114$
;src/enemy.c:54: case 1: // Jumping
00110$:
;src/enemy.c:55: e->type = ENEMY_TYPE_JUMPING;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/enemy.c:56: e->y = ENEMY_START_Y;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x69
;src/enemy.c:57: e->isJumping = 1;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/enemy.c:58: e->velocityY = ENEMY_JUMP_STRENGTH;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
;src/enemy.c:59: e->jumpTimer = 40 + (simpleRand() % 70);
	call	_simpleRand
	ld	e, #0x46
	call	__moduchar
	ldhl	sp,#12
	ld	(hl), c
	ld	a, (hl+)
	add	a, #0x28
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:60: break;
	jp	00114$
;src/enemy.c:62: case 2: // Flying
00111$:
;src/enemy.c:63: e->type = ENEMY_TYPE_FLYING;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x03
;src/enemy.c:64: e->y = ENEMY_FLY_Y_HIGH + (simpleRand() % (ENEMY_FLY_Y_LOW - ENEMY_FLY_Y_HIGH));
	call	_simpleRand
	ld	e, #0x28
	call	__moduchar
	ldhl	sp,#14
	ld	(hl), c
	ld	a, (hl)
	add	a, #0x32
	ldhl	sp,	#7
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:65: e->isJumping = 0;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:66: e->flyingBobTimer = simpleRand() % 16;
	pop	de
	push	de
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	call	_simpleRand
	ldhl	sp,#14
	ld	(hl), a
	and	a, #0x0f
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:67: e->flyingDirection = (simpleRand() & 1) ? 1 : -1;
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	call	_simpleRand
	rrca
	jr	NC, 00116$
	ldhl	sp,	#12
	ld	(hl), #0x01
	jr	00117$
00116$:
	ldhl	sp,	#12
	ld	(hl), #0xff
00117$:
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:68: break;
	jr	00114$
;src/enemy.c:70: case 3: // Targeting
00112$:
;src/enemy.c:71: e->type = ENEMY_TYPE_TARGETING;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x04
;src/enemy.c:72: e->targetX = player.x;
	pop	de
	push	de
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	bc, #_player+0
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;src/enemy.c:73: e->x = e->targetX;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/enemy.c:74: e->y = 10;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0a
;src/enemy.c:75: e->isJumping = 1;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/enemy.c:76: e->velocityY = -2;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xfe
;src/enemy.c:78: }
00114$:
;src/enemy.c:79: }
	add	sp, #15
	ret
;src/enemy.c:81: void spawnBossEnemy(UINT8 index)
;	---------------------------------
; Function spawnBossEnemy
; ---------------------------------
_spawnBossEnemy::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;src/enemy.c:83: Enemy *e = &enemies[index];
	ld	bc, #_enemies+0
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, bc
;src/enemy.c:84: e->x = ENEMY_START_X;
	ld	c,l
	ld	b,h
	ld	(hl), #0xa0
	inc	hl
	ld	(hl), #0x00
;src/enemy.c:85: e->isActive = 1;
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x01
;src/enemy.c:86: e->animCounter = 0;
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x00
;src/enemy.c:87: e->currentFrame = 0;
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x00
;src/enemy.c:88: e->deathTimer = 0;
	ld	hl, #0x000d
	add	hl, bc
	ld	(hl), #0x00
;src/enemy.c:89: e->hitFlashTimer = 0;
	ld	hl, #0x0010
	add	hl, bc
	ld	(hl), #0x00
;src/enemy.c:90: e->health = 10;
	ld	hl, #0x000e
	add	hl, bc
	ld	(hl), #0x0a
;src/enemy.c:91: e->maxHealth = 10;
	ld	hl, #0x000f
	add	hl, bc
	ld	(hl), #0x0a
;src/enemy.c:92: e->type = ENEMY_TYPE_BOSS;
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x05
;src/enemy.c:93: e->y = ENEMY_START_Y;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x69
;src/enemy.c:94: e->isJumping = 0;
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x00
;src/enemy.c:95: e->velocityY = 0;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/enemy.c:96: e->jumpTimer = 40 + (simpleRand() % 70);
	ld	hl, #0x0008
	add	hl, bc
	push	hl
	push	bc
	call	_simpleRand
	ld	e, #0x46
	call	__moduchar
	ld	a, c
	pop	bc
	pop	hl
	add	a, #0x28
	ld	(hl), a
;src/enemy.c:97: e->spriteBase = 8 + (index * 4);
	ld	hl, #0x000a
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, #0x08
	ld	(de), a
;src/enemy.c:98: e->bossDirection = -1;
	ld	hl, #0x0013
	add	hl, bc
	ld	(hl), #0xff
;src/enemy.c:99: }
	inc	sp
	ret
;src/enemy.c:101: void updateBossPhysics(Enemy *e)
;	---------------------------------
; Function updateBossPhysics
; ---------------------------------
_updateBossPhysics::
	add	sp, #-7
	ld	c, e
	ld	b, d
;src/enemy.c:103: if (!e->isActive)
	ld	hl, #0x0005
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl), a
	or	a, a
;src/enemy.c:104: return;
	jp	Z, 00122$
;src/enemy.c:106: if (e->deathTimer > 0)
	ld	hl, #0x000d
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
;src/enemy.c:108: e->deathTimer--;
	dec	a
	ld	(hl), a
;src/enemy.c:109: if (e->deathTimer == 0)
;src/enemy.c:111: e->isActive = 0;
	or	a,a
	jp	NZ,00122$
	ld	(de), a
;src/enemy.c:112: hideSprite4(e->spriteBase);
	ld	hl, #0x000a
	add	hl, bc
	ld	a, (hl)
	call	_hideSprite4
;src/enemy.c:114: return;
	jp	00122$
00106$:
;src/enemy.c:117: if (e->isJumping)
	ld	hl, #0x0004
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl), a
;src/enemy.c:119: e->velocityY += GRAVITY;
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;src/enemy.c:127: e->jumpTimer = 40 + (simpleRand() % 70);
	ld	hl, #0x0008
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
;src/enemy.c:117: if (e->isJumping)
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
;src/enemy.c:119: e->velocityY += GRAVITY;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0xfe
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;src/enemy.c:120: e->y -= e->velocityY;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	sub	a, (hl)
;src/enemy.c:122: if (e->y >= FLOOR_Y)
	ld	(de), a
	sub	a, #0x69
	jr	C, 00115$
;src/enemy.c:124: e->y = FLOOR_Y;
	ld	a, #0x69
	ld	(de), a
;src/enemy.c:125: e->isJumping = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
;src/enemy.c:126: e->velocityY = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:127: e->jumpTimer = 40 + (simpleRand() % 70);
	push	bc
	call	_simpleRand
	ld	e, #0x46
	call	__moduchar
	ld	a, c
	pop	bc
	add	a, #0x28
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	jr	00115$
00114$:
;src/enemy.c:132: if (e->jumpTimer > 0)
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00110$
;src/enemy.c:134: e->jumpTimer--;
	dec	hl
	dec	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00110$:
;src/enemy.c:136: if (e->jumpTimer == 0)
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00115$
;src/enemy.c:138: e->isJumping = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
;src/enemy.c:139: e->velocityY = ENEMY_JUMP_STRENGTH;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
00115$:
;src/enemy.c:143: INT16 nextX = e->x + (e->bossDirection * getEnemySpeed());
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #0x0013
	add	hl, bc
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
	ld	c, a
	push	bc
	call	_getEnemySpeed
	pop	bc
	ld	e, a
	ld	a, c
	call	__muluschar
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;src/enemy.c:145: if (nextX < 5)
	ld	a, c
	sub	a, #0x05
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00120$
;src/enemy.c:147: e->x = 5;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x05
	ld	(hl+), a
	ld	(hl), #0x00
;src/enemy.c:148: e->bossDirection = 1;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00122$
00120$:
;src/enemy.c:150: else if (nextX > 145)
	ld	a, #0x91
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00117$
;src/enemy.c:152: e->x = 145;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x91
	ld	(hl+), a
	ld	(hl), #0x00
;src/enemy.c:153: e->bossDirection = -1;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xff
	jr	00122$
00117$:
;src/enemy.c:157: e->x = nextX;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	inc	hl
	ld	(hl), b
00122$:
;src/enemy.c:159: }
	add	sp, #7
	ret
;src/enemy.c:161: void updateEnemyPhysics(Enemy *e)
;	---------------------------------
; Function updateEnemyPhysics
; ---------------------------------
_updateEnemyPhysics::
	add	sp, #-20
	ldhl	sp,	#18
	ld	a, e
	ld	(hl+), a
;src/enemy.c:163: if (!e->isActive)
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#17
	ld	(hl), a
	or	a, a
;src/enemy.c:164: return;
	jp	Z, 00153$
;src/enemy.c:166: if (e->type == ENEMY_TYPE_BOSS)
	ldhl	sp,#18
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
	ldhl	sp,	#15
	ld	(hl), a
	sub	a, #0x05
	jr	NZ, 00104$
;src/enemy.c:168: updateBossPhysics(e);
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_updateBossPhysics
;src/enemy.c:169: return;
	jp	00153$
00104$:
;src/enemy.c:172: if (e->deathTimer > 0)
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	e, a
;src/enemy.c:178: hideSprite4(e->spriteBase);
	push	de
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/enemy.c:172: if (e->deathTimer > 0)
	ld	a, e
	or	a, a
	jr	Z, 00108$
;src/enemy.c:174: e->deathTimer--;
	ld	a, e
	dec	a
	ld	(bc), a
;src/enemy.c:175: if (e->deathTimer == 0)
	or	a, a
	jp	NZ, 00153$
;src/enemy.c:177: e->isActive = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
;src/enemy.c:178: hideSprite4(e->spriteBase);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	call	_hideSprite4
;src/enemy.c:180: return;
	jp	00153$
00108$:
;src/enemy.c:185: e->velocityY += GRAVITY;
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;src/enemy.c:186: e->y -= e->velocityY;
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/enemy.c:188: if (e->x > e->targetX + 2)
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;src/enemy.c:200: e->isJumping = 0;
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
;src/enemy.c:183: if (e->type == ENEMY_TYPE_TARGETING)
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	sub	a, #0x04
	jp	NZ, 00149$
;src/enemy.c:185: e->velocityY += GRAVITY;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0xfe
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/enemy.c:186: e->y -= e->velocityY;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	sub	a, c
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:188: if (e->x > e->targetX + 2)
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#14
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	NC, 00112$
;src/enemy.c:190: e->x -= getEnemySpeed();
	call	_getEnemySpeed
	ld	c, a
	ld	b, #0x00
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	b, a
	ld	c, e
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00113$
00112$:
;src/enemy.c:192: else if (e->x < e->targetX - 2)
	dec	bc
	dec	bc
	ldhl	sp,	#16
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00113$
;src/enemy.c:194: e->x += getEnemySpeed();
	call	_getEnemySpeed
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00113$:
;src/enemy.c:197: if (e->y >= FLOOR_Y)
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x69
	jp	C, 00150$
;src/enemy.c:199: e->y = FLOOR_Y;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x69
;src/enemy.c:200: e->isJumping = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:201: e->velocityY = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:202: e->type = ENEMY_TYPE_GROUND;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jp	00150$
00149$:
;src/enemy.c:205: else if (e->type == ENEMY_TYPE_FLYING)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ, 00146$
;src/enemy.c:207: e->flyingBobTimer++;
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	inc	a
	ld	c, a
	ld	(de), a
;src/enemy.c:211: e->flyingDirection = -e->flyingDirection;
	push	de
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
;src/enemy.c:208: if (e->flyingBobTimer > 15)
	ld	a, #0x0f
	sub	a, c
	jr	NC, 00117$
;src/enemy.c:210: e->flyingBobTimer = 0;
;src/enemy.c:211: e->flyingDirection = -e->flyingDirection;
	dec	hl
	xor	a, a
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	xor	a, a
	sub	a, c
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
00117$:
;src/enemy.c:213: e->y += e->flyingDirection;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, c
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:215: if (e->y < ENEMY_FLY_Y_HIGH)
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#17
	ld	(hl), a
	sub	a, #0x32
	jr	NC, 00121$
;src/enemy.c:217: e->y = ENEMY_FLY_Y_HIGH;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x32
;src/enemy.c:218: e->flyingDirection = 1;
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
	jr	00122$
00121$:
;src/enemy.c:220: else if (e->y > ENEMY_FLY_Y_LOW)
	ld	a, #0x5a
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NC, 00122$
;src/enemy.c:222: e->y = ENEMY_FLY_Y_LOW;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x5a
;src/enemy.c:223: e->flyingDirection = -1;
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0xff
00122$:
;src/enemy.c:226: e->x -= getEnemySpeed();
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	push	bc
	call	_getEnemySpeed
	pop	bc
	ld	e, a
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jp	00150$
00146$:
;src/enemy.c:228: else if (e->isJumping)
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;src/enemy.c:241: e->jumpTimer = 20 + (simpleRand() % 30);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
;src/enemy.c:228: else if (e->isJumping)
	ld	a, c
	or	a, a
	jp	Z, 00143$
;src/enemy.c:230: e->velocityY += GRAVITY;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0xfe
	ld	c, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/enemy.c:231: e->y -= e->velocityY;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	sub	a, c
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/enemy.c:233: if (e->y >= FLOOR_Y)
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x69
	jr	C, 00128$
;src/enemy.c:235: e->y = FLOOR_Y;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x69
;src/enemy.c:236: e->isJumping = 0;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:237: e->velocityY = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:239: if (e->type == ENEMY_TYPE_JUMPING)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00124$
;src/enemy.c:241: e->jumpTimer = 20 + (simpleRand() % 30);
	call	_simpleRand
	ld	e, #0x1e
	call	__moduchar
	ld	a, c
	add	a, #0x14
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00124$:
;src/enemy.c:244: if (e->type == ENEMY_TYPE_FALLING)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x02
	jr	NZ, 00128$
;src/enemy.c:246: e->type = ENEMY_TYPE_GROUND;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
00128$:
;src/enemy.c:250: e->x -= getEnemySpeed();
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	call	_getEnemySpeed
	ldhl	sp,	#14
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jp	00150$
00143$:
;src/enemy.c:252: else if (e->type == ENEMY_TYPE_GROUND)
	ldhl	sp,	#15
	ld	a, (hl)
	or	a, a
	jr	NZ, 00140$
;src/enemy.c:254: if (e->jumpTimer > 0)
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00130$
;src/enemy.c:256: e->jumpTimer--;
	dec	hl
	dec	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00130$:
;src/enemy.c:258: if (e->jumpTimer == 0)
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00132$
;src/enemy.c:260: e->isJumping = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/enemy.c:261: e->velocityY = ENEMY_JUMP_STRENGTH;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
;src/enemy.c:262: e->jumpTimer = 40 + (simpleRand() % 70);
	call	_simpleRand
	ld	e, #0x46
	call	__moduchar
	ld	a, c
	add	a, #0x28
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00132$:
;src/enemy.c:265: e->x -= getEnemySpeed();
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	call	_getEnemySpeed
	ldhl	sp,	#14
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00150$
00140$:
;src/enemy.c:267: else if (e->type == ENEMY_TYPE_JUMPING)
	ldhl	sp,	#15
	ld	a, (hl)
	dec	a
	jr	NZ, 00150$
;src/enemy.c:269: if (e->jumpTimer > 0)
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00134$
;src/enemy.c:271: e->jumpTimer--;
	dec	hl
	dec	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00134$:
;src/enemy.c:273: if (e->jumpTimer == 0)
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00136$
;src/enemy.c:275: e->isJumping = 1;
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;src/enemy.c:276: e->velocityY = ENEMY_JUMP_STRENGTH;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0c
;src/enemy.c:277: e->jumpTimer = 20 + (simpleRand() % 30);
	call	_simpleRand
	ld	e, #0x1e
	call	__moduchar
	ld	a, c
	add	a, #0x14
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00136$:
;src/enemy.c:280: e->x -= getEnemySpeed();
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	call	_getEnemySpeed
	ldhl	sp,	#14
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00150$:
;src/enemy.c:283: if (e->x < -20)
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, #0xec
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00153$
;src/enemy.c:285: e->isActive = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
;src/enemy.c:286: hideSprite4(e->spriteBase);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	call	_hideSprite4
00153$:
;src/enemy.c:288: }
	add	sp, #20
	ret
;src/enemy.c:290: void updateEnemyAnimation(Enemy *e)
;	---------------------------------
; Function updateEnemyAnimation
; ---------------------------------
_updateEnemyAnimation::
	add	sp, #-13
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
;src/enemy.c:292: if (!e->isActive)
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	or	a, a
;src/enemy.c:293: return;
	jp	Z, 00125$
;src/enemy.c:295: if (e->deathTimer > 0)
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;src/enemy.c:299: hideSprite4(e->spriteBase);
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;src/enemy.c:295: if (e->deathTimer > 0)
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
;src/enemy.c:297: if (e->deathTimer % 4 < 2)
	ld	a, (hl)
	and	a, #0x03
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00125$
;src/enemy.c:299: hideSprite4(e->spriteBase);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	call	_hideSprite4
;src/enemy.c:301: return;
	jp	00125$
00106$:
;src/enemy.c:304: if (e->hitFlashTimer > 0)
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00110$
;src/enemy.c:306: e->hitFlashTimer--;
	dec	a
	ld	(bc), a
;src/enemy.c:307: if (e->hitFlashTimer % 2 == 0)
	and	a, #0x01
	jr	NZ, 00110$
;src/enemy.c:309: hideSprite4(e->spriteBase);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	call	_hideSprite4
;src/enemy.c:310: return;
	jp	00125$
00110$:
;src/enemy.c:314: e->animCounter++;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/enemy.c:318: e->currentFrame = (e->currentFrame + 1) % 3;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;src/enemy.c:315: if (e->animCounter >= ANIM_SPEED)
	ld	a, c
	sub	a, #0x0a
	jr	C, 00112$
;src/enemy.c:317: e->animCounter = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/enemy.c:318: e->currentFrame = (e->currentFrame + 1) % 3;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	d, #0x00
	ld	e, a
	inc	de
	ld	bc, #0x0003
	call	__modsint
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
00112$:
;src/enemy.c:321: UINT8 baseTile = 0;
	ldhl	sp,	#6
	ld	(hl), #0x00
;src/enemy.c:322: UINT8 frame_count = 1;
	ldhl	sp,	#10
;src/enemy.c:324: switch (e->type)
	ld	a, #0x01
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	a, #0x05
	sub	a, c
	jr	C, 00118$
	ld	b, #0x00
	ld	hl, #00183$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00183$:
	.dw	00113$
	.dw	00114$
	.dw	00118$
	.dw	00115$
	.dw	00116$
	.dw	00117$
;src/enemy.c:326: case ENEMY_TYPE_GROUND:
00113$:
;src/enemy.c:327: frame_count = 3;
	ldhl	sp,	#10
	ld	(hl), #0x03
;src/enemy.c:328: baseTile = 8 + (e->currentFrame * 4);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, #0x08
	ld	(hl), a
;src/enemy.c:329: break;
	jr	00118$
;src/enemy.c:330: case ENEMY_TYPE_JUMPING:
00114$:
;src/enemy.c:331: frame_count = 3;
	ldhl	sp,	#10
	ld	(hl), #0x03
;src/enemy.c:332: baseTile = 20 + (e->currentFrame * 4);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, #0x14
	ld	(hl), a
;src/enemy.c:333: break;
	jr	00118$
;src/enemy.c:334: case ENEMY_TYPE_FLYING:
00115$:
;src/enemy.c:335: frame_count = 1;
	ldhl	sp,	#10
	ld	(hl), #0x01
;src/enemy.c:336: baseTile = 32;
	ldhl	sp,	#6
	ld	(hl), #0x20
;src/enemy.c:337: break;
	jr	00118$
;src/enemy.c:338: case ENEMY_TYPE_TARGETING:
00116$:
;src/enemy.c:339: frame_count = 3;
	ldhl	sp,	#10
	ld	(hl), #0x03
;src/enemy.c:340: baseTile = 8 + (e->currentFrame * 4);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, #0x08
	ld	(hl), a
;src/enemy.c:341: break;
	jr	00118$
;src/enemy.c:342: case ENEMY_TYPE_BOSS:
00117$:
;src/enemy.c:343: frame_count = 3;
	ldhl	sp,	#10
	ld	(hl), #0x03
;src/enemy.c:344: baseTile = 36 + (e->currentFrame * 4);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	add	a, a
	add	a, a
	add	a, #0x24
	ld	(hl), a
;src/enemy.c:346: }
00118$:
;src/enemy.c:348: if (e->animCounter >= ANIM_SPEED)
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x0a
	jr	C, 00120$
;src/enemy.c:350: e->animCounter = 0;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
;src/enemy.c:351: e->currentFrame = (e->currentFrame + 1) % frame_count;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__modsint
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
00120$:
;src/enemy.c:354: set_sprite_tile(e->spriteBase, baseTile);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#9
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00184$:
	ldhl	sp,	#9
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00184$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;src/enemy.c:355: set_sprite_tile(e->spriteBase + 1, baseTile + 2);
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x02
	ldhl	sp,	#5
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	c
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00185$:
	ldhl	sp,	#8
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00185$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
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
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;src/enemy.c:356: set_sprite_tile(e->spriteBase + 2, baseTile + 1);
	ldhl	sp,	#10
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x02
	ld	c, a
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00186$:
	ldhl	sp,	#8
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00186$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
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
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;src/enemy.c:357: set_sprite_tile(e->spriteBase + 3, baseTile + 3);
	ldhl	sp,	#10
	inc	(hl)
	inc	(hl)
	inc	(hl)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl), a
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	a, (hl-)
	ld	c, a
	inc	c
	inc	c
	inc	c
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00187$:
	ldhl	sp,	#8
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00187$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
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
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;src/enemy.c:357: set_sprite_tile(e->spriteBase + 3, baseTile + 3);
00125$:
;src/enemy.c:358: }
	add	sp, #13
	ret
;src/enemy.c:360: void drawEnemy(Enemy *e)
;	---------------------------------
; Function drawEnemy
; ---------------------------------
_drawEnemy::
	add	sp, #-3
	ld	c, e
	ld	b, d
;src/enemy.c:362: if (e->isActive && e->deathTimer == 0)
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	ld	hl, #0x000d
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00104$
;src/enemy.c:366: e->x, e->y);
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/enemy.c:365: e->spriteBase + 2, e->spriteBase + 3,
	ld	hl, #0x000a
	add	hl, bc
	ld	c, (hl)
	ld	e, c
	ld	b, e
	inc	b
	inc	b
	inc	b
	ld	a, e
	inc	a
	inc	a
;src/enemy.c:364: moveSprite4(e->spriteBase, e->spriteBase + 1,
	inc	e
	ldhl	sp,	#0
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	a, c
	call	_moveSprite4
00104$:
;src/enemy.c:368: }
	add	sp, #3
	ret
;src/enemy.c:370: UINT8 countActiveEnemies(void)
;	---------------------------------
; Function countActiveEnemies
; ---------------------------------
_countActiveEnemies::
	dec	sp
;src/enemy.c:374: for (i = 0; i < MAX_ENEMIES; i++)
	ldhl	sp,	#0
	ld	(hl), #0x00
	ld	c, #0x00
00104$:
;src/enemy.c:376: if (enemies[i].isActive)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	de, #_enemies
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
;src/enemy.c:377: count++;
	ldhl	sp,	#0
	inc	(hl)
00105$:
;src/enemy.c:374: for (i = 0; i < MAX_ENEMIES; i++)
	inc	c
	ld	a, c
	sub	a, #0x04
	jr	C, 00104$
;src/enemy.c:379: return count;
	ldhl	sp,	#0
	ld	a, (hl)
;src/enemy.c:380: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
