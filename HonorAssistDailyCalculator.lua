local addonName, addonTable = ...
HonorAssist = addonTable

local dailyData = {}
local totalHonor = 0
local totalKills = 0
local startTimeUtc = nil

function HonorAssist:LoadDailySettings()
	dailyData = {}
	totalHonor = 0
	totalKills = 0
	startTimeUtc = HonorAssist:GetHonorDayStartTimeUtc()
	HonorAssist:GetDailyDataSinceDateTimeUtc(startTimeUtc)
end

function HonorAssist:AddKillToDailyDatabase(playerKilled, estimatedHonorGained, printResult)
	dailyData = HonorAssist:AddToDatabase(dailyData, playerKilled, estimatedHonorGained)
	local timesKilled = #dailyData[playerKilled]
	local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(timesKilled, estimatedHonorGained)

	totalHonor = totalHonor + realisticHonor
	HonorAssist:UpdateDailyTrackerHonor(totalHonor)

	totalKills = totalKills + 1
	HonorAssist:UpdateDailyTrackerKills(totalKills)

	HonorAssist:UpdateDailyTrackerAverage(totalKills, totalHonor)

	if printResult then
		print('Realistic Honor: You have killed ' .. playerKilled .. ' ' .. timesKilled .. ' times. This kill granted ' .. percentage * 100 .. '% value for ' .. realisticHonor .. ' honor.')
	end
end