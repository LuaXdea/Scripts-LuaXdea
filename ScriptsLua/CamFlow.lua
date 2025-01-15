-- | CamFlow v1.0 | By LuaXdea |
-- [YouTube]: https://youtube.com/@lua-x-dea?si=NRm2RlRsL8BLxAl5

-- | Configuración |
local CamFlow = true -- Activa el CamFlow [default true]
local Offsets = 25 -- Desplazamiento de cámara [default 25]
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
    local offsetX = FollowingMode and 0 or not FollowingMode and ((mustHitSection and camX_player or camX_opponent) or gfSection and camX_gf)
    local offsetY = FollowingMode and 0 or not FollowingMode and ((mustHitSection and camY_player or camY_opponent) or gfSection and camY_gf)
    if CamFlow then
        for i = 0,7 do
            if getProperty('strumLineNotes.members['..i..'].animation.curAnim.name') == 'confirm' then
                offsetX = offsetX + directionOffsets[i + 1][1] * Offsets
                offsetY = offsetY + directionOffsets[i + 1][2] * Offsets
            end
        end
        if FollowingMode then
            FollowX = (mustHitSection and camX_player or camX_opponent) or gfSection and camX_gf
            FollowY = (mustHitSection and camY_player or camY_opponent) or gfSection and camY_gf
            setProperty('camFollow.x',FollowX)
            setProperty('camFollow.y',FollowY)
        end
    local FollowResult = FollowingMode and 'camGame.targetOffset' or not FollowingMode and 'camFollow'
        setProperty(FollowResult..'.x',offsetX)
        setProperty(FollowResult..'.y',offsetY)
    end
end
