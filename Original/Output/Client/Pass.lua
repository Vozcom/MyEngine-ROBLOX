return function(Modules,ReplicatedModules)local public={};local private={};local
MPService=game:GetService('MarketplaceService');public.BuyGamepass=function(ID)
MPService:PromptGamePassPurchase(game.Players.LocalPlayer,ID)end;public.
BuyProduct=function(ID)MPService:PromptProductPurchase(game.Players.LocalPlayer,
ID)end;return public;end;