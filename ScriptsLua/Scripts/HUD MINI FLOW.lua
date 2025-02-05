-- | HUD MINI FLOW v0.2 Test | By LuaXdea |
-- [YouTube]: https://youtube.com/@lua-x-dea?si=NRm2RlRsL8BLxAl5

-- | Psych Engine | Supported versions |
-- • 0.7.2h • 0.7.3


-- | Configuración |

-- | General settings |
local Intro = true -- La presentación [default: true]
local ColorBarVanilla = false -- Cambia el color de la barra de vida al del Base Engine [default: false]
local HealthBarColorFix = true --[[ Si el color de la barra,
    de vida de DAD y BF son iguales o muy similares,
    se hará un ajuste en el color para que no sean iguales
    [default: true]
    ]]


-- | Disable settings |
local DisableDownScroll = false -- Evita que el jugador active el DownScroll [default: false]
local DisableMiddleScroll = false -- Evita que el jugador active el MiddleScroll [default: false]
local DisableGhostTapping = false -- Evita que el jugador active el GhostTapping [default: false]
local DisableHideHud = false -- Evita que el jugador active el HideHud [default: false]
local DisableScoreZoom = false -- Evita que el jugador active el ScoreZoom [default: false]
local DisableFlashingLights = false -- Evita que el jugador active el FlashingLights [default: false]
local DisableLowQuality = false -- Evita que el jugador active el LowQuality [default: false]
local DisableShadersEnabled = false -- Evita que el jugador active los shaders [default: false]
local DisableCameraZoom = false --[[ Desactiva el zoom de la cámara,
    incluyendo el evento "Add Camera Zoom" 
    [default: false]
    ]]
local SkipCountdown = false -- Omite la cuenta regresiva del inicio de la canción [default: false]
local DisablePause = false -- Impide que el jugador pueda pausar el juego [default: false]


-- | UI settings |
local ForceScroll = false -- Forzar el desplazamiento todo el UI [default: false]
local ScrollX = 0 -- Desplazamiento X (Requiere ForceScroll) [default: 0]
local ScrollY = 0 -- Desplazamiento Y (Requiere ForceScroll) [default: 0]
local IconScaleX = 0.6 -- EscalaX base de los iconos [default: 0.6]
local IconScaleY = 0.6 -- EscalaY base de los iconos [default: 0.6]
local IconScaleBeatX = 0.7 -- Por cada Beat hará un cambio en su escalaX [default: 0.7]
local IconScaleBeatY = 0.7 -- Por cada Beat hará un cambio en su escalaY [default: 0.7]


-- | Health |
local HealthDrainOp = true -- El oponente te drena vida [default: true]
local Drain = 0.023 -- Drenado de vida (Requiere HealthDrainOp) [default: 0.023]
local MinHealth = 0.4 -- Límite de drenado (Requiere HealthDrainOp) [default: 0.4]
local LowHealthSpin = true --[[ El icono de BF y de DAD,
    gire cuando la salud está por debajo del límite de MinHealth
    [default: true]
    ]]


-- | ScoreMini |
local ScoreTxtMini = true -- Opción para que se vea el ScoreMini [default: true]
local TimeScoreMini = 0.2 --[[ El tiempo que tardará,
    en llegar a la nueva puntuación [default: 0.2]
    ]]
local ColorScoreMini = '00FF00' --[[ El color que se volverá,
    el ScoreMini cuando se gana puntos
    [default: Hex 00FF00 (Verde)]
    ]]


local CamFlow = true -- Activa el CamFlow [default: true]
local FollowingMode = true --[[ Elige el tipo de desplazamiento que quieres usar:
    true = targetOffset
    false = camFollow
    [default: true]
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
local GeneralOffset = 20 -- Reemplaza a los offsets de dad,boyfriend y gf si el IndividualOffsets está en false (Requiere IndividualOffsets == false) [default: 20]

-- | Offsets de las cámaras | (Requiere IndividualOffsets)
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
function onCreate()
    setProperty('skipCountdown',SkipCountdown)
    setProperty('guitarHeroSustains',not HealthDrainOp)
    onCreateFunction()
end
function onCreatePost()
    runHaxeCode([[
    game.updateIconsPosition = function() {
        var iconOffset:Int = 26;
        game.iconP1.offset.set(iconOffset,iconOffset);
        game.iconP2.offset.set(iconOffset,iconOffset);
    };
    game.updateIconsScale = function(elapsed:Float) {};
    ]])
    local ScrollY = not ForceScroll and (downscroll and 0 or 590) or ScrollY
    setProperty('healthBar.bg.visible',false)
    setProperty('healthBar.x',-150 + ScrollX)
    setProperty('healthBar.y',15 + ScrollY)
    setProperty('healthBar.scale.x',Intro and 0.01 or 0.4)
    setProperty('healthBar.scale.y',Intro and 0.01 or 1)
    setProperty('healthBar.alpha',Intro and 0 or 1)

    setProperty('iconP1.x',ScrollX + (Intro and 140 or 170))
    setProperty('iconP1.y',40 + ScrollY)
    setProperty('iconP1.scale.x',Intro and 0.01 or IconScaleX)
    setProperty('iconP1.scale.y',Intro and 0.01 or IconScaleY)
    setProperty('iconP1.alpha',Intro and 0 or 1)

    setProperty('iconP2.x',ScrollX + (Intro and 70 or 40))
    setProperty('iconP2.y',40 + ScrollY)
    setProperty('iconP2.scale.x',Intro and 0.01 or IconScaleX)
    setProperty('iconP2.scale.y',Intro and 0.01 or IconScaleY)
    setProperty('iconP2.alpha',Intro and 0 or 1)

    setProperty('scoreTxt.visible',ScoreTxtMini)
    setProperty('scoreTxt.alpha',Intro and 0 or 1)
    setProperty('scoreTxt.x',-489 + ScrollX)
    setProperty('scoreTxt.y',35 + ScrollY)

    setProperty('timeBar.bg.visible',false)
    setProperty('timeBar.x',-50 + ScrollX)
    setProperty('timeBar.y',5 + ScrollY)
    setProperty('timeBar.scale.x',Intro and 0.01 or 0.4)
    setProperty('timeBar.scale.y',Intro and 0.01 or 1)
    setProperty('timeBar.alpha',Intro and 0 or 1)

    setProperty('timeTxt.visible',false)
    onCreatePostFunction()
end
function onUpdate(elapsed)
    if LowHealthSpin then
        doTweenAngle('IconP1Angle','iconP1',getProperty('healthBar.percent') < 20 and 360 or 0,0.3)
        doTweenAngle('IconP2Angle','iconP2',getProperty('healthBar.percent') > 80 and 0 or 360,0.3)
    end
    if ColorBarVanilla then
        HealthBarColorFix = false
        setHealthBarColors('FF0000','00FF00')
    end
    onUpdateFunction(elapsed)
end
function onUpdatePost(elapsed)
    setProperty('camZooming',not DisableCameraZoom)
    onUpdatePostFunction(elapsed)
end
function onCountdownTick(counter)
    if Intro then
        if counter == 0 then
            startTween('healthBarScaleSet','healthBar.scale',{x = 0.05,y = 1},0.5,{ease = 'backInOut'})
            doTweenAlpha('healthBarAlpha','healthBar',1,0.5,'backInOut')
            startTween('timeBarScaleSet','timeBar.scale',{x = 0.05,y = 1},0.5,{ease = 'backInOut'})
            doTweenAlpha('timeBarAlpha','timeBar',1,0.5,'backInOut')
        elseif counter == 1 then
            doTweenX('healthBarScaleX','healthBar.scale',0.4,(bpm >= 180) and 1.5 or 2,'backInOut')
            doTweenX('timeBarScaleX','timeBar.scale',0.4,(bpm >= 180) and 1.5 or 2,'backInOut')
            for i = 1,2 do
                doTweenAlpha('Icons'..i..'Alpha','iconP'..i,1,0.3,'backInOut')
                startTween('Icons'..i..'Scale','iconP'..i..'.scale',{x = IconScaleX,y = IconScaleY},(bpm >= 180) and 0.3 or 0.5,{ease = 'backInOut'})
            end
        elseif counter == 2 then
            for i = 1,2 do
                doTweenX('Icons'..i..'X','iconP'..i,(i == 2) and getProperty('iconP2.x') - 30 or getProperty('iconP1.x') + 30,(bpm >= 180) and 1 or 1.5,'backInOut')
                doTweenX('Icons'..i..'ScaleX','iconP'..i..'.scale',0.9,1)
            end
        elseif counter == 3 then
            for i = 1,2 do
                doTweenX('Icons'..i..'ScaleX','iconP'..i..'.scale',0.6,0.5,'bounceOut')
            end
        elseif counter == 4 then
            if ScoreTxtMini and not getProperty('cpuControlled') then
                doTweenAlpha('ScoreMiniAlpha','scoreTxt',1,0.5)
            else
                setProperty('scoreTxt.visible',false)
            end
        end
    end
end
function onSongStart()
    onSongStartFunction()
end
function onBeatHit()
    onBeatHitFunction()
end
function onPause()
    if DisablePause then
        return Function_Stop;
    end
end


-- | Function list |
function onCreateFunction()
    Options()
end
function onCreatePostFunction()
    defaultCams() -- CamFlow
end
function onUpdateFunction(elapsed)
end
function onUpdatePostFunction(elapsed)
    ScoreMiniPost(elapsed) -- ScoreMini
    healthBarFix() -- healthBarFix
    onCamFlow() -- CamFlow
end
function onSongStartFunction()
end
function onBeatHitFunction()
    IconsScaleBeat() -- IconsScaleBeat
end
function opponentNoteHit(membersIndex,noteData,noteType,isSustainNote)
    HealthDrain()
end





local defaultSettings = {}

function Options()
    local settingsList = {
        'downScroll','middleScroll','ghostTapping','hideHud',
        'scoreZoom','flashing','lowQuality','shaders'
    }
    for _,setting in pairs(settingsList) do
        defaultSettings[setting] = getPropertyFromClass('backend.ClientPrefs','data.'..setting)
    end
    if downscroll then
        setPropertyFromClass('backend.ClientPrefs','data.downScroll',not DisableDownScroll)
    end
    if middlescroll then
        setPropertyFromClass('backend.ClientPrefs','data.middleScroll',not DisableMiddleScroll)
    end
    if ghostTapping then
        setPropertyFromClass('backend.ClientPrefs','data.ghostTapping',not DisableGhostTapping)
    end
    if hideHud then
        setPropertyFromClass('backend.ClientPrefs','data.hideHud',not DisableHideHud)
    end
    if scoreZoom then
        setPropertyFromClass('backend.ClientPrefs','data.scoreZoom',not DisableScoreZoom)
    end
    if flashingLights then
        setPropertyFromClass('backend.ClientPrefs','data.flashing',not DisableFlashingLights)
    end
    if lowQuality then
        setPropertyFromClass('backend.ClientPrefs','data.lowQuality',not DisableLowQuality)
    end
    if shadersEnabled then
        setPropertyFromClass('backend.ClientPrefs','data.shaders',not DisableShadersEnabled)
    end
end
function onDestroy()
    for setting,value in pairs(defaultSettings) do
        setPropertyFromClass("backend.ClientPrefs","data."..setting,value)
    end
end



-- IconsScaleBeat
function IconsScaleBeat()
    for i = 1,2 do
        setProperty('iconP'..i..'.scale.x',IconScaleBeatX)
        setProperty('iconP'..i..'.scale.y',IconScaleBeatY)
        startTween('iconsTween'..i,'iconP'..i..'.scale',{x = IconScaleX,y = IconScaleY},0.5,{ease = 'bounceOut'})
    end
end

-- Reemplazo de saveFile [saveFileLua]
function saveFileLua(filePath,content,absolute)
    local absolute = absolute or false
    runHaxeCode([[
        var path = "]]..filePath..[[";
        if (!]]..tostring(absolute)..[[) path = Paths.mods(path);
        if (!FileSystem.exists(path)) {
            var dir = path.substr(0,path.lastIndexOf("/"));
            if (!FileSystem.exists(dir)) FileSystem.createDirectory(dir);
            File.saveContent(path,"]]..content..[[");
        }
    ]])
end


-- HealthDrain
function HealthDrain()
    if HealthDrainOp and getHealth() >= MinHealth then
        setHealth(getHealth() - Drain)
    end
end

-- ScoreMini
local ScoreActual = getProperty('songScore')
local timerUp,timerDown,incrementStageUp,incrementStageDown = 0,0,0,0
local incrementSpeed = {up = 1,down = 1}
function ScoreMiniPost(elapsed)
    local TargetScore = getProperty('songScore')
    timerUp = timerUp + elapsed
    timerDown = timerDown + elapsed
    if timerUp >= TimeScoreMini then
        incrementStageUp = incrementStageUp + 1
        incrementSpeed.up = 1 + (2 * incrementStageUp)
        timerUp = 0
    end
    if timerDown >= TimeScoreMini then
        incrementStageDown = incrementStageDown + 1
        incrementSpeed.down = math.min(1 + incrementStageDown, 4)
        timerDown = 0
    end
    if ScoreActual ~= TargetScore then
        local direction = (ScoreActual < TargetScore) and 'up' or 'down'
        ScoreActual = ScoreActual + ((direction == 'up') and incrementSpeed.up or -incrementSpeed.down)
        setProperty('scoreTxt.color',getColorFromHex((direction == 'up') and ColorScoreMini or 'FF0000'))
        if (direction == 'up' and ScoreActual > TargetScore) or (direction == 'down' and ScoreActual < TargetScore) then
            ScoreActual = TargetScore
        end
        if ScoreActual == TargetScore then
            doTweenColor('ScoreR','scoreTxt','FFFFFF',0.3)
            incrementSpeed.up,incrementSpeed.down = 1,1
            incrementStageUp,incrementStageDown = 0,0
        end
    end
    if ScoreTxtMini and not getProperty('cpuControlled') then
        setTextString('scoreTxt',math.floor(ScoreActual))
    end
end

-- CamFlow
function defaultCams()
    if not CustomCam then
        camX_player= getMidpointX('boyfriend') - 100
        camY_player = getMidpointY('boyfriend') - 100
        camX_opponent = getMidpointX('dad') + 150
        camY_opponent = getMidpointY('dad') - 100
        camX_gf = getMidpointX('gf')
        camY_gf = getMidpointY('gf')
    end
end
function onCamFlow()
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
            local FollowX = gfSection and camX_gf or (mustHitSection and camX_player or camX_opponent)
            local FollowY = gfSection and camY_gf or (mustHitSection and camY_player or camY_opponent)
            setProperty('camFollow.x',FollowX)
            setProperty('camFollow.y',FollowY)
        end
    local FollowResult = FollowingMode and 'camGame.targetOffset' or not FollowingMode and 'camFollow'
        setProperty(FollowResult..'.x',offsetX)
        setProperty(FollowResult..'.y',offsetY)
    end
end

-- healthBarFix
function healthBarFix()
    if HealthBarColorFix then
        local bfRGB,dadRGB = getProperty('boyfriend.healthColorArray'),getProperty('dad.healthColorArray')
        if areColorsSimilar(bfRGB[1],bfRGB[2],bfRGB[3],dadRGB[1],dadRGB[2],dadRGB[3]) then
            local adjustedColor = adjustColor(dadRGB[1],dadRGB[2],dadRGB[3],calculateLuminosity(dadRGB[1],dadRGB[2],dadRGB[3]))
            setHealthBarColors(rgbToHex(adjustedColor[1],adjustedColor[2],adjustedColor[3]),rgbToHex(bfRGB[1],bfRGB[2],bfRGB[3]))
        end
    end
end
function areColorsSimilar(r1,g1,b1,r2,g2,b2)
    return math.abs(r1 - r2) <= 50 and math.abs(g1 - g2) <= 50 and math.abs(b1 - b2) <= 50
end
function calculateLuminosity(r,g,b)
    return 0.299 * r + 0.587 * g + 0.114 * b
end
function adjustColor(r,g,b,lum)
    local adj = (lum > 128) and -60 or 60
    return { math.max(0,math.min(255,r + adj)),math.max(0,math.min(255,g + adj)),math.max(0,math.min(255,b + adj)) }
end

-- ColorHex
function rgbToHex(r,g,b)
    return string.format("0x%02X%02X%02X",r,g,b)
end
