local CamFlow = true
local Offsets = 30
local FollowingMode = false
local CustomCam = false

local camX_opponent = 500
local camY_opponent = 600
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
    camX_player= getMidpointX('boyfriend') - 100
    camY_player = getMidpointY('boyfriend') - 100
    camX_opponent = getMidpointX('dad') + 150
    camY_opponent = getMidpointY('dad') - 100
    camX_gf = getMidpointX('gf')
    camY_gf = getMidpointY('gf')
    end
end
function onUpdatePost(elapsed)
    local offsetX = FollowingMode and 0 or not FollowingMode and ((mustHitSection and camX_player or camX_opponent) or gfSection and camX_gf)
    local offsetY = FollowingMode and 0 or not FollowingMode and ((mustHitSection and camY_player or camY_opponent) or gfSection and camY_gf)
    if CamFlow then
        for i = 0,7 do
            if getProperty('strumLineNotes.members['..i..'].animation.curAnim.name') == 'confirm' then
                offsetX = offsetX + directionOffsets[i + 1][1] * Offsets
                offsetY = offsetY + directionOffsets[i + 1][2] * Offsets
            end
        end
    local FollowResult = FollowingMode and 'camGame.targetOffset' or not FollowingMode and 'camFollow'
        setProperty(FollowResult..'.x',offsetX)
        setProperty(FollowResult..'.y',offsetY)
    end
end
