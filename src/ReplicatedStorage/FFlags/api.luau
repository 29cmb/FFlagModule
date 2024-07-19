--!nocheck
local Types = require(script.Parent.types)
local api = {} :: (Types.UnloadedAPI)
local HttpService = game:GetService("HttpService")

function api:Load()
    api  = require(script.Parent):Extend() :: (Types.API)
    function api:Connect()
        local apiConnection = {} :: Types.APIConnection

        local url = self.Config.BASE_API_URL
        if not url or not string.match(url, "^(https?)://[%w-_]+%.[%w-_]+/?[%w-_/%.%?&=]*$") then 
            warn("API could not connect: Invalid URL structure")
            return false
        end

        local success, err = pcall(function()
            HttpService:GetAsync(self.Config.BASE_API_URL)
        end)

        if not success or err then 
            warn("API could not connect: " .. err)
            return false
        end

        function apiConnection:CreateFFlag(flag, value)
            local success, data = pcall(function() 
                return HttpService:PostAsync(url .. "/api/create", HttpService:JSONEncode({
                    ["flag"] = flag, ["value"] = value
                }))
            end)

            if not success then 
                warn("Failed to create FFlag: " .. err)
                return false
            end

            return success
        end

        function apiConnection:CreateFFlagAsync(flag, value)
            task.spawn(function()
                self:CreateFFlag(flag, value)
            end)
        end

        function apiConnection:SetFFlagValue(flag, value)
            local success, data = pcall(function() 
                return HttpService:PostAsync(url .. "/api/set", HttpService:JSONEncode({
                    ["flag"] = flag, ["value"] = value
                }))
            end)
            if not success then 
                warn("Failed to set FFlag value: " .. data)
                return false
            end

            return success
        end

        function apiConnection:SetFFlagValueAsync(flag, value)
            task.spawn(function()
                self:SetFFlagValue(flag, value)
            end)
        end

        function apiConnection:GetFlags()
            local success, data = pcall(function() 
                return HttpService:GetAsync(url .. "/api/flags")
            end)

            if not success then 
                warn("Failed to get FFlags: " .. data)
                return false
            end

            return HttpService:JSONDecode(data).data
        end

        function apiConnection:GetFlagLogs()
            local success, data = pcall(function() 
                return HttpService:GetAsync(url .. "/api/logs")
            end)

            if not success then 
                warn("Failed to get logs: " .. data)
                return false
            end

            return HttpService:JSONDecode(data).data
        end

        function apiConnection:GetFFlagValue(flag)
            local success, data = pcall(function() 
                return HttpService:PostAsync(url .. "/api/get", HttpService:JSONEncode({
                    ["flag"] = flag
                }, Enum.HttpContentType.ApplicationJson))
            end)

            if not success then 
                warn("Failed to get FFlag: " .. err)
                return false
            end

            return HttpService:JSONDecode(data).value
        end

        function apiConnection:LockFFlag(flag)
            local success, data = pcall(function() 
                return HttpService:PostAsync(url .. "/api/lock", HttpService:JSONEncode({
                    ["flag"] = flag
                }))
            end)

            if not success then 
                warn("Failed to lock FFlag: " .. err)
                return false
            end

            return success
        end

        function apiConnection:LockFFlagAsync(flag) 
            task.spawn(function()
                self:LockFFlag(flag)
            end)
        end

        function apiConnection:UnlockFFlag(flag)
            local success, data = pcall(function() 
                return HttpService:PostAsync(url .. "/api/unlock", HttpService:JSONEncode({
                    ["flag"] = flag
                }))
            end)

            if not success then 
                warn("Failed to unlock FFlag: " .. err)
                return false
            end

            return success
        end

        function apiConnection:UnlockFFlagAsync(flag) 
            task.spawn(function()
                self:UnlockFFlag(flag)
            end)
        end

        return apiConnection
    end
end

return api