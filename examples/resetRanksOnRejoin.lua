--[[
    This script uses the RankCache library to fetch a user's group data when they join
    and clear it again when they leave.

    You may want to use this script if your game relies heavily on ranks which change during server runtime.
]]

local rankCache = require(game:GetService('ReplicatedStorage').RankCache)

--// Fetches a user's information for the default configured group
game:GetService('Players').PlayerAdded:Connect(function(player)
    rankCache:FetchPlayerInfo(player)
end)

--// Clears the user's information after they leave the game
game:GetService('Players').PlayerRemoving:Connect(function(player)
    rankCache:ClearPlayerInfo(player)
end)