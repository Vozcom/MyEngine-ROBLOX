local ReplicatedModules = {}
ReplicatedModules.Functions = {}

local ClientModules = {}
ClientModules.Functions = {}

math.randomseed(tick())

-- add replicated modules
for _, module in pairs(game.ReplicatedStorage.Modules:GetChildren()) do
    if module:IsA('ModuleScript') then
        ReplicatedModules[module.Name] = require(module)(ReplicatedModules)
    end
end
for _, funct in pairs(game.ReplicatedStorage.Modules.Functions:GetChildren()) do
    ReplicatedModules.Functions[funct.Name] = require(funct)
end

-- add all public tables
for _, module in pairs(script:GetChildren()) do
    if module:IsA('ModuleScript') then
        ClientModules[module.Name] = require(module)(ClientModules, ReplicatedModules)
    end
end

-- run the awake code
for _, module in pairs(ClientModules) do
	if module.Awake then
		module.Awake()
	end
end

-- Run the init code
for _, module in pairs(ReplicatedModules) do
	if module.Init then
		module.Init()
	end
end
for _, module in pairs(ClientModules) do
	if module.Init then
		module.Init()
	end
end

-- BindToRenderStep before anything
for name, module in pairs(ClientModules) do
	if module.EarlyUpdate then
		game:GetService("RunService"):BindToRenderStep(name .. "_EU", Enum.RenderPriority.First.Value, module.EarlyUpdate)
	end
end
-- BindToRenderStep after input
for name, module in pairs(ClientModules) do
	if module.Update then
		game:GetService("RunService"):BindToRenderStep(name .. "_U", Enum.RenderPriority.Input.Value + 1, module.Update)
	end
end
-- BindToRenderStep as last
for name, module in pairs(ClientModules) do
	if module.LateUpdate then
		game:GetService("RunService"):BindToRenderStep(name .. "_LU", Enum.RenderPriority.Last.Value, module.LateUpdate)
	end
end