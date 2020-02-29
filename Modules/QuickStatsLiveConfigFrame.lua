local AceGUI = LibStub("AceGUI-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

QuickStatsLiveConfigFrame = {}

function QuickStatsLiveConfigFrame:ToggleFrame()
    if not self._frame:IsShown() then
        AceConfigDialog:Open("QuickStatsLive", self._frame)
    else
        self._frame:Hide()
    end
end

function QuickStatsLiveConfigFrame:Hide()
	if self._frame:isShown() then
		self._frame:Hide()
	end
end

function QuickStatsLiveConfigFrame:Show()
	if not self._frame:isShown() then
		AceConfigDialog:Open("QuickStatsLive", self._frame)
	end
end

function QuickStatsLiveConfigFrame:Initialize()
    if not self._frame then
        self._frame = AceGUI:Create("Frame")
        self._frame:Hide()
		-- Global Register of the Config Frame
        _G["QuickStatsLiveUISpecialFrame"] = self._frame.frame
        table.insert(UISpecialFrames, "QuickStatsLiveUISpecialFrame")
    end
end

QuickStatsLiveConfigFrame:Initialize()