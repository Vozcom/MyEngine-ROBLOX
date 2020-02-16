return function(Modules, ReplicatedModules)

	local public = {}
	public.__index = public
    public.Enabled = true
   
    local PlayerDataTemplate = {
        
        Coins = 0,
        RobuxSpent = 0,
        Gamepasses = {},
    }
    
    function public:New(player, encodedData)

		local data = {}
		if encodedData and typeof(encodedData) == "string" then
			data = game:GetService("HttpService"):JSONDecode(encodedData)
		end

		local tempdata = ReplicatedModules.DeepCopy.Copy(PlayerDataTemplate)
		data = ReplicatedModules.DeepCopy.Merge(tempdata, data)
		data.Player = player

		setmetatable(data, self)
		return data
    end

    function public:AddCash(amount)
        self.Coins = self.Coins + amount
	end
    
    function public:AddRobuxSpent(amount)
		self.RobuxSpent = self.RobuxSpent + amount
	end

	function public:OwnsGamePass(id)
		return self.Gamepasses[tostring(id)]
	end

	function public:AddGamePass(id)
		if not self:OwnsGamePass(id) then
			self.Gamepasses[tostring(id)] = true
		end
    end

    function public:PackNeededData(indexesWanted)
		local neededData = {}
        for _, index in pairs(indexesWanted) do
            
			if self[index] then
				neededData[index] = self[index]
			else
				error("Tried to pack an unexisting index")
			end
		end
		return neededData
	end
    
    function public:GetSaveData()
		return game:GetService("HttpService"):JSONEncode(self)
    end
    return public
end