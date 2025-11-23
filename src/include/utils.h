#ifndef UTILS_H
#define UTILS_H

#include "gametypes.h"

// Random number generation
UINT8 simpleRand(void);
void initRand(UINT16 seed);

// Sprite utilities
void moveSprite4(UINT8 sprite1, UINT8 sprite2, UINT8 sprite3, UINT8 sprite4, INT16 x, UINT8 y);
void hideSprite4(UINT8 base);
void waitFrames(UINT8 frames);

// Collision detection
UINT8 checkCollision(UINT8 x1, UINT8 y1, UINT8 w1, UINT8 h1,
                       UINT8 x2, UINT8 y2, UINT8 w2, UINT8 h2);

#endif // UTILS_H
