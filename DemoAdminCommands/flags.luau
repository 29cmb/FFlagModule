--!nocheck
--[[
    This is a nexus admin command
    It is located at ServerScriptService -> Admin -> MainModule -> IncludedCommands -> BasicCommands -> flags
]]

local IncludedCommandUtil = require(script.Parent.Parent:WaitForChild("IncludedCommandUtil"))
local Flags = require(game.ReplicatedStorage.FFlags)
return {
    Keyword = "flags",
    Category = "BasicCommands",
    Description = "Get all the flags and their values",
    ServerLoad = function(Api)
        local GetFlagsRemoteFunction = Instance.new("RemoteFunction")
        GetFlagsRemoteFunction.Name = "GetFlags"
        GetFlagsRemoteFunction.Parent = Api.EventContainer

        GetFlagsRemoteFunction.OnServerInvoke = function()
            return Flags:Connect():GetFlags() or {}
        end
    end,
    ClientRun = function(CommandContext)
        local Util = IncludedCommandUtil.ForContext(CommandContext)
        local ScrollingTextWindow = require(Util.ClientResources:WaitForChild("ScrollingTextWindow")) :: any
        local Api = Util:GetApi()

        local Window = ScrollingTextWindow.new()
        Window.Title = "Flags"
        Window.GetTextLines = function(_, SearchTerm, _)
            local flagData = Api.EventContainer:WaitForChild("GetFlags"):InvokeServer()
            local flags = {}

            print(flagData)
            for _,fd in pairs(flagData) do 
                print(fd)
                table.insert(flags, fd.flag .. ": " .. typeof(fd) == "boolean" and (fd.value == true and "✅" or "❌") or fd.value)
            end

            return flags
        end
        Window:Show()
    end,
}