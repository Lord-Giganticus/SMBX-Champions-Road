--------------------------------------------------
-- Level code
-- Created 8:17 2021-11-28
--------------------------------------------------

local laststate
local lastpower
local timer = nil

function onStart()
    player.powerup = PLAYER_BIG
    lastpower = player.powerup
    fight = Layer.get("Maro Fight")
end

function onTick()
    -- Found this in https://wohlsoft.ru/pgewiki/SMBX_Player_Offsets
    -- 2 is "Powering down to small state"
    if player:mem(0x122, FIELD_WORD) == 2 and laststate == nil then
        laststate = player:mem(0x122, FIELD_WORD)
        -- Don't allow player to have Super Mushroom or be small. Must be a higher powerup to prevent unintended cheese.
        if player.powerup > PLAYER_BIG then
            lastpower = player.powerup
        end
        return
    end
    -- Making sure laststate is not null and that the forced animation state is 0 ("No state")
    if laststate ~= nil and player:mem(0x122, FIELD_WORD) == 0 then
        -- Don't allow player to have Super Mushroom or be small. Must be a higher powerup to prevent unintended cheese.
        if lastpower > PLAYER_BIG then
            player.powerup = PLAYER_BIG
            lastpower = player.powerup
        end
        -- Avoid looping
        laststate = nil
    end
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