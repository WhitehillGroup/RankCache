# JSM RankCache

JSM RankCache is a library designed to make it easier to obtain up-to-date group ranking information across all of your in-game scripts.

**Why use this over :GetRankInGroup/:GetRoleInGroup?**
- This library ensures that you get up-to-date rank information whilst keeping API requests to a minimum.
- It provides full control over when rank data is refreshed.

⚠️ Knowledge of Roblox scripting is required to use this library.

---

## Installation methods

### Method 1 (recommended): Roblox Model
1. Take the [Roblox Model](https://google.com)
2. Drag into your game via the Toolbox
3. Parent the module to a place it can be accessed by both the client and server (ideally `ReplicatedStorage`)

### Method 2: GitHub Releases
1. Download the latest rbxm release from [the GitHub releases](https://github.com/TheCakeChicken/RankCache/releases)
2. Drag the downloaded file into studio
3. Parent the module to a place it can be accessed by both the client and server (ideally `ReplicatedStorage`)

### Method 3: Rojo
1. Download the GitHub repository to your computer.
2. Install [Rojo](https://rojo.space/) and all associated Studio/VSC plugins.
3. Use Rojo to sync the RankCache library into your Studio project. (Or build the library using `rojo build -o RankCache.rbxm`)

## Basic Usage
```lua
local rankCache = require(game:GetService('ReplicatedStorage').RankCache)

-- Fetches Player1's rank for group 1234
local player1Rank = rankCache:GetPlayerRank(game.Players.Player1, 1234)

-- Fetches Player1's role for group 1234
local player1Role = rankCache:GetPlayerRole(game.Players.Player1, 1234)

-- Fetches Player2's rank for the configured default group
local player2Rank = rankCache:GetPlayerRank(game.Players.Player2)

-- Fetches Player2's role for the configured default group
local player2Role = rankCache:GetPlayerRole(game.Players.Player2)
```

More examples are available in the [examples](https://google.com) folder.