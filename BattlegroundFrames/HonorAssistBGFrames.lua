local addonName, addonTable = ...
HonorAssist = addonTable

local isInBattleground = false
local playersCurrentRealm = nil
local playersCurrentFaction = nil

function HonorAssist:LoadBGFrames()
	playersCurrentRealm = GetRealmName()
	local englishFaction, localizedFaction = UnitFactionGroup("Player")
	playersCurrentFaction = englishFaction
end

function HonorAssist:AddPlayerToList(fullName, faction, class, classToken)
	local name = nil
	local realm = nil
	fullName, name, realm = HonorAssist:GetRealmName(fullName)

	if (HonorAssist:IsAlreadyEnemy(fullName)) then
		return fullName, name, realm
	end

	local bgFrameBtn = HonorAssist:CreateBgFrame()

	if (realm == playersCurrentRealm) then
		HonorAssist:UpdateBGFrameBtnMacros(bgFrameBtn, name)
	else
		HonorAssist:UpdateBGFrameBtnMacros(bgFrameBtn, fullName)
	end

	HonorAssist:UpdateName(bgFrameBtn, fullName)
	HonorAssist:UpdateHealth(bgFrameBtn, 1, 1)
	HonorAssist:UpdateHealthColor(bgFrameBtn, class)
	HonorAssist:UpdateResource(bgFrameBtn, 1, 1)
	HonorAssist:UpdateResourceColor(bgFrameBtn, .8, .8, .8)
	HonorAssist:ReserveBgFrame(bgFrameBtn, fullName)

	return fullName, name, realm
end

function HonorAssist:RemovePlayerFromList(fullName)
	local name = nil
	local realm = nil
	fullName, name, realm = HonorAssist:GetRealmName(fullName)
	local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(fullName)

	if (not isAlreadyEnemy) then
		return
	end

	HonorAssist:ReleaseBgFrame(bgFrameBtn, fullName)
	HonorAssist:ClearBGFrameBtnMacros(bgFrameBtn)
end

function HonorAssist:UpdateBattlefieldScore()
	local enemiesInBg = {}
	local englishFaction, localizedFaction = UnitFactionGroup("Player")
	local totalPlayerCount = GetNumBattlefieldScores()
	for i = 1, totalPlayerCount do
		local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class, classToken = GetBattlefieldScore(i);

		local factionName = nil
		if (faction == 0) then
			factionName = "Horde"
		else
			factionName = "Alliance"
		end

		if (englishFaction ~= factionName) then
			local fullName, name, realm = HonorAssist:AddPlayerToList(name, faction, class, classToken)

			if (enemiesInBg[fullName] == nil) then
				enemiesInBg[fullName] = { bgFrameBtn = nil }
			end
		end
	end

	for i, bgFrameBtn in pairs(HonorAssist.battlegroundFrames.battlegroundFrame.enemies) do
		if enemiesInBg[bgFrameBtn.guid] == nil then
			enemiesInBg[bgFrameBtn.guid] = { bgFrameBtn = bgFrameBtn }
		end
	end

	for key, enemy in pairs(enemiesInBg) do
		if enemy.bgFrameBtn ~= nil then
			 HonorAssist:ReleaseBgFrame(enemy.bgFrameBtn, enemy.bgFrameBtn.guid)
		end
	end
end

function HonorAssist:ProcessCombatLogEventUnfiltered(info, timestamp, event, hideCaster, srcGUID, srcName, srcFlags, sourceRaidFlags, dstGUID, dstName, dstFlags, destRaidFlags, ...)
	timestamp, event, hideCaster, srcGUID, srcName, srcFlags, sourceRaidFlags, dstGUID, dstName, dstFlags, destRaidFlags, arg12, arg13, arg14, arg15, arg16 = CombatLogGetCurrentEventInfo()

	if (event == "UNIT_DIED") then
		local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(dstName)
		if (isAlreadyEnemy) then
			HonorAssist:UpdateDeath(bgFrameBtn, dstName)
		end
	end
end

function HonorAssist:ReportNewBgUnit(unitId)
	if (not UnitIsPlayer(unitId)) then
		return
	end

	local englishFaction, localizedFaction = UnitFactionGroup(unitId)

	if (englishFaction == playersCurrentFaction) then
		return
	end

	local guid = UnitGUID(unitId)
	local initName, initRealm = UnitName(unitId)

	if (initRealm == nil) then
		initRealm = playersCurrentRealm
	end

	local fullName, name, realm = HonorAssist:GetRealmName(initName .. "-" .. initRealm)
	local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(fullName)

	if (not isAlreadyEnemy) then
		return
	end

	HonorAssist:UpdateUnit(bgFrameBtn, fullName)
end

function HonorAssist:UpdateBgFrameHealth(unitId)
	if (not UnitIsPlayer(unitId)) then
		return
	end

	local englishFaction, localizedFaction = UnitFactionGroup(unitId)

	if (englishFaction == playersCurrentFaction) then
		return
	end

	local guid = UnitGUID(unitId)
	local initName, initRealm = UnitName(unitId)

	if (initRealm == nil) then
		initRealm = playersCurrentRealm
	end

	local fullName, name, realm = HonorAssist:GetRealmName(initName .. "-" .. initRealm)
	local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(fullName)

	if (not isAlreadyEnemy) then
		return
	end

	if (UnitIsDeadOrGhost(unitId)) then
		HonorAssist:UpdateDeath(bgFrameBtn, fullName)
		return
	end

	local currentHealth = UnitHealth(unitId)
	local maxHealth = UnitHealthMax(unitId)
	HonorAssist:UpdateHealth(bgFrameBtn, currentHealth, maxHealth)
end

function HonorAssist:UpdateBgFramePower(unitId)
	if (not UnitIsPlayer(unitId)) then
		return
	end

	local englishFaction, localizedFaction = UnitFactionGroup(unitId)

	if (englishFaction == playersCurrentFaction) then
		return
	end

	local guid = UnitGUID(unitId)
	local initName, initRealm = UnitName(unitId)

	if (initRealm == nil) then
		initRealm = playersCurrentRealm
	end

	local fullName, name, realm = HonorAssist:GetRealmName(initName .. "-" .. initRealm)
	local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(fullName)

	if (not isAlreadyEnemy) then
		return
	end

	if (UnitIsDeadOrGhost(unitId)) then
		HonorAssist:UpdateDeath(bgFrameBtn, fullName)
		return
	end

	local currentPower = UnitPower(unitId)
	local maxPower = UnitPowerMax(unitId)
	local powerType, powerToken = UnitPowerType(unitId);
	local info = PowerBarColor[powerToken]
	HonorAssist:UpdateResource(bgFrameBtn, currentPower, maxPower)
	HonorAssist:UpdateResourceColor(bgFrameBtn, info.r, info.g, info.b)
end

function HonorAssist:UpdateBgFrameAllianceFlagCarrier(chatMsg)
	HonorAssist:UpdateBgFrameFlagCarrier(chatMsg, "Alliance")
end

function HonorAssist:UpdateBgFrameHordeFlagCarrier(chatMsg)
	HonorAssist:UpdateBgFrameFlagCarrier(chatMsg, "Horde")
end

function HonorAssist:UpdateBgFrameNeutralFlagCarrier(chatMsg)
	HonorAssist:UpdateBgFrameFlagCarrier(chatMsg, "Neutral")
end

function HonorAssist:UpdateBgFrameFlagCarrier(chatMsg)
	-- If Italian we don't have translations yet, so return. If you can do Italian traslations and want to help us solve this problem please reach out on Github or Curseforge.
	if (GetLocale() == "itIT") then
		return
	end

	if string.match(chatMsg, HonorAssist:GetTranslation("FLAG_PICK_UP")) then
		local faction, player = nil
		if (GetLocale() == "deDE" or GetLocale() == "koKR") then
			player, faction = string.match(chatMsg, HonorAssist:GetTranslation("FLAG_PICK_UP"))
		else
			faction, player = string.match(chatMsg, HonorAssist:GetTranslation("FLAG_PICK_UP"))
		end

		if (faction ~= playersCurrentFaction) then
			return
		end

		-- Get full name including realm.
		local fullName, name, realm = HonorAssist:GetRealmName(player)
		local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(fullName)

		-- We have not discovered this player yet. Ignore.
		if not isAlreadyEnemy then
			return
		end

		HonorAssist:ActivateWarsongFlagCarrier(bgFrameBtn)
		return
	end

	if string.match(chatMsg, HonorAssist:GetTranslation("FLAG_RETURN")) then
		local _, _, player, faction = nil
		if (GetLocale() == "ruRU") then
			_, _, player, faction = string.find(chatMsg, HonorAssist:GetTranslation("FLAG_RETURN"))
		else
			_, _, faction, player = string.find(chatMsg, HonorAssist:GetTranslation("FLAG_RETURN"))
		end

		if (faction ~= playersCurrentFaction) then
			return
		end

		-- We don't care who had the flag. We just care that it was returned.
		HonorAssist:DeactivateWarsongFlagCarrier()
		return
	end

	if string.match(chatMsg, HonorAssist:GetTranslation("FLAG_CAPTURED")) then
		HonorAssist:DeactivateWarsongFlagCarrier()
		return
	end
end

-- Not used
function HonorAssist:UpdateRangeByUnitId(unitId)
	if (not UnitIsPlayer(unitId)) then
		return
	end

	local guid = UnitGUID(unitId)
	local fullName, name, realm = HonorAssist:GetRealmName(UnitName(unitId))
	local isAlreadyEnemy, bgFrameBtn = HonorAssist:IsAlreadyEnemy(fullName)

	if (not isAlreadyEnemy) then
		return
	end

	if (UnitIsDeadOrGhost(unitId)) then
		return
	end

	local isInRange = UnitInRange(unitId)
	HonorAssist:UpdateRange(bgFrameBtn, isInRange)
end

-- Not used
function HonorAssist:UpdateRangeByCombatLog(bgFrameBtn, isInRange)
	HonorAssist:UpdateRange(bgFrameBtn, isInRange)
end

function HonorAssist:GetRealmName(fullName)
	local name, realm = string.match(fullName, "(.-)%-(.*)$")

	if (name == nil or realm == nil) then
		name = fullName
		fullName = fullName .. "-" .. playersCurrentRealm
		realm = playersCurrentRealm
	end

	return fullName, name, realm
end