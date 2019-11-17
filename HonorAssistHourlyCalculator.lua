local addonName, addonTable = ...
HonorAssist = addonTable

local hourlyData = {}
local totalKills = 0
local totalHonor = 0
local lastHourTimeUtc = nil

function HonorAssist:LoadHourlySettings()
	dailyData = {}
	totalHonor = 0
	lastHourTimeUtc = HonorAssist:GetLastHourTimeUtc()
	HonorAssist:GetHourlyDataSinceDateTimeUtc(lastHourTimeUtc)
end

function HonorAssist:AddKillToHourlyDatabase(playerKilled, estimatedHonorGained)
	hourlyData = HonorAssist:AddToDatabase(dailyData, playerKilled, estimatedHonorGained)
	local timesKilled = #hourlyData[playerKilled]
	local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(timesKilled, estimatedHonorGained)

	totalHonor = totalHonor + realisticHonor
	totalKills = totalKills + 1
end

function HonorAssist:RemoveOldData()
end