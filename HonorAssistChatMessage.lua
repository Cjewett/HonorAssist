local addonName, addonTable = ...
HonorAssist = addonTable

-- This runs after HonorAssistDailyCalculator. That means the kill is already added to that database, so we can use the times killed from that service.
-- When calculating realistic honor we need to decrease by 1 to get the real value of the kill. 
ChatFrame_AddMessageEventFilter("CHAT_MSG_COMBAT_HONOR_GAIN", function(self, event, text, ...)
	if string.match(text, "dies, honorable kill") then
		local estimatedHonorGained = string.match(text, "%d+")
		local playerKilled = string.match(text, "^([^%s]+)")
		local playerRank = HonorAssist:Trim(string.match(text, "(Rank:.([^(]+))"))
		local timesKilled = HonorAssist:GetTotalKillsDailyDatabase(playerKilled)
		local percentage, realisticHonor = HonorAssist:CalculateRealisticHonor(timesKilled - 1, estimatedHonorGained)
		local timeText = 'times'

		if timesKilled == 1 then
			timeText = 'time'
		end

		text = 'You have killed ' .. playerKilled .. ' (' .. playerRank .. ') ' .. timesKilled .. ' ' .. timeText 
			.. '. This kill granted ' .. percentage * 100 .. '% value for ' .. realisticHonor .. ' honor ' .. string.match(text, "(%(.+)") .. '.'

		return false, text, ...
	else
		dkText = '|cFFFF0000' .. text
		return false, dkText, ...
	end
end)