--------------------------------------------------
-- Level code
-- Created 8:17 2021-11-28
--------------------------------------------------

local BetterDamage = API.load("BetterDamage")
local timer = nil

function onStart()
    player.powerup = PLAYER_BIG
    BetterDamage.Initalize()
    fight = Layer.get("Maro Fight")
end

function onTick()
    if timer ~= nil then
        if timer ~= 0 then
            timer = timer - 1
        else
            fight.speedX = fight.speedX * -1
            timer = 10 * 65
        end
    end
end

function onEvent(eventName)
    if eventName == "Sheild Break" then
        fight.speedX = 1
        timer = 6 * 65
    end
    if eventName == "MARO dies" then
        fight.speedX = 0
        timer = nil
    end
end