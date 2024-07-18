local api = {}
local HttpService = game:GetService("HttpService")

function api:Load()
    api = require(script.Parent):Extend()
    function api:Connect()
        local url = self.Config.BASE_API_URL
        if not string.match(url, "^(https?)://[%w-_]+%.[%w-_]+/?[%w-_/%.%?&=]*$") then 
            warn("API could not connect: Invalid URL structure")
            return false
        end
    
        return {}
    end
end

function api:Connect()
   warn("Cannot connect until api is loaded")
   return false
end

return api