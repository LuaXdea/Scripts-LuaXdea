-- | SceneTint v1.1 | by LuaXdea |
local DadCapa,BfCapa,GfCapa
local Multiplier = 2
local OriginalColors = {}
local Props = {'redMultiplier','greenMultiplier','blueMultiplier','redOffset','greenOffset','blueOffset'}

local function ParseToken(Token)
    if not Token then return 'WHITE' end
    Token = Token:gsub('#',''):gsub('%s','')
    if Token == '' or Token:lower() == 'nil' then return 'WHITE' end
    if #Token == 3 then
        Token = Token:sub(1,1):rep(2)..Token:sub(2,2):rep(2)..Token:sub(3,3):rep(2)
    end
    return (#Token == 6 and Token:match('^[0-9A-Fa-f]+$')) and Token:upper() or 'WHITE'
end
local function HexToRGB(Hex)
    return tonumber(Hex:sub(1,2),16),tonumber(Hex:sub(3,4),16),tonumber(Hex:sub(5,6),16)
end
local function SetCharColor(Char,Token,Restore)
    if Restore then
        for I,Prop in ipairs(Props) do
            setProperty(Char..'.colorTransform.'..Prop, OriginalColors[Char][I])
        end
        return
    end
    local R,G,B = 255,255,255
    if Token ~= 'WHITE' then R,G,B = HexToRGB(Token) end
    setProperty(Char..'.colorTransform.redMultiplier',0)
    setProperty(Char..'.colorTransform.greenMultiplier',0)
    setProperty(Char..'.colorTransform.blueMultiplier',0)
    setProperty(Char..'.colorTransform.redOffset',R)
    setProperty(Char..'.colorTransform.greenOffset',G)
    setProperty(Char..'.colorTransform.blueOffset',B)
end
function onCreate()
    makeLuaSprite('Base')
    makeGraphic('Base',screenWidth * Multiplier,screenHeight * Multiplier,'000000')
    setProperty('Base.alpha',0)
    screenCenter('Base')
    setObjectOrder('Base',400)
    addLuaSprite('Base')
    for _,Char in ipairs({'dad','boyfriend','gf'}) do
        OriginalColors[Char] = {}
        for _,Prop in ipairs(Props) do
            table.insert(OriginalColors[Char],getProperty(Char..'.colorTransform.'..Prop))
        end
    end
end
function onEvent(n,v1,v2)
    if n ~= 'SceneTint' then return end
    local Args = stringSplit(v1 or '',',')
    local Mode = Args[1] or '0'
    local BaseHex = Args[2] or '000000'
    if Mode == '1' then
        DadCapa = getObjectOrder('dadGroup')
        BfCapa = getObjectOrder('boyfriendGroup')
        GfCapa = getObjectOrder('gfGroup')
        cameraFlash('camHUD','FFFFFF',0.25)
        setObjectOrder('dadGroup',420)
        setObjectOrder('gfGroup',410)
        setObjectOrder('boyfriendGroup',430)
        local Parts = stringSplit(v2 or '',',')
        while #Parts < 3 do table.insert(Parts,'') end
        SetCharColor('dad',ParseToken(Parts[1]),false)
        SetCharColor('boyfriend',ParseToken(Parts[2]),false)
        SetCharColor('gf',ParseToken(Parts[3]),false)
        setProperty('Base.colorTransform.color',getColorFromHex(BaseHex or '000000'))
        setProperty('Base.alpha',1)
    elseif Mode == '0' then
        cameraFlash('camHUD','FFFFFF',0.25)
        setObjectOrder('dadGroup',DadCapa)
        setObjectOrder('boyfriendGroup',BfCapa)
        setObjectOrder('gfGroup',GfCapa)
        for _,Char in ipairs({'dad','boyfriend','gf'}) do
            SetCharColor(Char,nil,true)
        end
        setProperty('Base.alpha',0)
    end
end
