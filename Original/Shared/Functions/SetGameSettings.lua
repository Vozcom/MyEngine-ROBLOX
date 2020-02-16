local Players = game:GetService('Players')
local MPService = game:GetService('MarketplaceService')

return function(Modules, ReplicatedModules, p)

    local public = {}
    local private = {}
    local s = require(game.ReplicatedStorage.DefaultSettings)

    public.getCollision = function()

        local PhysService = game:GetService('PhysicsService')
        PhysService:CollisionGroupSetCollidable('p', 'p', s.CollisionPlayers)

        if s.CollisionPlayers then
            return
        else
            for k, v in pairs(p.Character:GetChildren()) do
                if v:IsA('BasePart') then
                    PhysService:SetPartCollisionGroup(v, 'p')
                end
            end
        end
    end

    public.BubbleChat = function()
        if not s.BubbleChat then
            return
        else
            game.Players:SetChatStyle(Enum.ChatStyle.ClassicAndBubble)
        end
    end

    public.InventoryEnabled = function()
        if s.InventoryEnabled then
            return
        else
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
        end
    end
    public.TopBarTransparency = function()
        Players.LocalPlayer:WaitForChild('PlayerGui'):SetTopbarTransparency(s.TopBarTransparency)
    end
    public.Speed = function()
        p.Character.Humanoid.WalkSpeed = s.Speed
    end

    public.ShiftToSprint = function()

        if not s.ShiftToSprint then
            return
        else
            local character = Players.LocalPlayer.Character
            local Mouse = Players.LocalPlayer:GetMouse()
            Mouse.KeyDown:connect(function(key)
                if key == tostring(0) then
                    character.Humanoid.WalkSpeed = s.Speed + 15
                end
            end)
            Mouse.KeyUp:connect(function(key)
            
                if key == tostring(0) then
                    character.Humanoid.WalkSpeed = s.Speed
                end
            end)
        end
    end
    return public
end