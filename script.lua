    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    local textLabel = Instance.new("TextLabel")

    -- Настраиваем GUI
    screenGui.Name = "CoordinateGui"
    textLabel.Name = "CoordinateLabel"
    textLabel.Size = UDim2.new(0, 100, 0, 25)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.BackgroundColor3 = Color3.fromRGB(4, 28, 50) -- Задаем цвет фона (красный в данном случае)
    textLabel.TextColor3 = Color3.new(1, 1, 1) -- Задаем цвет текста (белый в данном случае)

    -- Создаем закругление
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20) -- Задаем радиус закругления
    corner.Parent = textLabel -- Добавляем закругление к нашему GUI
    
    -- Добавляем GUI в игру
    screenGui.Parent = playerGui
    textLabel.Parent = screenGui

    local close_button = Instance.new("TextButton")
    close_button.Text = "Закрыть"
    close_button.Position = UDim2.new(0.76, 0, 0.55, -50)
    close_button.Size = UDim2.new(0.2, 0, 0.2, 0)
    close_button.Parent = screenGui

    -- Добавляем обработчик события для закрытия GUI при нажатии левой кнопкой мыши
    close_button.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Обновляем координаты игрока в GUI
    game:GetService("RunService").Heartbeat:Connect(function()
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local position = player.Character.HumanoidRootPart.Position
            -- Форматируем координаты до сотых
            local formattedPosition = string.format("X: %.2f\nY: %.2f\nZ: %.2f", position.X, position.Y, position.Z)
            textLabel.Text = formattedPosition
        end
    end)

    -- Скрываем GUI при смерти игрока
    game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid").Died:Connect(function()
            screenGui.Enabled = false
        end)
    end)
