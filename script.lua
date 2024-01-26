local ScreenGui = Instance.new("ScreenGui")
local Coords = Instance.new("ImageLabel")
local CloseCoords = Instance.new("TextLabel")
local CloseCoordsCircle = Instance.new("ImageLabel")
local CloseButton = Instance.new("TextButton")
local CloseButtonCircle = Instance.new("ImageLabel")

ScreenGui.Parent = game.CoreGui

Coords.Name = "Coords"
Coords.Parent = ScreenGui
Coords.AnchorPoint = Vector2.new(0.5, 0.5)
Coords.BackgroundColor3 = Color3.fromRGB(14, 41, 84)
Coords.BackgroundTransparency = 1.000
Coords.Position = UDim2.new(0.0642084777, 0, 0.111290321, 0)
Coords.Size = UDim2.new(0, 80, 0, 80)
Coords.Image = "rbxassetid://3570695787"
Coords.ImageColor3 = Color3.fromRGB(14, 41, 84)
Coords.ScaleType = Enum.ScaleType.Slice
Coords.SliceCenter = Rect.new(100, 100, 100, 100)
Coords.SliceScale = 0.120

CloseCoords.Name = "CloseCoords"
CloseCoords.Parent = Coords
CloseCoords.AnchorPoint = Vector2.new(0.5, 0.5)
CloseCoords.BackgroundColor3 = Color3.fromRGB(132, 167, 161)
CloseCoords.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseCoords.BorderSizePixel = 0
CloseCoords.Position = UDim2.new(0.5, 0, 0.129999995, 0)
CloseCoords.Size = UDim2.new(0, 70, 0, 20)
CloseCoords.ZIndex = 2
CloseCoords.Font = Enum.Font.SourceSansItalic
CloseCoords.Text = "Coords"
CloseCoords.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseCoords.TextSize = 14.000

CloseCoordsCircle.Name = "CloseCoordsCircle"
CloseCoordsCircle.Parent = CloseCoords
CloseCoordsCircle.AnchorPoint = Vector2.new(0.5, 0.5)
CloseCoordsCircle.BackgroundColor3 = Color3.fromRGB(53, 47, 68)
CloseCoordsCircle.BackgroundTransparency = 1.000
CloseCoordsCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
CloseCoordsCircle.Size = UDim2.new(0, 80, 1, 2)
CloseCoordsCircle.Image = "rbxassetid://3570695787"
CloseCoordsCircle.ImageColor3 = Color3.fromRGB(132, 167, 161)
CloseCoordsCircle.ScaleType = Enum.ScaleType.Slice
CloseCoordsCircle.SliceCenter = Rect.new(100, 100, 100, 100)
CloseCoordsCircle.SliceScale = 0.120

CloseButton.Name = "CloseButton"
CloseButton.Parent = Coords
CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(31, 110, 140)
CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.879999995, 0, 0.125, 0)
CloseButton.Size = UDim2.new(0, 14, 0, 14)
CloseButton.ZIndex = 3
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = ""
CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextSize = 14.000

CloseButtonCircle.Name = "CloseButtonCircle"
CloseButtonCircle.Parent = CloseButton
CloseButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
CloseButtonCircle.BackgroundColor3 = Color3.fromRGB(31, 110, 140)
CloseButtonCircle.BackgroundTransparency = 1.000
CloseButtonCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
CloseButtonCircle.Size = UDim2.new(-0.200000003, 24, -0.200000003, 24)
CloseButtonCircle.ZIndex = 2
CloseButtonCircle.Image = "rbxassetid://3570695787"
CloseButtonCircle.ImageColor3 = Color3.fromRGB(31, 110, 140)
CloseButtonCircle.ScaleType = Enum.ScaleType.Slice
CloseButtonCircle.SliceCenter = Rect.new(100, 100, 100, 100)
CloseButtonCircle.SliceScale = 0.120
CloseButton.MouseButton1Click:Connect(function() 
	ScreenGui:Destroy()
end)

-- Обновляем координаты игрока в GUI
game:GetService("RunService").Heartbeat:Connect(function()
	local player = game.Players.LocalPlayer
	if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local position = player.Character.HumanoidRootPart.Position
		-- Форматируем координаты до сотых
		local formattedPosition = string.format("X: %.2f\nY: %.2f\nZ: %.2f", position.X, position.Y, position.Z)
		Coords.Text = formattedPosition
	end
end)

-- Скрываем GUI при смерти игрока
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
	character:WaitForChild("Humanoid").Died:Connect(function()
		ScreenGui.Enabled = false
	end)
end)
