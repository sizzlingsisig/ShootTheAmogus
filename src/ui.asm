;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module ui
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _playSound
	.globl _printf
	.globl _gotoxy
	.globl _fill_bkg_rect
	.globl _wait_vbl_done
	.globl _joypad
	.globl _drawHearts
	.globl _drawScore
	.globl _drawWave
	.globl _showStartScreen
	.globl _showGameOverScreen
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
;src/ui.c:11: void drawHearts(void)
;	---------------------------------
; Function drawHearts
; ---------------------------------
_drawHearts::
	dec	sp
	dec	sp
;src/ui.c:14: for (i = 0; i < MAX_LIVES; i++)
	ld	c, #0x00
00111$:
;src/ui.c:16: UINT8 spriteBase = 28 + (i * 2);
	ld	b, c
	ld	a, b
	add	a, a
	add	a, #0x1c
	ldhl	sp,	#0
	ld	(hl), a
;src/ui.c:17: if (i < game.lives)
	ld	hl, #_game
	ld	a, c
	sub	a, (hl)
	jr	NC, 00102$
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#0
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sla	e
	rl	d
	sla	e
	rl	d
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), #0x30
;src/ui.c:20: move_sprite(spriteBase, 8 + (i * 16), 8);
	ld	a, b
	swap	a
	and	a, #0xf0
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
	ld	b, (hl)
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x08
	ld	(hl+), a
	ld	(hl), b
;src/ui.c:21: set_sprite_tile(spriteBase + 1, 49);
	ldhl	sp,	#0
	ld	b, (hl)
	inc	b
	ld	e, b
;c:\gbdk\include\gb\gb.h:1887: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x31
;src/ui.c:22: move_sprite(spriteBase + 1, 8 + (i * 16), 16);
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0x10
	ld	(hl+), a
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
;src/ui.c:22: move_sprite(spriteBase + 1, 8 + (i * 16), 16);
	jr	00112$
00102$:
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#0
	ld	b, (hl)
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/ui.c:27: move_sprite(spriteBase + 1, OFFSCREEN_X, OFFSCREEN_Y);
	ldhl	sp,	#0
	ld	b, (hl)
	inc	b
;c:\gbdk\include\gb\gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:\gbdk\include\gb\gb.h:1974: itm->y=y, itm->x=x;
	ld	a, #0xc8
	ld	(hl+), a
	ld	(hl), #0xc8
;src/ui.c:27: move_sprite(spriteBase + 1, OFFSCREEN_X, OFFSCREEN_Y);
00112$:
;src/ui.c:14: for (i = 0; i < MAX_LIVES; i++)
	inc	c
	ld	a, c
	sub	a, #0x03
	jp	C, 00111$
;src/ui.c:30: }
	inc	sp
	inc	sp
	ret
;src/ui.c:32: void drawScore(void)
;	---------------------------------
; Function drawScore
; ---------------------------------
_drawScore::
;src/ui.c:34: gotoxy(13, 0);
	ld	hl, #0x0d
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:35: printf("%05d", game.score);
	ld	hl, #(_game + 1)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;src/ui.c:36: }
	ret
___str_0:
	.ascii "%05d"
	.db 0x00
;src/ui.c:38: void drawWave(void)
;	---------------------------------
; Function drawWave
; ---------------------------------
_drawWave::
;src/ui.c:40: gotoxy(0, 0);
	xor	a, a
	rrca
	push	af
	call	_gotoxy
	pop	hl
;src/ui.c:41: printf(" Wave:%d", game.waveNumber);
	ld	hl, #(_game + 5)
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;src/ui.c:42: }
	ret
___str_1:
	.ascii " Wave:%d"
	.db 0x00
;src/ui.c:44: void showStartScreen(void)
;	---------------------------------
; Function showStartScreen
; ---------------------------------
_showStartScreen::
	dec	sp
	dec	sp
;src/ui.c:46: UINT8 blinkCounter = 0;
	ldhl	sp,	#1
;src/ui.c:47: UINT8 showText = 1;
	xor	a, a
	ld	(hl-), a
	ld	(hl), #0x01
;src/ui.c:49: SCX_REG = 0;
	xor	a, a
	ldh	(_SCX_REG + 0), a
;src/ui.c:50: SCY_REG = 0;
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/ui.c:51: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/ui.c:52: BGP_REG = 0x1B;
	ld	a, #0x1b
	ldh	(_BGP_REG + 0), a
;src/ui.c:53: fill_bkg_rect(0, 0, 20, 18, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/ui.c:55: gotoxy(4, 5);
	ld	hl, #0x504
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:56: printf("SHOOT 'THE");
	ld	de, #___str_2
	push	de
	call	_printf
	pop	hl
;src/ui.c:57: gotoxy(6, 6);
	ld	hl, #0x606
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:58: printf("AMOGUS!");
	ld	de, #___str_3
	push	de
	call	_printf
	pop	hl
;src/ui.c:59: gotoxy(8, 9);
	ld	hl, #0x908
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:60: printf("BY");
	ld	de, #___str_4
	push	de
	call	_printf
	pop	hl
;src/ui.c:61: gotoxy(3, 10);
	ld	hl, #0xa03
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:62: printf("SIZZLING SISIG");
	ld	de, #___str_5
	push	de
	call	_printf
	pop	hl
;src/ui.c:64: if (game.highScore > 0)
	ld	hl, #(_game + 3)
	ld	a, (hl+)
	or	a, (hl)
	jr	Z, 00118$
;src/ui.c:66: gotoxy(3, 11);
	ld	hl, #0xb03
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:67: printf("HIGH: %d", game.highScore);
	ld	hl, #(_game + 3)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
	add	sp, #4
;src/ui.c:70: while (1)
00118$:
00108$:
;src/ui.c:72: if (++blinkCounter > 30)
	ldhl	sp,	#1
	inc	(hl)
	ld	a, #0x1e
	sub	a, (hl)
	jr	NC, 00104$
;src/ui.c:74: blinkCounter = 0;
;src/ui.c:75: showText = !showText;
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/ui.c:76: gotoxy(2, 14);
	ld	hl, #0xe02
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:77: printf(showText ? "PRESS  START" : "              ");
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
	ld	bc, #___str_7
	jr	00113$
00112$:
	ld	bc, #___str_8
00113$:
	push	bc
	call	_printf
	pop	hl
00104$:
;src/ui.c:80: if (joypad() & J_START)
	call	_joypad
	rlca
	jr	C, 00110$
;src/ui.c:82: wait_vbl_done();
	call	_wait_vbl_done
	jr	00108$
00110$:
;src/ui.c:84: }
	inc	sp
	inc	sp
	ret
___str_2:
	.ascii "SHOOT 'THE"
	.db 0x00
___str_3:
	.ascii "AMOGUS!"
	.db 0x00
___str_4:
	.ascii "BY"
	.db 0x00
___str_5:
	.ascii "SIZZLING SISIG"
	.db 0x00
___str_6:
	.ascii "HIGH: %d"
	.db 0x00
___str_7:
	.ascii "PRESS  START"
	.db 0x00
___str_8:
	.ascii "              "
	.db 0x00
;src/ui.c:86: UINT8 showGameOverScreen(void)
;	---------------------------------
; Function showGameOverScreen
; ---------------------------------
_showGameOverScreen::
	dec	sp
	dec	sp
;src/ui.c:88: UINT8 blinkCounter = 0;
	ldhl	sp,	#1
;src/ui.c:89: UINT8 showText = 1;
	xor	a, a
	ld	(hl-), a
	ld	(hl), #0x01
;src/ui.c:92: playSound(SOUND_GAME_OVER);
	ld	a, #0x03
	call	_playSound
;src/ui.c:94: SCX_REG = 0;
	xor	a, a
	ldh	(_SCX_REG + 0), a
;src/ui.c:95: SCY_REG = 0;
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/ui.c:96: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/ui.c:97: BGP_REG = 0x1B;
	ld	a, #0x1b
	ldh	(_BGP_REG + 0), a
;src/ui.c:98: fill_bkg_rect(0, 0, 20, 18, 0x00);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/ui.c:100: gotoxy(5, 6);
	ld	hl, #0x605
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:101: printf("GAME  OVER");
	ld	de, #___str_9
	push	de
	call	_printf
	pop	hl
;src/ui.c:102: gotoxy(4, 9);
	ld	hl, #0x904
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:103: printf("SCORE: %d", game.score);
	ld	hl, #_game + 1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_10
	push	de
	call	_printf
	add	sp, #4
;src/ui.c:104: gotoxy(4, 10);
	ld	hl, #0xa04
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:105: printf("WAVE:  %d", game.waveNumber);
	ld	hl, #_game + 5
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #___str_11
	push	de
	call	_printf
	add	sp, #4
;src/ui.c:107: for (i = 0; i < 60; i++)
	ld	c, #0x3c
00111$:
;src/ui.c:108: wait_vbl_done();
	call	_wait_vbl_done
	dec	c
	jr	NZ, 00111$
;src/ui.c:107: for (i = 0; i < 60; i++)
;src/ui.c:110: while (1)
00107$:
;src/ui.c:112: if (++blinkCounter > 30)
	ldhl	sp,	#1
	inc	(hl)
	ld	a, #0x1e
	sub	a, (hl)
	jr	NC, 00103$
;src/ui.c:114: blinkCounter = 0;
;src/ui.c:115: showText = !showText;
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/ui.c:116: gotoxy(3, 15);
	ld	hl, #0xf03
	push	hl
	call	_gotoxy
	pop	hl
;src/ui.c:117: printf(showText ? "START:RETRY" : "           ");
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
	ld	bc, #___str_12
	jr	00115$
00114$:
	ld	bc, #___str_13
00115$:
	push	bc
	call	_printf
	pop	hl
00103$:
;src/ui.c:120: if (joypad() & J_START)
	call	_joypad
	rlca
	jr	NC, 00105$
;src/ui.c:121: return 1;
	ld	a, #0x01
	jr	00112$
00105$:
;src/ui.c:122: wait_vbl_done();
	call	_wait_vbl_done
	jr	00107$
00112$:
;src/ui.c:124: }
	inc	sp
	inc	sp
	ret
___str_9:
	.ascii "GAME  OVER"
	.db 0x00
___str_10:
	.ascii "SCORE: %d"
	.db 0x00
___str_11:
	.ascii "WAVE:  %d"
	.db 0x00
___str_12:
	.ascii "START:RETRY"
	.db 0x00
___str_13:
	.ascii "           "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
