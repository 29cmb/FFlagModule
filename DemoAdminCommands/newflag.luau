--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> newflag
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Flags = require(game.ReplicatedStorage.FFlags)
return {
    Keyword = {"newflag","nflag"},
    Category = "BasicCommands",
    Description = "Create a new flag",
    Arguments = {
        {
            Name = "Flag",
            Type = "string",
            Description = "Name of the flag"
        },
        {
            Name = "Value",
            Type = "string",
            Description = "Value of the flag"
        }
    },
    ServerRun = function(CommandContext, flag, value)
        local Util = IncludedCommandUtil.ForContext(CommandContext)
        if value == "true" then value = true end
        if value == "false" then value = false end
            
        Util:SendMessage(if Flags:Connect():CreateFFlag(flag, value) == true then "Created flag " .. flag .. " successfully" else "Failed to create flag " .. flag)
    end
}