--[[
    | Event: SimpleBar v1 | - | By LuaXdea [Coder] |
    [YouTube]: https://youtube.com/@lua-x-dea?si=6AIgRDcOr08Aw22Y
]]
function onCreatePost()
    local barData = {
        {name = 'TopBar',x = 0,y = -360,width = 1280,height = 360},
        {name = 'BottomBar',x = 0,y = 720,width = 1280,height = 360},
        {name = 'LeftBar',x = -640,y = 0,width = 640,height = 720},
        {name = 'RightBar',x = 1280,y = 0,width = 640,height = 720}
    }
    for _,bar in ipairs(barData) do
        makeLuaSprite(bar.name,nil,bar.x,bar.y)
        makeGraphic(bar.name,bar.width,bar.height,'000000')
        if version == '1.0' then
        setProperty(bar.name..'.camera',instanceArg('camHUD'),false,true)
        else
        setObjectCamera(bar.name,'camHUD')
        end
        addLuaSprite(bar.name)
    end
    barPositions = {
        topBarY = -360,
        bottomBarY = 720,
        leftBarX = -640,
        rightBarX = 1280
    }
end
function onEvent(n,v1,v2)
    if n == 'SimpleBar' then
        local params = stringSplit(v1,',')
        local speed = tonumber(params[1])
        local mode = params[2] and params[2]:lower() == 'a'
        local offset = tonumber(v2)
        if not mode then debugPrint((offset < 0 or offset > 360) and 'Limit from 0 to 360' or '','FF0000') end
        if mode then debugPrint((offset < 0 or offset > 640) and 'Limit from 0 to 640' or '','FF0000') end
        if speed and offset then
            if mode and offset >= 0 and offset <= 640 then
                local leftTarget = barPositions.leftBarX + offset
                local rightTarget = barPositions.rightBarX - offset
                local easing = offset > 0 and 'quadOut' or 'quadIn'
                doTweenX('LeftBarTween','LeftBar',leftTarget,speed,easing)
                doTweenX('RightBarTween','RightBar',rightTarget,speed,easing)
            elseif not mode and offset >= 0 and offset <= 360 then
                local topTarget = barPositions.topBarY + offset
                local bottomTarget = barPositions.bottomBarY - offset
                local easing = offset > 0 and 'quadOut' or 'quadIn'
                doTweenY('TopBarTween','TopBar',topTarget,speed,easing)
                doTweenY('BottomBarTween','BottomBar',bottomTarget,speed,easing)
            end
        end
    end
end
