local addonName, addonTable = ...
HonorAssist = addonTable

local dailyData = {}
local totalHonor = 0
local totalKills = 0
local startTimeEpoch = nil

function HonorAssist:LoadDailySettings()
	dailyData = {}
	totalHonor = 0
	totalKills = 0
	startTimeEpoch = HonorAssist:GetHonorDayStartTimeEpoch()
end

function HonorAssist:GetDailyStartTimeEpoch()
	return startTimeEpoch
end

-- Passing in dishonorable kill information will probably not work as expected. We don't really care about dishonorable kills right now.
-- Mainly because we would rather not test what a dishonorable kill event looks like due to the in-game ramifications.
function HonorAssist:AddKillToDailyDatabase(playerKilled, estimatedHonorGained, timeKilledUtc, printResult)
	dailyData = HonorAssist:AddToDatabase(dailyData, playerKilled, estimatedHonorGained, timeKilledUtc)
	local timesKilled = #dailyData[playerKilled] - 1
	local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(timesKilled, estimatedHonorGained)

	totalHonor = totalHonor + realisticHonor
	HonorAssist:UpdateDailyTrackerHonor(totalHonor)

	totalKills = totalKills + 1
	HonorAssist:UpdateDailyTrackerKills(totalKills)

	HonorAssist:UpdateDailyTrackerAverage(totalKills, totalHonor)

	return realisticHonor
end

function HonorAssist:GetTotalKillsDailyDatabase(playerName)
	if HonorAssist:HasBeenKilled(dailyData, playerName) == false then
		return 0
	end
		return table.getn(dailyData[playerName])
end
