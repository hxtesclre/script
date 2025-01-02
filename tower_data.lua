local towerConfigurations = {
    ["Tankenstein"] = {
        basePrice = {Coins = 100, Gems = 200},
        suffixes = {
            ["EternalGlore"] = {Coins = 300, Gems = 600},
            ["FarReach1"] = {Coins = 150, Gems = 300},
            ["FarReach2"] = {Coins = 200, Gems = 400},
            ["FarReach3"] = {Coins = 250, Gems = 500},
            -- Добавьте сюда другие дополнения для Tankenstein
        }
    },
    ["Caveman"] = {
        basePrice = {Coins = 150, Gems = 300},
        suffixes = {
            ["EternalGlore"] = {Coins = 1000, Gems = 2000},
            ["FarReach1"] = {Coins = 200, Gems = 400},
            ["FarReach2"] = {Coins = 250, Gems = 500},
            ["FarReach3"] = {Coins = 300, Gems = 600},
            -- Добавьте сюда другие дополнения для Caveman
        }
    },
    -- Добавьте сюда другие башни
}

return towerConfigurations
