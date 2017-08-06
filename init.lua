--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...

--------------------------------------
-- Custom Slash Commands
--------------------------------------

core.commands = {
	["help"] = core.CommandList,
}


local function HandleSlashCommands(str)	
	if (#str == 0) then	
		-- User just entered "/pwrinc" with no additional args.
		core.Config.Toggle()
		return		
	end	
	
	local args = {}
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg)
		end
	end
	
	local path = core.commands -- required for updating found table.
	
	for id, arg in ipairs(args) do
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower()			
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args))) 
					return					
				elseif (type(path[arg]) == "table") then				
					path = path[arg] -- another sub-table found!
				end
			else
				-- does not exist!
				core:CommandList()
				return
			end
		end
	end
end

function core:CommandList()
	local color = "fffb00"
	core:PrintLine()
	core:Print("List of slash commands:")
	core:Print("|cff"..color.."/pwrinc|r - start the game")
	core:Print("|cff"..color.."/pwrinc reset|r - reset the AddOn configuration")
	core:Print("|cff"..color.."/pwrinc help|r  - shows help info")
	core:Print("|cff"..color.."/pwrinc stats|r - shows the player statistics")
	core:PrintLine()
end

function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor())
    local prefix = string.format("|cff%s%s|r", hex:upper(), "PowerIncoming:")
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...))
end

function core:PrintLine()
	local hex = select(4, self.Config:GetThemeColor())
	local prefix = string.format("|cff%s%s|r", hex:upper(), "---------------------------------------------------------------")
	DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix))
end

-- WARNING: self automatically becomes events frame!
function core:init(event, name)
	if (name ~= "PowerIncoming") then return end

	-- allows using left and right buttons to move through chat 'edit' box
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
	end
	
	----------------------------------
	-- Register Slash Commands!
	----------------------------------
	SLASH_PowerIncoming1 = "/pwrinc"
	SlashCmdList.PowerIncoming = HandleSlashCommands

	core:PrintLine()
	core:Print("|cfffffb00/pwrinc|r - start the game")
	core:PrintLine()

	-- Needs to be removed, once developing is finished!
	-- core.Config.Toggle()
end



local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", core.init)