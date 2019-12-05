local currentPlayerFaction, _ = UnitFactionGroup("player")

hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
	if (not HonorAssistLogging) then
		return
	end

	if UnitIsPlayer(frame.unit) then
		local faction, _ = UnitFactionGroup(frame.unit)
		if (currentPlayerFaction == faction) then
			return
		end

		local level = UnitLevel(frame.unit)

		if not UnitIsPVP(frame.unit) or UnitIsTrivial(frame.unit) or level <= 47 then
			return
		end
      
		local name = GetUnitName(frame.unit)
		local rank = UnitPVPRank(frame.unit)
		local timesKilledToday = HonorAssist:GetTotalKillsDailyDatabase(name)
    	local honorPercentLeft, realisticHonor = HonorAssist:GetPlayerEstimatedHonor(timesKilledToday, 1, level, rank)

    	frame.name:SetText(name..' (' .. HonorAssist:Round(realisticHonor, 0) .. ')')
	end
end)