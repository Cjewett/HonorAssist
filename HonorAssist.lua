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
	HonorAssist:LoadHistoryLoader()
	HonorAssist:LoadNameplateSettings()
	HonorAssist:LoadOptionsUi()

	-- Push data into all of the services from the master database.
	-- 'All' currently includes HonorAssistDailyCalculator and HonorAssistHourlyCalculator.
	HonorAssist:LoadDataSinceDateTimeUtc(HonorAssist:GetDailyStartTimeEpoch(), HonorAssist:GetHourlyStartTimeEpoch())
end

function HonorAssist:ProcessChatMsgCombatHonorGain(honorGainedSummary)
	local eventTimeUtc = HonorAssist:GetCurrentTimeUtc()
	local estimatedHonorGained = string.match(honorGainedSummary, "%d+")
	local playerKilled = string.match(honorGainedSummary, "^([^%s]+)")
	local hasParentheses = string.match(honorGainedSummary, "%(")

	-- If there is no number then it is a dishonorable kill. Ignore.
	if estimatedHonorGained == nil then
		return
	end

	-- If there is estimatedHonorGained, playerKilled, and parentheses in the summary then a player was killed.
	if estimatedHonorGained ~= nil and playerKilled ~= nil and hasParentheses ~= nill then
		HonorAssist:ProcessPlayerKillMessage(eventTimeUtc, estimatedHonorGained, playerKilled)
	end

	-- If there is estimatedHonorGained and no parentheses in the summary then bonus honor was gained. 
	if estimatedHonorGained ~= nil and hasParentheses == nil then
		HonorAssist:ProcessBonusHonorMessage(eventTimeUtc, estimatedHonorGained)
	end
end

function HonorAssist:ProcessPlayerKillMessage(eventTimeUtc, estimatedHonorGained, playerKilled)
	HonorAssist:AddKillToMasterDatabase(playerKilled, estimatedHonorGained, eventTimeUtc)
	local honorGained = HonorAssist:AddKillToDailyDatabase(playerKilled, estimatedHonorGained, eventTimeUtc)
	HonorAssist:AddToHourlyDatabase(honorGained, eventTimeUtc)
	HonorAssist:AddKillToHistory(playerKilled, estimatedHonorGained, eventTimeUtc)
end

function HonorAssist:ProcessBonusHonorMessage(eventTimeUtc, estimatedHonorGained)
	HonorAssist:AddBonusHonorToMasterDatabase(estimatedHonorGained, eventTimeUtc)
	local honorGained = HonorAssist:AddBonusHonorToDailyDatabase(tonumber(estimatedHonorGained), eventTimeUtc)
	HonorAssist:AddToHourlyDatabase(honorGained, eventTimeUtc)
	HonorAssist:AddBonusHonorToHistory(honorGained, eventTimeUtc)
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
SLASH_HONORASSIST2 = "/honorassist help"
SLASH_HONORASSIST3 = "/honorassist show"
SLASH_HONORASSIST4 = "/honorassist hide"
SLASH_HONORASSIST5 = "/honorassist debug"
SlashCmdList["HONORASSIST"] = function(msg)
	if HonorAssist:StringIsNullOrEmpty(msg) then
		HonorAssist:PrintHelpInformation()
	end

	local slashCommandMsg = HonorAssist:SplitString(msg, " ")
	local subCommand = slashCommandMsg[1]

	if subCommand == "help" then
		HonorAssist:PrintHelpInformation()
	end

	if subCommand == "debug" then
		HonorAssistDEBUG = not HonorAssistDEBUG
		print('HonorAssist DEBUG = ' .. '|cFF00FFFF' .. tostring(HonorAssistDEBUG))
	end

	if subCommand == "show" then
		HonorAssist:ShowTrackerUi(true)
	end

	if subCommand == "hide" then
		HonorAssist:ShowTrackerUi(false)
	end

	if subCommand == "test" then
		HonorAssist:ProcessChatMsgCombatHonorGain("You have been awarded 200 honor points")
	end
end

function HonorAssist:PrintHelpInformation()
	print("HonorAssist Help Information")
	print("/honorassist, /honorassist help -- Displays help information for HonorAssist addon.")
	print("/honorassist show -- Shows the Honor Assist (Daily) tracker.")
	print("/honorassist hide -- Hides the Honor Assist (Daily) tracker.")
end
