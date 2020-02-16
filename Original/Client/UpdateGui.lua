return function(Modules, ReplicatedModules)

	local public = {}
	local private = {}

	local PlayerData = {}
	local Bindings = {}

	local GameGui

	function public.Awake()
		GameGui = Modules.GuiLibrary.GetGameGui()
	end

	function public.Init() -- on join

		Modules.Remotes.Bind("UpdateStats", private.UpdateStats)

		local s = ReplicatedModules.Functions.SetGameSettings(Modules, ReplicatedModules)
		s.InventoryEnabled()
		s.TopBarTransparency()
		s.ShiftToSprint()
	end

	function private.UpdateStats(stats)

		assert(type(stats) == "table", "Data sent from server must be a table to be updated")
		for key, value in pairs(stats) do
			PlayerData[key] = value
		end
		for key, value in pairs(stats) do
			if Bindings[key] then
				for _, f in pairs(Bindings[key]) do
					f(value)
				end
			end
		end
		-- update stat functions below
	end
	function public.GetPlayerData()
		return PlayerData
	end
	function private.Bind(key, func)
		if not Bindings[key] then
			Bindings[key] = {}
		end
		table.insert(Bindings[key], func)
	end	
	return public
end