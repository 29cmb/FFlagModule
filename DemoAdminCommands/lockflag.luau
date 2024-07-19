--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> lockflag
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Flags = require(game.ReplicatedStorage.FFlags)
return {
    Keyword = {"lockflag", "lflag"},
    Category = "BasicCommands",
    Description = "Lock a flag",
    Arguments = {
        {
            Name = "Flag",
            Type = "string",
            Description = "Flag to lock"
        }
    },
    ServerRun = function(CommandContext, flag)
        local Util = IncludedCommandUtil.ForContext(CommandContext)
        Util:SendMessage(if Flags:Connect():LockFFlag(flag) == true then "Locked " .. flag .. " successfully" else "Failed to lock " .. flag)
    end
}