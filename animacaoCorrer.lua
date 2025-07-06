-- READY ME IF YOU NOT BLIND 👁️‍🗨️❌⚠️⚠️⚠️⚠️
 
-- Put this Script in ServerScriptService ⚠️
-- Animator Script 📝🔥
-- Made by Kuro Lite 😎
-- This is Animation version 📝 , if you want the no Animation version to Animate then you pick the wrong one 🤓☝️
-- Btw you still able to Animate on this if your brain too lazy 🤔
-- Here how you can animate ⚠️📝
-- Scrolling down until you see these Animation 1 , Animation 2 , Animation 3
-- Look at the script: 👁️‍🗨️
-- " RootJoint " is " Torso " 📝
-- " Neck " is " Head " 📝
-- " LeftShoulder " and " RightShoulder " is " Arm " 📝
-- " LeftHip " and " RightHip " is " Leg " 📝
-- Next is Position and Rotate ⚠️
-- "Cframe.New( 0 , 0 ,0 ) "  This is Position , you can change the number in there and it will change the position of body part you're Animate 📝
-- "Cframe.Angles( 0 ,0 ,0 ) "  This is Rotate , you can change the number in there and it will change the Angle just like you're rotating the body part you Animate 📝
-- And ye that how you can Animate your own Animation, if you still cannot understand it then you can use the Animation version that i made 📝
 
 
 
local RunService = game:GetService("RunService")
local TransitionSpeed = 0.03 -- Changing the Smooth of Animation 📝
local AnimationSpeeds = {
Animation1 = 1.2, -- Animation 1 speed 📝
Animation2 = 2,   -- Animation 2 speed 📝
Animation3 = 5    -- Animation 3 speed 📝
}
local function lerp(a, b, t)
    return a:Lerp(b, t)
end
 
local function applyAnimations(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local torso = character:FindFirstChild("Torso")
    local head = character:FindFirstChild("Head")
    local leftArm = character:FindFirstChild("Left Arm")
    local rightArm = character:FindFirstChild("Right Arm")
    local leftLeg = character:FindFirstChild("Left Leg")
    local rightLeg = character:FindFirstChild("Right Leg")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoidRootPart and torso and head and leftArm and rightArm and leftLeg and rightLeg and humanoid then
        
        local rootJoint = humanoidRootPart:FindFirstChild("RootJoint")
        local neck = torso:FindFirstChild("Neck")
        local leftShoulder = torso:FindFirstChild("Left Shoulder")
        local rightShoulder = torso:FindFirstChild("Right Shoulder")
        local leftHip = torso:FindFirstChild("Left Hip")
        local rightHip = torso:FindFirstChild("Right Hip")
        
        if rootJoint and neck and leftShoulder and rightShoulder and leftHip and rightHip then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            
            -- Animation 1 📝 , This is Idle Animation 📝
            local Animation1 = {
            Pose1 = {
            RootJoint = rootJoint.C0 * CFrame.new(0, 0.1, 0.1) * CFrame.Angles(-0.1, 0, 0),
            Neck = neck.C0 * CFrame.new(0, 0, 0) * CFrame.Angles(0.2, 0, 0),
            LeftShoulder = leftShoulder.C0 * CFrame.new(0, 0, 0) * CFrame.Angles(-0.3, 0, 0),
            RightShoulder = rightShoulder.C0 * CFrame.new(0, 0, 0) * CFrame.Angles(-0.3, 0, 0),
            LeftHip = leftHip.C0 * CFrame.new(-0.1, -0.05, 0.01) * CFrame.Angles(-0.05, 0, 0.2),
            RightHip = rightHip.C0 * CFrame.new(0.1, -0.05, 0.01) * CFrame.Angles(-0.05, 0, -0.2),
            },
            Pose2 = {
            RootJoint = rootJoint.C0 * CFrame.new(0, 0.02, 0.05) * CFrame.Angles(0, 0, 0),
            Neck = neck.C0 * CFrame.new(0, 0, 0) * CFrame.Angles(-0.1, 0, 0),
            LeftShoulder = leftShoulder.C0 * CFrame.new(0, 0, 0.01) * CFrame.Angles(0, 0, 0),
            RightShoulder = rightShoulder.C0 * CFrame.new(0, 0, 0.01) * CFrame.Angles(0, 0, 0),
            LeftHip = leftHip.C0 * CFrame.new(-0.1, -0, 0.01) * CFrame.Angles(-0.025, 0, 0.1),
            RightHip = rightHip.C0 * CFrame.new(0.1, -0, 0.01) * CFrame.Angles(-0.025, 0, -0.1),
            }
            }
            -- Animation 2 📝 , This is Running Animation 📝
            local Animation2 = {
            Pose1 = {
            RootJoint = rootJoint.C0 * CFrame.new(0, 0, -0.1) * CFrame.Angles(0.5, -0.05, 0),
            Neck = neck.C0 * CFrame.Angles(0.05, 0, 0),
            LeftShoulder = leftShoulder.C0 * CFrame.new(-0.5, 0, -0.025) * CFrame.Angles(-0.3, 0, 0),
            RightShoulder = rightShoulder.C0 * CFrame.new(-0.5, 0, 0.025) * CFrame.Angles(-0.3, 0, 0),
            LeftHip = leftHip.C0 * CFrame.new(-0.4, 0.3, 0.1) * CFrame.Angles(-0.1, 0, 0),
            RightHip = rightHip.C0 * CFrame.new(0.4, 0.3, -0.1) * CFrame.Angles(-0.1, 0, 0),
            },
            Pose2 = {
            RootJoint = rootJoint.C0 * CFrame.new(0, 0, -0.1) * CFrame.Angles(0.5, 0.05, 0),
            Neck = neck.C0 * CFrame.Angles(-0.5, 0, 0),
            LeftShoulder = leftShoulder.C0 * CFrame.new(0.5, 0, 0.025) * CFrame.Angles(-0.3, 0, 0),
            RightShoulder = rightShoulder.C0 * CFrame.new(0.5, 0, -0.025) * CFrame.Angles(-0.3, 0, 0),
            LeftHip = leftHip.C0 * CFrame.new(-0.4, 0.3, -0.1) * CFrame.Angles(-0, 0, 0),
            RightHip = rightHip.C0 * CFrame.new(0.4, 0.3, 0.1) * CFrame.Angles(-0, 0, 0),
            }
            }
            -- Animation 3 📝 , This is Jump Animation 📝              
            local Animation3 = {
            Pose1 = {
            RootJoint = rootJoint.C0 * CFrame.new(0, 0.2, 0) * CFrame.Angles(0.1, 0, 0),
            Neck = neck.C0 * CFrame.Angles(-0.1, 0, 0),
            LeftShoulder = leftShoulder.C0 * CFrame.new(0, 0.2, -0.1) * CFrame.Angles(-0.3, 0, 0.3),
            RightShoulder = rightShoulder.C0 * CFrame.new(0, 0.2, -0.1) * CFrame.Angles(-0.3, 0, -0.3),
            LeftHip = leftHip.C0 * CFrame.new(-1, 0.6, 0) * CFrame.Angles(0, 0, 0.5),
            RightHip = rightHip.C0 * CFrame.new(1, 0.3, 0) * CFrame.Angles(0, 0, 0.5),
            },
            Pose2 = {
            RootJoint = rootJoint.C0 * CFrame.new(0, 0.2, 0) * CFrame.Angles(0.2, 0, 0),
            Neck = neck.C0 * CFrame.Angles(-0.1, 0, 0),
            LeftShoulder = leftShoulder.C0 * CFrame.new(0, 0.3, -0.15) * CFrame.Angles(-0.4, 0, 0.4),
            RightShoulder = rightShoulder.C0 * CFrame.new(0, 0.3, -0.15) * CFrame.Angles(-0.4, 0, -0.4),
            LeftHip = leftHip.C0 * CFrame.new(0, -0, 0) * CFrame.Angles(0, 0, 0),
            RightHip = rightHip.C0 * CFrame.new(0, -0, 0) * CFrame.Angles(0, 0, 0),
            }
            }
            
            local time = 0
            local currentPose = "Pose1"
            local activeAnimation = Animation1 -- Default to Animation1
            
            RunService.Heartbeat:Connect(function(deltaTime)
                local animationSpeed = AnimationSpeeds[activeAnimation == Animation1 and "Animation1" or (activeAnimation == Animation2 and "Animation2" or "Animation3")]
                time = time + deltaTime * animationSpeed
                
                if time >= 1 then
                    time = 0
                    currentPose = (currentPose == "Pose1") and "Pose2" or "Pose1"
                end
                
                if humanoid:GetState() == Enum.HumanoidStateType.Freefall or humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                    activeAnimation = Animation3
                elseif humanoid.MoveDirection.Magnitude > 0 then
                    activeAnimation = Animation2
                else
                    activeAnimation = Animation1
                end
                
                local targetPose = activeAnimation[currentPose]
                rootJoint.C0 = lerp(rootJoint.C0, targetPose.RootJoint, TransitionSpeed)
                neck.C0 = lerp(neck.C0, targetPose.Neck, TransitionSpeed)
                leftShoulder.C0 = lerp(leftShoulder.C0, targetPose.LeftShoulder, TransitionSpeed)
                rightShoulder.C0 = lerp(rightShoulder.C0, targetPose.RightShoulder, TransitionSpeed)
                leftHip.C0 = lerp(leftHip.C0, targetPose.LeftHip, TransitionSpeed)
                rightHip.C0 = lerp(rightHip.C0, targetPose.RightHip, TransitionSpeed)
            end)
        end
    end
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        applyAnimations(character)
    end)
end)

for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        applyAnimations(player.Character)
    end
end