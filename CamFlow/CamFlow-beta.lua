local CamFlow = true
local Offsets = 50
local Follow = true
local CustomCam = false

local camX_opponent = 500
local camY_opponent = 400
local camX_player = 600
local camY_player = 400
local camX_gf = 400
local camY_gf = 350

local directionOffsets = {
    -- [opponentStrums]
    {-1,0}, -- Izquierda [Note 0]
    {0,1},  -- Abajo [Note 1]
    {0,-1}, -- Arriba [Note 2]
    {1,0},   -- Derecha [Note 3]
    -- [playerStrums]
    {-1,0}, -- Izquierda [Note 4]
    {0,1},  -- Abajo [Note 5]
    {0,-1}, -- Arriba [Note 6]
    {1,0}   -- Derecha [Note 7]
}
function onCreatePost()
    if not CustomCam then
    camX_playerDefault = getMidpointX('boyfriend') - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]') - 100
    camY_playerDefault = getMidpointY('boyfriend') + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]') - 100
    camX_opponentDefault = getMidpointX('dad') + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + 150
    camY_opponentDefault = getMidpointY('dad') + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') - 100
    camX_gfDefault = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')
    camY_gfDefault = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')
    end
    camX_opponent = CustomCam and camX_opponent or camX_opponentDefault
    camY_opponent = CustomCam and camY_opponent or camY_opponentDefault
    camX_player = CustomCam and camX_player or camX_playerDefault
    camY_player = CustomCam and camY_player or camY_playerDefault
    camX_gf = CustomCam and camX_gf or camX_gfDefault
    camY_gf = CustomCam and camY_gf or camY_gfDefault
end
function onUpdatePost(elapsed)
    local offsetX = Follow and 0 or not Follow and ((mustHitSection and camX_player - Offsets or camX_opponent - Offsets) or gfSection and camX_gf - Offsets)
    local offsetY = Follow and 0 or not Follow and ((mustHitSection and camY_player - Offsets or camY_opponent - Offsets) or gfSection and camY_gf - Offsets)
    if CamFlow then
        for i = 0,7 do
            if getProperty('strumLineNotes.members['..i..'].animation.curAnim.name') == 'confirm' then
                offsetX = offsetX + directionOffsets[i + 1][1] * Offsets
                offsetY = offsetY + directionOffsets[i + 1][2] * Offsets
            end
        end
        if mustHitSection then
            FollowX,FollowY = camX_player,camY_player
        elseif not mustHitSection then
            FollowX,FollowY = camX_opponent,camY_opponent
        else
            FollowX,FollowY = camX_gf,camY_gf
        end
        if Follow then
            setProperty('camFollow.x',FollowX)
            setProperty('camFollow.y',FollowY)
        end
    local FollowResult = Follow and 'camGame.targetOffset' or not Follow and 'camFollow'
        setProperty(FollowResult..'.x',offsetX)
        setProperty(FollowResult..'.y',offsetY)
    end
end
