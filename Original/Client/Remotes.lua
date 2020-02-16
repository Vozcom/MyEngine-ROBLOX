local required = false
return function(Modules, ReplicatedModules)

    if not required then

        required = true
        local public = {}
        local private = {}

        local FireRequests = {}
        local FireQueue = {}
        local BusyQueuing = {}

        function public.Awake()
            game.ReplicatedStorage.Remotes.Connect:FireServer()
            private.Index, private.Server = game.ReplicatedStorage.Remotes.Connect.OnClientEvent:Wait()
        end
        function public.Start()
			game.ReplicatedStorage.Remotes.Connect:FireServer(true)
        end
        
        function public.Bind(tag, func)
            if private.Server[tag] then
                private.Server[tag].RemoteEvent.OnClientEvent:connect(func)
            end
        end

        function public.Fire(tag, ...)
            local extraData
            if private.Index[tag] and not FireRequests[tag] then

                FireRequests[tag] = true
                private.Index[tag].Key, extraData = private.Index[tag].RemoteFunction:InvokeServer(private.Index[tag].Key, ...)
                FireRequests[tag] = false
            end
            return extraData
        end

        function public.FireQueued(tag, ...)

            if not FireQueue[tag] then FireQueue[tag] = {} end
            table.insert(FireQueue[tag], {...})

            if not BusyQueuing then
                spawn(function()

                    BusyQueuing = true
                    while #(FireQueue[tag]) > 0 do

                        if private.Index[tag] then
                            
                            private.Index[tag].Key = private.Index[tag].RemoteFunction:InvokeServer(private.Index[tag].Key, unpack(FireQueue[tag][1]))
                            table.remove(FireQueue[tag], 1)
                        end
                    end
                    BusyQueuing = false
                end)
            end
        end
        return public
    else
        while true do
            -- crashed
        end
    end
end