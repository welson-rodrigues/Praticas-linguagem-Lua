local tool = script.Parent

local ServiceFolder = game.ServerScriptService:WaitForChild("AnimationLiteService")
local PlayEvent = ServiceFolder:WaitForChild("AnimationLitePlayEvent")
local AnimFolder = game.ServerStorage:WaitForChild("RBX_ANIMSAVES")
local KeyframeSequence = AnimFolder:WaitForChild("testeLindo")

tool.Activated:Connect(function()
    local character = tool.Parent
    
    if character and character:FindFirstChild("Humanoid") then        

        PlayEvent:Fire(
            character,       
            KeyframeSequence, 
            1 
        )
    end
end)
