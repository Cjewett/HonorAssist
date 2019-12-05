local addonName, addonTable = ...
HonorAssist = addonTable

-- This runs after HonorAssistDailyCalculator. That means the kill is already added to that database, so we can use the times killed from that service.
-- When calculating realistic honor we need to decrease by 1 to get the real value of the kill. 
ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_HONOR_GAIN", function(self, event, text, ...)
	local estimatedHonorGained = string.match(text, "%d+")
	local playerKilled = string.match(text, "^([^%s]+)")
	local playerRank = HonorAssist:Trim(string.match(text, "^(.([^(]+))")) -- Extracts message up until first open parentheses.
	playerRank = string.match(playerRank, "(%a+:.+)") -- Pulls out "Rank: Title".

	if HonorAssist:IsHonorableKill(estimatedHonorGained, playerKilled, playerRank) then
		text = HonorAssist:CreateHonorableKillMessage(estimatedHonorGained, playerKilled, playerRank, text)
	else
		-- Don't need to do anything here for now.
	end

	return false, text, ...
end)

function HonorAssist:IsHonorableKill(estimatedHonorGained, playerKilled, playerRank)
	if estimatedHonorGained == nil or playerKilled == nil or playerRank == nil then
		return false
	end

	return true
end

function HonorAssist:CreateHonorableKillMessage(estimatedHonorGained, playerKilled, playerRank, text)
	local timesKilled = HonorAssist:GetTotalKillsDailyDatabase(playerKilled)
	local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(timesKilled - 1, estimatedHonorGained)
	local timeText = 'TIMES'

	if timesKilled == 1 then
		timeText = 'TIME'
	end

	local chatInfo = ChatTypeInfo["COMBAT_HONOR_GAIN"]

	text = HonorAssist:GetTranslation("YOU_HAVE_KILLED") .. ' ' .. playerKilled .. ' (' .. playerRank .. ') ' .. timesKilled .. ' ' .. HonorAssist:GetTranslation(timeText) .. '. '
		.. HonorAssist:GetTranslation("THIS_KILL_GRANTED") .. ' ' .. percentage * 100 .. '% ' .. HonorAssist:GetTranslation("VALUE_FOR") .. ' |cFF00ccff' .. realisticHonor .. ' ' 
		.. HonorAssist:GetTranslation("HONOR"):lower() .. '|cFF' .. HonorAssist:RGBPercToHex(chatInfo.r, chatInfo.g, chatInfo.b) .. ' ' .. string.match(text, "(%(.+)") .. '.'
	
	return text
end
