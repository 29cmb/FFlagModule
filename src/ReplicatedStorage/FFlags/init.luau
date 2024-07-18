local FFlags = {}
FFlags.Loaded = false
FFlags.API = require(script.api)
FFlags.Config = require(script.config)
FFlags.Connected = false

function FFlags:Load()
    if self.Loaded == false then
        if self.Config:Validate() ~= true then
            warn("Load failed!")
            return false
        end

        local loaded = self.API:Load()
        if loaded == false then warn("Load failed!") 
            return false 
        end

        self.Loaded = true
        print("Loaded!")
        return self
    else
        print("FFlags is already loaded, cannot load again.")
    end
end

function FFlags:Connect()
    if self.Loaded == false then 
        warn("Flags cannot connect to API if the module has not been loaded")
        return
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
end

function FFlags:Extend()
    return self
end

return FFlags