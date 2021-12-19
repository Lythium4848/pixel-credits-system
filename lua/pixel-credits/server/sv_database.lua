PIXEL = PIXEL or {}
PIXEL.Credits = PIXEL.Credits or {}
PIXEL.Credits.Config = PIXEL.Credits.Config or {}
PIXEL.Credits.DB = PIXEL.Credits.DB or {}
require("mysqloo")

function PIXEL.Credits.DB.Connect()
	PIXEL.Credits.DB.Connection = mysqloo.connect(PIXEL.Credits.Config.MySQL["Hostname"], PIXEL.Credits.Config.MySQL["Username"], PIXEL.Credits.Config.MySQL["Password"], PIXEL.Credits.Config.MySQL["Database"], PIXEL.Credits.Config.MySQL["Port"])

	PIXEL.Credits.DB.Connection.onConnected = function()
		PIXEL.Credits.Log("info", "Connected to MySQL database.")
		PIXEL.Credits.DB.Query("CREATE TABLE IF NOT EXISTS credit_users(userid VARCHAR(32) NOT NULL PRIMARY KEY, credits VARCHAR(255) NOT NULL DEFAULT '0')")
	end

	PIXEL.Credits.DB.Connection.onFailed = function(db, sqlerror)
		PIXEL.Credits.Log("error", "Failed to connect to MySQL database: " .. sqlerror)
	end

	PIXEL.Credits.DB.Connection:connect()
end

hook.Add("Initialize", "PIXELCreditsDBConnection", function()
	PIXEL.Credits.DB.Connect()
	PIXEL.Credits.Log("info", "Attempting connection to MySQL Database.")
end)


function PIXEL.Credits.DB.Query(q, callback)
	local query = PIXEL.Credits.DB.Connection:query(q)

	query.onSuccess = function(q, data)
		if callback then
			callback(data, q)
		end
	end
	query.onError = function(q, err)
		PIXEL.Credits.Log("error", "MySQL Query Error: " .. err)
	end

	query:start()
end