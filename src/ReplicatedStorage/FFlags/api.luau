local api = {}
local HttpService = game:GetService("HttpService")

function api:Load()
    api = require(script.Parent):Extend()
    function api:Connect()
        local apiConnection = {}

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

        function apiConnection:SetFFlagValue(flag, value)
            local success, data = pcall(function() 
                return HttpService:PostAsync(url .. "/api/set", HttpService:JSONEncode({
                    ["flag"] = flag, ["value"] = value
                }))
            end)
            if not success then 
                warn("Failed to set FFlag value: " .. err)
            end

            return success
        end

        function apiConnection:SetFFlagValueAsync(flag, value)
            return self:SetFFlagValue(flag, value)
        end

        return apiConnection
    end
end

return api