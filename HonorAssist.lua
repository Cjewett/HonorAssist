local addonName, addonTable = ...
HonorAssist = addonTable

local HonorAssistFrame = CreateFrame("Frame", "HonorAssist", UIParent)

HonorAssistFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
HonorAssistFrame:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")

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

	HonorAssist:LoadDatabaseSettings()
	HonorAssist:LoadDailySettings()
	HonorAssist:LoadTrackerUiSettings()
end

function HonorAssist:ProcessChatMsgCombatHonorGain(honorGainedSummary)
	local estimatedHonorGained = string.match(honorGainedSummary, "%d+")
	local playerKilled = string.match(honorGainedSummary, "^([^%s]+)")
	HonorAssist:AddKillToMasterDatabase(playerKilled, estimatedHonorGained)
	HonorAssist:AddKillToDailyDatabase(playerKilled, estimatedHonorGained, HonorAssistLogging)
end

SLASH_HONORASSIST1 = "/honorassist"
SlashCmdList["HONORASSIST"] = function(msg)
	HonorAssistLogging = not HonorAssistLogging
	print('Honor assist logging set to ' .. tostring(HonorAssistLogging))
end