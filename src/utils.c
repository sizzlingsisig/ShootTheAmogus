#include "utils.h"
#include "gametypes.h"
#include "gbt_player.h"

static UINT16 randSeed;

UINT8 simpleRand(void)
{
    randSeed = (randSeed * 1103515245U + 12345U) & 0x7FFFU;
    return (UINT8)(randSeed >> 8);
}

void initRand(UINT16 seed)
{
    randSeed = seed;
}

void moveSprite4(UINT8 sprite1, UINT8 sprite2, UINT8 sprite3, UINT8 sprite4,
                 INT16 x, UINT8 y)
{
    move_sprite(sprite1, x, y);
    move_sprite(sprite2, x + SPRITE_SIZE, y);
    move_sprite(sprite3, x, y + SPRITE_SIZE);
    move_sprite(sprite4, x + SPRITE_SIZE, y + SPRITE_SIZE);
}

void hideSprite4(UINT8 base)
{
    move_sprite(base, OFFSCREEN_X, OFFSCREEN_Y);
    move_sprite(base + 1, OFFSCREEN_X, OFFSCREEN_Y);
    move_sprite(base + 2, OFFSCREEN_X, OFFSCREEN_Y);
    move_sprite(base + 3, OFFSCREEN_X, OFFSCREEN_Y);
}

void waitFrames(UINT8 frames)
{
    UINT8 i;
    for (i = 0; i < frames; i++)
    {
        wait_vbl_done();
        gbt_update();
    }
}

UINT8 checkCollision(UINT8 x1, UINT8 y1, UINT8 w1, UINT8 h1,
                       UINT8 x2, UINT8 y2, UINT8 w2, UINT8 h2)
{
    return (x1 < x2 + w2 && x1 + w1 > x2 &&
            y1 < y2 + h2 && y1 + h1 > y2);
}
