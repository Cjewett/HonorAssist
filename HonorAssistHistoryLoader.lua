local addonName, addonTable = ...
HonorAssist = addonTable

local historyData = {}
local historyDisplayTimeEpoch = nil
local dayLogs = {}

function HonorAssist:LoadHistoryLoader()
	historyData = {}
	historyDisplayTimeEpoch = HonorAssist:GetHonorDayStartTimeEpoch()
	historyData[historyDisplayTimeEpoch] = {} -- We should always display current day, even if no data is available.
	dayLogs = {}
end

function HonorAssist:MoveOneDayBack()
	local newTimeEpoch = HonorAssist:GetPreviousDayTimeEpoch()
	if newTimeEpoch == nil then
		return
	end

	historyDisplayTimeEpoch = newTimeEpoch
	HonorAssist:PushHistoryDataToUi()
end

function HonorAssist:MoveOneDayForward()
	local newTimeEpoch = HonorAssist:GetNextDayTimeEpoch()
	if newTimeEpoch == nil then
		return
	end

	historyDisplayTimeEpoch = newTimeEpoch
	HonorAssist:PushHistoryDataToUi()
end

function HonorAssist:GetPreviousDayTimeEpoch()
	local previousAvailableDayTimeEpoch = nil
	for dayStartTimeEpoch, _ in pairs(historyData) do
		if dayStartTimeEpoch < historyDisplayTimeEpoch then
			if previousAvailableDayTimeEpoch == nil then
				previousAvailableDayTimeEpoch = dayStartTimeEpoch
			elseif dayStartTimeEpoch > previousAvailableDayTimeEpoch then
				previousAvailableDayTimeEpoch = dayStartTimeEpoch
			end
		end
	end

	return previousAvailableDayTimeEpoch
end

function HonorAssist:GetNextDayTimeEpoch()
	local nextAvailableDayTimeEpoch = nil
	for dayStartTimeEpoch, _ in pairs(historyData) do
		if dayStartTimeEpoch > historyDisplayTimeEpoch then
			if nextAvailableDayTimeEpoch == nil then
				nextAvailableDayTimeEpoch = dayStartTimeEpoch
			elseif dayStartTimeEpoch < nextAvailableDayTimeEpoch then
				nextAvailableDayTimeEpoch = dayStartTimeEpoch
			end
		end
	end

	return nextAvailableDayTimeEpoch
end

function HonorAssist:AddKillToHistory(playerKilled, estimatedHonorGained, timeKilledUtc)
	HonorAssist:AddToHistory(playerKilled, estimatedHonorGained, timeKilledUtc)
end

function HonorAssist:AddBonusHonorToHistory(bonusHonorGained, eventTimeUtc)
	HonorAssist:AddToHistory(HonorAssist.BonusHonorKey, bonusHonorGained, eventTimeUtc)
end

function HonorAssist:AddToHistory(uniqueKey, estimatedHonorGained, eventTimeUtc)
	local eventTimeEpoch = HonorAssist:DatabaseTimeUtcToEpochTime(eventTimeUtc)
	local honorDayStartTimeEpoch = HonorAssist:GetHonorDayStartTimeEpochBasedOnKillTimeEpoch(eventTimeEpoch)

	if historyData[honorDayStartTimeEpoch] == nil then
		historyData[honorDayStartTimeEpoch] = {}
	end

	historyData[honorDayStartTimeEpoch] = HonorAssist:AddToDatabase(historyData[honorDayStartTimeEpoch], uniqueKey, estimatedHonorGained, eventTimeUtc)
end

function HonorAssist:PushHistoryDataToUi()
	HonorAssist:PushToPreviousHistory()
	HonorAssist:PushToCurrentHistory()
	HonorAssist:PushToNextHistory()
end

function HonorAssist:PushToPreviousHistory()
	HonorAssist:ClearPreviousHistoryMessages()
	local previousAvailableDayTimeEpoch = HonorAssist:GetPreviousDayTimeEpoch()

	-- We shouldn't let users click next or previous on the UI if tehre is no more data to display. If we do then just return.
	if previousAvailableDayTimeEpoch == nil then
		HonorAssist:UpdatePreviousHistoryDescription("-")
		return
	end

	HonorAssist:UpdatePreviousHistoryDescription(date("%x", previousAvailableDayTimeEpoch))
	-- If there is a next day available then show it.
	local dayLog = HonorAssist:GetCachedDayLog(previousAvailableDayTimeEpoch)

	for k, v in pairs(dayLog.KillHistory) do
		if v.TimesKilled > 1 then
			HonorAssist:AddPreviousHistoryMessage('' .. v.DateUtc .. ': ' .. v.Name .. ' ' .. v.TimesKilled .. 'x (' .. v.Honor .. ' ' .. HonorAssist:GetTranslation("HONOR"):lower() .. ')')
		else
			HonorAssist:AddPreviousHistoryMessage('' .. v.DateUtc .. ': ' .. v.Name .. ' (' .. v.Honor .. ' ' .. HonorAssist:GetTranslation("HONOR"):lower() .. ')')
		end
	end

	HonorAssist:AddPreviousHistoryMessage(HonorAssist:GetTranslation("HONOR") .. ": " .. dayLog.TotalHonor)
	HonorAssist:AddPreviousHistoryMessage(HonorAssist:GetTranslation("KILLS") .. ": " .. dayLog.TotalKills)
	HonorAssist:UpdatePreviousHistoryDescription(date("%x", previousAvailableDayTimeEpoch))
end

function HonorAssist:PushToCurrentHistory()
	HonorAssist:ClearCurrentHistoryMessages()

	if historyDisplayTimeEpoch == HonorAssist:GetHonorDayStartTimeEpoch() and historyData[historyDisplayTimeEpoch] == nil then
		return
	end

	local dayLog = HonorAssist:GetCachedDayLog(historyDisplayTimeEpoch)
	for k, v in pairs(dayLog.KillHistory) do
		print(v.Name)
		if v.TimesKilled > 1 then
			HonorAssist:AddCurrentHistoryMessage('' .. v.DateUtc .. ': ' .. v.Name .. ' ' .. v.TimesKilled .. 'x (' .. v.Honor .. ' honor)')
		else
			HonorAssist:AddCurrentHistoryMessage('' .. v.DateUtc .. ': ' .. v.Name .. ' (' .. v.Honor .. ' honor)')
		end
	end

	HonorAssist:AddCurrentHistoryMessage(HonorAssist:GetTranslation("HONOR") .. ": " .. dayLog.TotalHonor)
	HonorAssist:AddCurrentHistoryMessage(HonorAssist:GetTranslation("KILLS") .. ": " .. dayLog.TotalKills)
	HonorAssist:UpdateCurrentHistoryDescription(date("%x", historyDisplayTimeEpoch))
end

function HonorAssist:PushToNextHistory()
	HonorAssist:ClearNextHistoryMessages()
	local nextAvailableDayTimeEpoch = HonorAssist:GetNextDayTimeEpoch()

	-- If there is no next day available then show this weeks statistics.
	if historyDisplayTimeEpoch == HonorAssist:GetHonorDayStartTimeEpoch() or nextAvailableDayTimeEpoch == nil then
		local honorWeekStartTime, dayStartTimesEpoch = HonorAssist:GetHonorWeekStartTimeEpoch()
		local totalHonor, totalKills = 0, 0

		for index, dayStartTimeEpoch in pairs(dayStartTimesEpoch) do
			local dayLog = HonorAssist:GetCachedDayLog(dayStartTimeEpoch)

			if dayLog ~= nil then
				totalHonor = totalHonor + dayLog.TotalHonor
				totalKills = totalKills + dayLog.TotalKills
			end
		end

		HonorAssist:UpdateNextHistoryDescription(HonorAssist:GetTranslation("THIS_WEEK")) -- Pass in localized parameter
		HonorAssist:AddNextHistoryMessage(HonorAssist:GetTranslation("HONOR") .. ": " .. totalHonor)
		HonorAssist:AddNextHistoryMessage(HonorAssist:GetTranslation("KILLS") .. ": " .. totalKills)
		return
	end

	HonorAssist:UpdateNextHistoryDescription(date("%x", nextAvailableDayTimeEpoch))
	-- If there is a next day available then show it.
	local dayLog = HonorAssist:GetCachedDayLog(nextAvailableDayTimeEpoch)
	for k, v in pairs(dayLog.KillHistory) do
		if v.TimesKilled > 1 then
			HonorAssist:AddNextHistoryMessage('' .. v.DateUtc .. ': ' .. v.Name .. ' ' .. v.TimesKilled .. 'x (' .. v.Honor .. ' ' .. HonorAssist:GetTranslation("HONOR"):lower() .. ')')
		else
			HonorAssist:AddNextHistoryMessage('' .. v.DateUtc .. ': ' .. v.Name .. ' (' .. v.Honor .. ' ' .. HonorAssist:GetTranslation("HONOR"):lower() .. ')')
		end
	end

	HonorAssist:AddNextHistoryMessage(HonorAssist:GetTranslation("HONOR") .. ": " .. dayLog.TotalHonor)
	HonorAssist:AddNextHistoryMessage(HonorAssist:GetTranslation("KILLS") .. ": " .. dayLog.TotalKills)
	HonorAssist:UpdateNextHistoryDescription(date("%x", nextAvailableDayTimeEpoch))
end

function HonorAssist:GetCachedDayLog(dayTimeEpoch)
	-- If the day is the current day then we don't want to cache it.
	if dayTimeEpoch == HonorAssist:GetHonorDayStartTimeEpoch() then
		return HonorAssist:GenerateDayLog(historyData[dayTimeEpoch])
	end

	if dayLogs[dayTimeEpoch] == nil then
		dayLogs[dayTimeEpoch] = HonorAssist:GenerateDayLog(historyData[dayTimeEpoch])
	end

	return dayLogs[dayTimeEpoch]
end

function HonorAssist:GenerateDayLog(dayData)
	local dayLog = {}
	dayLog.KillHistory = {}
	dayLog.TotalKills = 0
	dayLog.TotalHonor = 0

	if dayData == nil then
		return
	end

	for enemyName, enemyKills in pairs(dayData) do
		for index, honorGained in pairs(enemyKills) do
			if (enemyName ~= HonorAssist.BonusHonorKey) then
				local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(index - 1, honorGained.Honor)
				local timeKilledEpoch = HonorAssist:DatabaseTimeUtcToEpochTime(honorGained.DateUtc)
				table.insert(dayLog.KillHistory, { Name = enemyName, DateUtc = honorGained.DateUtc:match("(%d+:%d+:%d+)"), Honor = realisticHonor, TimesKilled = index })
				dayLog.TotalKills = dayLog.TotalKills + 1
				dayLog.TotalHonor = dayLog.TotalHonor + realisticHonor
			else
				local eventTimeEpoch = HonorAssist:DatabaseTimeUtcToEpochTime(honorGained.DateUtc)
				table.insert(dayLog.KillHistory, { Name = enemyName, DateUtc = honorGained.DateUtc:match("(%d+:%d+:%d+)"), Honor = honorGained.Honor, TimesKilled = 0 })
				dayLog.TotalHonor = dayLog.TotalHonor + honorGained.Honor			
			end
		end
	end

	table.sort(dayLog, function(a, b) return a.DateUtc < b.DateUtc end)
	return dayLog
end