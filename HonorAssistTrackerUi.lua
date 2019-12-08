local addonName, addonTable = ...
HonorAssist = addonTable

local titleText = HonorAssist:GetTranslation("HONOR_ASSIST") .. " (" .. HonorAssist:GetTranslation("DAILY") .. ")"
local totalKillsText = HonorAssist:GetTranslation("KILLS") .. ": "
local honorGainedTodayText = HonorAssist:GetTranslation("HONOR_GAINED") .. ": "
local averageHonorText = HonorAssist:GetTranslation("AVERAGE") .. ": "
local honorPerHourText = HonorAssist:GetTranslation("HONOR") .. "/" .. HonorAssist:GetTranslation("HOUR")
local fromBonusText = HonorAssist:GetTranslation("FROM_BONUS")
local fromKillsText = HonorAssist:GetTranslation("FROM_KILLS")

function HonorAssist:LoadTrackerUiSettings()
	if HonorAssistTrackerFramePositionX == nil or HonorAssistTrackerFramePositionY == nil then
		HonorAssistTrackerFramePositionX = 0
		HonorAssistTrackerFramePositionY = 0
	end

	if HonorAssistShowTrackerUi == nil then
		HonorAssistShowTrackerUi = true
	end

	HonorAssist:SetPosition()
	HonorAssist:ShowTrackerUi(HonorAssistShowTrackerUi)
end

HonorAssist.trackerFrame = CreateFrame("Frame", addonName, UIParent)
HonorAssist.trackerFrame:SetFrameStrata("BACKGROUND")
HonorAssist.trackerFrame:SetWidth(175)
HonorAssist.trackerFrame:SetHeight(108)
HonorAssist.trackerFrame:SetMovable(true)
HonorAssist.trackerFrame:EnableMouse(true)
HonorAssist.trackerFrame:SetClampedToScreen(true)
HonorAssist.trackerFrame:RegisterForDrag("LeftButton")
HonorAssist.trackerFrame:SetScript("OnDragStart", HonorAssist.trackerFrame.StartMoving)
HonorAssist.trackerFrame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	HonorAssistTrackerFramePositionX = self:GetLeft()
	HonorAssistTrackerFramePositionY = self:GetBottom()
end)

HonorAssist.texture = HonorAssist.trackerFrame:CreateTexture()
HonorAssist.texture:SetAllPoints(HonorAssist.trackerFrame)
HonorAssist.texture:SetColorTexture(0, 0, 0, 0.2)
HonorAssist.trackerFrame.texture = HonorAssist.texture

-- Title
HonorAssist.title = HonorAssist.trackerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.title:SetPoint("TOP", 2, 0)
HonorAssist.title:SetTextColor(1, 1, 1, 1)
HonorAssist.title:SetText(titleText)

-- Honor Gained Today
HonorAssist.honorGained = HonorAssist.trackerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.honorGained:SetPoint("TOPLEFT", 4, -18)
HonorAssist.honorGained:SetTextColor(1, 1, 1, 1)
HonorAssist.honorGained:SetText(honorGainedTodayText)

-- Honor From Bonus
HonorAssist.honorFromBonus = HonorAssist.trackerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.honorFromBonus:SetPoint("TOPLEFT", 4, -34)
HonorAssist.honorFromBonus:SetTextColor(1, 1, 1, 1)
HonorAssist.honorFromBonus:SetText("From Bonus:")

-- Honor From Kills
HonorAssist.honorFromKills = HonorAssist.trackerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.honorFromKills:SetPoint("TOPLEFT", 4, -50)
HonorAssist.honorFromKills:SetTextColor(1, 1, 1, 1)
HonorAssist.honorFromKills:SetText("From Kills:")

-- Total Kills
HonorAssist.totalKills = HonorAssist.trackerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.totalKills:SetPoint("TOPLEFT", 4, -66)
HonorAssist.totalKills:SetTextColor(1, 1, 1, 1)
HonorAssist.totalKills:SetText(totalKillsText)

-- Average Honor Per Kill
HonorAssist.avgHonor = HonorAssist.trackerFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.avgHonor:SetPoint("TOPLEFT", 4, -82)
HonorAssist.avgHonor:SetTextColor(1, 1, 1, 1)
HonorAssist.avgHonor:SetText(averageHonorText)

-- Average Honor Per Hour
HonorAssist.avgHonorPerHour = HonorAssist.trackerFrame:CreateFontString(nil, "ARTOWORK", "GameFontNormalSmall")
HonorAssist.avgHonorPerHour:SetPoint("BOTTOM", 2, 0)
HonorAssist.avgHonorPerHour:SetTextColor(1, 1, 1, 1)
HonorAssist.avgHonorPerHour:SetText("0 " .. honorPerHourText)

-- Show HonorAssist.trackerFrame
HonorAssist.trackerFrame:SetPoint("CENTER", 0, 0)

function HonorAssist:ShowTrackerUi(enable)
	if enable == true then
		HonorAssistShowTrackerUi = true
		HonorAssist.trackerFrame:Show()
	elseif enable == false then
		HonorAssistShowTrackerUi = false
		HonorAssist.trackerFrame:Hide()
	end
end

function HonorAssist:SetPosition()
	if HonorAssistTrackerFramePositionX == nil and HonorAssistTrackerFramePositionY == nil then
		HonorAssist.trackerFrame:SetPoint("CENTER", HonorAssistTrackerFramePositionX, HonorAssistTrackerFramePositionY)
	else
		HonorAssist.trackerFrame:SetPoint("BOTTOMLEFT", HonorAssistTrackerFramePositionX, HonorAssistTrackerFramePositionY)
	end
end

function HonorAssist:UpdateDailyTrackerKills(kills) 
	HonorAssist.totalKills:SetText(totalKillsText .. kills)
end

function HonorAssist:UpdateDailyTrackerHonor(honor) 
	HonorAssist.honorGained:SetText(honorGainedTodayText .. honor)
end

function HonorAssist:UpdateDailyTrackerAverage(kills, honor)
	HonorAssist.avgHonor:SetText(averageHonorText .. HonorAssist:Round((honor / kills), 2))
end

function HonorAssist:UpdateHourlyHonor(hourlyHonor)
	HonorAssist.avgHonorPerHour:SetText(HonorAssist:Round(hourlyHonor, 2) .. " " .. honorPerHourText)
end

function HonorAssist:UpdateDailyBonusHonor(honor)
	HonorAssist.honorFromBonus:SetText(fromBonusText .. ": " .. honor)
end

function HonorAssist:UpdateDailyKillHonor(honor)
	HonorAssist.honorFromKills:SetText(fromKillsText .. ": " .. honor)
end