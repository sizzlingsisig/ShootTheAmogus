#include "sound.h"
#include "gbt_player.h"

void playSound(SoundType type)
{
    switch (type)
    {
    case SOUND_JUMP:
        NR10_REG = 0x16;
        NR11_REG = 0x40;
        NR12_REG = 0x73;
        NR13_REG = 0x00;
        NR14_REG = 0xC3;
        break;
    case SOUND_SHOOT:
        NR10_REG = 0x06;
        NR11_REG = 0x60;
        NR12_REG = 0x83;
        NR13_REG = 0x80;
        NR14_REG = 0x87;
        break;
    case SOUND_HIT:
        NR10_REG = 0x26;
        NR11_REG = 0x50;
        NR12_REG = 0xF4;
        NR13_REG = 0x40;
        NR14_REG = 0xC5;
        break;
    case SOUND_ENEMY_DEATH:
        NR10_REG = 0x36;
        NR11_REG = 0x60;
        NR12_REG = 0xC3;
        NR13_REG = 0x30;
        NR14_REG = 0xC4;
        break;
    case SOUND_GAME_OVER:
        gbt_stop();
        break;
    }
}
