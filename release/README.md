# ShootTheAmogus

**Authors:**
- Christian Joseph G. Hernia

**Date:** November 26, 2025

---

## Project Overview
ShootTheAmogus is a retro-inspired Game Boy shooter created for CMSC 131: Special Topics. Players defend against waves of Amogus enemies, using fast reflexes and strategic shooting. The game features custom graphics, sound, and music, all designed for authentic Game Boy hardware and emulators.

## Features
- Playable Game Boy ROM
- Multiple enemy types and behaviors
- Wave-based progression and scoring
- Custom sprite graphics and backgrounds
- Sound effects and music
- Responsive controls

## Tools & Assets
- **Music:**
  - Composed in MOD format using [mod2gbt](https://github.com/untoxa/mod2gbt)
  - Track: [Serious Ping Pong Matches](https://github.com/DeerTears/GB-Studio-Community-Assets/blob/master/Music/Action/Serious%20Ping%20Pong%20Matches.mod) by DeerTears (GB Studio Community Assets)
- **Graphics:**
  - Sprites and tiles created with [GB Tile Designer](https://www.devrs.com/gb/hmgd/gbtd.html) and [GB Map Designer](https://www.devrs.com/gb/hmgd/gbmd.html) by Nathan Heffley
- **Development:**
  - C language with [GBDK](https://github.com/gbdk-2020/gbdk-2020)

## Folder Structure & Main Files
- `src/` — Source code for the game
  - `main.c` — Entry point, handles initialization and main game loop
  - `game.c` — Core game logic (waves, scoring, difficulty, state management)
  - `player.c` — Player movement, input, and animation
  - `enemy.c` — Enemy spawning, movement, and AI
  - `bullet.c` — Bullet logic and collision
  - `sound.c` — Sound effects and music playback
  - `ui.c` — User interface (score, lives, wave display)
  - `collision.c` — Collision detection between entities
  - `utils.c` — Utility functions (random, helpers)
  - `assets/` — Sprite, tile, and music assets
    - `.c`, `.h`, `.asm` files for graphics and music
    - Example: `Amogus.c`, `bg.c`, `ghostamogus.c`, `musi.mod`
  - `include/` — Header files for all modules
    - Example: `player.h`, `enemy.h`, `game.h`, etc.
- `build.bat` — Windows batch file to build the project
- `main.gb` — Compiled Game Boy ROM
- `README.md` — Project documentation

## Getting Started
1. Download the ROM from the `release/` folder or build from source.
2. Run the ROM in a Game Boy emulator (e.g., BGB, mGBA, Gambatte).
3. Use arrow keys to move, B (Z key in mGBA) to jump, and A (X key in mGBA) to shoot.

## Building from Source
- Clone the repository:
  ```sh
  git clone https://github.com/sizzlingsisig/ShootTheAmogus.git
  cd ShootTheAmogus
  ```
- Build instructions are provided in `build.bat`.

## Music Integration
- The music track is converted from MOD to GBT format using mod2gbt.
- Music playback is handled by the gbt_player library in the game code.
- Credits to DeerTears for the original MOD file.

## Graphics Workflow
- Sprites and backgrounds were designed in GB Tile Designer and GB Map Designer.
- Assets are exported as `.c`, `.h`, and `.asm` files for use in the game.

## Game Mechanics
- **Player Movement:** Move left and right using the arrow keys. Jump with A, shoot with B.
- **Shooting:** Fire bullets to defeat enemies. Only a limited number of bullets can be on screen at once.
- **Enemies:** Multiple types (ground, jumping, flying, targeting, boss) spawn in waves. Each has unique movement and behavior.
- **Waves:** Survive increasingly difficult waves. Each wave increases enemy speed and spawn rate.
- **Scoring:** Earn points for defeating enemies. Bonus points for defeating bosses and completing waves.
- **Lives & Health:** Player starts with several lives. Colliding with enemies or missing too many causes life loss.
- **Game Over:** The game ends when all lives are lost.
- **Sound & Music:** Sound effects play for actions; background music runs throughout gameplay.

## How the Game Works

### Enemies
- **Ground Enemy:**
  - Moves horizontally from right to left along the ground (Y=105).
  - Periodically jumps after a timer expires.
- **Jumping Enemy:**
  - Starts in a jumping state, moving in a parabolic arc.
  - After landing, waits before jumping again.
  - Moves leftward while jumping or on the ground.
- **Flying Enemy (Ghost):**
  - Spawns at a random height between Y=50 and Y=90.
  - Moves left while bobbing up and down, reversing vertical direction every 16 frames.
  - Has a capped horizontal speed for balance.
- **Targeting Enemy:**
  - Spawns above the ground and targets the player's current X position.
  - Moves horizontally to align with the player, then falls to the ground.
- **Boss Enemy:**
  - Appears every 5th wave.
  - Moves back and forth, jumps periodically, and has high health.
  - Requires multiple hits to defeat and awards bonus points.

# ShootTheAmogus

Short description
---------------
ShootTheAmogus is a compact Game Boy shooter built with GBDK. The player defends against waves of Amogus-themed enemies using jumping and shooting mechanics. The project includes custom sprites, tile maps, sound effects, and a converted MOD music track for authentic Game Boy audio.

Screenshots / GIF
-----------------
- See `docs/screenshots/` for static images and `docs/gifs/` for animated gameplay (if present).

How to play
-----------
- Controls:
  - Left / Right arrow keys — Move player horizontally
  - A — Jump
  - B — Shoot
- Objective: Survive waves of enemies, score points by defeating enemies, and survive as many waves as possible. Bosses appear on milestone waves and grant higher points.

How to run
----------
- Run the provided ROM:
  - File: `main.gb` (or `release/ShootTheAmogus-v1.0.0.gb` if using releases)
  - Recommended emulators: `BGB`, `mGBA`, `Gambatte`

  Example (BGB):
  ```bash
  bgb main.gb
  ```

- On hardware: flash `main.gb` to a Game Boy flash cart using your preferred flasher (follow hardware vendor instructions).

How to build
------------
- Requirements:
  - GBDK-2020 (tested with v4.1.0 or latest stable from https://github.com/gbdk-2020/gbdk-2020)
  - A Windows environment or WSL for `build.bat` (batch file provided). A Makefile or build script may be present.
  - `mod2gbt` for converting MOD music files to GBT format

- Basic build steps (Windows via `build.bat`):
  ```powershell
  # from project root
  .\build.bat
  ```

- Manual build steps (example):
  ```bash
  # Set up GBDK toolchain in PATH
  gbdk-build src/main.c -o main.gb
  # Or use the included build script
  ```

Project structure (brief)
-------------------------
- `main.gb` — Compiled Game Boy ROM
- `build.bat` — Windows build script
- `src/` — Source code and assets
  - `main.c` — Program entry point; initializes subsystems and runs the main loop
  - `game.c` — High-level game state management (waves, scoring, difficulty)
  - `player.c` — Player input handling, physics, and animation
  - `enemy.c` — Enemy spawning, behaviors (ground, jumping, flying, targeting, boss)
  - `bullet.c` — Bullet spawning and update logic
  - `collision.c` — Collision checks between bullets, player, enemies
  - `sound.c` — Sound effect triggers and music playback (uses `gbt_player`)
  - `ui.c` — Score, lives, wave display code
  - `utils.c` — Random number seed, helper functions
  - `assets/` — Graphics and music assets (`.c`, `.h`, `.asm`, `.mod`)
  - `include/` — Header files (`*.h`) for each module

Technical notes
---------------
- Audio: Music was sourced as a MOD file (`Serious Ping Pong Matches.mod`) from DeerTears' GB Studio Community Assets and converted to GBT with `mod2gbt`. GBT playback is handled using `gbt_player`.
- Graphics: Tiles and maps were created with `GB Tile Designer` and `GB Map Designer` by Nathan Heffley; exported assets were included under `src/assets/`.
- Enemy speed & difficulty: Enemy base speed is defined in `src/include/gametypes.h` (`ENEMY_SPEED_BASE`) and is increased by `updateDifficulty()` in `game.c` up to `MAX_ENEMY_SPEED`.
- Platform: Project is written in C using GBDK-2020 and targets original Game Boy hardware and emulators.

License / credits
-----------------
- License: MIT (see `LICENSE` if present)
- Music source: "Serious Ping Pong Matches" — DeerTears, from GB Studio Community Assets (converted with `mod2gbt`) — original license and attribution retained.
- Tools & libraries: `GBDK-2020`, `gbt_player`, `mod2gbt`, `GB Tile Designer`, `GB Map Designer`.
- Special thanks: DeerTears (music), Nathan Heffley (tile/map tools), GBDK contributors, and the Game Boy dev community.

Contact & contributions
-----------------------
- Repo: https://github.com/sizzlingsisig/ShootTheAmogus
- To contribute: fork, create a feature branch, and open a pull request. Include a short description and test steps.
