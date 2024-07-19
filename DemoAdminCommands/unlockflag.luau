--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> unlockflag
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Flags = require(game.ReplicatedStorage.FFlags)
return {
    Keyword = {"unlockflag", "uflag"},
    Category = "BasicCommands",
    Description = "Unlock a flag value",
    Arguments = {
        {
            Name = "Flag",
            Type = "string",
            Description = "Flag to unlock"
        }
    },
    ServerRun = function(CommandContext, flag)
        local Util = IncludedCommandUtil.ForContext(CommandContext)
        Util:SendMessage(if Flags:Connect():UnlockFFlag(flag) == true then "Unlocked " .. flag .. " successfully" else "Failed to lock " .. flag)
    end
}