-- | CamFlow v1.5 | By LuaXdea |
-- [YouTube]: https://youtube.com/@lua-x-dea?si=NRm2RlRsL8BLxAl5

-- | Configuración |
local CamFlow = true -- Activa el CamFlow [default: true]
local FollowingMode = {true,'targetOffset'} --[[ Puedes elegir
    Entre el nuevo que ofrece CamFlow o el seguimiento original.
    Si pones "true" usaras el nuevo y si pones false el original.
    Elige también el tipo de desplazamiento que quieres usar,
    targetOffset o camFollow.
    [default: {true,'targetOffset'}]
    ]]
local CameraSpeedOff = true --[[ Puedes desactivar el cameraSpeed en el script,
    Si ya tienes en otro script que ya hace lo mismo,
    Es para evitar problemas si otro script esta usando el cameraSpeed.
    [default: true]
    ]]
local CameraSpeed = 1 -- Velocidad de la cámara (Requiere CameraSpeedOff = false) [default: 1]
local CustomCam = false --[[ Personaliza la pocision de las cámaras:
    true = Cámaras personalizadas 
    false = Cámaras por defecto del Psych Engine
    [default: false]
    ]]


-- | Posiciones de las cámaras | [Configurado para Test]
-- (Requiere CustomCam)
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
local IndividualOffsets = false -- Es para si quieres usar los Offsets por individual [default: false]
local GeneralOffset = 25 --[[ Reemplaza a los offsets de
    dad,boyfriend y gf,
    Si el IndividualOffsets está en false
    (Requiere IndividualOffsets == false)
    [default: 25]
    ]]

-- | Offsets de las cámaras | (Requiere IndividualOffsets)
-- Offset: Define hasta dónde puede desplazarse la cámara al seguir a los personajes.
local offset_opponent = 20
local offset_player = 20
local offset_gf = 20

-- | Dirección de desplazamiento | (Requiere FollowingMode[1] = true)
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
        camX_player= getMidpointX('boyfriend') - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]') - 100
        camY_player = getMidpointY('boyfriend') + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]') - 100
        camX_opponent = getMidpointX('dad') + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + 150
        camY_opponent = getMidpointY('dad') + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') - 100
        camX_gf = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')
        camY_gf = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')
    end
end
function onUpdatePost(elapsed)
    if not CameraSpeedOff then setProperty('cameraSpeed',CameraSpeed) end
    if not (FollowingMode[2] == 'targetOffset' or FollowingMode[2] == 'camFollow') then 
        return debugPrint('English: Only targetOffset or camFollow is allowed.\n\nEspañol: Solo se permite usar targetOffset o camFollow\n ','RED') 
    end
    local isTargetOffset = FollowingMode[2] == 'targetOffset'
    local offsetX = isTargetOffset and 0 or not isTargetOffset and gfSection and camX_gf or (mustHitSection and camX_player or camX_opponent)
    local offsetY = isTargetOffset and 0 or not isTargetOffset and gfSection and camY_gf or (mustHitSection and camY_player or camY_opponent)
    local Offsets = IndividualOffsets and (gfSection and offset_gf or mustHitSection and offset_player or offset_opponent) or GeneralOffset
    local anim = getProperty(gfSection and 'gf' or (mustHitSection and 'boyfriend' or 'dad')..'.animation.curAnim.name')
    if CamFlow then
        for i = 0,7 do
            if getPropertyFromGroup('strumLineNotes',i,'animation.curAnim.name') == 'confirm' then
                offsetX = FollowingMode[1] and (offsetX + directionOffsets[i + 1][1] * Offsets) or (anim:find('LEFT') and (offsetX - Offsets) or (anim:find('RIGHT') and (offsetX + Offsets) or offsetX))
                offsetY = FollowingMode[1] and (offsetY + directionOffsets[i + 1][2] * Offsets) or (anim:find('UP') and (offsetY - Offsets) or (anim:find('DOWN') and (offsetY + Offsets) or offsetY))
            end
        end
        if isTargetOffset then
            local FollowX = gfSection and camX_gf or (mustHitSection and camX_player or camX_opponent)
            local FollowY = gfSection and camY_gf or (mustHitSection and camY_player or camY_opponent)
            callMethod('camFollow.setPosition',{FollowX,FollowY})
        end
    local FollowResult = isTargetOffset and 'camGame.targetOffset.set' or not isTargetOffset and 'camFollow.setPosition'
        callMethod(FollowResult,{offsetX,offsetY})
    end
end
