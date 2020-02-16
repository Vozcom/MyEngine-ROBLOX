return function(Modules, ReplicatedModules)

    local public = {}
    local private = {}
    local BadgeService = game:GetService("BadgeService")

    function private.checkifhas(p, badgeId)
        if not BadgeService:IsLegal(badgeId) and BadgeService:IsDisabled(badgeId) then
            return false
        else
            if not BadgeService:UserHasBadge(p.UserId, BadgeId) then
                return false
            else
                return true
            end
		end
    end
    function public.getBadge(p, badgeId)
        if private.checkifhas(p, badgeId) then
            BadgeService:AwardBadge(p.UserId, badgeId)
        end
    end
    return public
end