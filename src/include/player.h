#ifndef PLAYER_H
#define PLAYER_H

#include "gametypes.h"

// Player functions
void initPlayer(void);
void updatePlayerInput(UINT8 joy);
void updatePlayerPhysics(void);
void updatePlayerAnimation(void);
void drawPlayer(void);

// Global player state
extern Player player;

#endif // PLAYER_H
