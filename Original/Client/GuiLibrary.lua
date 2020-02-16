return function(Modules, ReplicatedModules)

	local public = {}
    local GameGui
    
	function public.Awake()
        GameGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("GameGui")
	end
	function public.GetGameGui()
		repeat wait() until GameGui
		return GameGui
	end
	return public
end