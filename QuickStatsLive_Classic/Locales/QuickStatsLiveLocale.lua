QuickStatsLiveLocale = {}

local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("QuickStatsLive")

function QuickStatsLiveLocale:GetUIString(key, ...)
	local args = {...};
	local str = L[key];
	if str and args then
		for k,v in pairs(args) do -- start at 1, need 0 for our string placeholders
			str = str:gsub("#"..(k-1), v);
		end
	end
	return str;
end