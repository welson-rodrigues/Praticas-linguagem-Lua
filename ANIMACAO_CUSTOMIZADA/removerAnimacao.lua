game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        repeat task.wait() until character:FindFirstChild("Humanoid")
        task.wait(0.1)
        local animateScript = character:FindFirstChild("Animate")
        if animateScript then
            animateScript:Destroy()
        end
    end)
end)
