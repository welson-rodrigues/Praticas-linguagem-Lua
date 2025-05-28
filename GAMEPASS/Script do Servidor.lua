local Players            = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ServerStorage      = game:GetService("ServerStorage")

-- IDs das Gamepasses
local gamepassIDs = {
    M60 = 1235092283,
    PC = 1235042314
}

-- Clona e entrega a ferramenta ao Backpack
local function darArma(player, nome)
    local backpack = player:FindFirstChild("Backpack")
    local armaModel = ServerStorage:FindFirstChild(nome)
    if backpack and armaModel then
        armaModel:Clone().Parent = backpack
    end
end

-- Verifica todas as Gamepasses e entrega armas
local function verificarEEntregar(player)
    for nome, id in pairs(gamepassIDs) do
        local sucesso, temPasse = pcall(function()
            return MarketplaceService:UserOwnsGamePassAsync(player.UserId, id)
        end)
        if sucesso and temPasse then
            darArma(player, nome)
        end
    end
end

-- Quando o jogador entra / renasce
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        verificarEEntregar(player)
    end)
end)

-- Logo após a compra concluída
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassID, comprado)
    if comprado then
        for nome, id in pairs(gamepassIDs) do
            if id == gamePassID then
                darArma(player, nome)
            end
        end
    end
end)
