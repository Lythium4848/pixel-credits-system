PIXEL = PIXEL or {}
PIXEL.Credits = PIXEL.Credits or {}
PIXEL.Credits.DB = PIXEL.Credits.DB or {}

util.AddNetworkString( "pixel_credits_setup_user" )
util.AddNetworkString( "pixel_credits_finished_setup_user" )

net.Receive("pixel_credits_setup_user", function()
	local ply = net.ReadEntity()
	local plySteamID = ply:SteamID64()

	PIXEL.Credits.DebugLog("Setting up user " .. plySteamID .. ".")
	PIXEL.Credits.DB.Query("INSERT IGNORE INTO `credit_users` (`userid`) VALUES ('" .. plySteamID .. "')")

	PIXEL.Credits.DB.GetCredits(plySteamID, function(data)
		if not data[1] then
			PIXEL.Credits.Log("warning", "Failed to setup user " .. plySteamID .. ".")
			return
		end
		local creditAmount = tonumber(data[1].credits)
		PIXEL.Credits.DebugLog(creditAmount)
		PIXEL.Credits.DebugLog(ply)
		ply:SetNWInt("PIXEL.Credits.PlayersCredits", creditAmount)

		net.Start("pixel_credits_finished_setup_user")
		net.Send(ply)
	end)
end)
