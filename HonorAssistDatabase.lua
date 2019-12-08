local addonName, addonTable = ...
HonorAssist = addonTable

HonorAssist.BonusHonorKey = "Bonus Honor"
local databaseTimePattern = "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)"

function HonorAssist:LoadDatabaseSettings()
	if HonorAssistData == nil then
		HonorAssistData = {}
	end
end

function HonorAssist:LoadDataSinceDateTimeUtc(dailyStartTimeEpoch, hourlyStartTimeEpoch)
	for enemyName, enemyKills in pairs(HonorAssistData) do
		for index, honorGained in pairs(enemyKills) do
			if not HonorAssist:CheckIfInvalidEntry(honorGained) then
				if enemyName ~= HonorAssist.BonusHonorKey then
					local timeKilledEpoch = HonorAssist:DatabaseTimeUtcToEpochTime(honorGained.DateUtc)

					-- If the time we killed is greater than daily start time then add data to current day.
					if (timeKilledEpoch >= dailyStartTimeEpoch) then
						local realisticHonorGained = HonorAssist:AddKillToDailyDatabase(enemyName, honorGained.Honor, honorGained.DateUtc)

						-- If the time we killed is greater than hourly start time then add data to current hour.
						if (timeKilledEpoch >= hourlyStartTimeEpoch) then
							HonorAssist:AddToHourlyDatabase(realisticHonorGained, honorGained.DateUtc)
						end
					end

					-- Send all kills to to be processed by history.
					HonorAssist:AddKillToHistory(enemyName, honorGained.Honor, honorGained.DateUtc)
				else
					local eventTimeEpoch = HonorAssist:DatabaseTimeUtcToEpochTime(honorGained.DateUtc)
					if (eventTimeEpoch >= dailyStartTimeEpoch) then
						local realisticHonorGained = HonorAssist:AddBonusHonorToDailyDatabase(tonumber(honorGained.Honor), honorGained.DateUtc)

						if (eventTimeEpoch >= hourlyStartTimeEpoch) then
							HonorAssist:AddToHourlyDatabase(realisticHonorGained, honorGained.DateUtc)
						end
					end

					HonorAssist:AddBonusHonorToHistory(honorGained.Honor, honorGained.DateUtc)
				end
			end
		end
	end
end

-- 11/24/2019: It was possible for the database to log dishonorable kills. That resulted in no Honor saved in the database and we were not handling nil values. This check is required as long as 
-- we want to support early users (and we do). 
function HonorAssist:CheckIfInvalidEntry(honorGained)
	if honorGained.Honor == nil or honorGained.DateUtc == nil then
		return true
	end

	return false
end

function HonorAssist:GetTotalKillsMasterDatabase(playerName)
	if HonorAssist:HasDatabaseEntry(HonorAssistData, playerName) == false then
		return 0
	end
		return table.getn(HonorAssistData[playerName])
end

-- Adds kill to master database.
function HonorAssist:AddKillToMasterDatabase(playerKilled, estimatedHonorGained, timeKilledUtc)
	HonorAssistData = HonorAssist:AddToDatabase(HonorAssistData, playerKilled, estimatedHonorGained, timeKilledUtc)
end

function HonorAssist:AddBonusHonorToMasterDatabase(estimatedHonorGained, eventTimeUtc)
	HonorAssistData = HonorAssist:AddToDatabase(HonorAssistData, HonorAssist.BonusHonorKey, estimatedHonorGained, eventTimeUtc)
end

-- Add honor to database passed in and return the same table back with whatever maniuplations were made.
function HonorAssist:AddToDatabase(databaseTable, uniqueKey, estimatedHonorGained, eventTimeUtc)
	if HonorAssist:HasDatabaseEntry(databaseTable, uniqueKey) == false then
		databaseTable[uniqueKey] = {}
	end

	table.insert(databaseTable[uniqueKey], { Honor = estimatedHonorGained, DateUtc = eventTimeUtc })

	return databaseTable
end

-- Checks if key has entry before.
function HonorAssist:HasDatabaseEntry(databaseTable, uniqueKey)
	return databaseTable[uniqueKey] ~= nil
end

-- Database is in format of mm/dd/yy hh:mm:ss. We want to convert that format to epoch time.
function HonorAssist:DatabaseTimeUtcToEpochTime(dateTimeUtc)
	 local month, day, year, hour, minute, seconds = dateTimeUtc:match(databaseTimePattern)
	 return time({ year = 2000 + year, month = month, day = day, hour = hour, min = minute, sec = seconds })
end