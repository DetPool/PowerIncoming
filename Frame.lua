--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...
core.Frame = {} -- adds Config table to addon namespace
local Frame = core.Frame


--------------------------------------
-- Defaults
--------------------------------------

local xCenter, yCenter = UIParent:GetCenter()

local default = {
	title = "War Inc.",

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
}


--------------------------------------
-- Initializing Variables
--------------------------------------

local Main
local HelpFrame
local ConfigFrame
local mainHelpButton

local xPosition = default.position.x
local yPosition = default.position.y

local counter = 0
local cheatUsed = false

local expandedMain = false
local isResizingMain = false
local helpShown = false

---------------------------------
-- Main Frame
---------------------------------
function Frame:CreateMain() -- creates the Main Frame
	Main = CreateFrame("Frame", "War Inc._Main", UIParent, "BasicFrameTemplate")
	Main:ClearAllPoints()
	Main:SetSize(default.size.width, default.size.height) -- width, height
	Main:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", xPosition, yPosition) -- point, relativeFrame, relativePoint, xOffset, yOffset
	Main.title = Main:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	Main.title:SetPoint("CENTER", Main.TitleBg, "CENTER", 0, 0)
	Main.title:SetText(default.title)
	Main:SetMovable(true)
	Main:EnableMouse(true)
	Main:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving()
            self.isMoving = true
        end
    end)
    Main:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self:StopMovingOrSizing()
            self.isMoving = false
            xPosition = self:GetLeft()
            yPosition = self:GetTop()
            Config:UpdateHelpPlate()
        end
    end)
    Main:SetScript("OnHide", function(self)
        --Config:ToggleHelpPlate(false)

        if (self.isMoving) then
            self:StopMovingOrSizing()
            self.isMoving = false
        end
    end)

	--[[
	Main.mainHelpButton = CreateFrame("Button", "War Inc._HelpBtn", Main, "MainHelpPlateButton")
	Main.mainHelpButton:ClearAllPoints()
	Main.mainHelpButton:SetPoint("LEFT", Main.TitleBg, "LEFT", -20, 0)
	Main.mainHelpButton.initialTutorial = false
	Main.mainHelpButton:SetScript("OnClick", function(self)
		--Config:ToggleHelpPlate()
	end)
	]]

	Main:Hide()
	return Main
end



