@echo off

REM Set GBDK path
SET GBDK=C:\gbdk

echo Compiling source files...
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/main.o src/main.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/game.o src/game.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/player.o src/player.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/enemy.o src/enemy.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/bullet.o src/bullet.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/collision.o src/collision.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/ui.o src/ui.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/sound.o src/sound.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Isrc/include -Isrc/assets -c -o src/utils.o src/utils.c

echo Compiling resource files...
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/GameSprites.o src/assets/GameSprites.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/Amogus.o src/assets/Amogus.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/bigamogus.o src/assets/bigamogus.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/hatamogus.o src/assets/hatamogus.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/ghostamogus.o src/assets/ghostamogus.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/heart.o src/assets/heart.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/bg.o src/assets/bg.c
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/bgtiles.o src/assets/bgtiles.c

echo Compiling GBT Player assembly files...
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/gbt_player.o src/assets/gbt_player.s
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/gbt_player_bank1.o src/assets/gbt_player_bank1.s

echo Compiling song data...
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o src/assets/output.o src/assets/output.c

echo Linking everything together...
%GBDK%\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -Wl-yt2 -Wl-yo4 -Wl-ya1 -o main.gb src/main.o src/game.o src/player.o src/enemy.o src/bullet.o src/collision.o src/ui.o src/sound.o src/utils.o src/assets/output.o src/assets/gbt_player.o src/assets/gbt_player_bank1.o src/assets/GameSprites.o src/assets/Amogus.o src/assets/heart.o src/assets/bg.o src/assets/bgtiles.o src/assets/hatamogus.o src/assets/ghostamogus.o src/assets/bigamogus.o

echo Cleaning up temporary files...
del src\*.o src\assets\*.o *.lst *.sym *.map 2>nul

if exist main.gb (
    echo.
    echo ==============================
    echo SUCCESS! main.gb created!
    echo ==============================
    echo.
) else (
    echo.
    echo ==============================
    echo ERROR: Compilation failed!
    echo ==============================
    echo.
)

pause