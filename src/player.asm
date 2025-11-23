;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module player
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _playSound
	.globl _hideSprite4
	.globl _moveSprite4
	.globl _joypad
	.globl _player
	.globl _initPlayer
	.globl _updatePlayerInput
	.globl _updatePlayerPhysics
	.globl _updatePlayerAnimation
	.globl _drawPlayer
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_player::
	.ds 8
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
;src/player.c:7: void initPlayer(void)
;	---------------------------------
; Function initPlayer
; ---------------------------------
_initPlayer::
;src/player.c:9: player.x = PLAYER_START_X;
	ld	hl, #_player
;src/player.c:10: player.y = PLAYER_START_Y;
	ld	a, #0x0a
	ld	(hl+), a
	ld	(hl), #0x69
;src/player.c:11: player.isJumping = 0;
	ld	hl, #_player + 3
	ld	(hl), #0x00
;src/player.c:12: player.velocityY = 0;
	ld	hl, #_player + 2
	ld	(hl), #0x00
;src/player.c:13: player.animCounter = 0;
	ld	hl, #_player + 4
	ld	(hl), #0x00
;src/player.c:14: player.currentFrame = 0;
	ld	hl, #_player + 5
	ld	(hl), #0x00
;src/player.c:15: player.invincibilityTimer = 0;
	ld	hl, #_player + 6
	ld	(hl), #0x00
;src/player.c:16: player.flashTimer = 0;
	ld	hl, #_player + 7
	ld	(hl), #0x00
;src/player.c:17: }
	ret
;src/player.c:19: void updatePlayerInput(UINT8 joy)
;	---------------------------------
; Function updatePlayerInput
; ---------------------------------
_updatePlayerInput::
	ld	c, a
;src/player.c:21: if (joy & J_LEFT)
	bit	1, c
	jr	Z, 00104$
;src/player.c:23: UINT8 nextX = player.x - PLAYER_SPEED;
	ld	de, #_player+0
	ld	a, (de)
	dec	a
	dec	a
;src/player.c:24: if (nextX >= 5)
	cp	a, #0x05
	jr	C, 00104$
;src/player.c:26: player.x = nextX;
	ld	(de), a
00104$:
;src/player.c:29: if (joy & J_RIGHT)
	bit	0, c
	jr	Z, 00108$
;src/player.c:31: UINT8 nextX = player.x + PLAYER_SPEED;
	ld	de, #_player+0
	ld	a, (de)
	add	a, #0x02
;src/player.c:32: if (nextX <= 145)
	cp	a, #0x92
	jr	NC, 00108$
;src/player.c:34: player.x = nextX;
	ld	(de), a
00108$:
;src/player.c:38: if ((joy & J_B) && !player.isJumping)
	bit	5, c
	ret	Z
	ld	hl, #_player + 3
	ld	a, (hl)
	or	a, a
	ret	NZ
;src/player.c:40: player.isJumping = 1;
	ld	(hl), #0x01
;src/player.c:41: player.velocityY = JUMP_STRENGTH;
	ld	hl, #_player + 2
	ld	(hl), #0x0f
;src/player.c:42: playSound(SOUND_JUMP);
	ld	a, #0x01
;src/player.c:44: }
	jp	_playSound
;src/player.c:46: void updatePlayerPhysics(void)
;	---------------------------------
; Function updatePlayerPhysics
; ---------------------------------
_updatePlayerPhysics::
;src/player.c:48: if (player.isJumping)
	ld	a, (#(_player + 3) + 0)
	or	a, a
	ret	Z
;src/player.c:50: player.velocityY += GRAVITY;
	ld	bc, #_player + 2
	ld	a, (bc)
	add	a, #0xfe
	ld	e, a
	ld	(bc), a
;src/player.c:51: player.y -= player.velocityY;
	ld	hl, #_player + 1
	ld	a, (hl)
	sub	a, e
;src/player.c:53: if (player.y >= FLOOR_Y)
	ld	(hl), a
	sub	a, #0x69
	ret	C
;src/player.c:55: player.y = FLOOR_Y;
	ld	(hl), #0x69
;src/player.c:56: player.isJumping = 0;
	ld	hl, #(_player + 3)
	ld	(hl), #0x00
;src/player.c:57: player.velocityY = 0;
	xor	a, a
	ld	(bc), a
;src/player.c:60: }
	ret
;src/player.c:62: void updatePlayerAnimation(void)
;	---------------------------------
; Function updatePlayerAnimation
; ---------------------------------
_updatePlayerAnimation::
;src/player.c:64: if (player.invincibilityTimer > 0)
	ld	hl, #_player + 6
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;src/player.c:66: player.invincibilityTimer--;
	dec	a
	ld	(hl), a
;src/player.c:67: player.flashTimer++;
	ld	hl, #_player + 7
	inc	(hl)
	ld	a, (hl)
;src/player.c:69: if (player.flashTimer % 4 < 2)
	and	a, #0x03
	sub	a, #0x02
	jr	NC, 00104$
;src/player.c:71: hideSprite4(0);
	xor	a, a
;src/player.c:72: return;
	jp	_hideSprite4
00104$:
;src/player.c:76: player.animCounter++;
	ld	hl, #_player + 4
	inc	(hl)
	ld	a, (hl)
;src/player.c:77: if (player.animCounter >= ANIM_SPEED)
	sub	a, #0x0a
	ret	C
;src/player.c:79: player.animCounter = 0;
	ld	(hl), #0x00
;src/player.c:81: if ((joypad() & (J_LEFT | J_RIGHT)))
	call	_joypad
	and	a, #0x03
	ret	Z
;src/player.c:83: player.currentFrame = !player.currentFrame;
	ld	bc, #_player + 5
	ld	a, (bc)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(bc), a
;src/player.c:85: if (player.currentFrame)
	or	a, a
	jr	Z, 00106$
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x05
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x07
;src/player.c:90: set_sprite_tile(3, 7);
	ret
00106$:
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;src/player.c:97: set_sprite_tile(3, 3);
;src/player.c:101: }
	ret
;src/player.c:103: void drawPlayer(void)
;	---------------------------------
; Function drawPlayer
; ---------------------------------
_drawPlayer::
;src/player.c:105: moveSprite4(0, 1, 2, 3, player.x, player.y);
	ld	a, (#(_player + 1) + 0)
	ld	hl, #_player
	ld	c, (hl)
	ld	b, #0x00
	push	af
	inc	sp
	push	bc
	ld	hl, #0x302
	push	hl
	ld	e, #0x01
	xor	a, a
	call	_moveSprite4
;src/player.c:106: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
