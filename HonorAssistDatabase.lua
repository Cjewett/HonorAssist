local addonName, addonTable = ...
HonorAssist = addonTable

local databaseTimePattern = "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)"

function HonorAssist:LoadDatabaseSettings()
	if HonorAssistData == nil then
		HonorAssistData = {}
	end
end

function HonorAssist:LoadDataSinceDateTimeUtc(dailyStartTimeEpoch, hourlyStartTimeEpoch)
	for enemyName, enemyKills in pairs(HonorAssistData) do
		for index, honorGained in pairs(enemyKills) do
			if not HonorAssist:CheckIfInvalidKill(honorGained) then
				local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(index, honorGained.Honor)
				local timeKilledEpoch = HonorAssist:DatabaseTimeUtcToLuaTime(honorGained.DateUtc)

				-- If the time we killed is greater than daily start time then add data to current day.
				if (timeKilledEpoch > dailyStartTimeEpoch) then
					local realisticHonorGained = HonorAssist:AddKillToDailyDatabase(enemyName, honorGained.Honor, honorGained.DateUtc, false)

					-- If the time we killed is greater than hourly start time then add data to current hour.
					if (timeKilledEpoch > hourlyStartTimeEpoch) then
						HonorAssist:AddKillToHourlyDatabase(realisticHonorGained, honorGained.DateUtc)
					end
				end
			end
		end
	end
end

-- 11/24/2019: It was possible for the database to log dishonorable kills. That resulted in no Honor saved in the database and we were not handling nil values. This check is required as long as 
-- we want to support early users (and we do). 
function HonorAssist:CheckIfInvalidKill(honorGained)
	if honorGained.Honor == nil or honorGained.DateUtc == nil then
		return true
	end

	return false
end

function HonorAssist:GetTotalKillsMasterDatabase(playerName)
	if HonorAssist:HasBeenKilled(HonorAssistData, playerName) == false then
		return 0
	end
		return table.getn(HonorAssistData[playerName])
end

-- Adds kill to master database.
function HonorAssist:AddKillToMasterDatabase(playerKilled, estimatedHonorGained, timeKilledUtc)
	HonorAssistData = HonorAssist:AddToDatabase(HonorAssistData, playerKilled, estimatedHonorGained, timeKilledUtc)
end

-- Add kill to database passed in and return the same table back with whatever maniuplations were made.
-- Also return the amount of times the player has been killed which determines the diminishing return.
function HonorAssist:AddToDatabase(databaseTable, playerKilled, estimatedHonorGained, timeKilledUtc)
	if HonorAssist:HasBeenKilled(databaseTable, playerKilled) == false then
		databaseTable[playerKilled] = {}
	end

	local timesKilled = #databaseTable[playerKilled]

	table.insert(databaseTable[playerKilled], { Honor = estimatedHonorGained, DateUtc = timeKilledUtc })

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
