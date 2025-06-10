-- Script by AbxStudio
local spawner = script.Parent -- Reference to the spawner part
local storage = game:GetService("ServerStorage") -- Change to ServerStorage if using ServerStorage
local zombieTemplate = storage:FindFirstChild("Zombie") -- Reference to the template model
local spawnInterval = 3 -- Time between spawns (in seconds)
 
if not zombieTemplate then
    warn("Zombie template not found in storage!")
    return
end
 
while true do
    -- Clone the zombie model
    local newZombie = zombieTemplate:Clone()
    newZombie.Parent = workspace -- Move the cloned zombie to the workspace
    
    -- Position the zombie at the spawner's location
    if newZombie.PrimaryPart then
        newZombie:SetPrimaryPartCFrame(spawner.CFrame)
    else
        warn("Zombie model does not have a PrimaryPart set!")
    end
    
    -- Wait for the spawn interval
    wait(spawnInterval)
end
