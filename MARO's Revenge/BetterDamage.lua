local BetterDamage = {}

local laststate = nil
local lastpower

function BetterDamage.Initalize()
    lastpower = player.powerup
end

function BetterDamage.onTick()
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
end

function BetterDamage.onInitAPI()
    registerEvent(BetterDamage, "onTick", "onTick")
end

return BetterDamage