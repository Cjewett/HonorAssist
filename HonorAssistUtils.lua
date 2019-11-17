local addonName, addonTable = ...
HonorAssist = addonTable

function HonorAssist:GetCurrentTimeUtc()
	return '' .. date("!%x") .. ' ' .. date("!%X")
end

function HonorAssist:GetPreviousHourTimeEpoch()
	return time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")}) - (60 * 60)
end

function HonorAssist:GetHonorDayStartTimeEpoch()
	local todaysResetTimeUtc = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = 15, min = 0, sec = 0})
	local currentTimeThresholdUtc = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")})

	-- If the current UTC time is greater than todays reset time then that means todays reset time is the correct time.
	-- Else if current UTC time is less than todays reset time then that means we need to get subtract 24 hours to get the correct day of when the 'WoW Honor Day' started. (It starts at 7 PM UTC)
	if (currentTimeThresholdUtc > todaysResetTimeUtc) then
		todaysResetTimeUtc = todaysResetTimeUtc
	elseif (currentTimeThresholdUtc < todaysResetTimeUtc) then
		todaysResetTimeUtc = todaysResetTimeUtc - (60 * 60 * 24)
	end

	return todaysResetTimeUtc
end

function HonorAssist:CalculateRealisticHonor(timesKilled, estimatedHonorGained)
	if timesKilled >= 5 then
		return 0, 0
	end

	local percentage = 1 - (0.25 * timesKilled)
	local realisticHonor = estimatedHonorGained * percentage
	return percentage, realisticHonor
end

function HonorAssist:Round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function HonorAssist:GetPlayerDailyKillCount(playerName)
	local dailyTotalKills = HonorAssist:GetTotalKillsDailyDatabase(playerName)
	local totalKills = HonorAssist:GetTotalKillsMasterDatabase(playerName)
	return dailyTotalKills, totalKills
end
