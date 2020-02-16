return function(Modules, ReplicatedModules)

    local public = {}
    local private = {}

    function public.Animation(frame, info)

		local TweenService = game:GetService('TweenService')
		local tInfo = TweenInfo.new(info.Timer, Enum.EasingStyle[info.Style], Enum.EasingDirection[info.Direction], 0)
		
		local animation = TweenService:create(frame, tInfo, info.Goal)
		return animation:Play()
    end
    
    function public.Particles()

		local TService = game:GetService('TweenService')
		local container = game.Players.LocalPlayer.PlayerGui.Particles
		for i = 1, 35 do

			local new = container.example:Clone()
			new.Parent = container.Storage
			new.Name = 'NewParticle'
			new.Visible = true

			new.ImageColor3 = Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255))
			local x = math.random(0, 1000)/1000
			new.Position = UDim2.new(x, 0, 1, 0)

			local xVec = math.random(-200, 200)/1000
			local yVec = math.random(100, 900)/1000
			local tInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)

			local info = {}
			info.ImageTransparency = 1
			info.Rotation = 360
			info.Position = UDim2.new(x+xVec, 0, yVec, 0)

			local ts = TService:create(new, tInfo, info)
			ts:Play()
		end
	end
    return public
end