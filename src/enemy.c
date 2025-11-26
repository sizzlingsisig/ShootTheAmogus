#include "enemy.h"
#include "utils.h"
#include "player.h"
#include "game.h"

Enemy enemies[MAX_ENEMIES];

void initEnemies(void)
{
    UINT8 i;
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        enemies[i].isActive = 0;
        enemies[i].spriteBase = 8 + (i * 4);
        hideSprite4(enemies[i].spriteBase);
    }
}

void spawnEnemy(UINT8 index)
{
    Enemy *e = &enemies[index];

    e->x = ENEMY_START_X + (simpleRand() % 60);
    e->isActive = 1;
    e->animCounter = 0;
    e->currentFrame = 0;
    e->deathTimer = 0;
    e->hitFlashTimer = 0;
    e->health = 1;
    e->maxHealth = 2;

    UINT8 wave = getWaveNumber();
    UINT8 availableTypes = 1;
    if (wave >= 5) {
        availableTypes = 4;
    } else if (wave >= 4) {
        availableTypes = 3;
    } else if (wave >= 3) {
        availableTypes = 2;
    }

    UINT8 spawnType = simpleRand() % availableTypes;

    switch (spawnType)
    {
    case 0: // Ground
        e->type = ENEMY_TYPE_GROUND;
        e->y = ENEMY_START_Y;
        e->isJumping = 0;
        e->velocityY = 0;
        e->jumpTimer = 30 + (simpleRand() % 50);
        break;

    case 1: // Jumping
        e->type = ENEMY_TYPE_JUMPING;
        e->y = ENEMY_START_Y;
        e->isJumping = 1;
        e->velocityY = ENEMY_JUMP_STRENGTH;
        e->jumpTimer = 40 + (simpleRand() % 70);
        break;

    case 2: // Flying
        e->type = ENEMY_TYPE_FLYING;
        e->y = ENEMY_FLY_Y_HIGH + (simpleRand() % (ENEMY_FLY_Y_LOW - ENEMY_FLY_Y_HIGH));
        e->isJumping = 0;
        e->flyingBobTimer = simpleRand() % 16;
        e->flyingDirection = (simpleRand() & 1) ? 1 : -1;
        // Set initial speed for flying enemies
        e->maxHealth = 2; // reuse field for max speed if needed
        break;

    case 3: // Targeting
        e->type = ENEMY_TYPE_TARGETING;
        e->targetX = player.x;
        e->x = e->targetX;
        e->y = 10;
        e->isJumping = 1;
        e->velocityY = -2;
        break;
    }
}

void spawnBossEnemy(UINT8 index)
{
    Enemy *e = &enemies[index];
    e->x = ENEMY_START_X;
    e->isActive = 1;
    e->animCounter = 0;
    e->currentFrame = 0;
    e->deathTimer = 0;
    e->hitFlashTimer = 0;
    e->health = 10;
    e->maxHealth = 10;
    e->type = ENEMY_TYPE_BOSS;
    e->y = ENEMY_START_Y;
    e->isJumping = 0;
    e->velocityY = 0;
    e->jumpTimer = 40 + (simpleRand() % 70);
    e->spriteBase = 8 + (index * 4);
    e->bossDirection = -1;
}

void updateBossPhysics(Enemy *e)
{
    if (!e->isActive)
        return;

    if (e->deathTimer > 0)
    {
        e->deathTimer--;
        if (e->deathTimer == 0)
        {
            e->isActive = 0;
            hideSprite4(e->spriteBase);
        }
        return;
    }

    if (e->isJumping)
    {
        e->velocityY += GRAVITY;
        e->y -= e->velocityY;

        if (e->y >= FLOOR_Y)
        {
            e->y = FLOOR_Y;
            e->isJumping = 0;
            e->velocityY = 0;
            e->jumpTimer = 40 + (simpleRand() % 70);
        }
    }
    else
    {
        if (e->jumpTimer > 0)
        {
            e->jumpTimer--;
        }
        if (e->jumpTimer == 0)
        {
            e->isJumping = 1;
            e->velocityY = ENEMY_JUMP_STRENGTH;
        }
    }

    INT16 nextX = e->x + (e->bossDirection * getEnemySpeed());

    if (nextX < 5)
    {
        e->x = 5;
        e->bossDirection = 1;
    }
    else if (nextX > 145)
    {
        e->x = 145;
        e->bossDirection = -1;
    }
    else
    {
        e->x = nextX;
    }
}

void updateEnemyPhysics(Enemy *e)
{
    if (!e->isActive)
        return;

    if (e->type == ENEMY_TYPE_BOSS)
    {
        updateBossPhysics(e);
        return;
    }

    if (e->deathTimer > 0)
    {
        e->deathTimer--;
        if (e->deathTimer == 0)
        {
            e->isActive = 0;
            hideSprite4(e->spriteBase);
        }
        return;
    }

    if (e->type == ENEMY_TYPE_TARGETING)
    {
        e->velocityY += GRAVITY;
        e->y -= e->velocityY;

        if (e->x > e->targetX + 2)
        {
            e->x -= getEnemySpeed();
        }
        else if (e->x < e->targetX - 2)
        {
            e->x += getEnemySpeed();
        }

        if (e->y >= FLOOR_Y)
        {
            e->y = FLOOR_Y;
            e->isJumping = 0;
            e->velocityY = 0;
            e->type = ENEMY_TYPE_GROUND;
        }
    }
    else if (e->type == ENEMY_TYPE_FLYING)
    {
        e->flyingBobTimer++;
        if (e->flyingBobTimer > 15)
        {
            e->flyingBobTimer = 0;
            e->flyingDirection = -e->flyingDirection;
        }
        e->y += e->flyingDirection;

        if (e->y < ENEMY_FLY_Y_HIGH)
        {
            e->y = ENEMY_FLY_Y_HIGH;
            e->flyingDirection = 1;
        }
        else if (e->y > ENEMY_FLY_Y_LOW)
        {
            e->y = ENEMY_FLY_Y_LOW;
            e->flyingDirection = -1;
        }

        // Set max speed for ghost enemies
        UINT8 speed = getEnemySpeed();
        UINT8 maxGhostSpeed = 4; // Set your desired max speed here
        if (speed > maxGhostSpeed) speed = maxGhostSpeed;
        e->x -= speed;
    }
    else if (e->isJumping)
    {
        e->velocityY += GRAVITY;
        e->y -= e->velocityY;

        if (e->y >= FLOOR_Y)
        {
            e->y = FLOOR_Y;
            e->isJumping = 0;
            e->velocityY = 0;

            if (e->type == ENEMY_TYPE_JUMPING)
            {
                e->jumpTimer = 20 + (simpleRand() % 30);
            }

            if (e->type == ENEMY_TYPE_FALLING)
            {
                e->type = ENEMY_TYPE_GROUND;
            }
        }

        e->x -= getEnemySpeed();
    }
    else if (e->type == ENEMY_TYPE_GROUND)
    {
        if (e->jumpTimer > 0)
        {
            e->jumpTimer--;
        }
        if (e->jumpTimer == 0)
        {
            e->isJumping = 1;
            e->velocityY = ENEMY_JUMP_STRENGTH;
            e->jumpTimer = 40 + (simpleRand() % 70);
        }

        e->x -= getEnemySpeed();
    }
    else if (e->type == ENEMY_TYPE_JUMPING)
    {
        if (e->jumpTimer > 0)
        {
            e->jumpTimer--;
        }
        if (e->jumpTimer == 0)
        {
            e->isJumping = 1;
            e->velocityY = ENEMY_JUMP_STRENGTH;
            e->jumpTimer = 20 + (simpleRand() % 30);
        }

        e->x -= getEnemySpeed();
    }

    if (e->x < -20)
    {
        e->isActive = 0;
        hideSprite4(e->spriteBase);
        // Lose 1/4 life when enemy leaves screen
        loseQuarterLife();
    }
}

void updateEnemyAnimation(Enemy *e)
{
    if (!e->isActive)
        return;

    if (e->deathTimer > 0)
    {
        if (e->deathTimer % 4 < 2)
        {
            hideSprite4(e->spriteBase);
        }
        return;
    }

    if (e->hitFlashTimer > 0)
    {
        e->hitFlashTimer--;
        if (e->hitFlashTimer % 2 == 0)
        {
            hideSprite4(e->spriteBase);
            return;
        }
    }

    e->animCounter++;
    if (e->animCounter >= ANIM_SPEED)
    {
        e->animCounter = 0;
        e->currentFrame = (e->currentFrame + 1) % 3;
    }

    UINT8 baseTile = 0;
    UINT8 frame_count = 1;

    switch (e->type)
    {
    case ENEMY_TYPE_GROUND:
        frame_count = 3;
        baseTile = 8 + (e->currentFrame * 4);
        break;
    case ENEMY_TYPE_JUMPING:
        frame_count = 3;
        baseTile = 20 + (e->currentFrame * 4);
        break;
    case ENEMY_TYPE_FLYING:
        frame_count = 1;
        baseTile = 32;
        break;
    case ENEMY_TYPE_TARGETING:
        frame_count = 3;
        baseTile = 8 + (e->currentFrame * 4);
        break;
    case ENEMY_TYPE_BOSS:
        frame_count = 3;
        baseTile = 36 + (e->currentFrame * 4);
        break;
    }

    if (e->animCounter >= ANIM_SPEED)
    {
        e->animCounter = 0;
        e->currentFrame = (e->currentFrame + 1) % frame_count;
    }

    set_sprite_tile(e->spriteBase, baseTile);
    set_sprite_tile(e->spriteBase + 1, baseTile + 2);
    set_sprite_tile(e->spriteBase + 2, baseTile + 1);
    set_sprite_tile(e->spriteBase + 3, baseTile + 3);
}

void drawEnemy(Enemy *e)
{
    if (e->isActive && e->deathTimer == 0)
    {
        moveSprite4(e->spriteBase, e->spriteBase + 1,
                    e->spriteBase + 2, e->spriteBase + 3,
                    e->x, e->y);
    }
}

UINT8 countActiveEnemies(void)
{
    UINT8 count = 0;
    UINT8 i;
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        if (enemies[i].isActive)
            count++;
    }
    return count;
}
