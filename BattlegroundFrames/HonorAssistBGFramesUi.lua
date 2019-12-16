local addonName, addonTable = ...
HonorAssist = addonTable

function HonorAssist:LoadBGFramesUi()
	if HonorAssistBattlegroundFramesPositionX == nil or HonorAssistBattlegroundFramesPositionY == nil then
		HonorAssistBattlegroundFramesPositionX = 0
		HonorAssistBattlegroundFramesPositionY = 0
	end

	if HonorAssistBattlegroundFramesToggle == nil then
		HonorAssistBattlegroundFramesToggle = true
	end

	if HonorAssistBattlegroundFramesLockToggle == nil then
		HonorAssistBattlegroundFramesLockToggle = false
	end

	HonorAssist:SetBattlegroundFramePosition()
	HonorAssist:LockBattlegroundFramesWindow()
end

HonorAssist.battlegroundFrames = CreateFrame("Frame", "HonorAssistBattlegroundFrames", UIParent)
HonorAssist.battlegroundFrames:SetFrameStrata("BACKGROUND")
HonorAssist.battlegroundFrames:SetWidth(200)
HonorAssist.battlegroundFrames:SetHeight(200)
HonorAssist.battlegroundFrames:SetMovable(true)
HonorAssist.battlegroundFrames:EnableMouse(true)
HonorAssist.battlegroundFrames:SetClampedToScreen(true)
HonorAssist.battlegroundFrames:RegisterForDrag("LeftButton")
HonorAssist.battlegroundFrames:SetScript("OnDragStart", HonorAssist.battlegroundFrames.StartMoving)
HonorAssist.battlegroundFrames:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	HonorAssistBattlegroundFramesPositionX = self:GetLeft()
	HonorAssistBattlegroundFramesPositionY = self:GetBottom()
end)

HonorAssist.battlegroundFrames.texture = HonorAssist.battlegroundFrames:CreateTexture()
HonorAssist.battlegroundFrames.texture:SetAllPoints(HonorAssist.battlegroundFrames)
HonorAssist.battlegroundFrames.texture = HonorAssist.battlegroundFrames.texture

function HonorAssist:SetBattlegroundFramePosition()
	if HonorAssistBattlegroundFramesPositionX == nil and HonorAssistBattlegroundFramesPositionY == nil then
		HonorAssist.battlegroundFrames:SetPoint("CENTER", HonorAssistBattlegroundFramesPositionX, HonorAssistBattlegroundFramesPositionY)
	else
		HonorAssist.battlegroundFrames:SetPoint("BOTTOMLEFT", HonorAssistBattlegroundFramesPositionX, HonorAssistBattlegroundFramesPositionY)
	end
end

HonorAssist.battlegroundFrames.battlegroundFrame = {}
HonorAssist.battlegroundFrames.battlegroundFrame.pool = {}
HonorAssist.battlegroundFrames.battlegroundFrame.enemies = {}

function HonorAssist:LockBattlegroundFramesWindow()
	HonorAssist.battlegroundFrames:SetMovable(not HonorAssistBattlegroundFramesLockToggle)
end

function HonorAssist:CreateBgFrame()
	local bgFrameBtn = HonorAssist:GetFreeBgFrameBtn()

	if bgFrameBtn ~= nil then
		return bgFrameBtn
	end

	local id = #HonorAssist.battlegroundFrames.battlegroundFrame.pool + 1
	local bgFrameBtn = CreateFrame("Button", "HonorAssistBattlegroundFrame" .. id, HonorAssist.battlegroundFrames, "SecureActionButtonTemplate")
	bgFrameBtn.isUsed = false
	bgFrameBtn.index = id
	bgFrameBtn.guid = nil
	bgFrameBtn:SetPoint("TOP", 0, 26 - (id * 29))
	bgFrameBtn:SetSize(190, 28)
	bgFrameBtn:SetBackdrop({ bgFile = "Interface/Buttons/GreyscaleRamp64", edgeFile = "Interface/Buttons/WHITE8X8", edgeSize = 1 })
	bgFrameBtn:SetBackdropColor(0.075, 0.075, 0.075, 1)
	bgFrameBtn:SetBackdropBorderColor(0, 0, 0, 1)
	bgFrameBtn:SetAlpha(1)
	bgFrameBtn:RegisterForDrag('LeftButton')
	bgFrameBtn:SetScript('OnDragStart', function()
		if (not HonorAssistBattlegroundFramesLockToggle) then
			HonorAssist.battlegroundFrames:StartMoving() 
		end
	end)
	bgFrameBtn:SetScript('OnDragStop', function()
		if (not HonorAssistBattlegroundFramesLockToggle) then
			HonorAssist.battlegroundFrames:StopMovingOrSizing()
			HonorAssistBattlegroundFramesPositionX = HonorAssist.battlegroundFrames:GetLeft()
			HonorAssistBattlegroundFramesPositionY = HonorAssist.battlegroundFrames:GetBottom()
		end
	end)
	bgFrameBtn:SetAttribute("type1", "")
	bgFrameBtn:SetAttribute("macrotext1", "")
	bgFrameBtn:Hide()

	bgFrameBtn.healthBar = CreateFrame("StatusBar", nil, bgFrameBtn)
	bgFrameBtn.healthBar:SetPoint("TOPLEFT", 1, -1)
	bgFrameBtn.healthBar:SetPoint("BOTTOMRIGHT", -1, 1)
	bgFrameBtn.healthBar:SetStatusBarTexture("Interface/Buttons/GreyscaleRamp64")
	bgFrameBtn.healthBar:SetMinMaxValues(0, 1)

	bgFrameBtn.resourceBar = CreateFrame("StatusBar", nil, bgFrameBtn.healthBar)
	bgFrameBtn.resourceBar:SetPoint("BOTTOMLEFT")
	bgFrameBtn.resourceBar:SetPoint("RIGHT")
	bgFrameBtn.resourceBar:SetHeight(3)
	bgFrameBtn.resourceBar:SetBackdrop({ bgFile = "Interface/Buttons/GreyscaleRamp64", insets = { top = -1 } });
	bgFrameBtn.resourceBar:SetStatusBarTexture("Interface/Buttons/GreyscaleRamp64");
	bgFrameBtn.resourceBar:SetStatusBarColor(0.3, 0.5, 0.85);
	bgFrameBtn.resourceBar:SetBackdropColor(0.075, 0.075, 0.075, 0.9);
	bgFrameBtn.resourceBar:SetBackdropBorderColor(0, 0, 0, 1);
	bgFrameBtn.resourceBar:SetMinMaxValues(0, 1);

	bgFrameBtn.name = bgFrameBtn.healthBar:CreateFontString(nil, "ARTWORK")
	bgFrameBtn.name:SetPoint("TOPLEFT", 5, 0)
	bgFrameBtn.name:SetPoint("BOTTOMRIGHT")
	bgFrameBtn.name:SetFont("Fonts/ARIALN.TTF", 12)
	bgFrameBtn.name:SetJustifyH("LEFT")
	bgFrameBtn.name:SetJustifyV("MIDDLE")
	bgFrameBtn.name:SetTextColor(1, 1, 1)
	bgFrameBtn.name:SetShadowColor(0, 0, 0, 1)
	bgFrameBtn.name:SetShadowOffset(1, -1)

	bgFrameBtn.healthBarText = bgFrameBtn.healthBar:CreateFontString(nil, "ARTWORK")
	bgFrameBtn.healthBarText:SetPoint("TOPRIGHT", -5, 0)
	bgFrameBtn.healthBarText:SetPoint("BOTTOMRIGHT")
	bgFrameBtn.healthBarText:SetFont("Fonts/ARIALN.TTF", 12)
	bgFrameBtn.healthBarText:SetJustifyH("RIGHT")
	bgFrameBtn.healthBarText:SetJustifyV("MIDDLE")
	bgFrameBtn.healthBarText:SetTextColor(1, 1, 1)
	bgFrameBtn.healthBarText:SetShadowColor(0, 0, 0, 1)
	bgFrameBtn.healthBarText:SetShadowOffset(1, -1)

	table.insert(HonorAssist.battlegroundFrames.battlegroundFrame.pool, bgFrameBtn)
	HonorAssist:SortBgFrames()
	return bgFrameBtn
end

function HonorAssist:SortBgFrames()
	table.sort(HonorAssist.battlegroundFrames.battlegroundFrame.pool, function(a, b) return a.isUsed and not b.isUsed end)

	for i, bgFrameBtn in pairs(HonorAssist.battlegroundFrames.battlegroundFrame.pool) do
		bgFrameBtn.index = i
		bgFrameBtn:SetPoint("TOP", 0, 26 - (i * 29))
	end
end

function HonorAssist:GetFreeBgFrameBtn()
	for i, bgFrameBtn in pairs(HonorAssist.battlegroundFrames.battlegroundFrame.pool) do
		if not bgFrameBtn.isUsed then
			return bgFrameBtn
		end
	end
end

function HonorAssist:ReserveBgFrame(bgFrameBtn, GUID)
	HonorAssist.battlegroundFrames.battlegroundFrame.enemies[GUID] = bgFrameBtn
	bgFrameBtn.isUsed = true
	bgFrameBtn.guid = GUID
	bgFrameBtn:Show()
end

function HonorAssist:ReleaseBgFrame(bgFrameBtn, GUID)
	HonorAssist.battlegroundFrames.battlegroundFrame.enemies[GUID] = nil
	bgFrameBtn.isUsed = false
	bgFrameBtn.guid = nil
	HonorAssist:SortBgFrames()
	bgFrameBtn:Hide()
end

function HonorAssist:ClearAllBgFrames()
	for i, bgFrameBtn in pairs(HonorAssist.battlegroundFrames.battlegroundFrame.pool) do
		if (bgFrameBtn.guid ~= nil) then
			HonorAssist.battlegroundFrames.battlegroundFrame.enemies[bgFrameBtn.guid] = nil
			bgFrameBtn.isUsed = false
			bgFrameBtn.guid = nil
			HonorAssist:ClearBGFrameBtnMacros(bgFrameBtn)
			bgFrameBtn:Hide()
		end
	end

	HonorAssist:SortBgFrames()
end

function HonorAssist:UpdateBGFrameBtnMacros(bgFrameBtn, unitName)
	bgFrameBtn:SetAttribute("type1", "macro")
	bgFrameBtn:SetAttribute("macrotext1", "/targetexact " .. unitName)
end

function HonorAssist:ClearBGFrameBtnMacros(bgFrameBtn)
	bgFrameBtn:SetAttribute("type1", "")
	bgFrameBtn:SetAttribute("macrotext1", "")
end

function HonorAssist:UpdateUnit(bgFrameBtn, guid)
	bgFrameBtn.guid = guid
end

function HonorAssist:UpdateName(bgFrameBtn, name)
	bgFrameBtn.name:SetText(name)
end

function HonorAssist:UpdateHealth(bgFrameBtn, currentHealth, maxHealth)
	local health = currentHealth / maxHealth
	bgFrameBtn.healthBar:SetValue(health)
	bgFrameBtn.healthBarText:SetText(HonorAssist:Round(health * 100, 0) .. "%")
end

function HonorAssist:UpdateDeath(bgFrameBtn)
	bgFrameBtn.healthBar:SetValue(0)
	bgFrameBtn.healthBarText:SetText(HonorAssist:GetTranslation("DEAD"))
	bgFrameBtn.resourceBar:SetValue(0)
end

function HonorAssist:UpdateHealthColor(bgFrameBtn, classFileName)
	local color = RAID_CLASS_COLORS[classFileName:upper()]
	bgFrameBtn.healthBar:SetStatusBarColor(color.r, color.g, color.b)
end

function HonorAssist:UpdateResource(bgFrameBtn, currentResource, maxResource)
	bgFrameBtn.resourceBar:SetValue(currentResource / maxResource)
end

function HonorAssist:UpdateResourceColor(bgFrameBtn, altR, altG, altB)
	bgFrameBtn.resourceBar:SetStatusBarColor(altR, altG, altB)
end

function HonorAssist:UpdateRange(bgFrameBtn, isInRange)
	if (isInRange) then
		bgFrameBtn:SetAlpha(1)
	else
		bgFrameBtn:SetAlpha(0.5)
	end
end

function HonorAssist:IsAlreadyEnemy(guid)
	if (HonorAssist.battlegroundFrames.battlegroundFrame.enemies[guid] == nil) then
		return false
	end

	return true, HonorAssist.battlegroundFrames.battlegroundFrame.enemies[guid]
end