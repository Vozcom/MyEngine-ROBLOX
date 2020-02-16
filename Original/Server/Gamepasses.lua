local FunctionBindings = {}
return function(Modules, ReplicatedModules)

    local public = {}
    local private = {}
    public.Enabled = true

    local MPService = game:GetService('MarketplaceService')

    function private.BindGamePass(id, initFunc)
        FunctionBindings[tostring(id)] = initFunc
    end

    private.BindGamePass(954826727, function(p) -- skip stage
        
    end)

    function public.Init()
        Modules.DataManager.BindToPlayerAdded(private.PlayerJoined)
	end

    function private.PlayerJoined(player)

		local playerData = Modules.DataManager.GetPlayerData(player)
        for _, gamePassInfo in pairs(game.ServerStorage.ServerData.Gamepasses:GetChildren()) do
            
            if not playerData:OwnsGamePass(gamePassInfo.Name) then
                if MPService:UserOwnsGamePassAsync(player.UserId, tonumber(gamePassInfo.Name)) then
                    
                    playerData:AddGamePass(gamePassInfo.Name)
                    if FunctionBindings[tostring(gamePassInfo.Name)] then
                        FunctionBindings[tostring(gamePassInfo.Name)](player)
					end
				end
			else
				if FunctionBindings[tostring(gamePassInfo.Name)] then
					FunctionBindings[tostring(gamePassInfo.Name)](player)
				end
			end
		end
    end

    -- just bought a dev product
    function MPService.ProcessReceipt(receiptInfo)

		local player = game.Players:GetPlayerByUserId(receiptInfo.PlayerId)
        if player and game.ServerStorage.ServerData.DevProducts:FindFirstChild(tostring(receiptInfo.ProductId)) then
            
			local playerData = Modules.DataManager.GetPlayerData(player)
            if playerData then
                
				playerData:AddRobuxSpent(receiptInfo.CurrencySpent)
                spawn(function() Modules.DataManager.SaveData(player) end)
                
                if FunctionBindings[tostring(receiptInfo.ProductId)] then
                    FunctionBindings[tostring(receiptInfo.ProductId)](game.Players:GetPlayerByUserId(receiptInfo.PlayerId))
                end
			end
		end
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

    -- just bought a gamepass (IN GAME)
    MPService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, purchaseSuccess)
        
        local gamePass = game.ServerStorage.ServerData.Gamepasses:FindFirstChild(tostring(gamePassId))
        if purchaseSuccess and gamePass then
            
			Modules.DataManager.GetPlayerData(player):AddGamePass(gamePassId)
			if FunctionBindings[tostring(gamePassId)] then
                FunctionBindings[tostring(gamePassId)](player)
			end
		end
	end)
    return public
end