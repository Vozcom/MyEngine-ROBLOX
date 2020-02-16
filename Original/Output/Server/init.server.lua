local ServerModules={};ServerModules.Functions={};local ReplicatedModules={};
ReplicatedModules.Functions={};math.randomseed(tick());for _,module in pairs(
game.ReplicatedStorage.Modules:GetChildren())do if module:IsA('ModuleScript')
then ReplicatedModules[module.Name]=require(module)(ReplicatedModules)end end;
for _,func in pairs(game.ReplicatedStorage.Modules.Functions:GetChildren())do
ReplicatedModules.Functions[func.Name]=require(func)end;for _,module in pairs(
script:GetChildren())do if module:IsA('ModuleScript')then ServerModules[module.
Name]=require(module)(ServerModules,ReplicatedModules)end end;for _,func in
pairs(script.Functions:GetChildren())do ServerModules.Functions[func.Name]=
require(func)end;for _,module in pairs(ReplicatedModules)do if module.Awake then
module.Awake()end end;for _,module in pairs(ServerModules)do if module.Awake
then module.Awake()end end;for _,module in pairs(ReplicatedModules)do if module.
Init and module.Enabled then module.Init()end end;for _,module in pairs(
ServerModules)do if module.Init and module.Enabled then module.Init()end end