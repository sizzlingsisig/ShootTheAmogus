#include <gb/gb.h>
#include "game.h"

// Entry point: initialize game systems and enter the main game loop
void main(void)
{
    Game_init();
    Game_start();
}
