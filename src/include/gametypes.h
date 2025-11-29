
#ifndef GAMETYPES_H
#define GAMETYPES_H

#include <gb/gb.h>

// GBDK type definitions
typedef unsigned char UINT8;
typedef signed char INT8;
typedef unsigned int UINT16;
typedef signed int INT16;

// ===== CONSTANTS =====
#define MAX_BULLETS 6
#define MAX_ENEMIES 4
#define SPRITE_SIZE 8
#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144

#define PLAYER_SPEED 2
#define BULLET_SPEED 4
#define ENEMY_SPEED_BASE 4
#define ANIM_SPEED 10
#define FIRE_RATE 15

#define GRAVITY -2
#define JUMP_STRENGTH 15
#define ENEMY_JUMP_STRENGTH 12
#define FLOOR_Y 105

#define PLAYER_START_X 10
#define PLAYER_START_Y 105

#define ENEMY_START_X 160
#define ENEMY_START_Y 105
#define ENEMY_START_Y_AIR 40
#define ENEMY_FLY_Y_HIGH 50
#define ENEMY_FLY_Y_MID 70
#define ENEMY_FLY_Y_LOW 90

#define BULLET_OFFSET_X 12
#define BULLET_OFFSET_Y 2

#define OFFSCREEN_X 200
#define OFFSCREEN_Y 200

#define MAX_LIVES 3
#define INVINCIBILITY_TIME 60
#define ENEMIES_PER_WAVE 10

// Spawn timing
#define INITIAL_SPAWN_INTERVAL 20
#define BASE_SPAWN_INTERVAL 35
#define MIN_SPAWN_INTERVAL 10
#define SPAWN_RANDOMNESS 25

// Difficulty
#define DIFFICULTY_INTERVAL 300
#define MAX_ENEMY_SPEED 6

// ===== ENUMS =====
typedef enum
{
    ENEMY_TYPE_GROUND,
    ENEMY_TYPE_JUMPING,
    ENEMY_TYPE_FALLING,
    ENEMY_TYPE_FLYING,
    ENEMY_TYPE_TARGETING,
    ENEMY_TYPE_BOSS
} EnemyType;

typedef enum
{
    STATE_START_SCREEN,
    STATE_PLAYING,
    STATE_GAME_OVER
} GameState;

typedef enum
{
    SOUND_JUMP = 1,
    SOUND_SHOOT,
    SOUND_GAME_OVER,
    SOUND_HIT,
    SOUND_ENEMY_DEATH
} SoundType;

// ===== STRUCTURES =====
typedef struct
{
    UINT8 x;
    UINT8 y;
    UINT8 width;
    UINT8 height;
    UINT8 spritids[4];
} GameCharacter;

typedef struct
{
    INT16 x;
    UINT8 y;
    INT8 velocityY;
    UINT8 isJumping;
    UINT8 isActive;
    UINT8 animCounter;
    UINT8 currentFrame;
    UINT8 jumpTimer;
    EnemyType type;
    UINT8 spriteBase;
    UINT8 flyingBobTimer;
    INT8 flyingDirection;
    UINT8 deathTimer;
    UINT8 health;
    UINT8 maxHealth;
    UINT8 hitFlashTimer;
    UINT16 targetX;
    INT8 bossDirection;
} Enemy;

typedef struct
{
    UINT8 x;
    UINT8 y;
    INT8 velocityY;
    UINT8 isJumping;
    UINT8 animCounter;
    UINT8 currentFrame;
    UINT8 invincibilityTimer;
    UINT8 flashTimer;
} Player;

typedef struct
{
    UINT8 lives;
    UINT16 score;
    UINT16 highScore;
    UINT8 waveNumber;
    UINT8 enemiesKilledInWave;
    UINT8 difficultyLevel;
    UINT8 enemySpeed;
    UINT16 frameCounter;
} Game;

#endif // GAMETYPES_H
