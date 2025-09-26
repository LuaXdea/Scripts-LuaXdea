--[[
    | Event: FlashLua v1 | - | By LuaXdea [Coder] |
    [YouTube]: https://youtube.com/@lua-x-dea?si=6AIgRDcOr08Aw22Y
]]
function onCreate()
    makeLuaSprite('FlashLua',nil)
    makeGraphic('FlashLua',1280,720,'FFFFFF')
    setObjectCamera('FlashLua','camOther')
    setProperty('FlashLua.alpha',0)
    addLuaSprite('FlashLua')
end
function onEvent(n,v1,v2)
    if n == 'FlashLua' and flashingLights then
        local OptionsV1 = stringSplit(v1 or '',',')
        local Alpha = tonumber(OptionsV1[1]) or 1
        local isMonoChrom = OptionsV1[2] == 'true' or (OptionsV1[2] ~= 'false' and true)
        setBlendMode('FlashLua',isMonoChrom and 'ADD' or not isMonoChrom and 'SUBTRACT')
        setProperty('FlashLua.alpha',Alpha)
        doTweenAlpha('FlashLuaAlpha','FlashLua',0,tonumber(v2) or 0.5)
    end
end
