local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local textLabel = Instance.new("TextLabel")
local scale = 1

-- Настраиваем GUI
screenGui.Name = "CoordinateGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 10

frame.Size = UDim2.new(0, 200 * scale, 0, 90 * scale)
frame.Position = UDim2.new(0, 10 * scale, 0, 10 * scale)
frame.BackgroundColor3 = Color3.fromRGB(4, 28, 50)
frame.BorderSizePixel = 0

textLabel.Name = "CoordinateLabel"
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Text = "Coordinates: "
textLabel.BackgroundColor3 = Color3.fromRGB(4, 28, 50)
textLabel.BorderSizePixel = 0
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.Parent = frame

-- Создаем закругление
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10 * scale)
corner.Parent = frame

-- Добавляем GUI в игру
screenGui.Parent = playerGui
frame.Parent = screenGui

local close_button = Instance.new("TextButton")
close_button.Text = "Закрыть"
close_button.Position = UDim2.new(0.76, 0, 0.8, 0)
close_button.Size = UDim2.new(0.2, 0, 0.2, 0)
close_button.Parent = frame

-- Добавляем обработчик события для закрытия GUI при нажатии левой кнопкой мыши
close_button.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Обновляем координаты игрока в GUI
game:GetService("RunService").Heartbeat:Connect(function()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local position = player.Character.HumanoidRootPart.Position
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
