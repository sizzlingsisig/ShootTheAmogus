
#include <gb/gb.h>
#include <gbdk/console.h>
#include "gametypes.h"
#include <stdio.h>
#include "ui.h"
#include "game.h"
#include "utils.h"
#include "sound.h"

void drawHearts(void)
{
    UINT8 i;
    for (i = 0; i < MAX_LIVES; i++)
    {
        UINT8 spriteBase = 28 + (i * 2);
        if (i < game.lives)
        {
            set_sprite_tile(spriteBase, 48);
            move_sprite(spriteBase, 8 + (i * 16), 8);
            set_sprite_tile(spriteBase + 1, 49);
            move_sprite(spriteBase + 1, 8 + (i * 16), 16);
        }
        else
        {
            move_sprite(spriteBase, OFFSCREEN_X, OFFSCREEN_Y);
            move_sprite(spriteBase + 1, OFFSCREEN_X, OFFSCREEN_Y);
        }
    }
}

void drawScore(void)
{
    gotoxy(13, 0);
    printf("%05d", game.score);
}

void drawWave(void)
{
    gotoxy(0, 0);
    printf(" Wave:%d", game.waveNumber);
}

void showStartScreen(void)
{
    UINT8 blinkCounter = 0;
    UINT8 showText = 1;

    SCX_REG = 0;
    SCY_REG = 0;
    HIDE_SPRITES;
    BGP_REG = 0x1B;
    fill_bkg_rect(0, 0, 20, 18, 0x00);

    gotoxy(4, 5);
    printf("SHOOT 'THE");
    gotoxy(6, 6);
    printf("AMOGUS!");
    gotoxy(8, 9);
    printf("BY");
    gotoxy(3, 10);
    printf("SIZZLING SISIG");

    if (game.highScore > 0)
    {
        gotoxy(3, 11);
        printf("HIGH: %d", game.highScore);
    }

    while (1)
    {
        if (++blinkCounter > 30)
        {
            blinkCounter = 0;
            showText = !showText;
            gotoxy(2, 14);
            printf(showText ? "PRESS  START" : "              ");
        }

        if (joypad() & J_START)
            break;
        wait_vbl_done();
    }
}

UINT8 showGameOverScreen(void)
{
    UINT8 blinkCounter = 0;
    UINT8 showText = 1;
    UINT8 i;

    playSound(SOUND_GAME_OVER);

    SCX_REG = 0;
    SCY_REG = 0;
    HIDE_SPRITES;
    BGP_REG = 0x1B;
    fill_bkg_rect(0, 0, 20, 18, 0x00);

    gotoxy(5, 6);
    printf("GAME  OVER");
    gotoxy(4, 9);
    printf("SCORE: %d", game.score);
    gotoxy(4, 10);
    printf("WAVE:  %d", game.waveNumber);

    for (i = 0; i < 60; i++)
        wait_vbl_done();

    while (1)
    {
        if (++blinkCounter > 30)
        {
            blinkCounter = 0;
            showText = !showText;
            gotoxy(3, 15);
            printf(showText ? "START:RETRY" : "           ");
        }

        if (joypad() & J_START)
            return 1;
        wait_vbl_done();
    }
}
