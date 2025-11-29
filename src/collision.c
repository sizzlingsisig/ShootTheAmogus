// Collision handling between bullets, enemies, and the player
#include "collision.h"
#include "player.h"
#include "enemy.h"
#include "bullet.h"
#include "game.h"
#include "utils.h"
#include "sound.h"

// Check all bullets against all active enemies and apply damage
void checkBulletEnemyCollisions(void)
{
    UINT8 i, j;
    for (i = 0; i < MAX_BULLETS; i++)
    {
        if (bullets[i].y == 0)
            continue;

        for (j = 0; j < MAX_ENEMIES; j++)
        {
            Enemy *e = &enemies[j];
            if (!e->isActive || e->deathTimer > 0)
                continue;

            if (checkCollision(bullets[i].x + 1, bullets[i].y + 1, 6, 6,
                               e->x + 2, e->y + 2, 12, 12))
            {
                bullets[i].y = 0;
                move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);

                e->health--;
                e->hitFlashTimer = 6;

                if (e->health == 0)
                {
                    playSound(SOUND_ENEMY_DEATH);
                    
                    if (e->type == ENEMY_TYPE_BOSS)
                    {
                        addScore(100);
                        incrementWave();
                    }
                    else if (e->type == ENEMY_TYPE_FLYING || e->type == ENEMY_TYPE_TARGETING)
                    {
                        addScore(20);
                        incrementEnemiesKilled();
                    }
                    else
                    {
                        addScore(10);
                        incrementEnemiesKilled();
                    }

                    e->deathTimer = 12;
                }

                break;
            }
        }
    }
}

// Check player against enemies; apply invincibility and life loss
void checkPlayerEnemyCollisions(void)
{
    if (player.invincibilityTimer > 0)
        return;

    UINT8 i;
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        Enemy *e = &enemies[i];
        if (!e->isActive || e->deathTimer > 0)
            continue;

        if (checkCollision(player.x + 2, player.y + 2, 12, 12,
                           e->x + 2, e->y + 2, 12, 12))
        {
            game.lives--;
            playSound(SOUND_HIT);
            player.invincibilityTimer = INVINCIBILITY_TIME;

            if (e->type == ENEMY_TYPE_BOSS)
            {
                e->health--;
                e->hitFlashTimer = 6;

                if (e->health == 0)
                {
                    e->deathTimer = 12;
                    incrementWave();
                    playSound(SOUND_ENEMY_DEATH);
                }
                else
                {
                    playSound(SOUND_HIT);
                }
            }
            else
            {
                e->deathTimer = 12;
            }
            return;
        }
    }
}
