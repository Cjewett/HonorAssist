local addonName, addonTable = ...
HonorAssist = addonTable

local databaseTimePattern = "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)"

function HonorAssist:LoadDatabaseSettings()
	if HonorAssistData == nil then
		HonorAssistData = {}
	end
end

-- Load data into daily calculator.
-- Note: Daily and Hourly caluclator function to retrieve data can be merged into one. Separated for now to keep coupling separte for debugging purposes.
function HonorAssist:GetDailyDataSinceDateTimeUtc(dateTimeUtc)
	for enemyName, enemyKills in pairs(HonorAssistData) do
		for index, honorGained in pairs(enemyKills) do
	  		local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(index, honorGained.Honor)
	  		local timeKilled = HonorAssist:DatabaseTimeUtcToLuaTime(honorGained.DateUtc)

	  		-- If the time we killed is greater then it is considered a kill for the current day.
	  		if (timeKilled > dateTimeUtc) then
	  			HonorAssist:AddKillToDailyDatabase(enemyName, honorGained.Honor, false)
	  		end
		end
	end
end

-- Load data into hourly calculator.
-- Note: Daily and Hourly caluclator function to retrieve data can be merged into one. Separated for now to keep coupling separte for debugging purposes.
function HonorAssist:GetHourlyDataSinceDateTimeUtc(dateTimeUtc)
	for enemyName, enemyKills in pairs(HonorAssistData) do
		for index, honorGained in pairs(enemyKills) do
	  		local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(index, honorGained.Honor)
	  		local timeKilled = HonorAssist:DatabaseTimeUtcToLuaTime(honorGained.DateUtc)

	  		-- If the time we killed is greater then it is considered a kill for the current day.
	  		if (timeKilled > dateTimeUtc) then
	  			HonorAssist:AddKillToHourlyDataabase(enemyName, honorGained.Honor)
	  		end
		end
	end
end

-- Adds kill to master database.
function HonorAssist:AddKillToMasterDatabase(playerKilled, estimatedHonorGained)
	local timesKilled = nil
	HonorAssistData, timesKilled = HonorAssist:AddToDatabase(HonorAssistData, playerKilled, estimatedHonorGained)
end

-- Add kill to database passed in and return the same table back with whatever maniuplations were made.
-- Also return the amount of times the player has been killed which determines the diminishing return.
function HonorAssist:AddToDatabase(databaseTable, playerKilled, estimatedHonorGained)
	if HonorAssist:HasBeenKilled(databaseTable, playerKilled) == false then
		databaseTable[playerKilled] = {}
	end

	local currentTimeUtc = HonorAssist:GetCurrentTimeUtc()
	local timesKilled = #databaseTable[playerKilled]

	table.insert(databaseTable[playerKilled], { Honor = estimatedHonorGained, DateUtc = currentTimeUtc })

	return databaseTable
end

-- Checks if the player has been killed before.
function HonorAssist:HasBeenKilled(databaseTable, playerName)
	return databaseTable[playerName] ~= nil
end

-- Database is in format of mm/dd/yy hh:mm:ss. We want to convert that format to epoch time.
function HonorAssist:DatabaseTimeUtcToLuaTime(dateTimeUtc)
	 local month, day, year, hour, minute, seconds = dateTimeUtc:match(databaseTimePattern)
	 return time({ year = 2000 + year, month = month, day = day, hour = hour, min = minute, sec = seconds })
end