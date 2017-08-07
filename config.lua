--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...
core.Config = {} -- adds Config table to addon namespace
local Config = core.Config

---------------------------------
-- All Frames
---------------------------------
function Config:CreateAll()
	Frame.CreateMain()
	--[[
	Config.CreateScrollFrame()
	Config.CreateGameFrame()
	Config.CreateSpaceFrame()
	Config.CreateStatsFrame()
	Config.CreateConfigFrame()
	
	Config:UpdateHelpPlate()
	Config:ToggleHelpPlate()
	]]
	
	
	return Main
end

-- Toggles or creates the Main Frame
function Config:Toggle(show)
	local menu = Main or Config:CreateAll()
	menu:SetShown(not menu:IsShown() or show)
end

-- Reads the default theme color
function Config:GetThemeColor()
	local c = default.theme
	return c.r, c.g, c.b, c.hex
end