--[[
    This script outlines basic uses of the RankCache library.
]]

local rankCache = require(game:GetService('ReplicatedStorage').RankCache)

-- Fetches Player1's rank for group 1234
local player1Rank = rankCache:GetPlayerRank(game.Players.Player1, 1234)

-- Fetches Player1's role for group 1234
local player1Role = rankCache:GetPlayerRole(game.Players.Player1, 1234)

-- Fetches Player2's rank for the configured default group
local player2Rank = rankCache:GetPlayerRank(game.Players.Player2)

-- Fetches Player2's role for the configured default group
local player2Role = rankCache:GetPlayerRole(game.Players.Player2)