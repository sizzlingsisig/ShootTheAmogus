#ifndef ENEMY_H
#define ENEMY_H

#include "gametypes.h"

// Enemy functions
void initEnemies(void);
void spawnEnemy(UINT8 index);
void spawnBossEnemy(UINT8 index);
void updateEnemyPhysics(Enemy* e);
void updateBossPhysics(Enemy* e);
void updateEnemyAnimation(Enemy* e);
void drawEnemy(Enemy* e);
UINT8 countActiveEnemies(void);

// Global enemy state
extern Enemy enemies[MAX_ENEMIES];

#endif // ENEMY_H
