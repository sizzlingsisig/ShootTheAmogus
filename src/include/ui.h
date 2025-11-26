#ifndef UI_H
#define UI_H

#include "gametypes.h"

extern UINT8 quarterLife;

void drawHearts(void);
void drawScore(void);
void drawWave(void);
void showStartScreen(void);
UINT8 showGameOverScreen(void);

#endif // UI_H
