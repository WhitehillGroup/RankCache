--[[
    JSM Rank Cache Module
    Author: TheCakeChicken

    This module can be required from both the client and the server.

    This module is designed to provide the developer with greater control over how group ranks/roles are handled in their game.
    Games which rely on these usually use Player:GetRankInGroup, which caches even after a player rejoins.

    You may wish to consider implementing a server script to fetch/clear this data when a player joins/leaves
    to ensure that when a player rejoins the game, the latest ranking information is fetched and used.

    TO SETUP:
        - Place this ModuleScript into ReplicatedStorage
        - Set relevant settings in the config table

    USAGE:
        -- Load the library
        local rankCache = require(game.ReplicatedStorage.RankCache)

        -- Fetches Player1's rank for group 1234
        local player1Rank = rankCache:GetPlayerRank(game.Players.Player1, 1234)

        -- Fetches Player1's role for group 1234
        local player1Role = rankCache:GetPlayerRole(game.Players.Player1, 1234)

        -- Fetches Player2's rank for the configured default group
        local player2Rank = rankCache:GetPlayerRank(game.Players.Player2)

        -- Fetches Player2's role for the configured default group
        local player2Role = rankCache:GetPlayerRole(game.Players.Player2)


    More advanced usage can be found within the GitHub repository.

    Need help?
    Check out the example scripts available in the GitHub repository
]]

local config = {
	--// Specifies the group ID to use when no groupId is provided
	DefaultGroupID = 0;
}

local module = {}

local GroupService = game:GetService('GroupService')

module.dataCache = setmetatable({}, {
	__index = function(t,i)
		t[i] = setmetatable({}, {__index = function(t_,i_) t_[i_] = {} return t_[i_] end})
		return t[i]
	end
})

module.FetchPlayerInfo = function(self, player, groupId)
	if (not groupId and not config.DefaultGroupID) then
		return error("Attempt to fetch player rank without specifying group. Is a default group set?")
	elseif (not groupId and config.DefaultGroupID) then
		groupId = config.DefaultGroupID
	end

	local isSuccess, usrGroups = pcall(function() return GroupService:GetGroupsAsync(player.UserId) end)

    --// If the request failed, return a default value but do not store to the cache, so subsequent requests will attempt to fetch new data
    if (not isSuccess) then
        warn("[RankCache] Failed to fetch group (ID: " .. groupId .. ") data for " .. player.Name .. " (" .. player.UserId .. ")");

        return {
            Rank = 0;
            Role = "Guest";
        }
    end

	local playerRank = 0
	local playerRole = "Guest"

	for _, group in pairs(usrGroups) do
		if group.Id == groupId then
			playerRank = group.Rank;
			playerRole = group.Role;

			break;
		end
	end

	self.dataCache[player.UserId][groupId] = {
		Rank = playerRank;
		Role = playerRole;
	}

	return self.dataCache[player.UserId][groupId]
end

module.ClearPlayerInfo = function(self, player)
	self.dataCache[player.UserId] = nil
end

module.GetPlayerRank = function(self, player, groupId)
	if (not groupId and not config.DefaultGroupID) then
		return error("Attempt to fetch player rank without specifying group. Is a default group set?")
	elseif (not groupId and config.DefaultGroupID) then
		groupId = config.DefaultGroupID
	end

	if self.dataCache[player.UserId][groupId].Rank then
		return self.dataCache[player.UserId][groupId].Rank
	end

	local data = self:FetchPlayerInfo(player, groupId)
	return data.Rank
end

module.GetPlayerRole = function(self, player, groupId)
	if (not groupId and not config.DefaultGroupID) then
		return error("Attempt to fetch player rank without specifying group. Is a default group set?")
	elseif (not groupId and config.DefaultGroupID) then
		groupId = config.DefaultGroupID
	end

	if self.dataCache[player.UserId][groupId].Role then
		return self.dataCache[player.UserId][groupId].Role
	end

	local data = self:FetchPlayerInfo(player, groupId)
	return data.Role
end

return module