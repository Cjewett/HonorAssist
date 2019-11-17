local addonName, addonTable = ...
HonorAssist = addonTable

local playerFaction, playerlocalizedFaction = UnitFactionGroup("player")


GameTooltip:HookScript("OnTooltipSetUnit", function(self)

    if UnitIsPlayer("mouseover") then
        mouseoverFaction, mouseoverlocalizedFaction = UnitFactionGroup("mouseover")

        if playerFaction ~= mouseoverFaction then
            local playerName = UnitName("mouseover")

            local dailyKillCount, totalKillCount = HonorAssist:GetPlayerDailyKillCount(playerName)

            -- TODO: Add in logic for base honor for all ranks
            local baseHonor = UnitHealth("mouseover") / UnitHealthMax("mouseover")
            local honorPercentLeft, realisticHonor = HonorAssist:CalculateRealisticHonor(dailyKillCount, 199 * baseHonor)

            -- TODO: Add in toggle for checking if user wants to know if taarger is worth honor
            -- TODO: Modify algo to reduce based on character's level\rank
            -- TODO: Modify algo for spliting honor with nearby raid members
            if honorPercentLeft > 0 then
                self:AddLine("|cff00ff00Honor Value : " .. "|cFF00FFFF" .. honorPercentLeft * 100 .. "%", 1, 1, 1)
                self:AddLine("|cff00ff00Estimated Honor : " .. "|cFF00FFFF" ..  HonorAssist:Round(realisticHonor), 1, 1, 1)
            else
                self:AddLine("|cffff0000NO HONOR", 1, 1, 1)
            end

            -- TODO: Add in toggle for viewing daily kills
            self:AddLine("Daily kills : " ..  "|cFF40FB40" .. tostring(dailyKillCount), 1, 1, 1)

            -- TODO: Add in toggle for viewing total kills
            self:AddLine("Lifetime kills : " .. "|cFF0088FF" .. tostring(totalKillCount), 1, 1, 1)

        end
    end
end)