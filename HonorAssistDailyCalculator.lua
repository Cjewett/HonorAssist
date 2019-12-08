local addonName, addonTable = ...
HonorAssist = addonTable

local dailyData = {}
local totalHonor = 0
local totalKills = 0
local killHonor = 0
local bonusHonor = 0
local startTimeEpoch = nil

function HonorAssist:LoadDailySettings()
	dailyData = {}
	totalHonor = 0
	totalKills = 0
	killHonor = 0
	bonusHonor = 0
	startTimeEpoch = HonorAssist:GetHonorDayStartTimeEpoch()
end

function HonorAssist:GetDailyStartTimeEpoch()
	return startTimeEpoch
end

-- Passing in dishonorable kill information will probably not work as expected. We don't really care about dishonorable kills right now.
-- Mainly because we would rather not test what a dishonorable kill event looks like due to the in-game ramifications.
function HonorAssist:AddKillToDailyDatabase(playerKilled, estimatedHonorGained, timeKilledUtc)
	dailyData = HonorAssist:AddToDatabase(dailyData, playerKilled, estimatedHonorGained, timeKilledUtc)
	local timesKilled = #dailyData[playerKilled] - 1
	local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(timesKilled, estimatedHonorGained)

	totalHonor = totalHonor + realisticHonor
	killHonor = killHonor + realisticHonor
	HonorAssist:UpdateDailyKillHonor(killHonor)
	HonorAssist:UpdateDailyTrackerHonor(totalHonor)

	totalKills = totalKills + 1
	HonorAssist:UpdateDailyTrackerKills(totalKills)

	HonorAssist:UpdateDailyTrackerAverage(totalKills, killHonor)

	return realisticHonor
end

function HonorAssist:AddBonusHonorToDailyDatabase(bonusHonorGained, eventTimeUtc)
	dailyData = HonorAssist:AddToDatabase(dailyData, HonorAssist.BonusHonorKey, bonusHonorGained, timeKilledUtc)
	totalHonor = totalHonor + bonusHonorGained
	bonusHonor = bonusHonor + bonusHonorGained
	HonorAssist:UpdateDailyBonusHonor(bonusHonor)
	HonorAssist:UpdateDailyTrackerHonor(totalHonor)

	return bonusHonorGained
end

function HonorAssist:GetTotalKillsDailyDatabase(playerName)
	if HonorAssist:HasDatabaseEntry(dailyData, playerName) == false then
		return 0
	end
		return table.getn(dailyData[playerName])
end