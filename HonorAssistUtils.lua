local addonName, addonTable = ...
HonorAssist = addonTable

function HonorAssist:GetCurrentTimeUtc()
	return '' .. date("!%x") .. ' ' .. date("!%X")
end

function HonorAssist:GetPreviousHourTimeEpoch()
	return time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")}) - (60 * 60)
end

function HonorAssist:GetHonorDayStartTimeEpoch()
	local todaysResetTimeEpoch, currentTimeThresholdEpoch = HonorAssist:GetHonorDayStartTimeEpochBasedOnRegion()

	-- If the current UTC time is greater than todays reset time then that means todays reset time is the correct time.
	-- Else if current UTC time is less than todays reset time then that means we need to get subtract 24 hours to get the correct day of when the 'WoW Honor Day' started.
	if (currentTimeThresholdEpoch > todaysResetTimeEpoch) then
		todaysResetTimeEpoch = todaysResetTimeEpoch
	elseif (currentTimeThresholdEpoch < todaysResetTimeEpoch) then
		todaysResetTimeEpoch = todaysResetTimeEpoch - (60 * 60 * 24)
	end

	return todaysResetTimeEpoch
end

function HonorAssist:GetHonorDayStartTimeEpochBasedOnRegion()
	local regionId = GetCurrentRegion()

	-- Default to US time. Maybe change to Midnight in the future but ideally we find all the real reset times.  
	local todaysResetTimeEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = 15, min = 0, sec = 0})
	local currentTimeThresholdEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")})

	if (regionId == 1) then -- US (includes Brazil and Oceania). Reset time is 3 PM UTC (unconfirmed).
		 todaysResetTimeEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = 15, min = 0, sec = 0})
		 currentTimeThresholdEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")})
	elseif (regionId == 2) then -- Korea. TODO: We don't know Korea's honor reset time.
	elseif (regionId == 3) then -- Europe (includes Russia). Reset time is 7 AM UTC according to Dagochen on Curseforge (thank you!).
		todaysResetTimeEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = 7, min = 0, sec = 0})
		currentTimeThresholdEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")})
	elseif (regionId == 4) then -- Taiwan. TODO: We don't know Taiwan's honor reset time.
	elseif (regionId == 5) then -- China. Reset time is 8 AM UTC according to wellcat on Curseforge (thank you!).
		todaysResetTimeEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = 8, min = 0, sec = 0})
		currentTimeThresholdEpoch = time({ year = date("!%Y"), month = date("!%m"), day = date("!%d"), hour = date("!%H"), min = date("!%M"), sec = date("!%S")})
	end

	return todaysResetTimeEpoch, currentTimeThresholdEpoch
end

function HonorAssist:GetHonorDayStartTimeEpochBasedOnKillTimeEpoch(timeKilledEpoch)
	local regionId = GetCurrentRegion()
	local killTime = date("*t", timeKilledEpoch)

	-- Default to US time. Maybe change to Midnight in the future but ideally we find all the real reset times.  
	local resetTimeEpoch = time({ year = killTime.year, month = killTime.month, day = killTime.day, hour = 15, min = 0, sec = 0})

	if (regionId == 1) then -- US (includes Brazil and Oceania). Reset time is 3 PM UTC (unconfirmed).
		 resetTimeEpoch = time({ year = killTime.year, month = killTime.month, day = killTime.day, hour = 15, min = 0, sec = 0})
	elseif (regionId == 2) then -- Korea. TODO: We don't know Korea's honor reset time.
	elseif (regionId == 3) then -- Europe (includes Russia). Reset time is 7 AM UTC according to Dagochen on Curseforge (thank you!).
		resetTimeEpoch = time({ year = killTime.year, month = killTime.month, day = killTime.day, hour = 7, min = 0, sec = 0})
	elseif (regionId == 4) then -- Taiwan. TODO: We don't know Taiwan's honor reset time.
	elseif (regionId == 5) then -- China. Reset time is 8 AM UTC according to wellcat on Curseforge (thank you!).
		resetTimeEpoch = time({ year = killTime.year, month = killTime.month, day = killTime.day, hour = 8, min = 0, sec = 0})
	end

	-- If the time killed epoch is greater than todays reset time then that means todays reset time is the correct time.
	-- Else if time killed epoch is less than todays reset time then that means we need to subtract 24 hours to get the correct day of when the 'WoW Honor Day' for that kill started. 
	if (timeKilledEpoch > resetTimeEpoch) then
		resetTimeEpoch = resetTimeEpoch
	elseif (timeKilledEpoch < resetTimeEpoch) then
		resetTimeEpoch = resetTimeEpoch - (60 * 60 * 24)
	end

	return resetTimeEpoch
end

function HonorAssist:GetHonorWeekStartTimeEpoch()
	local dayStartTimesEpoch = {}
	local todaysResetTimeEpoch = HonorAssist:GetHonorDayStartTimeEpoch()
	local resetDayWeekday = HonorAssist:GetResetDayWeekday()
	local currentWeekday = date("%A", todaysResetTimeEpoch)
	table.insert(dayStartTimesEpoch, todaysResetTimeEpoch)

	while currentWeekday ~= resetDayWeekday do
		todaysResetTimeEpoch = todaysResetTimeEpoch - (60 * 60 * 24)
		currentWeekday = date("%A", todaysResetTimeEpoch)
		table.insert(dayStartTimesEpoch, todaysResetTimeEpoch)
	end

	return todaysResetTimeEpoch, dayStartTimesEpoch
end

function HonorAssist:GetResetDayWeekday()
	local regionId = GetCurrentRegion()
	if (regionId == 1) then
		return "Tuesday" -- Tuesday
	else
		return "Wednesday" -- Wednesday
	end
end

function HonorAssist:CalculateRealisticHonor(timesKilled, estimatedHonorGained)
	if timesKilled >= 5 then
		return 0, 0
	end

	local percentage = 1 - (0.25 * timesKilled)
	local realisticHonor = estimatedHonorGained * percentage
	return percentage, realisticHonor
end

function HonorAssist:GetPlayerDailyKillCount(playerName)
	local dailyTotalKills = HonorAssist:GetTotalKillsDailyDatabase(playerName)
	local totalKills = HonorAssist:GetTotalKillsMasterDatabase(playerName)
	return dailyTotalKills, totalKills
end

function HonorAssist:Round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function HonorAssist:StringIsNullOrEmpty(s)
	if s == nil or s == '' then
		return true
	end
end

function HonorAssist:SplitString(slashCommand, delimiter)
	result = {}

	for match in (slashCommand .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	return result
end

function HonorAssist:Trim(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end