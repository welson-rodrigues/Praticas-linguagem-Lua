local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local WALK_ANIM_NAME = "Walk"
local BUTTON_ANIM_NAME = "ataque"

-- RemoteEvent
local REMOTE_NAME = "AnimationLitePlayRemote"
local remote = ReplicatedStorage:FindFirstChild(REMOTE_NAME)
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = REMOTE_NAME
    remote.Parent = ReplicatedStorage
    print("[AnimationLite] Created RemoteEvent:", REMOTE_NAME)
end

local serviceFolder = ServerScriptService:FindFirstChild("AnimationLiteService")
local playEventBindable = serviceFolder and serviceFolder:FindFirstChild("AnimationLitePlayEvent")
if not playEventBindable then
    warn("[AnimationLite] AnimationLiteService or PlayEvent not found. Open editor and save an animation then retry.")
end

local animFolder = ServerStorage:FindFirstChild("RBX_ANIMSAVES")
if not animFolder then
    warn("[AnimationLite] RBX_ANIMSAVES not found in ServerStorage.")
end

-- Função para disparar anim no character (server-side)
local function playKeyframeOnCharacter(character, animName, speed)
    if not playEventBindable or not animFolder then return end
    local kf = animFolder:FindFirstChild(animName)
    if not kf then
        warn("[AnimationLite] KeyframeSequence not found:", animName)
        return
    end
    if not character then return end
    character:SetAttribute("AnimationLitePlaying", nil)
    local ok, err = pcall(function()
        playEventBindable:Fire(character, kf, speed or 1)
    end)
    if not ok then
        warn("[AnimationLite] Failed to fire PlayEvent:", err)
    end
end

-- Remove Animate padrão do character (caso exista)
local function removeDefaultAnimate(character)
    if not character then return end
    local animate = character:FindFirstChild("Animate")
    if animate then
        animate:Destroy()
        print("[AnimationLite] Removed default Animate from character.")
    end
end

-- Sempre que dar player remove animação padrão do player
local function onCharacterAdded(player, character)
    task.wait(0.2)
    removeDefaultAnimate(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local isWalking = false
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not character.Parent then
            conn:Disconnect()
            return
        end
        local moveMag = 0
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then moveMag = root.AssemblyLinearVelocity.Magnitude end
        -- alternativa: humanoid.MoveDirection.Magnitude
        if moveMag > 0.5 then
            if not isWalking then
                isWalking = true
                playKeyframeOnCharacter(character, WALK_ANIM_NAME, 1)
            end
        else
            if isWalking then
                isWalking = false
                -- talvez seja necessário usar a animação de parado para ficar mais fluido
                -- Exemplo: playKeyframeOnCharacter(character, "Idle", 1)
                character:SetAttribute("AnimationLitePlaying", nil)
            end
        end
    end)
end

-- Player handlers
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        onCharacterAdded(player, character)
    end)
    if player.Character then
        onCharacterAdded(player, player.Character)
    end
end)

-- RemoteEvent handler (GUI cliente pede animação por nome)
remote.OnServerEvent:Connect(function(player, animName, speed)
    if type(animName) ~= "string" then return end
    local char = player.Character
    if not char then return end
    playKeyframeOnCharacter(char, animName, speed or 1)
end)

print("[AnimationLite] Core server script running.")

