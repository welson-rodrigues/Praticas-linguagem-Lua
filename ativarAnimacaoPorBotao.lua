-- StarterGui > ScreenGui > Button > LocalScript
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local remote = ReplicatedStorage:WaitForChild("AnimationLitePlayRemote")
local button = script.Parent

button.MouseButton1Click:Connect(function()
    -- pede ao servidor para tocar a animação "ataque"
    remote:FireServer("ataque", 1)
end)

