--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...
core.Config = {} -- adds Config table to addon namespace
local Config = core.Config

-- test


--------------------------------------
-- Defaults
--------------------------------------

local xCenter, yCenter = UIParent:GetCenter()

local default = {
	title = "Tic Tac Toe",

	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "ff7d00",
	},

	position = {
		x = xCenter * 1.4,
		y = yCenter * 1.3,
	},
	
	size = {
		width = 230,
		height = 275,
		expanded = {
			height = 120,
		},
	},

	chatTypes = {
		"EMOTE",
		"WHISPER",
		"PARTY",
		"RAID",
        "GUILD",
	}
}

-- Reads the default theme color
function Config:GetThemeColor()
	local c = default.theme
	return c.r, c.g, c.b, c.hex
end