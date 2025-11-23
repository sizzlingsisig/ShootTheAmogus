#include <gb/gb.h>
#include <stdio.h>
#include "game.h"
#include "player.h"
#include "enemy.h"
#include "bullet.h"
#include "utils.h"
#include "sound.h"
#include "ui.h"
#include "collision.h"
#include "gbt_player.h"

// External asset data
extern const unsigned char GameSprites[];
extern const unsigned char Amogus[];
extern const unsigned char hatamogus[];
extern const unsigned char ghostamogus[];
extern const unsigned char bigamogus[];
extern const unsigned char heart[];
extern const unsigned char bgmap[];
extern const unsigned char tile[];
extern const unsigned char *song_Data[];

Game game;
UINT8 enemySpawnTimer;

UINT8 getWaveNumber(void) { return game.waveNumber; }
UINT8 getEnemySpeed(void) { return game.enemySpeed; }
void incrementWave(void) { game.waveNumber++; game.enemiesKilledInWave = 0; }
void incrementEnemiesKilled(void) { game.enemiesKilledInWave++; }
void addScore(UINT16 points) { game.score += points; }

void Game_init(void)
{
    // Load sprite data
    set_sprite_data(0, 8, GameSprites);
    set_sprite_data(8, 12, Amogus);
    set_sprite_data(20, 12, hatamogus);
    set_sprite_data(32, 4, ghostamogus);
    set_sprite_data(36, 12, bigamogus);
    set_sprite_data(48, 2, heart);

    // Initialize sound
    NR52_REG = 0x80;
    NR50_REG = 0x77;
    NR51_REG = 0xFF;

    // Set palettes
    BGP_REG = 0xE4;
    OBP0_REG = 0xE4;
    OBP1_REG = 0xE4;

    SHOW_BKG;
    DISPLAY_ON;

    game.highScore = 0;
}

void Game_start(void)
{
    while (1)
    {
        showStartScreen();

        // Load background
        set_bkg_data(0, 9, tile);
        set_bkg_tiles(0, 0, 40, 18, bgmap);
        BGP_REG = 0xE4;

        Game_reset();

        // Initialize music
        disable_interrupts();
        gbt_play(song_Data, 2, 7);
        gbt_loop(1);
        set_interrupts(VBL_IFLAG);
        enable_interrupts();

        SHOW_SPRITES;
        set_sprite_tile(0, 0);
        set_sprite_tile(1, 2);
        set_sprite_tile(2, 1);
        set_sprite_tile(3, 3);

        // Game loop
        while (game.lives > 0)
        {
            Game_update();
            Game_draw();
            waitFrames(4);
        }

        if (!showGameOverScreen())
            break;
    }
}

void Game_reset(void)
{
    if (game.score > game.highScore)
    {
        game.highScore = game.score;
    }

    game.lives = MAX_LIVES;
    game.score = 0;
    game.difficultyLevel = 1;
    game.enemySpeed = ENEMY_SPEED_BASE;
    game.frameCounter = 0;
    game.waveNumber = 1;
    game.enemiesKilledInWave = 0;

    enemySpawnTimer = INITIAL_SPAWN_INTERVAL;
    initRand(DIV_REG);

    initPlayer();
    initBullets();
    initEnemies();
}

void updateDifficulty(void)
{
    if (game.frameCounter % DIFFICULTY_INTERVAL == 0 && game.frameCounter > 0)
    {
        game.difficultyLevel++;
        if (game.enemySpeed < MAX_ENEMY_SPEED)
        {
            game.enemySpeed++;
        }
    }
}

UINT8 getSpawnInterval(void)
{
    UINT8 interval = BASE_SPAWN_INTERVAL - (game.difficultyLevel * 3);
    return (interval < MIN_SPAWN_INTERVAL) ? MIN_SPAWN_INTERVAL : interval;
}

void checkWaveCompletion(void)
{
    if (game.enemiesKilledInWave >= ENEMIES_PER_WAVE)
    {
        game.waveNumber++;
        game.enemiesKilledInWave = 0;
        game.score += 50;
    }
}

void updateEnemySpawning(void)
{
    if (game.waveNumber >= 5 && game.waveNumber % 5 == 0)
    {
        if (countActiveEnemies() == 0 && enemySpawnTimer == 0)
        {
            spawnBossEnemy(0);
            enemySpawnTimer = 255;
        }
        else if (enemySpawnTimer > 0)
        {
            enemySpawnTimer--;
        }
        return;
    }

    enemySpawnTimer--;
    if (enemySpawnTimer == 0 || countActiveEnemies() == 0)
    {
        UINT8 i;
        UINT8 spawnCount = (simpleRand() % 10 == 0) ? 2 : 1;
        UINT8 spawned = 0;

        for (i = 0; i < MAX_ENEMIES && spawned < spawnCount; i++)
        {
            if (!enemies[i].isActive)
            {
                spawnEnemy(i);
                spawned++;
            }
        }

        UINT8 baseInterval = getSpawnInterval();
        UINT8 randomVariation = simpleRand() % (SPAWN_RANDOMNESS * 2);
        enemySpawnTimer = baseInterval + randomVariation;
    }
}

void Game_update(void)
{
    UINT8 joy = joypad();
    static UINT8 fireDelay = 0;

    game.frameCounter++;

    updateDifficulty();
    updatePlayerInput(joy);
    updatePlayerPhysics();
    updatePlayerAnimation();

    if ((joy & J_A) && fireDelay == 0)
    {
        if (fireBullet())
        {
            fireDelay = FIRE_RATE;
        }
    }
    if (fireDelay > 0) fireDelay--;

    updateBullets();
    updateEnemySpawning();

    UINT8 i;
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        updateEnemyPhysics(&enemies[i]);
        updateEnemyAnimation(&enemies[i]);
    }

    checkBulletEnemyCollisions();
    checkPlayerEnemyCollisions();
    checkWaveCompletion();
}

void Game_draw(void)
{
    UINT8 i;

    drawPlayer();
    for (i = 0; i < MAX_ENEMIES; i++)
    {
        drawEnemy(&enemies[i]);
    }

    scroll_bkg(1, 0);
    drawHearts();
    drawScore();
    drawWave();
}
