--[[
    | Event: flashLines | - | By LuaXdea [Coder] |
    [YouTube]: https://youtube.com/@lua-x-dea?si=6AIgRDcOr08Aw22Y
]]
local randomActive = false
function onCreate()
    local numLines = 10
    local lineWidth = math.ceil(1280 / numLines)
    for i = 1,numLines do
        makeLuaSprite('Line'..i,nil,(i - 1) * lineWidth)
        makeGraphic('Line'..i,lineWidth,720,'FFFFFF')
        if version == '1.0' then
        setProperty('Line'..i..'.camera',instanceArg('camOther'),false,true)
        else
        setObjectCamera('Line'..i,'camOther')
        end
        setProperty('Line'..i..'.alpha',0)
        setBlendMode('Line'..i,'ADD')
        addLuaSprite('Line'..i)
    end
end
function onEvent(n,v1,v2)
    if n == 'flashLines' then
        if v1:lower() == 'random' or v1:lower() == 'r' then
            Value2 = stringSplit(v2,',')
            stopRandomization()
            startRandomization(Value2)
        else
            local lineNumbers = stringSplit(v1,',')
            flashLines(lineNumbers)
        end
    end
end
function startRandomization(values)
    runTimer('randomLines',tonumber(values[1]) or 0.03)
    runTimer('stopRandom',tonumber(values[2]) or 0.5)
    randomActive = true
end
function stopRandomization()
    if randomActive then
        cancelTimer('randomLines')
        cancelTimer('stopRandom')
        randomActive = false
    end
end
function flashLines(numbers)
    for _, num in ipairs(numbers) do
        local line = 'Line'..num
        setProperty(line..'.alpha',1)
        setProperty(line..'.scale.x',1)
        doTweenAlpha(line..'AlphaTween',line,0,0.5)
        doTweenX(line..'ScaleTween',line..'.scale',0.01,0.5)
    end
end
function onTimerCompleted(t)
    if randomActive and t == 'randomLines' then
        flashLines({math.random(1,10)})
        runTimer('randomLines',Value2[1] or 0.03)
    elseif t == 'stopRandom' then
        stopRandomization()
    end
end
