#include "bullet.h"
#include "utils.h"
#include "sound.h"
#include "player.h"

GameCharacter bullets[MAX_BULLETS];

void initBullets(void)
{
    UINT8 i;
    for (i = 0; i < MAX_BULLETS; i++)
    {
        bullets[i].x = 0;
        bullets[i].y = 0;
        set_sprite_tile(24 + i, 0);
        bullets[i].spritids[0] = 24 + i;
        move_sprite(24 + i, OFFSCREEN_X, OFFSCREEN_Y);
    }
}

UINT8 fireBullet(void)
{
    UINT8 i;
    for (i = 0; i < MAX_BULLETS; i++)
    {
        if (bullets[i].y == 0)
        {
            bullets[i].x = player.x + BULLET_OFFSET_X;
            bullets[i].y = player.y + BULLET_OFFSET_Y;
            playSound(SOUND_SHOOT);
            return 1;
        }
    }
    return 0;
}

void updateBullets(void)
{
    UINT8 i;
    for (i = 0; i < MAX_BULLETS; i++)
    {
        if (bullets[i].y > 0)
        {
            bullets[i].x += BULLET_SPEED;

            if (bullets[i].x >= SCREEN_WIDTH)
            {
                bullets[i].y = 0;
                move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);
            }
            else
            {
                move_sprite(bullets[i].spritids[0], bullets[i].x, bullets[i].y);
            }
        }
    }
}
