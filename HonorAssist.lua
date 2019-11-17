local addonName, addonTable = ...
HonorAssist = addonTable

local HonorAssistFrame = CreateFrame("Frame", "HonorAssist", UIParent)

HonorAssistFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
HonorAssistFrame:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
HonorAssistFrame:SetScript("OnUpdate", function(self, timeSinceLastUpdate) HonorAssist:OnUpdateTimer(timeSinceLastUpdate); end);

HonorAssistFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		HonorAssist:ProcessPlayerEnteringWorld()
	end

	if event == "CHAT_MSG_COMBAT_HONOR_GAIN" then
		HonorAssist:ProcessChatMsgCombatHonorGain(...)
	end
end)

function HonorAssist:ProcessPlayerEnteringWorld()
	if HonorAssistLogging == nil then
		HonorAssistLogging = false
	end

	-- Initialize the values for all services first.
	HonorAssist:LoadDatabaseSettings()
	HonorAssist:LoadDailySettings()
	HonorAssist:LoadHourlySettings()
	HonorAssist:LoadTrackerUiSettings()

	-- Push data into all of the services from the master database.
	HonorAssist:LoadDataSinceDateTimeUtc(HonorAssist:GetDailyStartTimeEpoch(), HonorAssist:GetHourlyStartTimeEpoch())
end

function HonorAssist:ProcessChatMsgCombatHonorGain(honorGainedSummary)
	local estimatedHonorGained = string.match(honorGainedSummary, "%d+")
	local playerKilled = string.match(honorGainedSummary, "^([^%s]+)")
	local eventTimeUtc = HonorAssist:GetCurrentTimeUtc()
	HonorAssist:AddKillToMasterDatabase(playerKilled, estimatedHonorGained, eventTimeUtc)
	local honorGained = HonorAssist:AddKillToDailyDatabase(playerKilled, estimatedHonorGained, eventTimeUtc, HonorAssistLogging)
	HonorAssist:AddKillToHourlyDatabase(honorGained, eventTimeUtc)
end

function HonorAssist:OnUpdateTimer(timeSinceLastUpdate)
	local time = GetTime()

	if (time == nil) then
		return
	end

	self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + timeSinceLastUpdate;

	-- Update hourly calculator every minute.
	if (self.timeSinceLastUpdate >= 60) then
		self.timeSinceLastUpdate = 0
		HonorAssist:RecalculateHourlyData()
	end
end

SLASH_HONORASSIST1 = "/honorassist"
SlashCmdList["HONORASSIST"] = function(msg)
	HonorAssistLogging = not HonorAssistLogging
	print('Honor assist logging set to ' .. tostring(HonorAssistLogging))
end