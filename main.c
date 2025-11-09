#include <gb/gb.h>
#include <stdio.h>
#include "GameCharacter.c"
#include "GameSprites.c"
#include "Amogus.c"
#include "heart.c"
#include "bg.c"
#include "bgtiles.c"

// ===== CONSTANTS =====

#define MAX_BULLETS 6
#define SPRITE_SIZE 8
#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144

#define PLAYER_SPEED 2
#define BULLET_SPEED 4
#define ENEMY_SPEED 2
#define ANIM_SPEED 10
#define FIRE_RATE 10

#define GRAVITY -2
#define JUMP_STRENGTH 10
#define FLOOR_Y 105

#define PLAYER_START_X 70
#define PLAYER_START_Y 105

#define ENEMY_START_X 160
#define ENEMY_START_Y 105

#define BULLET_OFFSET_X 12
#define BULLET_OFFSET_Y 2

#define OFFSCREEN_X 200
#define OFFSCREEN_Y 200

#define MAX_LIVES 3

// ===== GAME STATE =====

UINT8 playerX = PLAYER_START_X;
UINT8 playerY = PLAYER_START_Y;
INT16 enemyX = ENEMY_START_X;
UINT8 enemyY = ENEMY_START_Y;

UINT8 lives = MAX_LIVES;
UINT16 score = 0;
UINT8 isJumping = 0;
INT8 velocityY = 0;

UINT8 animCounter = 0;
UINT8 currentEnemyFrame = 0;

struct GameCharacter bullets[MAX_BULLETS];

// ===== SIMPLE HELPER FUNCTIONS =====

void waitFrames(UINT8 loops){
    UINT8 i;
    for(i = 0; i < loops; i++){
        wait_vbl_done();
    }
}

void moveSprite4(UINT8 sprite1, UINT8 sprite2, UINT8 sprite3, UINT8 sprite4, 
                 INT16 x, UINT8 y){
    move_sprite(sprite1, x, y);
    move_sprite(sprite2, x + SPRITE_SIZE, y);
    move_sprite(sprite3, x, y + SPRITE_SIZE);
    move_sprite(sprite4, x + SPRITE_SIZE, y + SPRITE_SIZE);
}

void playSound(UINT8 type){
    if(type == 1){  // Jump sound
        NR10_REG = 0x16;
        NR11_REG = 0x40;  
        NR12_REG = 0x73;  
        NR13_REG = 0x00;  
        NR14_REG = 0xC3;
    }
    else if(type == 2){  // Shoot sound
        NR10_REG = 0x06;
        NR11_REG = 0x60;  
        NR12_REG = 0x83;  
        NR13_REG = 0x80;  
        NR14_REG = 0x87;
    }
}

void drawHearts(UINT8 count){
    UINT8 i;
    for(i = 0; i < 3; i++){
        if(i < count){
            set_sprite_tile(20 + (i * 2), 20);
            move_sprite(20 + (i * 2), 8 + (i * 16), 8);
            set_sprite_tile(21 + (i * 2), 21);
            move_sprite(21 + (i * 2), 8 + (i * 16), 16);
        } else {
            move_sprite(20 + (i * 2), OFFSCREEN_X, OFFSCREEN_Y);
            move_sprite(21 + (i * 2), OFFSCREEN_X, OFFSCREEN_Y);
        }
    }
}

// ===== BULLET FUNCTIONS =====

void setupBullets(void){
    UINT8 i;
    for(i = 0; i < MAX_BULLETS; i++){
        bullets[i].x = 0;
        bullets[i].y = 0;
        set_sprite_tile(12 + i, 0);
        bullets[i].spritids[0] = 12 + i;
        move_sprite(12 + i, OFFSCREEN_X, OFFSCREEN_Y);
    }
}

void fireBullet(void){
    UINT8 i;
    for(i = 0; i < MAX_BULLETS; i++){
        if(bullets[i].y == 0 || bullets[i].x > SCREEN_WIDTH){
            bullets[i].x = playerX + BULLET_OFFSET_X;
            bullets[i].y = playerY + BULLET_OFFSET_Y;
            playSound(2);
            return;
        }
    }
}

void updateBullets(void){
    UINT8 i;
    for(i = 0; i < MAX_BULLETS; i++){
        if(bullets[i].y > 0 && bullets[i].x < SCREEN_WIDTH){
            bullets[i].x += BULLET_SPEED;
            move_sprite(bullets[i].spritids[0], bullets[i].x, bullets[i].y);
        } else {
            bullets[i].y = 0;
            bullets[i].x = 0;
            move_sprite(bullets[i].spritids[0], OFFSCREEN_X, OFFSCREEN_Y);
        }
    }
}

// ===== PLAYER JUMPING =====

void jump(void){
    if(isJumping == 0){
        isJumping = 1;
        velocityY = JUMP_STRENGTH;
        playSound(1);
    }
}

void updateJump(void){
    INT8 hitFloor;
    
    velocityY = velocityY + GRAVITY;
    playerY = playerY - velocityY;
    
    if(playerY >= FLOOR_Y){
        isJumping = 0;
        velocityY = 0;
        playerY = FLOOR_Y;
        hitFloor = 1;
    }
}

// ===== ENEMY ANIMATION =====

void updateEnemyAnimation(void){
    animCounter++;
    
    if(animCounter >= ANIM_SPEED){
        animCounter = 0;
        currentEnemyFrame++;
        
        if(currentEnemyFrame >= 3){
            currentEnemyFrame = 0;
        }
    }
    
    // Update enemy sprite tiles based on current frame
    if(currentEnemyFrame == 0){
        set_sprite_tile(8, 8);
        set_sprite_tile(9, 10);
        set_sprite_tile(10, 9);
        set_sprite_tile(11, 11);
    }
    else if(currentEnemyFrame == 1){
        set_sprite_tile(8, 12);
        set_sprite_tile(9, 14);
        set_sprite_tile(10, 13);
        set_sprite_tile(11, 15);
    }
    else if(currentEnemyFrame == 2){
        set_sprite_tile(8, 16);
        set_sprite_tile(9, 18);
        set_sprite_tile(10, 17);
        set_sprite_tile(11, 19);
    }
}

// ===== COLLISION CHECKING =====

void checkBulletEnemy(void){
    UINT8 i;
    for(i = 0; i < MAX_BULLETS; i++){
        if(bullets[i].y > 0 && bullets[i].x < SCREEN_WIDTH){
            if(bullets[i].x >= enemyX && bullets[i].x <= enemyX + 16 &&
               bullets[i].y >= enemyY && bullets[i].y <= enemyY + 16){
                bullets[i].y = 0;
                bullets[i].x = 0;
                score += 10;
                enemyX = ENEMY_START_X;
            }
        }
    }
}

void checkPlayerEnemy(void){
    if(playerX >= enemyX - 8 && playerX <= enemyX + 16 &&
       playerY >= enemyY - 8 && playerY <= enemyY + 16){
        lives--;
        enemyX = ENEMY_START_X;
        enemyY = ENEMY_START_Y;
    }
}

void updatePlayerAnimation(void){
    animCounter++;
    
    if(animCounter >= ANIM_SPEED){
        animCounter = 0;
        
        // Only animate when moving
        if((joypad() & J_LEFT) || (joypad() & J_RIGHT)){
            // Swap between frame 1 and frame 2
            if(currentEnemyFrame == 0){
                set_sprite_tile(0, 4);
                set_sprite_tile(1, 6);
                set_sprite_tile(2, 5);
                set_sprite_tile(3, 7);
                currentEnemyFrame = 1;
            } else {
                set_sprite_tile(0, 0);
                set_sprite_tile(1, 2);
                set_sprite_tile(2, 1);
                set_sprite_tile(3, 3);
                currentEnemyFrame = 0;
            }
        }
    }
}

// ===== MAIN =====

void main(void){
    UINT8 joy;
    UINT8 fireDelay = 0;
    
    set_sprite_data(0, 8, GameSprites);
    set_sprite_data(8, 20, Amogus);
    set_sprite_data(20, 2, heart);
    
    set_bkg_data(0, 9, tile);
    set_bkg_tiles(0, 0, 40, 18, bgmap);
    
    NR52_REG = 0x80;
    NR50_REG = 0x77;
    NR51_REG = 0xFF;
    
    SHOW_BKG;
    SHOW_SPRITES;
    DISPLAY_ON;
    
    BGP_REG = 0xE4;
    OBP0_REG = 0xE4;
    OBP1_REG = 0xE4;
    
    setupBullets();
    
    // Setup player sprites
    set_sprite_tile(0, 0);
    set_sprite_tile(1, 2);
    set_sprite_tile(2, 1);
    set_sprite_tile(3, 3);
    
    // Setup enemy sprites - frame 1
    set_sprite_tile(8, 8);
    set_sprite_tile(9, 10);
    set_sprite_tile(10, 9);
    set_sprite_tile(11, 11);
    
    while(1){
        if(lives == 0) break;
        
        joy = joypad();
        
        // Move left/right
        if(joy & J_LEFT){
            playerX -= PLAYER_SPEED;
        }
        if(joy & J_RIGHT){
            playerX += PLAYER_SPEED;
        }
        
        // Jump with B button
        if((joy & J_B) && isJumping == 0){
            jump();
        }
        
        // Shoot with A button
        if((joy & J_A) && fireDelay == 0){
            fireBullet();
            fireDelay = FIRE_RATE;
        }
        
        if(fireDelay > 0) fireDelay--;
        
        // Update physics
        if(isJumping == 1){
            updateJump();
        }
        
        // Update animations
        updateEnemyAnimation();
        
        // Update bullets
        updateBullets();

        updatePlayerAnimation();
        
        // Move enemy LEFT towards player
        enemyX -= ENEMY_SPEED;
        
        // Respawn enemy when off-screen
        if(enemyX < -20){
            enemyX = ENEMY_START_X;
        }
        
        // Check collisions
        checkBulletEnemy();
        checkPlayerEnemy();
        
        // Draw everything
        moveSprite4(0, 1, 2, 3, playerX, playerY);
        moveSprite4(8, 9, 10, 11, enemyX, enemyY);
        
        scroll_bkg(1, 0);
        drawHearts(lives);
        
        waitFrames(5);
    }
}
