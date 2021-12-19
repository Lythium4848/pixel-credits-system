PIXEL = PIXEL or {}
PIXEL.Credits = PIXEL.Credits or {}


function PIXEL.Credits.Log(type, ...)
	local col = ""
	if type == "error" then
		col = Color(255, 0, 0)
	elseif type == "info" then
		col = Color(0, 0, 255)
	elseif type == "warning" then
		col = Color(255, 187, 0)
	else
		col = Color(255, 255, 255)
	end
	MsgC(col, "[PIXELCredits] ", ..., "\n")
end

local function epic(...)
	local hex = string.upper(bit.tohex(math.random(0, 0xFFFFFFFF), 8))
	MsgC(Color(0, 255, 0), "[0x", hex, "] ", ..., "\n")
end

function PIXEL.Credits.DebugLog(...)
	if !PIXEL.Credits.Debug then return end
	MsgC(Color(0, 255, 0), "[PIXELCredits-DEBUG] ", ..., "\n")
end

local function fuckingHugePrint()
	print("\n")
	epic(":::::::::  ::::::::::: :::    ::: :::::::::: :::         ::::::::  :::::::::  :::::::::: :::::::::  ::::::::::: :::::::::::  ::::::::  ")
	epic(":+:    :+:     :+:     :+:    :+: :+:        :+:        :+:    :+: :+:    :+: :+:        :+:    :+:     :+:         :+:     :+:    :+: ")
	epic("+:+    +:+     +:+      +:+  +:+  +:+        +:+        +:+        +:+    +:+ +:+        +:+    +:+     +:+         +:+     +:+        ")
	epic("+#++:++#+      +#+       +#++:+   +#++:++#   +#+        +#+        +#++:++#:  +#++:++#   +#+    +:+     +#+         +#+     +#++:++#++ ")
	epic("+#+            +#+      +#+  +#+  +#+        +#+        +#+        +#+    +#+ +#+        +#+    +#+     +#+         +#+            +#+ ")
	epic("#+#            #+#     #+#    #+# #+#        #+#        #+#    #+# #+#    #+# #+#        #+#    #+#     #+#         #+#     #+#    #+# ")
	epic("###        ########### ###    ### ########## ##########  ########  ###    ### ########## #########  ###########     ###      ########  ")
	epic("Loading PIXELCredits...")
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
			elseif fileName:StartWith("sh_") then
				AddCSLuaFile(filePath)
				include(filePath)
			elseif fileName:StartWith("sv_") then
				include(filePath)
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
	fuckingHugePrint()
	hook.Run("PIXEL.Credits.FullyLoaded")
end

if PIXEL.UI then
	loadAddon()
	return
end

hook.Add("PIXEL.UI.FullyLoaded", "PIXEL.Credits.WaitForPIXELUI", loadAddon)
