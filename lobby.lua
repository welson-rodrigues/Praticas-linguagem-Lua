-- 

local Timer = 10  -- Troque Pelo tempo que tu quiser 
local PartidaDura = 20 -- O tempo que cada partida vai durar
local Map
while true do
    if game.ReplicatedStorage.Partida.Value == true then wait() -- nada
    else
        wait(1)
        
        Timer = Timer -1
        if Timer == 0 then
            print("Chego a zero")
            game.ReplicatedStorage.Partida.Value = true
            
            Map = game.ServerStorage.Mapas:FindFirstChild(math.random(1,#game.ServerStorage.Mapas: GetChildren())):Clone()
            Map.Parent = workspace
            game.Debris:AddItem(Map, PartidaDura+1)
            spawn(function()
                wait(PartidaDura)
                Timer = 10 -- O Timer após a partida
                print("Recomeçando")
                game.ReplicatedStorage.Partida.Value = false
            end)
            
            
        end
        
        
        for _, plrs in pairs(game.Players:GetChildren()) do
            if plrs:IsA("Player") then
                if Timer == 0 then
                    plrs.PlayerGui.Timer.Tempo.Text = "Starting..."
                    local SpawnAC = 3 -- Quantidade de Spawn que tem em todos os mapas
                    plrs.Character.HumanoidRootPart.CFrame = Map: FindFirstChild("Spawn"..math.random(1,SpawnAC)).CFrame
                    spawn(function()
                        wait(0.4)
                        plrs.PlayerGui.Timer.Enabled = false 
                        wait(PartidaDura)
                        if workspace:FindFirstChild("Lobby") then
                            plrs.Character.HumanoidRootPart.CFrame = workspace.Lobby.SpawnLocation.CFrame 
                        else
                            plrs.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame
                        end
                    end)
                else
                    plrs.PlayerGui.Timer.Enabled = true
                    plrs.PlayerGui.Timer.Tempo.Text=Timer.."s"
                end
            end
        end
    end
    
    
    
    
    
    
end