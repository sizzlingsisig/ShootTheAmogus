#ifndef BULLET_H
#define BULLET_H

#include "gametypes.h"
#include <gb/gb.h>

// Bullet functions
void initBullets(void);
UINT8 fireBullet(void);
void updateBullets(void);

// Global bullet state
extern GameCharacter bullets[MAX_BULLETS];

#endif // BULLET_H
