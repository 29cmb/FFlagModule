--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> flaglogs
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Flags = require(game.ReplicatedStorage.FFlags)
return {
    Keyword = {"flaglogs","flogs"},
    Category = "BasicCommands",
    Description = "Get all the flag logs",
    ServerLoad = function(Api)
        local GetFlagLogsRemoteFunction = Instance.new("RemoteFunction")
        GetFlagLogsRemoteFunction.Name = "GetFlagLogs"
        GetFlagLogsRemoteFunction.Parent = Api.EventContainer

        GetFlagLogsRemoteFunction.OnServerInvoke = function()
            return Flags:Connect():GetFlagLogs() or {}
        end
    end,
    ClientRun = function(CommandContext)
        local Util = IncludedCommandUtil.ForContext(CommandContext)
        local ScrollingTextWindow = require(Util.ClientResources:WaitForChild("ScrollingTextWindow")) :: any
        local Api = Util:GetApi()

        local Window = ScrollingTextWindow.new()
        Window.Title = "Flag Logs"
        Window.GetTextLines = function()
            local flagData = Api.EventContainer:WaitForChild("GetFlagLogs"):InvokeServer()
            local flags = {}

            for _,fd in pairs(flagData) do 
                table.insert(flags, { Text = fd.message })
            end

            return flags
        end
        Window:Show()
    end,
}