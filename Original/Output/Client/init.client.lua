local ReplicatedModules={};ReplicatedModules.Functions={};local ClientModules={}
;ClientModules.Functions={};math.randomseed(tick());for _,module in pairs(game.
ReplicatedStorage.Modules:GetChildren())do if module:IsA('ModuleScript')then
ReplicatedModules[module.Name]=require(module)(ReplicatedModules)end end;for _,
funct in pairs(game.ReplicatedStorage.Modules.Functions:GetChildren())do
ReplicatedModules.Functions[funct.Name]=require(funct)end;for _,module in pairs(
script:GetChildren())do if module:IsA('ModuleScript')then ClientModules[module.
Name]=require(module)(ClientModules,ReplicatedModules)end end;for _,module in
pairs(ClientModules)do if module.Awake then module.Awake()end end;for _,module
in pairs(ReplicatedModules)do if module.Init then module.Init()end end;for _,
module in pairs(ClientModules)do if module.Init then module.Init()end end;for
name,module in pairs(ClientModules)do if module.EarlyUpdate then game:GetService(
'RunService'):BindToRenderStep(name..'_EU',Enum.RenderPriority.First.Value,
module.EarlyUpdate)end end;for name,module in pairs(ClientModules)do if module.
Update then game:GetService('RunService'):BindToRenderStep(name..'_U',Enum.
RenderPriority.Input.Value+1,module.Update)end end;for name,module in pairs(
ClientModules)do if module.LateUpdate then game:GetService('RunService'):
BindToRenderStep(name..'_LU',Enum.RenderPriority.Last.Value,module.LateUpdate)
end end