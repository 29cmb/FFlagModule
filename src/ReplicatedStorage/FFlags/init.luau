local FFlags = {}
FFlags.Loaded = false
FFlags.API = require(script.api)
FFlags.Config = require(script.config)
FFlags.Connected = false

function FFlags:Load()
    if self.Loaded == false then
        self.API:Load()
        self.Loaded = true
    else
        print("FFlags is already loaded, cannot load again.")
    end

    return self
end

function FFlags:Connect()
    if self.Loaded == false then 
        self:Load()
    end
    
    local success, connection = pcall(function() 
        return self.API:Connect()
    end)

    if success and connection ~= false then
        print("Connected to API successfully")
        self.Connected = true
        self.Connection = connection
        return connection
    end
    
    return self
end

function FFlags:Extend()
    return self
end

return FFlags