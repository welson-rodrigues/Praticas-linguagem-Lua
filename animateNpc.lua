local animateScript = script
local humanoid = animateScript.Parent:WaitForChild("Humanoid")

local function loadAnim(name, id)
    local anim = Instance.new("Animation")
    anim.Name = name
    anim.AnimationId = "rbxassetid://" .. id
    return humanoid:LoadAnimation(anim)
end

local walkAnim = loadAnim("WalkAnim", 180426354) -- animação de andar R6
local jumpAnim = loadAnim("JumpAnim", 128777973)  -- animação de pulo R6

-- Ativar animação de andar
humanoid.Running:Connect(function(speed)
    if speed > 0 then
        if not walkAnim.IsPlaying then
            walkAnim:Play()
        end
    else
        walkAnim:Stop()
    end
end)

-- Ativar animação de pulo
humanoid.Jumping:Connect(function()
    jumpAnim:Play()
end)
