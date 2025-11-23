#ifndef GAME_H
#define GAME_H

#include "gametypes.h"

// Game class-like structure functions
void Game_init(void);
void Game_start(void);
void Game_reset(void);
void Game_update(void);
void Game_draw(void);

// Internal game functions
void updateDifficulty(void);
UINT8 getSpawnInterval(void);
void checkWaveCompletion(void);
void updateEnemySpawning(void);

// Game state accessors
UINT8 getWaveNumber(void);
UINT8 getEnemySpeed(void);
void incrementWave(void);
void incrementEnemiesKilled(void);
void addScore(UINT16 points);

// Global game state
extern Game game;
extern UINT8 enemySpawnTimer;

#endif // GAME_H
