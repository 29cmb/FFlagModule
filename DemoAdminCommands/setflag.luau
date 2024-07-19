--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> setflag
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Flags = require(game.ReplicatedStorage.FFlags)
return {
    Keyword = {"setflag","sflag"},
    Category = "BasicCommands",
    Description = "Set a flag value",
    Arguments = {
        {
            Name = "Flag",
            Type = "string",
            Description = "Flag to change"
        },
        {
            Name = "Value",
            Type = "string",
            Description = "Value to set"
        }
    },
    ServerRun = function(CommandContext, flag, value)
        local Util = IncludedCommandUtil.ForContext(CommandContext)
        if value == "true" then value = true end
        if value == "false" then value = false end
            
        Util:SendMessage(if Flags:Connect():SetFFlagValue(flag, value) == true then "Set value of " .. flag .. " successfully" else "Failed to set value for " .. flag)
    end
}