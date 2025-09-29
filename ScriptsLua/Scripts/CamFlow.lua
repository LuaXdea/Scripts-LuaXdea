-- | CamFlow v1.6.1[Fix] [Return] | By LuaXdea |
-- [YouTube]: https://youtube.com/@lua-x-dea?si=NRm2RlRsL8BLxAl5

-- | Configuración |
local CamFlow = true -- Activa el CamFlow [default: true]
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
function onUpdatePost()
    local BaseX = gfSection and camX_gf or (mustHitSection and camX_player or camX_opponent)
    local BaseY = gfSection and camY_gf or (mustHitSection and camY_player or camY_opponent)
    if CustomCam then callMethod('camFollow.setPosition',{BaseX,BaseY}) end
    local Offsets = IndividualOffsets and (gfSection and offset_gf or mustHitSection and offset_player or offset_opponent) or GeneralOffset
    local offsetX,offsetY = 0,0
    if CamFlow then
        for i = 0,7 do
            if getPropertyFromGroup('strumLineNotes',i,'animation.curAnim.name') == 'confirm' then
                offsetX = offsetX + directionOffsets[i + 1][1] * Offsets
                offsetY = offsetY + directionOffsets[i + 1][2] * Offsets
            end
        end
    end
    callMethod('camGame.targetOffset.set',{offsetX,offsetY})
end
