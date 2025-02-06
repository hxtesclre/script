local lastTime = os.clock()

-- Функция для конвертации CFrame в строку
local function CFrameToString(cframe)
    return string.format("CFrame.new(%.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f)",
        cframe.X, cframe.Y, cframe.Z,
        cframe.RightVector.X, cframe.RightVector.Y, cframe.RightVector.Z,
        cframe.UpVector.X, cframe.UpVector.Y, cframe.UpVector.Z,
        cframe.LookVector.X, cframe.LookVector.Y, cframe.LookVector.Z)
end

-- Функция для преобразования таблицы в строку
local function tableToString(t)
    local str = "{"
    for i, v in ipairs(t) do
        if typeof(v) == "CFrame" then
            str = str .. CFrameToString(v) .. ", "
        else
            str = str .. tostring(v) .. ", "
        end
    end
    return str:sub(1, -3) .. "}"  -- Убираем последнюю лишнюю запятую
end

-- Мета-таблица для перехвата метода
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- Перехват PlaceTower
    if tostring(self) == "PlaceTower" and method == "InvokeServer" then
        print("\n🔎 Вызван PlaceTower!")

        -- Получаем текущее время и вычисляем задержку
        local currentTime = os.clock()
        local timeDiff = currentTime - lastTime
        lastTime = currentTime

        -- Собираем нужные данные
        local data = {
            args = args,  -- Просто передаем аргументы как есть
            delay = timeDiff  -- Задержка между вызовами
        }

        -- Выводим данные для отладки
        print("Аргументы для записи в файл:")
        for i, v in ipairs(args) do
            if typeof(v) == "CFrame" then
                print("Аргумент " .. i .. ": " .. CFrameToString(v))
            else
                print("Аргумент " .. i .. ": " .. tostring(v))
            end
        end

        -- Конвертируем данные в строку
        local dataString = "PlaceTower Call - {delay=" .. timeDiff .. " args=" .. tableToString(args) .. "}\n"

        -- Записываем данные в файл
        local success, err = pcall(function()
            appendfile("tower_placements.txt", dataString)  -- Записываем в файл
        end)

        if success then
            print("✅ Записано:", dataString)
        else
            warn("❌ Ошибка при записи в файл:", err)
        end
    end

    -- Перехват VoteStartRound
    if tostring(self) == "VoteStartRound" and method == "InvokeServer" then
        print("\n🔎 Вызван VoteStartRound!")

        -- Получаем текущее время и вычисляем задержку
        local currentTime = os.clock()
        local timeDiff = currentTime - lastTime
        lastTime = currentTime

        -- Собираем данные для записи
        local dataString = "VoteStartRound Call - {delay=" .. timeDiff .. " args=" .. tableToString(args) .. "}\n"

        -- Записываем данные в файл
        local success, err = pcall(function()
            appendfile("tower_placements.txt", dataString)  -- Записываем в файл
        end)

        if success then
            print("✅ Записано:", dataString)
        else
            warn("❌ Ошибка при записи в файл:", err)
        end
    end

    -- Перехват ChangeGameSpeed
    if tostring(self) == "ChangeGameSpeed" and method == "InvokeServer" then
        print("\n🔎 Вызван ChangeGameSpeed!")

        -- Получаем текущее время и вычисляем задержку
        local currentTime = os.clock()
        local timeDiff = currentTime - lastTime
        lastTime = currentTime

        -- Собираем данные для записи
        local dataString = "ChangeGameSpeed Call - {delay=" .. timeDiff .. " args=" .. tableToString(args) .. "}\n"

        -- Записываем данные в файл
        local success, err = pcall(function()
            appendfile("tower_placements.txt", dataString)  -- Записываем в файл
        end)

        if success then
            print("✅ Записано:", dataString)
        else
            warn("❌ Ошибка при записи в файл:", err)
        end
    end

    -- Перехват EndGameVote
    if tostring(self) == "EndGameVote" and method == "InvokeServer" then
        print("\n🔎 Вызван EndGameVote!")

        -- Получаем текущее время и вычисляем задержку
        local currentTime = os.clock()
        local timeDiff = currentTime - lastTime
        lastTime = currentTime

        -- Собираем данные для записи
        local dataString = "EndGameVote Call - {delay=" .. timeDiff .. " args=" .. tableToString(args) .. "}\n"

        -- Записываем данные в файл
        local success, err = pcall(function()
            appendfile("tower_placements.txt", dataString)  -- Записываем в файл
        end)

        if success then
            print("✅ Записано:", dataString)
        else
            warn("❌ Ошибка при записи в файл:", err)
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
