local Players             = game:GetService("Players")
local MarketplaceService  = game:GetService("MarketplaceService")
local player              = Players.LocalPlayer

-- IDs das Gamepasses
local gamepassIDs = {
    M60 = 1226110219,
    PC = 1227792745
}

local screenGui = script.Parent

-- Botão principal "LOJA"
local lojaBotao = Instance.new("TextButton")
lojaBotao.Name                  = "LojaBotao"
lojaBotao.Size                  = UDim2.new(0, 120, 0, 40)
lojaBotao.Position              = UDim2.new(0, 10, 0, 50)
lojaBotao.BackgroundColor3      = Color3.fromRGB(0, 170, 0)
lojaBotao.Text                  = "LOJA"
lojaBotao.TextColor3            = Color3.new(1,1,1)
lojaBotao.Font                  = Enum.Font.SourceSansBold
lojaBotao.TextSize              = 20
lojaBotao.Parent                = screenGui
Instance.new("UICorner", lojaBotao).CornerRadius = UDim.new(0, 12)

-- Frame dos botões secundários
local menuSecundario = Instance.new("Frame")
menuSecundario.Name             = "MenuSecundario"
menuSecundario.Size             = UDim2.new(0, 120, 0, 80)
menuSecundario.Position         = UDim2.new(0, 140, 0, 50)
menuSecundario.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
menuSecundario.Visible          = false
menuSecundario.Parent           = screenGui
Instance.new("UICorner", menuSecundario).CornerRadius = UDim.new(0, 12)

-- Criar botões de arma
local armas = {"M60", "PC"}
local botoes = {}

for i, nome in ipairs(armas) do
    local btn = Instance.new("TextButton")
    btn.Name                  = nome
    btn.Text                  = nome
    btn.Size                  = UDim2.new(1, -10, 0, 30)
    btn.Position              = UDim2.new(0, 5, 0, (i-1)*35 + 5)
    btn.BackgroundColor3      = Color3.fromRGB(70, 70, 70)
    btn.TextColor3            = Color3.new(1,1,1)
    btn.Font                  = Enum.Font.SourceSansBold
    btn.TextSize              = 16
    btn.Parent                = menuSecundario
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    botoes[nome] = btn
end

-- Submenu de compra
local compraFrame = Instance.new("Frame")
compraFrame.Name               = "SubmenuCompra"
compraFrame.Size               = UDim2.new(0, 200, 0, 80)
compraFrame.Position           = UDim2.new(0, 270, 0, 50)
compraFrame.BackgroundColor3   = Color3.fromRGB(50, 50, 50)
compraFrame.Visible            = false
compraFrame.Parent             = screenGui
Instance.new("UICorner", compraFrame).CornerRadius = UDim.new(0, 12)

local label = Instance.new("TextLabel")
label.Name                     = "Info"
label.Size                     = UDim2.new(1, -20, 0, 30)
label.Position                 = UDim2.new(0, 10, 0, 5)
label.BackgroundTransparency   = 1
label.TextColor3               = Color3.new(1,1,1)
label.Font                     = Enum.Font.SourceSansBold
label.TextSize                 = 18
label.Text                     = ""
label.Parent                   = compraFrame

local botaoComprar = Instance.new("TextButton")
botaoComprar.Name              = "BotaoComprar"
botaoComprar.Size              = UDim2.new(0, 180, 0, 35)
botaoComprar.Position          = UDim2.new(0, 10, 0, 40)
botaoComprar.BackgroundColor3  = Color3.fromRGB(0, 170, 0)
botaoComprar.Text              = "Comprar"
botaoComprar.TextColor3        = Color3.new(1,1,1)
botaoComprar.Font              = Enum.Font.SourceSansBold
botaoComprar.TextSize          = 20
botaoComprar.Parent            = compraFrame
Instance.new("UICorner", botaoComprar).CornerRadius = UDim.new(0, 8)

-- Abre/fecha menu
local aberto = false
lojaBotao.MouseButton1Click:Connect(function()
    aberto = not aberto
    menuSecundario.Visible = aberto
    compraFrame.Visible    = false
end)

-- Seleciona arma e mostra botão de compra
for nome, btn in pairs(botoes) do
    btn.MouseButton1Click:Connect(function()
        label.Text         = "Comprar: " .. nome
        botaoComprar.Name  = nome
        compraFrame.Visible = true
    end)
end

-- Ao clicar em "Comprar", abre PromptGamePassPurchase
botaoComprar.MouseButton1Click:Connect(function()
    local nome       = botaoComprar.Name
    local gamepassId = gamepassIDs[nome]
    if gamepassId then
        MarketplaceService:PromptGamePassPurchase(player, gamepassId)
    else
        warn("Gamepass não configurada para: " .. nome)
    end
end)
