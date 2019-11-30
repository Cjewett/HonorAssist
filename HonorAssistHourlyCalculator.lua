local addonName, addonTable = ...
HonorAssist = addonTable

local hourlyData = {}
local totalHonor = 0
local totalKills = 0
local startTimeEpoch = nil

function HonorAssist:LoadHourlySettings()
	hourlyData = {}
	totalHonor = 0
	totalKills = 0
	startTimeEpoch = HonorAssist:GetPreviousHourTimeEpoch()
end

function HonorAssist:GetHourlyStartTimeEpoch()
	return startTimeEpoch
end

-- Passing in dishonorable kill information will probably not work as expected. We don't really care about dishonorable kills right now.
-- Mainly because we would rather not test what a dishonorable kill event looks like due to the in-game ramifications.
function HonorAssist:AddKillToHourlyDatabase(honorGained, timeKilledUtc)
	local timeKilledEpoch = HonorAssist:DatabaseTimeUtcToLuaTime(timeKilledUtc)

	-- If there is no or negative honor then return.
	if (honorGained <= 0) then
		return totalHonor
	end

	-- If time killed is less than the hour we are currently tracking then ignore.
	if (timeKilledEpoch < startTimeEpoch - (60 * 60)) then
		return totalHonor
	end

	-- Instantiate table for time if it doesn't exist.
	if (hourlyData[timeKilledEpoch] == nil) then
		hourlyData[timeKilledEpoch] = {}
	end

	table.insert(hourlyData[timeKilledEpoch], { Honor = honorGained })
	totalHonor = totalHonor + honorGained
	totalKills = totalKills + 1
	HonorAssist:UpdateHourlyHonor(totalHonor)
	return totalHonor
end

-- Update start time and remove data that has fallen out of the previous hour window.
function HonorAssist:RecalculateHourlyData()
	startTimeEpoch = HonorAssist:GetPreviousHourTimeEpoch()
	local deleteData = {}

	-- Inefficient but I'm sleepy.
	-- TODO: Make this O(n), not 2 * O(n). Stop requiring an extra table to store values to be deleted.
	-- Goes through list the first time and removes out of date honor from the totals.
	for timeKilledEpoch, honorEntries in pairs(hourlyData) do
		if (timeKilledEpoch < startTimeEpoch) then
			for index, honor in pairs(honorEntries) do
				totalHonor = totalHonor - honor.Honor
			end

			table.insert(deleteData, timeKilledEpoch)
		end
	end

	-- Goes thorugh list the second time and sets those keys to nil to remove from table.
	for _, timeKilledEpoch in pairs(deleteData) do
		hourlyData[timeKilledEpoch] = nil
	end

	HonorAssist:UpdateHourlyHonor(totalHonor)
end
