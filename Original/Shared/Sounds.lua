return function(Modules, ReplicatedModules)

    local public = {}
    local private = {}

    function public.getsound(soundpath, switch)

        if soundpath then
            if not switch then
                soundpath:Play()
            else
                switch[1]:Stop()
                if not switch[2].Playing then 
                    switch[2]:Play()
                end
            end
        else
            print('Unknown path for the sound!')
        end
	end
    return public
end