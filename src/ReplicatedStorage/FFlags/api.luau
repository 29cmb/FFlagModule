local api = {}
local HttpService = game:GetService("HttpService")

function api:Load()
    api = require(script.Parent):Extend()
    function api:Connect()
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

        return self
    end
end

function api:Connect()
   warn("Cannot connect until api is loaded")
   return false
end

return api