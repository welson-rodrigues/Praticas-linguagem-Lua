local Players = game:GetService("Players")
local player = Players.LocalPlayer

script.Parent.MouseButton1Click:Connect(function()
    player:Kick("Você saiu do jogo. Obrigado por jogar!")
end)
