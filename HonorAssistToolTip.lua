local addonName, addonTable = ...
HonorAssist = addonTable

local currentPlayerFaction, _ = UnitFactionGroup("player")


GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    local frameUnit = nil

    if UnitIsPlayer("mouseover") then
        frameUnit ="mouseover"
    elseif string.match(GetMouseFocus():GetName():lower(), "targettargettarget") then
        frameUnit = "targettargettarget"
    elseif string.match(GetMouseFocus():GetName():lower(), "targettarget") then
        frameUnit = "targettarget"
    elseif string.match(GetMouseFocus():GetName():lower(), "target") then
        frameUnit = "target"
    end

    if frameUnit ~= nil and UnitIsPlayer(frameUnit) then
        playerData = {}
        playerData.Faction, _ = UnitFactionGroup(frameUnit)
        playerData.Level = UnitLevel(frameUnit)

        -- TODO need to make this dynamic based on players level (the level cap to show honor)
        -- IE only show for players that would give you honor not assuming player is MAX level

        if HonorAssistDEBUG then
            print("This is frameUnit " .. " Frame: " .. GetMouseFocus():GetName() .. " playerData.Faction: " .. playerData.Faction .. "  playerData.Level: "..  playerData.Level)
        end

        if currentPlayerFaction ~= playerData.Faction and tonumber(playerData.Level) > 47 then

            playerData.Rank = UnitPVPRank(frameUnit)
            playerData.Name = UnitName(frameUnit)
            playerData.baseHealth = ( UnitHealth(frameUnit) / UnitHealthMax(frameUnit) )

            HonorAssist:AddHonorLinesToTooltip(self, playerData)

        end
    end
end)


function HonorAssist:AddHonorLinesToTooltip(tooltip, playerData)
    if HonorAssistDEBUG then
        print("OnTooltipSetUnit playerName: " .. playerData.Name .. " baseHealth: " .. playerData.baseHealth .. " playerLevel: " .. playerData.Level .. " playerRank: " .. playerData.Rank)
    end

    local dailyKillCount, totalKillCount = HonorAssist:GetPlayerDailyKillCount(playerData.Name)

    if HonorAssistDEBUG then
        print("OnTooltipSetUnit dailyKillCount: " .. dailyKillCount .. " totalKillCount: " .. totalKillCount)
    end
    
    local honorPercentLeft, realisticHonor = HonorAssist:GetPlayerEstimatedHonor(dailyKillCount, playerData.baseHealth, playerData.Level, playerData.Rank)

    -- TODO: Modify algo for spliting honor with nearby raid members
    if honorPercentLeft > 0 then
        tooltip:AddLine("|cff00ff00Honor Value : " .. "|cFF00FFFF" .. honorPercentLeft * 100 .. "%", 1, 1, 1)
        tooltip:AddLine("|cff00ff00Estimated Honor : " .. "|cFF00FFFF" ..  HonorAssist:Round(realisticHonor), 1, 1, 1)
    else
        tooltip:AddLine("|cffff0000NO HONOR", 1, 1, 1)
    end

    -- TODO: Add in toggle for viewing daily kills
    tooltip:AddLine("Daily kills : " ..  "|cFF40FB40" .. tostring(dailyKillCount), 1, 1, 1)

    -- TODO: Add in toggle for viewing total kills
    tooltip:AddLine("Lifetime kills : " .. "|cFF0088FF" .. tostring(totalKillCount), 1, 1, 1)
end

