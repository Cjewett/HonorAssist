local addonName, addonTable = ...
HonorAssist = addonTable

local HonorAssistFrame = CreateFrame("Frame", "HonorAssist", UIParent)
HonorAssistDEBUG = false

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

	HonorAssist:Initialize()
end

function HonorAssist:Initialize()
	-- Initialize the values for all services first.
	HonorAssist:LoadDatabaseSettings()
	HonorAssist:LoadDailySettings()
	HonorAssist:LoadHourlySettings()
	HonorAssist:LoadTrackerUiSettings()

	-- Push data into all of the services from the master database.
	-- 'All' currently includes HonorAssistDailyCalculator and HonorAssistHourlyCalculator.
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
	if (self.timeSinceLastUpdate < 60) then
		return
	end

	self.timeSinceLastUpdate = 0

	-- Check to see if daily data needs to be reset
	if (HonorAssist:GetHonorDayStartTimeEpoch() ~= HonorAssist:GetDailyStartTimeEpoch()) then
		-- Just reinitialize everything for now. Wanted a quick solution before committing to anything. Hard to test without the daily resets actually working right now but 
		-- I'm fairly certain this works correctly.
		HonorAssist:Initialize()
		return
	end

	-- Recalculate hourly data
	HonorAssist:RecalculateHourlyData()
end

SLASH_HONORASSIST1 = "/honorassist"
SlashCmdList["HONORASSIST"] = function(msg)
  -- pattern matching that skips leading whitespace and whitespace between cmd and args
  -- any whitespace at end of args is retained
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

	if cmd == "log" then
		HonorAssistLogging = not HonorAssistLogging
		print('HonorAssist logging = ' .. '|cFF00FFFF'.. tostring(HonorAssistLogging))
	elseif cmd == "debug" then
		HonorAssistDEBUG = not HonorAssistDEBUG
		print('HonorAssist DEBUG = ' .. '|cFF00FFFF' .. tostring(HonorAssistDEBUG))
	else
		print('Command not found')
	end
end
