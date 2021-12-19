PIXEL = PIXEL or {}
PIXEL.Credits = PIXEL.Credits or {}


function PIXEL.Credits.Log(type, ...)
	local col = ""
	if type == "error" then
		col = Color(255, 0, 0)
	elseif type == "debug" then
		col = Color(0, 255, 0)
	elseif type == "info" then
		col = Color(0, 0, 255)
	elseif type == "warning" then
		col = Color(255, 187, 0)
	else
		col = Color(255, 255, 255)
	end
	MsgC(col, "[PIXELCredits] ", ..., "\n")
end

function epic(...)
	local hex = string.upper(bit.tohex(math.random(0, 0xFFFFFFFF), 8))
	MsgC(Color(0, 255, 0), "[0x", hex, "] ", ..., "\n")
end

function PIXEL.Credits.DebugLog(...)
	if !PIXEL.Credits.Debug then return end
	MsgC(Color(0, 255, 0), "[PIXELCredits-DEBUG] ", ..., "\n")
end
function fuckingHugePrint()
	epic(":::::::::  ::::::::::: :::    ::: :::::::::: :::         ::::::::  :::::::::  :::::::::: :::::::::  ::::::::::: :::::::::::  ::::::::  ")
	epic(":+:    :+:     :+:     :+:    :+: :+:        :+:        :+:    :+: :+:    :+: :+:        :+:    :+:     :+:         :+:     :+:    :+: ")
	epic("+:+    +:+     +:+      +:+  +:+  +:+        +:+        +:+        +:+    +:+ +:+        +:+    +:+     +:+         +:+     +:+        ")
	epic("+#++:++#+      +#+       +#++:+   +#++:++#   +#+        +#+        +#++:++#:  +#++:++#   +#+    +:+     +#+         +#+     +#++:++#++ ")
	epic("+#+            +#+      +#+  +#+  +#+        +#+        +#+        +#+    +#+ +#+        +#+    +#+     +#+         +#+            +#+ ")
	epic("#+#            #+#     #+#    #+# #+#        #+#        #+#    #+# #+#    #+# #+#        #+#    #+#     #+#         #+#     #+#    #+# ")
	epic("###        ########### ###    ### ########## ##########  ########  ###    ### ########## #########  ###########     ###      ########  ")
end

function PIXEL.LoadDirectory(path)
	local files, folders = file.Find(path .. "/*", "LUA")

	for _, fileName in ipairs(files) do
		local filePath = path .. "/" .. fileName

		if CLIENT then
			include(filePath)
		else
			if fileName:StartWith("cl_") then
				AddCSLuaFile(filePath)
				MsgC(Color(0, 0, 255), "[PIXELCredits] Loaded Client File: ", filePath, "\n")
			elseif fileName:StartWith("sh_") then
				AddCSLuaFile(filePath)
				include(filePath)
				MsgC(Color(0, 0, 255), "[PIXELCredits] Loaded Shared File: ", filePath, "\n")
			elseif fileName:StartWith("sv_") then
				include(filePath)
				MsgC(Color(0, 0, 255), "[PIXELCredits] Loaded Server File: ", filePath, "\n")
			end
		end
	end

	return files, folders
end

function PIXEL.LoadDirectoryRecursive(basePath)
	local _, folders = PIXEL.LoadDirectory(basePath)

	for _, folderName in ipairs(folders) do
		PIXEL.LoadDirectoryRecursive(basePath .. "/" .. folderName)
	end
end

local function loadAddon()
	PIXEL.LoadDirectoryRecursive("pixel-credits")
end

if PIXEL.UI then
	loadAddon()
	fuckingHugePrint()
	return
end

hook.Add("PIXEL.UI.FullyLoaded", "PIXEL.Credits.WaitForPIXELUI", loadAddon)
