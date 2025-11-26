;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module game
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gbt_loop
	.globl _gbt_play
	.globl _checkPlayerEnemyCollisions
	.globl _checkBulletEnemyCollisions
	.globl _showGameOverScreen
	.globl _showStartScreen
	.globl _drawWave
	.globl _drawScore
	.globl _drawHearts
	.globl _waitFrames
	.globl _initRand
	.globl _simpleRand
	.globl _updateBullets
	.globl _fireBullet
	.globl _initBullets
	.globl _countActiveEnemies
	.globl _drawEnemy
	.globl _updateEnemyAnimation
	.globl _updateEnemyPhysics
	.globl _spawnBossEnemy
	.globl _spawnEnemy
	.globl _initEnemies
	.globl _drawPlayer
	.globl _updatePlayerAnimation
	.globl _updatePlayerPhysics
	.globl _updatePlayerInput
	.globl _initPlayer
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _set_interrupts
	.globl _joypad
	.globl _quarterLife
	.globl _enemySpawnTimer
	.globl _game
	.globl _getWaveNumber
	.globl _getEnemySpeed
	.globl _incrementWave
	.globl _incrementEnemiesKilled
	.globl _addScore
	.globl _Game_init
	.globl _Game_start
	.globl _Game_reset
	.globl _updateDifficulty
	.globl _getSpawnInterval
	.globl _checkWaveCompletion
	.globl _updateEnemySpawning
	.globl _Game_update
	.globl _Game_draw
	.globl _loseQuarterLife
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_game::
	.ds 11
_enemySpawnTimer::
	.ds 1
_Game_update_fireDelay_10000_250:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_quarterLife::
	.ds 1
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
;src/game.c:191: static UINT8 fireDelay = 0;
	xor	a, a
	ld	hl, #_Game_update_fireDelay_10000_250
	ld	(hl), a
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/game.c:28: UINT8 getWaveNumber(void) { return game.waveNumber; }
;	---------------------------------
; Function getWaveNumber
; ---------------------------------
_getWaveNumber::
	ld	a, (#(_game + 5) + 0)
	ret
;src/game.c:29: UINT8 getEnemySpeed(void) { return game.enemySpeed; }
;	---------------------------------
; Function getEnemySpeed
; ---------------------------------
_getEnemySpeed::
	ld	a, (#(_game + 8) + 0)
	ret
;src/game.c:30: void incrementWave(void) { game.waveNumber++; game.enemiesKilledInWave = 0; }
;	---------------------------------
; Function incrementWave
; ---------------------------------
_incrementWave::
	ld	hl, #_game + 5
	inc	(hl)
	ld	hl, #_game + 6
	ld	(hl), #0x00
	ret
;src/game.c:31: void incrementEnemiesKilled(void) { game.enemiesKilledInWave++; }
;	---------------------------------
; Function incrementEnemiesKilled
; ---------------------------------
_incrementEnemiesKilled::
	ld	bc, #_game+6
	ld	a, (bc)
	inc	a
	ld	(bc), a
	ret
;src/game.c:32: void addScore(UINT16 points) { game.score += points; }
;	---------------------------------
; Function addScore
; ---------------------------------
_addScore::
	ld	c, e
	ld	b, d
	ld	hl, #(_game + 1)
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_game + 1)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ret
;src/game.c:34: void Game_init(void)
;	---------------------------------
; Function Game_init
; ---------------------------------
_Game_init::
;src/game.c:37: set_sprite_data(0, 8, GameSprites);
	ld	de, #_GameSprites
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/game.c:38: set_sprite_data(8, 12, Amogus);
	ld	de, #_Amogus
	push	de
	ld	hl, #0xc08
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/game.c:39: set_sprite_data(20, 12, hatamogus);
	ld	de, #_hatamogus
	push	de
	ld	hl, #0xc14
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/game.c:40: set_sprite_data(32, 4, ghostamogus);
	ld	de, #_ghostamogus
	push	de
	ld	hl, #0x420
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/game.c:41: set_sprite_data(36, 12, bigamogus);
	ld	de, #_bigamogus
	push	de
	ld	hl, #0xc24
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/game.c:42: set_sprite_data(48, 5, heart);
	ld	de, #_heart
	push	de
	ld	hl, #0x530
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/game.c:45: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/game.c:46: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/game.c:47: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/game.c:50: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/game.c:51: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/game.c:52: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/game.c:54: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/game.c:55: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/game.c:57: game.highScore = 0;
	ld	hl, #(_game + 3)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/game.c:58: }
	ret
;src/game.c:60: void Game_start(void)
;	---------------------------------
; Function Game_start
; ---------------------------------
_Game_start::
;src/game.c:62: while (1)
00107$:
;src/game.c:64: showStartScreen();
	call	_showStartScreen
;src/game.c:67: set_bkg_data(0, 9, tile);
	ld	de, #_tile
	push	de
	ld	hl, #0x900
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/game.c:68: set_bkg_tiles(0, 0, 40, 18, bgmap);
	ld	de, #_bgmap
	push	de
	ld	hl, #0x1228
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/game.c:69: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/game.c:71: Game_reset();
	call	_Game_reset
;c:\gbdk\include\gb\gb.h:811: __asm__("di");
	di
;src/game.c:75: gbt_play(song_Data, 2, 7);
	ld	hl, #0x702
	push	hl
	ld	de, #_song_Data
	push	de
	call	_gbt_play
	add	sp, #4
;src/game.c:76: gbt_loop(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_gbt_loop
	inc	sp
;src/game.c:77: set_interrupts(VBL_IFLAG);
	ld	a, #0x01
	call	_set_interrupts
;c:\gbdk\include\gb\gb.h:795: __asm__("ei");
	ei
;src/game.c:80: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;src/game.c:87: while (game.lives > 0)
00101$:
	ld	a, (#_game + 0)
	or	a, a
	jr	Z, 00103$
;src/game.c:89: Game_update();
	call	_Game_update
;src/game.c:90: Game_draw();
	call	_Game_draw
;src/game.c:91: waitFrames(4);
	ld	a, #0x04
	call	_waitFrames
	jr	00101$
00103$:
;src/game.c:94: if (!showGameOverScreen())
	call	_showGameOverScreen
	or	a, a
	jr	NZ, 00107$
;src/game.c:95: break;
;src/game.c:97: }
	ret
;src/game.c:99: void Game_reset(void)
;	---------------------------------
; Function Game_reset
; ---------------------------------
_Game_reset::
;src/game.c:101: if (game.score > game.highScore)
	ld	hl, #(_game + 1)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_game + 3)
	ld	a,	(hl+)
	ld	h, (hl)
	sub	a, c
	ld	a, h
	sbc	a, b
	jr	NC, 00102$
;src/game.c:103: game.highScore = game.score;
	ld	hl, #(_game + 3)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00102$:
;src/game.c:106: game.lives = MAX_LIVES;
	ld	hl, #_game
;src/game.c:107: game.score = 0;
	ld	a, #0x03
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/game.c:108: game.difficultyLevel = 1;
	ld	hl, #_game + 7
	ld	(hl), #0x01
;src/game.c:109: game.enemySpeed = ENEMY_SPEED_BASE;
	ld	hl, #_game + 8
	ld	(hl), #0x04
;src/game.c:110: game.frameCounter = 0;
	ld	hl, #(_game + 9)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/game.c:111: game.waveNumber = 1;
	ld	hl, #_game + 5
	ld	(hl), #0x01
;src/game.c:112: game.enemiesKilledInWave = 0;
	ld	hl, #_game + 6
	ld	(hl), #0x00
;src/game.c:114: enemySpawnTimer = INITIAL_SPAWN_INTERVAL;
	ld	hl, #_enemySpawnTimer
	ld	(hl), #0x14
;src/game.c:115: initRand(DIV_REG);
	ldh	a, (_DIV_REG + 0)
	ld	d, #0x00
	ld	e, a
	call	_initRand
;src/game.c:117: initPlayer();
	call	_initPlayer
;src/game.c:118: initBullets();
	call	_initBullets
;src/game.c:119: initEnemies();
;src/game.c:120: }
	jp	_initEnemies
;src/game.c:122: void updateDifficulty(void)
;	---------------------------------
; Function updateDifficulty
; ---------------------------------
_updateDifficulty::
;src/game.c:124: if (game.frameCounter % DIFFICULTY_INTERVAL == 0 && game.frameCounter > 0)
	ld	hl, #_game + 9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	bc, #0x012c
	ld	e, l
	ld	d, h
	call	__moduint
	pop	hl
	ld	a, b
	or	a, c
	ret	NZ
	ld	a, h
	or	a, l
	ret	Z
;src/game.c:126: game.difficultyLevel++;
	ld	hl, #_game + 7
	inc	(hl)
;src/game.c:127: if (game.enemySpeed < MAX_ENEMY_SPEED)
	ld	hl, #_game + 8
	ld	a, (hl)
	cp	a, #0x06
	ret	NC
;src/game.c:129: game.enemySpeed++;
	inc	a
	ld	(hl), a
;src/game.c:132: }
	ret
;src/game.c:134: UINT8 getSpawnInterval(void)
;	---------------------------------
; Function getSpawnInterval
; ---------------------------------
_getSpawnInterval::
;src/game.c:136: UINT8 interval = BASE_SPAWN_INTERVAL - (game.difficultyLevel * 3);
	ld	a, (#(_game + 7) + 0)
	ld	c, a
	add	a, a
	add	a, c
	ld	c, a
	ld	a, #0x23
	sub	a, c
;src/game.c:137: return (interval < MIN_SPAWN_INTERVAL) ? MIN_SPAWN_INTERVAL : interval;
	cp	a, #0x0a
	ret	NC
	ld	a, #0x0a
;src/game.c:138: }
	ret
;src/game.c:140: void checkWaveCompletion(void)
;	---------------------------------
; Function checkWaveCompletion
; ---------------------------------
_checkWaveCompletion::
;src/game.c:142: if (game.enemiesKilledInWave >= ENEMIES_PER_WAVE)
	ld	hl, #_game + 6
	ld	a, (hl)
	sub	a, #0x0a
	ret	C
;src/game.c:144: game.waveNumber++;
	ld	bc, #_game + 5
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/game.c:145: game.enemiesKilledInWave = 0;
	ld	(hl), #0x00
;src/game.c:146: game.score += 50;
	ld	hl, #(_game + 1)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0032
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_game + 1)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/game.c:148: }
	ret
;src/game.c:150: void updateEnemySpawning(void)
;	---------------------------------
; Function updateEnemySpawning
; ---------------------------------
_updateEnemySpawning::
	dec	sp
;src/game.c:152: if (game.waveNumber >= 5 && game.waveNumber % 5 == 0)
	ld	a, (#(_game + 5) + 0)
	cp	a, #0x05
	jr	C, 00108$
	ld	e, #0x05
	call	__moduchar
	ld	a, c
	or	a, a
	jr	NZ, 00108$
;src/game.c:154: if (countActiveEnemies() == 0 && enemySpawnTimer == 0)
	call	_countActiveEnemies
	or	a, a
	jr	NZ, 00104$
	ld	a, (#_enemySpawnTimer)
;src/game.c:156: spawnBossEnemy(0);
	or	a,a
	jr	NZ, 00104$
	call	_spawnBossEnemy
;src/game.c:157: enemySpawnTimer = 255;
	ld	hl, #_enemySpawnTimer
	ld	(hl), #0xff
	jr	00120$
00104$:
;src/game.c:159: else if (enemySpawnTimer > 0)
	ld	hl, #_enemySpawnTimer
	ld	a, (hl)
	or	a, a
	jr	Z, 00120$
;src/game.c:161: enemySpawnTimer--;
	dec	(hl)
;src/game.c:163: return;
	jr	00120$
00108$:
;src/game.c:166: enemySpawnTimer--;
	ld	hl, #_enemySpawnTimer
;src/game.c:167: if (enemySpawnTimer == 0 || countActiveEnemies() == 0)
	dec	(hl)
	jr	Z, 00113$
	call	_countActiveEnemies
	or	a, a
	jr	NZ, 00120$
00113$:
;src/game.c:170: UINT8 spawnCount = (simpleRand() % 10 == 0) ? 2 : 1;
	call	_simpleRand
	ld	e, #0x0a
	call	__moduchar
	ld	a, c
	or	a, a
	ld	a, #0x02
	jr	Z, 00123$
	ld	a, #0x01
00123$:
	ldhl	sp,	#0
	ld	(hl), a
;src/game.c:173: for (i = 0; i < MAX_ENEMIES && spawned < spawnCount; i++)
	ld	bc, #0x0
00118$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00112$
	ld	a, b
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00112$
;src/game.c:175: if (!enemies[i].isActive)
	ld	e, c
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
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
	jr	NZ, 00119$
;src/game.c:177: spawnEnemy(i);
	push	bc
	ld	a, c
	call	_spawnEnemy
	pop	bc
;src/game.c:178: spawned++;
	inc	b
00119$:
;src/game.c:173: for (i = 0; i < MAX_ENEMIES && spawned < spawnCount; i++)
	inc	c
	jr	00118$
00112$:
;src/game.c:182: UINT8 baseInterval = getSpawnInterval();
	call	_getSpawnInterval
	ld	c, a
;src/game.c:183: UINT8 randomVariation = simpleRand() % (SPAWN_RANDOMNESS * 2);
	push	bc
	call	_simpleRand
	ld	e, #0x32
;src/game.c:184: enemySpawnTimer = baseInterval + randomVariation;
	call	__moduchar
	ld	a, c
	pop	bc
	add	a, c
	ld	(#_enemySpawnTimer),a
00120$:
;src/game.c:186: }
	inc	sp
	ret
;src/game.c:188: void Game_update(void)
;	---------------------------------
; Function Game_update
; ---------------------------------
_Game_update::
	dec	sp
;src/game.c:190: UINT8 joy = joypad();
	call	_joypad
	ldhl	sp,	#0
	ld	(hl), a
;src/game.c:193: game.frameCounter++;
	ld	hl, #(_game + 9)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_game + 9)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/game.c:195: updateDifficulty();
	call	_updateDifficulty
;src/game.c:196: updatePlayerInput(joy);
	ldhl	sp,	#0
	ld	a, (hl)
	call	_updatePlayerInput
;src/game.c:197: updatePlayerPhysics();
	call	_updatePlayerPhysics
;src/game.c:198: updatePlayerAnimation();
	call	_updatePlayerAnimation
;src/game.c:200: if ((joy & J_A) && fireDelay == 0)
	push	hl
	ldhl	sp,	#2
	bit	4, (hl)
	pop	hl
	jr	Z, 00104$
	ld	a, (#_Game_update_fireDelay_10000_250)
	or	a, a
	jr	NZ, 00104$
;src/game.c:202: if (fireBullet())
	call	_fireBullet
	or	a, a
	jr	Z, 00104$
;src/game.c:204: fireDelay = FIRE_RATE;
	ld	hl, #_Game_update_fireDelay_10000_250
	ld	(hl), #0x0f
00104$:
;src/game.c:207: if (fireDelay > 0) fireDelay--;
	ld	hl, #_Game_update_fireDelay_10000_250
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
	dec	(hl)
00107$:
;src/game.c:209: updateBullets();
	call	_updateBullets
;src/game.c:210: updateEnemySpawning();
	call	_updateEnemySpawning
;src/game.c:213: for (i = 0; i < MAX_ENEMIES; i++)
	ld	c, #0x00
00109$:
;src/game.c:215: updateEnemyPhysics(&enemies[i]);
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
	ld	e, l
	ld	d, h
	push	bc
	push	de
	call	_updateEnemyPhysics
	pop	de
;src/game.c:216: updateEnemyAnimation(&enemies[i]);
	call	_updateEnemyAnimation
	pop	bc
;src/game.c:213: for (i = 0; i < MAX_ENEMIES; i++)
	inc	c
	ld	a, c
	sub	a, #0x04
	jr	C, 00109$
;src/game.c:219: checkBulletEnemyCollisions();
	call	_checkBulletEnemyCollisions
;src/game.c:220: checkPlayerEnemyCollisions();
	call	_checkPlayerEnemyCollisions
;src/game.c:221: checkWaveCompletion();
	inc	sp
	jp	_checkWaveCompletion
;src/game.c:222: }
	inc	sp
	ret
;src/game.c:224: void Game_draw(void)
;	---------------------------------
; Function Game_draw
; ---------------------------------
_Game_draw::
;src/game.c:228: drawPlayer();
	call	_drawPlayer
;src/game.c:229: for (i = 0; i < MAX_ENEMIES; i++)
	ld	c, #0x00
00103$:
;src/game.c:231: drawEnemy(&enemies[i]);
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
	ld	e, l
	ld	d, h
	push	bc
	call	_drawEnemy
	pop	bc
;src/game.c:229: for (i = 0; i < MAX_ENEMIES; i++)
	inc	c
	ld	a, c
	sub	a, #0x04
	jr	C, 00103$
;c:\gbdk\include\gb\gb.h:1475: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG + 0)
	inc	a
	ldh	(_SCX_REG + 0), a
;src/game.c:235: drawHearts();
	call	_drawHearts
;src/game.c:236: drawScore();
	call	_drawScore
;src/game.c:237: drawWave();
;src/game.c:238: }
	jp	_drawWave
;src/game.c:241: void loseQuarterLife(void)
;	---------------------------------
; Function loseQuarterLife
; ---------------------------------
_loseQuarterLife::
;src/game.c:243: quarterLife++;
	ld	hl, #_quarterLife
	inc	(hl)
;src/game.c:244: if (quarterLife >= 4) {
	ld	a, (hl)
	sub	a, #0x04
	jp	C, _drawHearts
;src/game.c:245: if (game.lives > 0) {
	ld	bc, #_game+0
	ld	a, (bc)
	or	a, a
	jr	Z, 00102$
;src/game.c:246: game.lives--;
	dec	a
	ld	(bc), a
00102$:
;src/game.c:248: quarterLife = 0; // Reset partial heart when a life is lost
	xor	a, a
	ld	(#_quarterLife),a
;src/game.c:250: drawHearts();
;src/game.c:251: }
	jp	_drawHearts
	.area _CODE
	.area _INITIALIZER
__xinit__quarterLife:
	.db #0x00	; 0
	.area _CABS (ABS)
