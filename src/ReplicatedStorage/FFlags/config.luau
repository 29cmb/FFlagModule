local config = {
    BASE_API_URL = "https://flags.devcmb.hackclub.app"
}
local HttpService = game:GetService("HttpService")

function config:Validate()
    local success, conf = pcall(function()
        return HttpService:GetAsync("https://flags.devcmb.hackclub.app/api/frontends/config") -- my own api
    end)

    if not success or not conf then return true end -- if my server sucks, just pass along the configuration
    conf = HttpService:JSONDecode(conf)

    for _,configItem in pairs(conf.data) do 
        if self[configItem] == nil then 
            warn(configItem .. " is not present in the configuration")
            return false
        end
    end

    return true
end

return config