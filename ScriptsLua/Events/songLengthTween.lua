-- | songLengthTween | by LuaXdea | 0.7.x • 1.0.x |
-- [YouTube] https://youtube.com/@lua-x-dea?si=B5m77O3lMFn_GOoa

local RestartSong = false
function onEvent(n,v1,v2)
    if n == 'songLengthTween' and (timeBarType == 'Time Left' or timeBarType == 'Song Name') then
        if v1 and v1 ~= '' then
            local m,s = v1:match('(%d+):?(%d*)')
            m,s = tonumber(m) or 0,tonumber(s) or 0
            if s >= 60 then m,s = m + math.floor(s / 60),s % 60 end
            ms = (m * 60 + s) * 1000
        else
            ms = getPropertyFromClass('flixel.FlxG','sound.music.length') -- Por si acaso :3
        end
        local d,e = (v2..','):match('([^,]*),([^,]*)')
        startTween('songLengthTween','game',{songLength = ms},tonumber(d) or 0.5,{ease = (e ~= '' and e) or 'linear'})
    else
        if not RestartSong then
            debugPrint('[songLengthTween] no es compatible con [Time Elapsed]\n\nSe cambió automáticamente a [Time Left]\n\nReiniciando el nivel en 5 segundos','RED')
            setPropertyFromClass('backend.ClientPrefs','data.timeBarType','Time Left')
            runTimer('Restart',1,6)
            RestartSong = not RestartSong
        end
    end
end
function onTimerCompleted(t,_,loopsLeft)
    if t == 'Restart' then
        if loopsLeft > 0 then
            debugPrint(tostring(loopsLeft))
        else
            debugPrint('0')
            restartSong()
        end
    end
end
