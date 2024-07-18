local types = {}

export type FFlag = {
    Load: (self: FFlag) -> nil,
    Connect: (self: FFlag) -> nil,
    Extend: (self: FFlag) -> FFlag
}

export type UnloadedAPI = {
    Load: (self: UnloadedAPI) -> API
}

export type API = FFlag & {
    Connect: (self: API) -> APIConnection
}

export type APIConnection = {
    CreateFFlag: (self: APIConnection, flag: string, value: any) -> boolean,
    CreateFFlagAsync: (self: APIConnection, flag: string, value: any) -> nil,
    SetFFlagValue: (self: APIConnection, flag: string, value: any) -> boolean,
    SetFFlagValueAsync: (self: APIConnection, flag: string, value: any) -> nil,
    GetFlags: (self: APIConnection) -> {
        {flag: string, value: any, locked: boolean}
    },
    GetFFlagValue: (self: APIConnection, flag: string) -> any
}

return types