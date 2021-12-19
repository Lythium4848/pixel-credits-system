PIXEL = PIXEL or {}
PIXEL.Credits = PIXEL.Credits or {}
PIXEL.Credits.DB = PIXEL.Credits.DB or {}

// Get Player Credits
function PIXEL.Credits.DB.GetCredits(userid, callback)
	PIXEL.Credits.DB.Query(string.format("SELECT credits FROM credit_users WHERE userid=%s;", userid), callback)
end

// Gives Player credits
function PIXEL.Credits.DB.GiveCredits(player, num)
	local target = player[1]
	local targetID = target:SteamID64()

	PIXEL.Credits.DB.GetCredits(targetID, function(data)
		if not data[1] then
			PIXEL.Credits.Log("warning", "Failed to give credits to " .. target:Nick() .. " (" .. targetID .. ")")

			return
		end

		PIXEL.Credits.DB.Query(string.format([[
	    	UPDATE credit_users
	    	SET credits = %s
	    	WHERE userid = %s;
		]], data[1].credits + num, targetID))
	end)

end

// Removes Player credits
function PIXEL.Credits.DB.RemoveCredits(player, num)
	local target = player[1]
	local targetID = target:SteamID64()

	PIXEL.Credits.DB.GetCredits(targetID, function(data)
		if not data[1] then
			PIXEL.Credits.Log("warning", "Failed to remove credits from " .. target:Nick() .. " (" .. targetID .. ")")

			return
		end

		PIXEL.Credits.DB.Query(string.format([[
	    	UPDATE credit_users
	    	SET credits = %s
	    	WHERE userid = %s;
		]], data[1].credits - num, targetID))
	end)

end