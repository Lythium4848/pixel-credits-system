CATEGORY_NAME = "PIXELCredits"

// Give Credits
function ulx.givecredits( calling_ply, target_ply, num )
    if SERVER then
        PIXEL.Credits.DebugLog(target_ply)
        PIXEL.Credits.DB.GiveCredits(target_ply, num)
    end
    local name = "credits"
    if num == "1" then name = "credit" end

    ulx.fancyLogAdmin(calling_ply, true, "#A gave #T #s #s", target_ply, num, name )

end

local pixelcredits_give = ulx.command(CATEGORY_NAME, "ulx givecredits", ulx.givecredits, "!givecredits")
pixelcredits_give:addParam{ type = ULib.cmds.PlayerArg }
pixelcredits_give:addParam{ type = ULib.cmds.StringArg, hint = "Number", ULib.cmds.takeRestOfLine }
pixelcredits_give:defaultAccess( ULib.ACCESS_SUPERADMIN  )
pixelcredits_give:help( "Give a player credits" )

// Remove Credits
function ulx.removecredits( calling_ply, target_ply, num )
    if SERVER then
        PIXEL.Credits.DebugLog(target_ply)
        PIXEL.Credits.DB.RemoveCredits(target_ply, num)
    end
    local name = "credits"
    if num == "1" then name = "credit" end

    ulx.fancyLogAdmin(calling_ply, true, "#A removed #s #s from #T", num, name, target_ply )

end

local pixelcredits_remove = ulx.command(CATEGORY_NAME, "ulx removecredits", ulx.removecredits, "!removecredits")
pixelcredits_remove:addParam{ type = ULib.cmds.PlayerArg }
pixelcredits_remove:addParam{ type = ULib.cmds.StringArg, hint = "Number", ULib.cmds.takeRestOfLine }
pixelcredits_remove:defaultAccess( ULib.ACCESS_SUPERADMIN  )
pixelcredits_remove:help( "Removes a players credits" )
