-- | HUD MINI FLOW | By LuaXdea |
local VersionFlow = '1.7' -- Version de HUD MINI FLOW
-- [YouTube]: https://youtube.com/@lua-x-dea?si=NRm2RlRsL8BLxAl5
-- [Gamebanana]: https://gamebanana.com/tools/19055

-- | Psych Engine | Supported versions |
-- • 0.7.2h
-- • 0.7.3


-- | Psych Engine 0.6.3 |
--[[
    [Español]
    Próximamente se añadirá compatibilidad con la versión 0.6.3.
    Sin embargo, será una adaptación del HUD MINI FLOW v2,
    por lo que no contará con todas las funciones disponibles en la versión 0.7.
    Algunas características no estarán presentes o se ajustarán
    para ofrecer una experiencia lo más similar posible,
    ya que la versión 0.6.3 carece de ciertos elementos exclusivos de la 0.7.

    [English]
    Compatibility with version 0.6.3 will be available soon.
    However, it will be an adapted version of the MINI FLOW HUD v2,
    so not all features from version 0.7 will be included.
    Some options will either be missing or adjusted to closely resemble the original,
    as certain elements only exist in version 0.7.
]]



-- | Configuración |

-- | General settings |
local Intro = true -- La presentación [default: true]
local ColorBarVanilla = false -- Cambia el color de la barra de vida al del Base Engine [default: false]
local HealthBarColorFix = true --[[ Si el color de la barra,
    de vida de DAD y BF son iguales o muy similares,
    se hará un ajuste en el color para que no sean iguales
    [default: true]
    ]]
local SmoothHealth = true -- HealthBar se actualizará de forma suave [default: true]
local SmoothHealthSpeed = 1 -- La velocidad de smoothHealth se puede aumentar para que sea más rapido o lento [default: 1]
local VersionAlert = true --[[ Te dira avisará si la versión,
    de Psych Engine que estas usando no es compatible,
    con el HUD MINI FLOW
    (0.7.2h • 0.7.3)
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
    incluyendo el evento "Add Camera Zoom" ya no funcionara correctamente
    [default: false]
    ]]
local SkipCountdown = false -- Omite la cuenta regresiva del inicio de la canción [default: false]
local DisablePause = false -- Impide que el jugador pueda pausar el juego [default: false]
local DisablePractice = false -- Evita que el jugador use practice [default: false]
local DisableBotPlay = false -- Evita que el jugador use botplay [default: false]


-- | UI settings |
local UiGroupCam = 'camHUD' -- Cámara para uiGroup [default: camHUD]
local ComboGroupCam = 'camHUD' -- Cámara para comboGroup [default: camHUD]
local ShowCombo = false -- Combo [default: false]
local ShowComboNum = true -- Combo de números [default: true]
local ShowRating = true -- Clasificaciones [default: true]
local StrumCamera = 'camHUD' -- Selecciona una cámara para los Strums [default: camHUD]
local Strums = 'strumLineNotes' --[[ Cual de los 3 Strums se usara
    para cambiar de cámara:
    1. playerStrums -> Notas de jugador
    2. opponentStrums -> Notas de oponente
    3. strumLineNotes -> Notas de jugador y oponente
    Por defecto se usara "strumLineNotes" en caso de que sea "nil"
    (default: strumLineNotes)
    ]]
local BotplayTxt = 'BOTPLAY' -- Texto de botplay [default: BOTPLAY]
local ForceScroll = false -- Forzar el desplazamiento todo el UI [default: false]
local ScrollX = 0 -- Desplazamiento X (Requiere ForceScroll) [default: 0]
local ScrollY = 0 -- Desplazamiento Y (Requiere ForceScroll) [default: 0]
local IconScaleX = 0.7 -- EscalaX base de los iconos [default: 0.7]
local IconScaleY = 0.7 -- EscalaY base de los iconos [default: 0.7]
local IconsArrows = true -- Los iconos se moverán con cada nota [default: true]
local IconMove = 7 -- Intensidad de movimiento (Requiere IconsArrows) [default: 7]
local IconsScaleBeatOn = true -- Activa el IconsScaleBeat [default: true]
local IconScaleBeatX = 0.8 -- Por cada Beat hará un cambio en su escalaX [default: 0.8]
local IconScaleBeatY = 0.8 -- Por cada Beat hará un cambio en su escalaY [default: 0.8]


-- | Simple Human Bot | Original: https://gamebanana.com/tools/18226
local ActivateBot = false -- Activa o desactiva el bot [default: false]
local precision = 'Normal' --[[ Precision del bot
    Opciones: "Normal", "Expert", "Custom"
    [default: Normal]
    ]]
local customOffsetRange = {-100,80} --[[ Precision personalizable
    (Requiere ActivateBot) [default: {-100,80}]
    ]]
local missChance = 0 --[[ Si se establece un número cercano a 1,
    el bot tendrá más probabilidades de fallar notas
    [default: 0]
    Idea de -> iamcyklus
    ]]


-- | Health |
local HealthDrainOp = true -- El oponente te drena vida [default: true]
local Drain = 0.02 -- Drenado de vida (Requiere HealthDrainOp) [default: 0.02]
local MinHealth = 0.4 -- Límite de drenado (Requiere HealthDrainOp) [default: 0.4]
local LowHealthSpin = true --[[ El icono de BF y de DAD,
    gire cuando la salud está por debajo del límite de MinHealth
    [default: true]
    ]]
local HealthBarLow = true --[[ La barra de vida parpadea,
    cuando BF o Dad están a poca vida [default: true]
    ]]


-- | ScoreMini |
local ScoreTxtMini = true -- Opción para que se vea el ScoreMini [default: true]
local ScoreMiniTxt = nil --[[ Texto que acompañara a la puntuación [default: nil]
    Ejemplo;
local ScoreMiniTxt = 'Score: '
    Será vera así:
    Score: 0
    ]]
local TimeScoreMini = 0.2 --[[ El tiempo que tardará,
    en llegar a la nueva puntuación [default: 0.2]
    ]]
local ColorScoreMini = '00FF00' --[[ El color que se volverá,
    el ScoreMini cuando se gana puntos
    [default: Hex 00FF00 (Verde)]
    ]]


-- | CamFlow |
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
local offset_opponent = 25
local offset_player = 25
local offset_gf = 25

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

-- Extras
local PathImages = 'HudMiniFlow/' -- Ruta de materiales
local VersionCheck = version ~= '0.7.2h' and version ~= '0.7.3' -- Versiones para verificar

function Materials()
    if VersionAlert and VersionCheck then
        createInstance('Background','flixel.addons.display.FlxBackdrop')
        loadGraphic('Background',PathImages..'BG')
        setObjectCamera('Background','camOther')
        screenCenter('Background')
        scaleObject('Background',0.05,0.05)
        setProperty('Background.color',getColorFromHex('840000'))
        setProperty('Background.alpha',0.35)
        callMethod('Background.velocity.set',{-100,100})
        addInstance('Background',true)

        makeLuaText('T1','English:\nThe Psych Engine version you are using is not compatible with "HUD MINI FLOW v'..VersionFlow..'"\n\nEspañol:\nLa versión de Psych Engine que estás usando no es compatible con "HUD MINI FLOW v'..VersionFlow..'"',screenWidth,0,screenHeight / 2.5)
        setTextSize('T1',23)
        setTextColor('T1','RED')
        setTextAlignment('T1','CENTER')
        setObjectCamera('T1','camOther')
        addLuaText('T1',true)
    end
end

function UIsetting()
    local ScrollY = not ForceScroll and (downscroll and 0 or 575) or ScrollY
    setProperty('healthBar.bg.visible',false)
    callMethod('healthBar.setPosition',{-150 + ScrollX,15 + ScrollY})
    callMethod('healthBar.scale.set',{Intro and 0.01 or 0.4,Intro and 0.01 or 1})
    setProperty('healthBar.alpha',Intro and 0 or 1)

    callMethod('iconBF.setPosition',{ScrollX + (Intro and 105 or 145),30 + ScrollY})
    callMethod('iconBF.scale.set',{Intro and 0.01 or IconScaleX,Intro and 0.01 or IconScaleY})
    setProperty('iconBF.alpha',Intro and 0 or 1)

    callMethod('iconDad.setPosition',{ScrollX + (Intro and 50 or 20),30 + ScrollY})
    callMethod('iconDad.scale.set',{Intro and 0.01 or IconScaleX,Intro and 0.01 or IconScaleY})
    setProperty('iconDad.alpha',Intro and 0 or 1)

    callMethod('scoreTxt.setPosition',{-489 + ScrollX,35 + ScrollY})
    setProperty('scoreTxt.visible',ScoreTxtMini)
    setProperty('scoreTxt.alpha',Intro and 0 or 1)

    callMethod('timeBar.setPosition',{-50 + ScrollX,5 + ScrollY})
    callMethod('timeBar.scale.set',{Intro and 0.01 or 0.4,Intro and 0.01 or 1})
    setProperty('timeBar.bg.visible',false)
    setProperty('timeBar.alpha',Intro and 0 or 1)

    setProperty('timeTxt.visible',false)
    setTextString('botplayTxt',BotplayTxt)
end
function onCountdownTick(counter)
    if Intro then
        for _,i in pairs({'iconBF','iconDad'}) do
            if counter == 0 then
                startTween('healthBarScaleSet','healthBar.scale',{x = 0.05,y = 1},0.5,{ease = 'backInOut'})
                doTweenAlpha('healthBarAlpha','healthBar',1,0.5,'backInOut')
                startTween('timeBarScaleSet','timeBar.scale',{x = 0.05,y = 1},0.5,{ease = 'backInOut'})
                doTweenAlpha('timeBarAlpha','timeBar',1,0.5,'backInOut')
            elseif counter == 1 then
                doTweenX('healthBarScaleX','healthBar.scale',0.4,(bpm >= 180) and 1.5 or 2,'backInOut')
                doTweenX('timeBarScaleX','timeBar.scale',0.4,(bpm >= 180) and 1.5 or 2,'backInOut')
                doTweenAlpha(i..'Alpha',i,1,0.3,'backInOut')
                startTween(i..'Scale',i..'.scale',{x = IconScaleX,y = IconScaleY},(bpm >= 180) and 0.3 or 0.5,{ease = 'backInOut'})
            elseif counter == 2 then
                iconBFXDefault = getProperty('iconBF.x') + 30
                iconBFYDefault = getProperty('iconBF.y')
                iconDadXDefault = getProperty('iconDad.x') - 30
                iconDadYDefault = getProperty('iconDad.y')
                doTweenX(i..'X',i,(i == 'iconDad') and getProperty('iconDad.x') - 30 or getProperty('iconBF.x') + 30,(bpm >= 180) and 1 or 1.5,'backInOut')
                doTweenX(i..'ScaleX',i..'.scale',0.9,1)
            elseif counter == 3 then
                doTweenX(i..'ScaleX',i..'.scale',IconScaleX,0.5,'bounceOut')
            elseif counter == 4 then
                if ScoreTxtMini and not getProperty('cpuControlled') then
                    doTweenAlpha('ScoreMiniAlpha','scoreTxt',1,0.5)
                else
                    setProperty('scoreTxt.visible',false)
                end
            end
        end
    end
end
-- | Function list |
function onBeatHit()
    IconsScaleBeat() -- IconsScaleBeat
end
function onPause()
    if DisablePause then return Function_Stop; end
end
function onCreate()
    Materials() -- Materials
    Options() -- Options
    ExtrasCreate() -- ExtrasCreate
end
function onCreatePost()
    UIMaker() -- UIMaker
    UIsetting() -- UIsetting
    ExtrasCreatePost() -- ExtrasCreatePost (onCreatePost)
end
function onUpdate(elapsed)
    IconsAnimations() -- IconsAnimations
    SimpleHumanBot() -- Simple Human Bot
    ExtrasUpdate() -- ExtrasUpdate (onUpdate)
end
function onUpdatePost(elapsed)
    ScoreMiniPost(elapsed) -- ScoreMini [elapsed]
    healthBarFix() -- healthBarFix
    onCamFlow() -- CamFlow
    ExtrasUpdatePost(elapsed) -- ExtrasUpdatePost (onUpdatePost) [elapsed]
end
function goodNoteHit(membersIndex,noteData,noteType,isSustainNote)
    IconBFArrows(noteData) -- IconsArrows [noteData]
end
function opponentNoteHit(membersIndex,noteData,noteType,isSustainNote)
    IconDadArrows(noteData) -- IconsArrows [noteData]
    HealthDrain() -- HealthDrain
end
function onTimerCompleted(tag,loops,loopsLeft)
    IconsReturn(tag) -- IconsReturn [tag]
end
function onEvent(eventName,value1,value2,strumTime)
    IconMakerRefresh(eventName,value1) -- IconMakerRefresh [eventName,value1]
    EventFlow(eventName,value1,value2) -- EventFlow [eventName,value1,value2]
end



-- Options
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
        setPropertyFromClass('backend.ClientPrefs','data.'..setting,value)
    end
end


-- UIMaker
-- Nota: El jodido "callMethod" no funcionaba bien con el "HealthIcon", así que mejor use "runHaxeCode"
function UIMaker()
    runHaxeCode([[
import objects.HealthIcon;

    var iconBF = new HealthIcon(boyfriend.healthIcon,true);
        game.variables.set('iconBF',iconBF);
        game.add(iconBF);
        game.uiGroup.add(iconBF);

    var iconDad = new HealthIcon(dad.healthIcon,false);
        game.variables.set('iconDad',iconDad);
        game.add(iconDad);
        game.uiGroup.add(iconDad);
    ]])
    setObjectCamera('uiGroup',UiGroupCam)
    setObjectCamera('comboGroup',ComboGroupCam)
end
function IconsAnimations()
    setProperty('iconP1.visible',false)
    setProperty('iconP2.visible',false)
    setProperty('iconBF.animation.curAnim.curFrame',getProperty('healthBar.percent') < 20 and 1 or 0)
    setProperty('iconDad.animation.curAnim.curFrame',getProperty('healthBar.percent') > 80 and 1 or 0)
    if LowHealthSpin and curStep > 0 then
        doTweenAngle('IconBFAngle','iconBF',getProperty('healthBar.percent') < 20 and iconBFAngleDefault + 360 or iconBFAngleDefault,0.3)
        doTweenAngle('IconDadAngle','iconDad',getProperty('healthBar.percent') > 80 and iconDadAngleDefault + 360 or iconDadAngleDefault,0.3)
    end
end
-- IconMakerRefresh [eventName,value1]
function IconMakerRefresh(n,v1)
    if n == 'Change Character' then
        local iconVar = (string.lower(v1) == 'dad' or string.lower(v1) == 'opponent') and 'iconDad' or not (string.lower(v1) == 'gf' or string.lower(v1) == 'girlfriend') and 'iconBF'
        local charIcon = (iconVar == 'iconDad') and 'dad.healthIcon' or 'boyfriend.healthIcon'
        runHaxeCode(('game.variables.get("%s").changeIcon(%s)'):format(iconVar,charIcon))
    end
end


-- IconsScaleBeat
function IconsScaleBeat()
    if IconsScaleBeatOn then
        for _,i in pairs({'iconBF','iconDad'}) do
            callMethod(i..'.scale.set',{IconScaleBeatX,IconScaleBeatY})
            startTween('Tween'..i..'ScaleXY',i..'.scale',{x = IconScaleX,y = IconScaleY},0.5,{ease = 'bounceOut'})
            -- doTweenX('Tween'..i..'ScaleX',i..'.scale',IconScaleX,0.5,'bounceOut')
            -- doTweenY('Tween'..i..'ScaleY',i..'.scale',IconScaleY,0.5,'bounceOut')
        end
    end
end


-- IconsArrows [noteData]
function IconBFArrows(noteData)
    if IconsArrows then
        local x,y = iconBFXDefault,iconBFYDefault
        if noteData == 0 then x = x - IconMove
        elseif noteData == 1 then y = y + IconMove
        elseif noteData == 2 then y = y - IconMove
        elseif noteData == 3 then x = x + IconMove end
        doTweenX('iconBFX','iconBF',x,0.15)
        doTweenY('iconBFY','iconBF',y,0.15)
        runTimer('iconBFReturn',0.15)
    end
end
function IconDadArrows(noteData)
    if IconsArrows then
        local x,y = iconDadXDefault,iconDadYDefault
        if noteData == 0 then x = x - IconMove
        elseif noteData == 1 then y = y + IconMove
        elseif noteData == 2 then y = y - IconMove
        elseif noteData == 3 then x = x + IconMove end
        doTweenX('iconDadX','iconDad',x,0.15)
        doTweenY('iconDadY','iconDad',y,0.15)
        runTimer('iconDadReturn',0.15)
    end
end
-- IconsReturn [tag]
function IconsReturn(t)
    if t == 'iconBFReturn' or t == 'iconDadReturn' then
        local char = t == 'iconBFReturn' and 'iconBF' or 'iconDad'
        doTweenX(char..'XReturn',char,_G[char..'XDefault'],0.15)
        doTweenY(char..'YReturn',char,_G[char..'YDefault'],0.15)
    end
end


-- saveFileLua [filePath,content,absolute]
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
        addHealth(-math.abs(Drain))
    end
end


-- Simple Human Bot v1.2
function SimpleHumanBot()
    runHaxeCode([[
    var ActivateBot = ]]..tostring(ActivateBot)..[[;
    var precision = "]]..precision..[[";
    var customOffsetRange = []]..customOffsetRange[1]..[[,]]..customOffsetRange[2]..[[];
    var missChance = ]]..missChance..[[;

   if (!ActivateBot) return;
        var songPos = Conductor.songPosition;
        var randomOffset:Int;
        for (note in game.notes) {
            switch(precision) {
                case 'Normal':
                    randomOffset = FlxG.random.int(-100,100);
                case 'Expert':
                    randomOffset = FlxG.random.int(-50,50);
                case 'Custom':
                    randomOffset = FlxG.random.int(customOffsetRange[0],customOffsetRange[1]);
                default:
                    randomOffset = FlxG.random.int(-100,100);
            }
            if (note.canBeHit && note.strumTime <= songPos - randomOffset && !note.ignoreNote && FlxG.random.float(0,1) > missChance) {
                game.goodNoteHit(note);
            }
        }
        for (strum in game.playerStrums) {
            if (strum.animation.curAnim.finished && strum.animation.curAnim.name != 'static') {
                strum.playAnim('static');
            }
        }
    ]])
end


-- ExtrasCreate (onCreate)
function ExtrasCreate()
    setProperty('skipCountdown',SkipCountdown)
    setProperty('guitarHeroSustains',not HealthDrainOp)
    if getProperty('practiceMode') then
        setProperty('practiceMode',not DisablePractice)
    end
    if getProperty('cpuControlled') then
        setProperty('cpuControlled',not DisableBotPlay)
    end
    setProperty('showCombo',ShowCombo)
    setProperty('showComboNum',ShowComboNum)
    setProperty('showRating',ShowRating)
end

-- ExtrasCreatePost (onCreatePost)
function ExtrasCreatePost()
    -- [Defaults]
    iconBFXDefault = getProperty('iconBF.x')
    iconBFYDefault = getProperty('iconBF.y')
    iconDadXDefault = getProperty('iconDad.x')
    iconDadYDefault = getProperty('iconDad.y')
    iconBFAngleDefault = getProperty('iconBF.angle')
    iconDadAngleDefault = getProperty('iconDad.angle')
    -- [DefaultCams]
    if not CustomCam then
        camX_player= getMidpointX('boyfriend') - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]') - 100
        camY_player = getMidpointY('boyfriend') + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]') - 100
        camX_opponent = getMidpointX('dad') + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + 150
        camY_opponent = getMidpointY('dad') + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') - 100
        camX_gf = getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')
        camY_gf = getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')
    end
    runHaxeCode([[
    var Camera = game.]]..StrumCamera..[[;
    var strumGroup = game.]]..(Strums == nil and 'strumLineNotes' or Strums)..[[;

        for (strum in strumGroup) { 
            if (Camera == game.camGame) strum.scrollFactor.set(1,1);
            strum.cameras = [Camera];
        }
        for (noteSplash in game.grpNoteSplashes) {
            if (Camera == game.camGame) noteSplash.scrollFactor.set(1,1);
            noteSplash.cameras = [Camera];
        }
        for (note in game.unspawnNotes) {
            if (Camera == game.camGame) note.scrollFactor.set(1,1);
            if (strumGroup == game.opponentStrums) {
                if (!note.mustPress) note.cameras = [Camera];
            } else if (strumGroup == game.playerStrums) {
                if (note.mustPress) note.cameras = [Camera];
            } else {
                note.cameras = [Camera];
            }
        }
    ]])
    if SmoothHealth then
        runHaxeCode([[
            game.variables.set('smoothHealth',game.health);
            game.healthBar.valueFunction = function() { 
                return game.variables.get('smoothHealth'); 
            };
        ]])
    end
end

-- ExtrasUpdate (onUpdate)
function ExtrasUpdate()
    local hp,stepMod = getProperty('healthBar.percent'),curStep % 6
    local bfAlpha = hp < 20 and (stepMod == 0 and 1 or 0.1) or 1
    local dadAlpha = hp > 80 and (stepMod == 0 and 1 or 0.1) or 1
    if HealthBarLow then
        doTweenAlpha('healthBarBF','healthBar.rightBar',bfAlpha,hp < 20 and 0.15 or 0.5)
        doTweenAlpha('healthBarDad','healthBar.leftBar',dadAlpha,0.15)
    end
    if ColorBarVanilla then
        HealthBarColorFix = false
        setHealthBarColors('FF0000','00FF00')
    end
    setProperty('camZooming',not DisableCameraZoom)
end

-- ExtrasUpdatePost (onUpdatePost) [elapsed]
function ExtrasUpdatePost(elapsed)
    if SmoothHealth then
        runHaxeCode([[
        var smoothHealth = game.variables.get('smoothHealth');
        var factor = FlxMath.bound(]]..elapsed..[[ * ]]..SmoothHealthSpeed..[[ * game.playbackRate,0,1);
            game.variables.set('smoothHealth',FlxMath.lerp(smoothHealth,game.health,factor));
        ]])
    end
    if VersionAlert and VersionCheck then
        setProperty('camGame.alpha',0.5)
        setProperty('camHUD.alpha',0.5)
    end
    -- Error de la 0.7.2h con el grpNoteSplashes
    for i = 0,getProperty('grpNoteSplashes.length') - 1 do
        if version == '0.7.2h' then
            setPropertyFromGroup('grpNoteSplashes',i,'visible',false)
        end
    end
end


-- ScoreMini v1
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
        local ScoreMiniTxt = ScoreMiniTxt == nil and '' or ScoreMiniTxt
        setTextString('scoreTxt',ScoreMiniTxt..math.floor(ScoreActual))
    end
end


-- CamFlow v1.5
-- Estoy tratando de hacer el CamFlow lo mas compacto posible
-- Eventos disponibles en la v2 Pronto...
function onCamFlow()
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


-- healthBarFix v1.2
function healthBarFix()
    if HealthBarColorFix then
        bfRGB,dadRGB = getProperty('boyfriend.healthColorArray'),getProperty('dad.healthColorArray')
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
    local adj = (lum > 128) and -70 or 70
    return { math.max(0,math.min(255,r + adj)),math.max(0,math.min(255,g + adj)),math.max(0,math.min(255,b + adj)) }
end


-- ColorHex v2
function rgbToHex(input,g,b)
    local r
    if type(input) == 'table' then
        r,g,b = input.r or input[1],input.g or input[2],input.b or input[3]
    else
        r = input
    end
    if type(r) ~= 'number' or type(g) ~= 'number' or type(b) ~= 'number' or
       r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255 then
        return nil
    end
    return string.format('0x%02X%02X%02X',r,g,b)
end



-- Reporte cualquier error de forma detallada a LuaXdea
