--[[-----------------------------------------------------------------------------
Frame Container
-------------------------------------------------------------------------------]]
local Type, Version = "QSLDialogBox", 2
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local pairs, assert, type = pairs, assert, type
local wipe = table.wipe

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: CLOSE

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Frame_OnShow(frame)
	frame.obj:Fire("OnShow")
end

local function Frame_OnClose(frame)
	frame.obj:Fire("OnClose")
end

local function Frame_OnMouseDown(frame)
    if frame.can_move then
	    frame:StartMoving()
    end
	AceGUI:ClearFocus()
end

local function Frame_OnMouseUp(frame)
	if frame.can_move then
	    frame:StopMovingOrSizing()
    end
	AceGUI:ClearFocus()
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self.frame:SetParent(UIParent)
		self.frame:SetFrameStrata("FULLSCREEN_DIALOG")
		self:ApplyStatus()
		self:Show()
	end,

	["OnRelease"] = function(self)
		self.status = nil
		wipe(self.localstatus)
	end,

	["OnWidthSet"] = function(self, width)
		local content = self.content
		local contentwidth = width - 34
		if contentwidth < 0 then
			contentwidth = 0
		end
		content:SetWidth(contentwidth)
		content.width = contentwidth
	end,

	["OnHeightSet"] = function(self, height)
		local content = self.content
		local contentheight = height - 57
		if contentheight < 0 then
			contentheight = 0
		end
		content:SetHeight(contentheight)
		content.height = contentheight
	end,

	["Hide"] = function(self)
		self.frame:Hide()
	end,

	["Show"] = function(self)
		self.frame:Show()
	end,
	
	-- called to set an external table to store status in
	["SetStatusTable"] = function(self, status)
		assert(type(status) == "table")
		self.status = status
		self:ApplyStatus()
	end,

	["ApplyStatus"] = function(self)
		local status = self.status or self.localstatus
		local frame = self.frame
		self:SetWidth(status.width or 100)
		self:SetHeight(status.height or 100)
		frame:ClearAllPoints()
		if status.top and status.left then
			frame:SetPoint("TOP", UIParent, "BOTTOM", 0, status.top)
			frame:SetPoint("LEFT", UIParent, "LEFT", status.left, 0)
		else
			frame:SetPoint("CENTER")
		end
	end,
	
	["EnableMovable"] = function(self, state)
		assert(type(state) == "boolean")
		self.frame.can_move = state
	end,
	
	["SetBackdropColor"] = function(self, r, g, b, a)
		self.frame:SetBackdropColor(r, g, b, a)
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local FrameBackdrop = {
	bgFile = "Interface\Tooltips\UI-Tooltip-Background"
}

local WIDGET_COUNT = 0

local function Constructor()
	local frame = CreateFrame("Frame", "QSLDialogBox_"..WIDGET_COUNT, UIParent)
	WIDGET_COUNT = WIDGET_COUNT + 1
	frame:Hide()

    frame.can_move = true

	frame:EnableMouse(false)
	frame:SetMovable(true)
	frame:SetResizable(false)
	frame:SetFrameStrata("FULLSCREEN_DIALOG")
	frame:SetBackdrop(FrameBackdrop)
	frame:SetBackdropColor(0, 0, 0, 1)
	frame:SetMinResize(100, 100)
	frame:SetToplevel(true)
	frame:SetScript("OnShow", Frame_OnShow)
	frame:SetScript("OnHide", Frame_OnClose)
	frame:SetScript("OnMouseDown", Frame_OnMouseDown)
	frame:SetScript("OnMouseUp", Frame_OnMouseUp)
	
	--Container Support
	local content = CreateFrame("Frame", nil, frame)
	content:SetPoint("TOPLEFT", 5, 5)
	content:SetPoint("BOTTOMRIGHT")
	
	local widget = {
		localstatus = {},
		content     = content,
		frame       = frame,
		type        = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end

	return AceGUI:RegisterAsContainer(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)