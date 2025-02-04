-- | CamFlow v1.1 Fix | By LuaXdea |
-- [YouTube]: https://youtube.com/@lua-x-dea?si=NRm2RlRsL8BLxAl5

-- | Configuración |
local CamFlow = true -- Activa el CamFlow [default true]
local FollowingMode = true --[[ Elige el tipo de desplazamiento que quieres usar:
    true = targetOffset
    false = camFollow
    [default true]
    ]]
local CameraSpeedOff = true --[[ Puedes desactivar el cameraSpeed en el script,
    Si ya tienes en otro script que ya hace lo mismo,
    Es para evitar problemas si otro script esta usando el cameraSpeed.
    [default true]
    ]]
local CameraSpeed = 1 -- Velocidad de la cámara [default 1]
local CustomCam = false --[[ Personaliza la pocision de las cámaras:
    true = Cámaras personalizadas 
    false = Cámaras por defecto del Psych Engine
    [default false]
    ]]

-- | Posiciones de las cámaras | [Configurado para Test]
-- Esto solo funciona si CustomCam está en true
-- camX: es la posición horizontal
-- camY: es la posición vertical
local camX_opponent = 600
local camY_opponent = 600
local camX_player = 700
local camY_player = 600
local camX_gf = 650
local camY_gf = 450


-- | Offsets |
local IndividualOffsets = false -- Es para si quieres usar los Offsets por individual [default false]
local GeneralOffset = 20 -- Reemplaza a los offsets de dad,boyfriend y gf si el IndividualOffsets está en false [default 20]

-- | Offsets de las cámaras |
-- Offset: Define hasta dónde puede desplazarse la cámara al seguir a los personajes.
local offset_opponent = 20
local offset_player = 20
local offset_gf = 20

-- | Dirección de desplazamiento |
local directionOffsets = {
    -- [opponentStrums]
    {-1,0}, -- Izquierda [Note 0]
    {0,1}, -- Abajo [Note 1]
    {0,-1}, -- Arriba [Note 2]
    {1,0}, -- Derecha [Note 3]
    -- [playerStrums]
    {-1,0}, -- Izquierda [Note 4]
    {0,1}, -- Abajo [Note 5]
    {0,-1}, -- Arriba [Note 6]
    {1,0} -- Derecha [Note 7]
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
    if not CameraSpeedOff then setProperty('cameraSpeed',CameraSpeed) end
    local offsetX = FollowingMode and 0 or not FollowingMode and gfSection and camX_gf or (mustHitSection and camX_player or camX_opponent)
    local offsetY = FollowingMode and 0 or not FollowingMode and gfSection and camY_gf or (mustHitSection and camY_player or camY_opponent)
    local Offsets = IndividualOffsets and (gfSection and offset_gf or mustHitSection and offset_player or offset_opponent) or GeneralOffset
    if CamFlow then
        for i = 0,7 do
            if getPropertyFromGroup('strumLineNotes',i,'animation.curAnim.name') == 'confirm' then
                offsetX = offsetX + directionOffsets[i + 1][1] * Offsets
                offsetY = offsetY + directionOffsets[i + 1][2] * Offsets
            end
        end
        if FollowingMode then
            FollowX = gfSection and camX_gf or (mustHitSection and camX_player or camX_opponent)
            FollowY = gfSection and camY_gf or (mustHitSection and camY_player or camY_opponent)
            setProperty('camFollow.x',FollowX)
            setProperty('camFollow.y',FollowY)
        end
    local FollowResult = FollowingMode and 'camGame.targetOffset' or not FollowingMode and 'camFollow'
        setProperty(FollowResult..'.x',offsetX)
        setProperty(FollowResult..'.y',offsetY)
    end
end
