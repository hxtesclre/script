local player = game:GetService("Players").LocalPlayer

local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()
    bb:ClickButton2(Vector2.new())
end)

local function upgradeTowers(duration)
    local startTime = os.clock()
    local unitsFolder = player.PlayerGui.UnitsManager.Main.Units

    while os.clock() - startTime < duration do
        for _, unit in ipairs(unitsFolder:GetChildren()) do
            if unit then  -- Проверяем, что это объект с именем (например, GUI элемент)
                local unitName = unit.Name
                print("⚡ Улучшаем башню:", unitName)

                -- Передаём имя в аргумент
                local args = {unitName}
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index")
                    :WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
                    :WaitForChild("Services"):WaitForChild("GameService")
                    :WaitForChild("RF"):WaitForChild("UpgradeTower")
                    :InvokeServer(unpack(args))
            end
        end
        wait(0.5) -- Улучшаем башни каждые 2 секунды (можно настроить)
    end
    print("✅ Завершено улучшение башен!")
end

local function repeating()
    local lines = readfile("tower_placements.txt"):split("\n")

    for _, line in ipairs(lines) do
        -- Пропускаем пустые строки
        if line ~= "" then
            -- Извлекаем delay
            local delay = tonumber(string.match(line, "delay=([%d%.]+)"))
            
            -- Извлекаем args как строку
            local argsString = string.match(line, "args={(.*)}")
            
            -- Создаем таблицу для хранения аргументов
            local args = {}

            -- Обрабатываем строки для различных событий
            -- Обрабатываем строку для PlaceTower
            if string.match(line, "PlaceTower Call") then
                -- Для PlaceTower аргументы могут содержать CFrame
                local cframeString, numberString = string.match(argsString, "CFrame.new%(([^)]+)%)%,%s*(%d+)")
                
                if cframeString and numberString then
                    -- Создаем CFrame из строки
                    local cframeValues = {}
                    for value in string.gmatch(cframeString, "-?[%d%.]+") do
                        table.insert(cframeValues, tonumber(value))
                    end
                    local cframe = CFrame.new(unpack(cframeValues))
                    
                    -- Добавляем CFrame и число в args
                    table.insert(args, cframe)
                    table.insert(args, tonumber(numberString))
                end

            -- Обрабатываем строку для ChangeGameSpeed
            elseif string.match(line, "ChangeGameSpeed Call") then
                -- Для ChangeGameSpeed аргументы это просто одно число
                local speed = tonumber(string.match(argsString, "(%d+)"))
                table.insert(args, speed)

            -- Обрабатываем строку для VoteStartRound
            elseif string.match(line, "VoteStartRound Call") then
                -- Для VoteStartRound аргументы могут быть пустыми
                -- Записываем пустую таблицу
                table.insert(args, {})

            -- Обрабатываем строку для EndGameVote
            elseif string.match(line, "EndGameVote Call") then
                -- Для EndGameVote аргумент это строка
                local voteType = string.match(argsString, "([%w_]+)")
                table.insert(args, voteType)
            
            elseif string.match(line, "StartUpgrade Call") then
                local duration = tonumber(string.match(line, "duration=([%d%.]+)")) or 80
                task.spawn(upgradeTowers, duration) -- Запускаем в параллельном процессе
            end



            -- Ждем указанное время (delay)
            wait(delay)
            
            -- Выполняем команду в зависимости от типа вызова
            if string.match(line, "PlaceTower Call") then
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("TowerService"):WaitForChild("RF"):WaitForChild("PlaceTower"):InvokeServer(unpack(args))
            elseif string.match(line, "ChangeGameSpeed Call") then
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("ChangeGameSpeed"):InvokeServer(unpack(args))
            elseif string.match(line, "VoteStartRound Call") then
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("VoteStartRound"):InvokeServer(unpack(args))
            elseif string.match(line, "EndGameVote Call") then
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("GameService"):WaitForChild("RF"):WaitForChild("EndGameVote"):InvokeServer(unpack(args))
            end
        end
    end
end

while true do
    repeating()
	game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("StatsService"):WaitForChild("RF"):WaitForChild("Prestige"):InvokeServer()
    wait()
end
