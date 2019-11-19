local addonName, addonTable = ...
HonorAssist = addonTable

local playerFaction, playerlocalizedFaction = UnitFactionGroup("player")


GameTooltip:HookScript("OnTooltipSetUnit", function(self)

    if UnitIsPlayer("mouseover") then
        local mouseoverFaction, mouseoverlocalizedFaction = UnitFactionGroup("mouseover")
        local playerLevel = UnitLevel("mouseover")

        --  TODO need to make this dynamic based on players level (the level cap to show honor)
        if playerFaction ~= mouseoverFaction and tonumber(playerLevel) > 47 then
            local playerRank = UnitPVPRank("mouseover")
            local playerName = UnitName("mouseover")
            local baseHealth = ( UnitHealth("mouseover") / UnitHealthMax("mouseover") )

            if HonorAssistDEBUG then
                print("OnTooltipSetUnit playerName: " .. playerName .. " baseHealth: " .. baseHealth .. " playerLevel: " .. playerLevel .. " playerRank: " .. playerRank)
            end

            local dailyKillCount, totalKillCount = HonorAssist:GetPlayerDailyKillCount(playerName)

            if HonorAssistDEBUG then
                print("OnTooltipSetUnit dailyKillCount: " .. dailyKillCount .. " totalKillCount: " .. totalKillCount)
            end

            -- TODO: Add in logic for base honor for all ranks
            -- TODO: Modify algo to reduce based on character's level\rank
        
            local honorPercentLeft, realisticHonor = HonorAssist:GetPlayerEstimatedHonor(dailyKillCount, baseHealth, playerLevel, playerRank)

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