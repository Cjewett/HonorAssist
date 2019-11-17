local addonName, addonTable = ...
HonorAssist = addonTable

local playerFaction, playerlocalizedFaction = UnitFactionGroup("player")


GameTooltip:HookScript("OnTooltipSetUnit", function(self)

    if UnitIsPlayer("mouseover") then
        mouseoverFaction, mouseoverlocalizedFaction = UnitFactionGroup("mouseover")

        if playerFaction ~= mouseoverFaction then
            local playerName = UnitName("mouseover")

            self:AddLine("Honor Assist|r", 1, 0, 1)
            local dailyKillCount, totalKillCount = HonorAssist:GetPlayerDailyKillCount(playerName)

            -- TODO: Add in logic for base honor for all ranks
            local baseHonor = UnitHealth("mouseover") / UnitHealthMax("mouseover") * 100
            local honorPercentLeft, realisticHonor = HonorAssist:CalculateRealisticHonor(dailyKillCount, 200 * baseHonor)

            -- TODO: Add in toggle for checking if user wants to know if targer is worth honor
            if honorPercentLeft > 0 then
                self:AddLine("|cff00ff00Worth Honor : " .. "|cFF00FFFF" .. honorPercentLeft, 1, 1, 1)
                self:AddLine("|cff00ff00Estimated Honor : " .. "|cFF00FFFF" .. realisticHonor, 1, 1, 1)
            else
                self:AddLine("|cffff0000NO HONOR", 1, 1, 1)
            end

            -- TODO: Add in toggle for viewing daily kills
            self:AddLine("Daily kills : " ..  "|cFF40FB40" .. tostring(dailyKillCount), 1, 1, 1)

            -- TODO: Add in toggle for viewing total kills
            self:AddLine("Total kills : " .. "|cFF0088FF" .. tostring(totalKillCount), 1, 1, 1)

        end
    end
end)