-- | backportFunctions [Test] | by LuaXdea |

function onCreate()
    runHaxeCode([[
    import psychlua.FunkinLua;
    import psychlua.LuaUtils;
    import states.MainMenuState;

    if (MainMenuState.psychEngineVersion == '0.7.1h') {
        FunkinLua.customFunctions.set('instanceArg',function(instanceName:String,?className:String = null) {
            var retStr:String ='$instanceStr::$instanceName';
            if(className != null) retStr += '::$className';
            return retStr;
        });
    }
        FunkinLua.customFunctions.set('loadMultipleFrames',function(variable:String,images:Array<String>) {
            var split:Array<String> = variable.split('.');
            var spr:FlxSprite = LuaUtils.getObjectDirectly(split[0]);
            if(split.length > 1) {
                spr = LuaUtils.getVarInArray(LuaUtils.getPropertyLoop(split),split[split.length-1]);
            }
            if(spr != null && images != null && images.length > 0)
            {
                spr.frames = Paths.getMultiAtlas(images);
            }
        });
        FunkinLua.customFunctions.set('getObjectOrder',function(obj:String,?group:String = null) {
            var leObj:FlxBasic = LuaUtils.getObjectDirectly(obj);
            if(leObj != null)
            {
                if(group != null)
                {
                    var groupOrArray:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(),group);
                    if(groupOrArray != null)
                    {
                        switch(Type.typeof(groupOrArray))
                        {
                            case TClass(Array): //Is Array
                                return groupOrArray.indexOf(leObj);
                            default: //Is Group
                                return Reflect.getProperty(groupOrArray,'members').indexOf(leObj); //Has to use a Reflect here because of FlxTypedSpriteGroup
                        }
                    }
                    else
                    {
                        luaTrace('getObjectOrder: Group $group doesn\'t exist!',false,false,FlxColor.RED);
                        return -1;
                    }
                }
                var groupOrArray:Dynamic = CustomSubstate.instance != null ? CustomSubstate.instance : LuaUtils.getTargetInstance();
                return groupOrArray.members.indexOf(leObj);
            }
            luaTrace('getObjectOrder: Object $obj doesn\'t exist!', false,false,FlxColor.RED);
            return -1;
        });
        FunkinLua.customFunctions.set('setObjectOrder',function(obj:String,position:Int,?group:String = null) {
            var leObj:FlxBasic = LuaUtils.getObjectDirectly(obj);
            if(leObj != null)
            {
                if(group != null)
                {
                    var groupOrArray:Dynamic = Reflect.getProperty(LuaUtils.getTargetInstance(),group);
                    if(groupOrArray != null)
                    {
                        switch(Type.typeof(groupOrArray))
                        {
                            case TClass(Array): //Is Array
                                groupOrArray.remove(leObj);
                                groupOrArray.insert(position,leObj);
                            default: //Is Group
                                groupOrArray.remove(leObj,true);
                                groupOrArray.insert(position,leObj);
                        }
                    }
                    else luaTrace('setObjectOrder: Group $group doesn\'t exist!',false,false,FlxColor.RED);
                }
                else
                {
                    var groupOrArray:Dynamic = CustomSubstate.instance != null ? CustomSubstate.instance : LuaUtils.getTargetInstance();
                    groupOrArray.remove(leObj,true);
                    groupOrArray.insert(position,leObj);
                }
                return;
            }
            luaTrace('setObjectOrder: Object $obj doesn\'t exist!', false,false,FlxColor.RED);
        });
        FunkinLua.customFunctions.set('setCameraScroll',function(x:Float,y:Float) {
            FlxG.camera.scroll.set(x - FlxG.width / 2,y - FlxG.height / 2);
        });
        FunkinLua.customFunctions.set('setCameraFollowPoint',function(x:Float,y:Float) {
            game.camFollow.setPosition(x,y);
        });
        FunkinLua.customFunctions.set('addCameraScroll',function(?x:Float = 0,?y:Float = 0) {
            FlxG.camera.scroll.add(x,y);
        });
        FunkinLua.customFunctions.set('addCameraFollowPoint',function(?x:Float = 0,?y:Float = 0) {
            game.camFollow.x += x;
            game.camFollow.y += y;
        });
        FunkinLua.customFunctions.set('getCameraScrollX',function() {
            return FlxG.camera.scroll.x + FlxG.width / 2;
        });
        FunkinLua.customFunctions.set('getCameraScrollY',function() {
            return FlxG.camera.scroll.y + FlxG.height / 2;
        });
        FunkinLua.customFunctions.set('getCameraFollowX',function() {
            return game.camFollow.x;
        });
        FunkinLua.customFunctions.set('getCameraFollowY',function() {
            return game.camFollow.y;
        });
    ]])
end
