-- | Music visualizer v1.2 | by LuaXdea |
-- | Creador original: https://x.com/Zozzz357638?s=09 |

-- | Compatibilidad | [0.7.2h,0.7.3]

-- | Configuración |
local numBars = 85 -- Número total de barras
local barWidth = 15 -- Ancho de cada barra
local BlendMode = 'add' -- Modo de funcion

-- | Resolución de referencia |
local hudW,hudH = 1280,720

-- | Pocision de visualizador | XY |
local visualizerOffsetX,visualizerOffsetY = 0,0

-- | Colores de barras | Limite: No ahi :3 |
local barColors = {'FF0000','00A8FF'}

-- | Separación entre barras |
local barGap = 1

-- | Suavidad de barras |
local scaleSpeed = 8

-- | Intensidad del visualizador (ajusta a tu gusto, 1 = normal, 2 = el doble, etc.) |
local reactIntensity = 1

-- | 1 = Music | 2 = Music + vocals | 3 = Music + vocals + opponentVocals
local visualizerMode = 3
-- {Music,vocals,opponentVocals} valores continuos [0 a 1]
local sourcePriority = {1,0.3,0.3}



-- | No tocar |
local waveCurScale,waveTargetScale = {},{}
local barBottomY,tags = {},{}
local barHeightBase = 5
local barGap = math.abs(math.floor(barGap))
local songStarted = false

function onCreate()
    local totalWidth = (numBars * barWidth) + ((numBars - 1) * barGap)
    local startX = (hudW / 2) - (totalWidth / 2) + visualizerOffsetX
    local baseY = hudH + visualizerOffsetY
    for i = 1,numBars do
        local r,g,b = getColorFromTable(i,numBars,barColors)
        local hex = string.format('%02x%02x%02x',r,g,b)
        local tag = 'bar'..i
        tags[i]   = tag
        local x = startX + (i - 1) * (barWidth + barGap)
        makeLuaSprite(tag,nil,x,baseY - barHeightBase)
        makeGraphic(tag,barWidth,barHeightBase,hex)
        setObjectCamera(tag,'other')
        addLuaSprite(tag)
        setProperty(tag..'.alpha',0)

        barBottomY[i] = baseY
        waveCurScale[i] = 1
        waveTargetScale[i] = 1
    end
end
function onSongStart()
    songStarted = true
    for i = 1,numBars do
        doTweenAlpha('barAlpha'..i,tags[i],1,2,'smootherStepOut')
    end
end
function onUpdate(elapsed)
    if not songStarted then return end
    visualizerMode,sourcePriority = normalizeConfig(visualizerMode,sourcePriority)
    local success,samples = pcall(function()
        return runHaxeCode([[
            try {
                var bytes = [];
                var sources:Array<Dynamic> = [];
                var weights:Array<Float> = [];
                var mode = ]]..visualizerMode..[[;
                var pMusic = ]]..sourcePriority[1]..[[;
                var pVoc   = ]]..sourcePriority[2]..[[;
                var pOpp   = ]]..sourcePriority[3]..[[;

                // | Music - [Instrumental] |
                if (FlxG.sound.music != null && FlxG.sound.music._sound != null && pMusic > 0) {
                    sources.push(FlxG.sound.music._sound.__buffer);
                    weights.push(pMusic);
                }
                // | Vocals |
                if (mode >= 2 && game.vocals != null && game.vocals._sound != null && pVoc > 0) {
                    sources.push(game.vocals._sound.__buffer);
                    weights.push(pVoc);
                }
                // | opponentVocals |
                if (mode >= 3 && game.opponentVocals != null && game.opponentVocals._sound != null && pOpp > 0) {
                    sources.push(game.opponentVocals._sound.__buffer);
                    weights.push(pOpp);
                }
                if (sources.length == 0) return null;
                var sr = sources[0].sampleRate;
                var time = FlxG.sound.music.time / 1000;
                var pos = Math.floor(time * sr);
                for (i in 0...]]..numBars..[[) {
                    var mixed = 0.0;
                    var totalW = 0.0;
                    for (j in 0...sources.length) {
                        var s = sources[j];
                        var w = weights[j];
                        var index = (pos + i * 64) * s.channels * 2;
                        if (index + 1 < s.data.length) {
                            var byte = s.data.buffer.getUInt16(index);
                            var val = (byte > 32767 ? byte - 65536 : byte);
                            mixed += val * w;
                            totalW += w;
                        }
                    }
                    if (totalW > 0) mixed /= totalW;
                    bytes.push(Math.floor(mixed));
                }
                return bytes;
            } catch(e) { return null; }
        ]])
    end)
    if not (success and samples) then return end
    for i = 1,numBars do
        local sample = samples[i] or 0
        local height = 5 + math.abs(sample / 32768) * (300 * reactIntensity)
        waveTargetScale[i] = height / barHeightBase
        waveCurScale[i] = smoothStep(waveCurScale[i],waveTargetScale[i],elapsed * scaleSpeed)
        local tag = tags[i]
        scaleObject(tag,1,waveCurScale[i])
        local currentHeight = barHeightBase * waveCurScale[i]
        setProperty(tag..'.y',barBottomY[i] - currentHeight)
        setBlendMode(tag,BlendMode)
    end
end

-- | Funciones Extras |
function smoothStep(a,b,t)
    if t > 1 then t = 1 end
    local f = t * t * (3 - 2 * t)
    return a + (b - a) * f
end
function hexToRgb(hex)
    hex = hex:gsub('#','')
    return tonumber('0x'..hex:sub(1,2)),
           tonumber('0x'..hex:sub(3,4)),
           tonumber('0x'..hex:sub(5,6))
end
function hsvToRgb(h,s,v)
    local c,x,m = v * s,v * s * (1 - math.abs((h / 60) % 2 - 1)),v - v * s
    local r,g,b
    if h < 60 then r,g,b = c,x,0
    elseif h < 120 then r,g,b = x,c,0
    elseif h < 180 then r,g,b = 0,c,x
    elseif h < 240 then r,g,b = 0,x,c
    elseif h < 300 then r,g,b = x,0,c
    else r,g,b = c,0,x end
    return (r + m) * 255,(g + m) * 255,(b + m) * 255
end
function getColorFromTable(i,max,colors)
    if #colors == 1 then return hexToRgb(colors[1]) end
    local pos = (i - 1) / (max - 1)
    local seg = pos * (#colors - 1)
    local idx = math.floor(seg) + 1
    local t   = seg - math.floor(seg)
    local r1,g1,b1 = hexToRgb(colors[idx])
    local r2,g2,b2 = hexToRgb(colors[math.min(idx + 1,#colors)])
    return r1 + (r2 - r1) * t,
           g1 + (g2 - g1) * t,
           b1 + (b2 - b1) * t
end
function normalizeConfig(mode,pri)
    local m = tonumber(mode) or 1
    m = math.floor(m + 0.5)
    if m < 0 then m = -m end
    if m == 0 then m = 1 end
    if m > 3 then m = 3 end
    local p = pri or {1,1,1}
    for i = 1,3 do
        local v = tonumber(p[i]) or 1
        if v < 0 then v = 0 elseif v > 1 then v = 1 end
        p[i] = v
    end
    return m,p
end
