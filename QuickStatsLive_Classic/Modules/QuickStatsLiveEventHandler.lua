QuickStatsLiveEventHandler = {};
QuickStatsLiveEventHandler.inst = nil;

function QuickStatsLiveEventHandler:CHAR_UPDATE(...)
	QuickStatsLiveEventHandler.inst:UpdateUI()
end

function QuickStatsLiveEventHandler:WORLD_ENTERED()
	C_Timer.After(1, function()
		QuickStatsLiveEventHandler:CHAR_UPDATE()
    end)
end