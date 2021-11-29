--------------------------------------------------
-- Level code
-- Created 11:19 2021-11-29
--------------------------------------------------

function onStart()
    player.powerup = PLAYER_BIG
end

function onTick()
    -- Found this in https://wohlsoft.ru/pgewiki/SMBX_Player_Offsets
    -- 2 is "Powering down to small state"
    if player:mem(0x122, FIELD_WORD) == 2 then
        player:kill()
    end
end