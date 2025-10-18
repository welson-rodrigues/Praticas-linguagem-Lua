--[[  
    🔥 SISTEMA DE ANIMAÇÃO CUSTOMIZADA R6 🔥
    ✨ Feito por: Handsome Kuro 👁️👄👁️
    ✨ Tradução e simplificação por: Zee GameDev
    📜 Mantidos todos os créditos do autor original

    👉 Este script substitui o Animate padrão e permite
    usar animações customizadas feitas com modelos R6.

    ✅ Coloque este script dentro do ServerScriptService
    ✅ Crie uma pasta "Tween" dentro do ReplicatedStorage
    ✅ Dentro dela, adicione subpastas: Idle, Walk, Jump
    ✅ Em cada subpasta, adicione modelos F1, F2, F3...
        (representando os frames da animação)
--]]

-- ========== CONFIGURAÇÕES ==========
local ANIMATION_SPEEDS = {
	Idle = 0.3,  -- Velocidade da animação de parado
	Walk = 0.15, -- Velocidade da animação andando
	Jump = 0.25  -- Velocidade da animação de pulo
}
local STATE_CHECK_RATE = 0         -- Taxa de atualização (0 = a cada frame)
local TWEEN_STYLE = Enum.EasingStyle.Linear -- Tipo de suavização da transição
-- ===================================

-- Serviços usados
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Pasta onde ficam as animações (somente Tween)
local TweenFolder = ReplicatedStorage:WaitForChild("Tween")

-- Ligações padrão entre as partes do corpo R6
local LIMB_CONNECTIONS = {
	{Part0 = "Torso", Part1 = "Head", MotorName = "Neck"},
	{Part0 = "Torso", Part1 = "Left Arm", MotorName = "Left Shoulder"},
	{Part0 = "Torso", Part1 = "Right Arm", MotorName = "Right Shoulder"},
	{Part0 = "Torso", Part1 = "Left Leg", MotorName = "Left Hip"},
	{Part0 = "Torso", Part1 = "Right Leg", MotorName = "Right Hip"}
}

local hasLoadedOnce = false

-- Função que lê os frames (Modelos F1, F2, F3...) de uma pasta
local function getFrames(folder)
	local frames = {}
	for _, child in pairs(folder:GetChildren()) do
		if child:IsA("Model") and child.Name:match("^F%d+$") then
			local frameNum = tonumber(child.Name:match("%d+"))
			table.insert(frames, {model = child, num = frameNum})
		end
	end

	table.sort(frames, function(a, b) return a.num < b.num end)

	local sortedFrames = {}
	for _, frame in ipairs(frames) do
		table.insert(sortedFrames, frame.model)
	end

	return sortedFrames
end

-- Posições padrão dos motores R6
local DEFAULT_C0 = {
	["Neck"] = CFrame.new(0, 1, 0),
	["Left Shoulder"] = CFrame.new(-1, 0.5, 0),
	["Right Shoulder"] = CFrame.new(1, 0.5, 0),
	["Left Hip"] = CFrame.new(-1, -1, 0),
	["Right Hip"] = CFrame.new(1, -1, 0)
}

local ADJUSTED_C1 = {
	["Neck"] = CFrame.new(0, -0.5, 0),
	["Left Shoulder"] = CFrame.new(0.5, 0.5, 0),
	["Right Shoulder"] = CFrame.new(-0.5, 0.5, 0),
	["Left Hip"] = CFrame.new(0.5, 1, 0),
	["Right Hip"] = CFrame.new(-0.5, 1, 0)
}

-- Calcula o C0 com base na pose de um modelo (frame)
local function calculateC0FromPose(part0, part1, motorName)
	if not part0 or not part1 then return nil end

	local defaultC1 = ADJUSTED_C1[motorName]
	if not defaultC1 then return nil end

	local newC0 = part0.CFrame:Inverse() * part1.CFrame * defaultC1
	return newC0
end

-- Gera os dados de pose (rotação e posição) de um modelo
local function getPoseData(rigModel)
	local poseData = {}

	for _, connection in pairs(LIMB_CONNECTIONS) do
		local part0 = rigModel:FindFirstChild(connection.Part0)
		local part1 = rigModel:FindFirstChild(connection.Part1)

		if part0 and part1 then
			local calculatedC0 = calculateC0FromPose(part0, part1, connection.MotorName)
			if calculatedC0 then
				poseData[connection.MotorName] = calculatedC0
			end
		end
	end

	if next(poseData) == nil then
		return nil
	end

	return poseData
end

-- Aplica a pose suavemente (com Tween)
local function applyPoseTween(character, poseData, tweenTime)
	local torso = character:FindFirstChild("Torso")
	if not torso or not poseData then return nil end

	local tweens = {}

	for motorName, targetC0 in pairs(poseData) do
		local motor = torso:FindFirstChild(motorName)
		if motor and motor:IsA("Motor6D") then
			local tween = TweenService:Create(
				motor,
				TweenInfo.new(tweenTime, TWEEN_STYLE, Enum.EasingDirection.InOut),
				{C0 = targetC0}
			)
			table.insert(tweens, tween)
			tween:Play()
		end
	end

	return tweens
end

-- Detecta o estado atual do jogador (Parado, Andando, Pulando)
local function getPlayerState(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not rootPart then return "Idle" end

	if humanoid:GetState() == Enum.HumanoidStateType.Freefall or 
		humanoid:GetState() == Enum.HumanoidStateType.Jumping then
		return "Jump"
	end

	if rootPart.AssemblyLinearVelocity.Magnitude > 0.5 then
		return "Walk"
	end

	return "Idle"
end

-- Loop principal que controla as animações
local function startAnimationLoop(player)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	local tweenAnims = {
		Idle = getFrames(TweenFolder.Idle),
		Walk = getFrames(TweenFolder.Walk),
		Jump = getFrames(TweenFolder.Jump)
	}

	local tweenPoses = {}

	for state, frames in pairs(tweenAnims) do
		tweenPoses[state] = {}
		for _, frame in ipairs(frames) do
			local poseData = getPoseData(frame)
			if poseData then
				table.insert(tweenPoses[state], poseData)
			end
		end
	end

	if not hasLoadedOnce then
		print("=== SISTEMA DE ANIMAÇÃO (DEBUG) ===")
		for state, poses in pairs(tweenPoses) do
			print("Tween/" .. state .. ": " .. #poses .. " frames carregados")
		end
		print("===================================")
		hasLoadedOnce = true
	end

	local currentFrameIndex = {Idle = 1, Walk = 1, Jump = 1}
	local lastState = "Idle"
	local activeTweens = {}
	local lastFrameTime = 0

	task.spawn(function()
		while character and character.Parent and humanoid and humanoid.Parent do
			local currentTime = tick()
			local currentState = getPlayerState(character)

			if currentState ~= lastState then
				for _, tween in pairs(activeTweens) do
					if tween then tween:Cancel() end
				end
				activeTweens = {}
				currentFrameIndex[currentState] = 1
				lastFrameTime = currentTime
			end

			lastState = currentState
			local tweenPoseList = tweenPoses[currentState]
			local hasTweenFrames = tweenPoseList and #tweenPoseList > 0

			if hasTweenFrames and (currentTime - lastFrameTime) >= ANIMATION_SPEEDS[currentState] then
				local frameIndex = currentFrameIndex[currentState]
				local pose = tweenPoseList[frameIndex]

				local tweens = applyPoseTween(character, pose, ANIMATION_SPEEDS[currentState])
				if tweens then activeTweens = tweens end

				currentFrameIndex[currentState] = frameIndex % #tweenPoseList + 1
				lastFrameTime = currentTime
			end

			task.wait(STATE_CHECK_RATE)
		end
	end)
end

-- Detecta novos jogadores e aplica o sistema
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		task.wait(0.5)
		startAnimationLoop(player)
	end)
	if player.Character then
		startAnimationLoop(player)
	end
end)

-- Inicia para jogadores já conectados
for _, player in pairs(Players:GetPlayers()) do
	if player.Character then
		startAnimationLoop(player)
	end
end

-- Créditos e mensagem final
print("Custom Animation System Loaded!")
print("========================================")
print("███████╗██╗   ██╗██████╗ ███████╗")
print("██╔════╝██║   ██║██╔══██╗██╔════╝")
print("███████╗██║   ██║██████╔╝███████╗")
print("╚════██║██║   ██║██╔══██╗╚════██║")
print("███████║╚██████╔╝██████╔╝███████║")
print("╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝")
print("")
print("   🔥 SUBSCRIBE FOR KURO LITE 🔥")
print("========================================")
print("✨ Animation System by Kuro Lite ✨")

