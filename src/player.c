#include "player.h"
#include "utils.h"
#include "sound.h"

Player player;

void initPlayer(void)
{
    player.x = PLAYER_START_X;
    player.y = PLAYER_START_Y;
    player.isJumping = 0;
    player.velocityY = 0;
    player.animCounter = 0;
    player.currentFrame = 0;
    player.invincibilityTimer = 0;
    player.flashTimer = 0;
}

void updatePlayerInput(UINT8 joy)
{
    if (joy & J_LEFT)
    {
        UINT8 nextX = player.x - PLAYER_SPEED;
        if (nextX >= 5)
        {
            player.x = nextX;
        }
    }
    if (joy & J_RIGHT)
    {
        UINT8 nextX = player.x + PLAYER_SPEED;
        if (nextX <= 145)
        {
            player.x = nextX;
        }
    }

    if ((joy & J_B) && !player.isJumping)
    {
        player.isJumping = 1;
        player.velocityY = JUMP_STRENGTH;
        playSound(SOUND_JUMP);
    }
}

void updatePlayerPhysics(void)
{
    if (player.isJumping)
    {
        player.velocityY += GRAVITY;
        player.y -= player.velocityY;

        if (player.y >= FLOOR_Y)
        {
            player.y = FLOOR_Y;
            player.isJumping = 0;
            player.velocityY = 0;
        }
    }
}

void updatePlayerAnimation(void)
{
    if (player.invincibilityTimer > 0)
    {
        player.invincibilityTimer--;
        player.flashTimer++;

        if (player.flashTimer % 4 < 2)
        {
            hideSprite4(0);
            return;
        }
    }

    player.animCounter++;
    if (player.animCounter >= ANIM_SPEED)
    {
        player.animCounter = 0;

        if ((joypad() & (J_LEFT | J_RIGHT)))
        {
            player.currentFrame = !player.currentFrame;

            if (player.currentFrame)
            {
                set_sprite_tile(0, 4);
                set_sprite_tile(1, 6);
                set_sprite_tile(2, 5);
                set_sprite_tile(3, 7);
            }
            else
            {
                set_sprite_tile(0, 0);
                set_sprite_tile(1, 2);
                set_sprite_tile(2, 1);
                set_sprite_tile(3, 3);
            }
        }
    }
}

void drawPlayer(void)
{
    moveSprite4(0, 1, 2, 3, player.x, player.y);
}
