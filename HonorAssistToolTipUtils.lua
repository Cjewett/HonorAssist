local addonName, addonTable = ...
HonorAssist = addonTable

-- local IsInRaid, GetNumGroupMembers, GetNumSubgroupMembers = IsInRaid, GetNumGroupMembers, GetNumSubgroupMembers

local baseRankHonorTable = {
	["0"] = "199",
	["5"] = "199",
	["6"] = "210",
	["7"] = "221",
	["8"] = "233",
	["9"] = "246",
	["10"] = "260",
	["11"] = "274",
	["12"] = "289",
	["13"] = "305",
	["14"] = "321",
	["15"] = "339",
	["16"] = "357",
	["17"] = "377",
	["18"] = "398"
}

--  TODO need to make this dynamic based on players level
local baseLevelHonorTable = {
	["60"] = "1",
	["59"] = ".9",
	["58"] = ".8",
	["57"] = ".7",
	["56"] = ".6",
	["55"] = ".5",
	["54"] = ".47",
	["53"] = ".35",
	["52"] = ".20",
	["51"] = ".28",
	["50"] = ".05",
	["49"] = ".03",
	["48"] = ".02"
}

--[[
local function partyIterator(groupMembers, uId)
	if not uId then
		return "player", 0
	elseif uId == "player" then
		if groupMembers > 0 then
			return "party1", 1
		end
	else
		local i = uId:byte(-1) - 0x30
		if i < groupMembers then
			return "party" .. i + 1, i + 1
		end
	end
end

local function soloIterator(_, state)
	if not state then -- no state == first call
		return "player", 0
	end
end

local function raidIterator(groupMembers, uId)
	local a, b = uId:byte(-2, -1)
	local i = (a >= 0x30 and a <= 0x39 and (a - 0x30) * 10 or 0) + b - 0x30
	if i < groupMembers then
		return "raid" .. i + 1, i + 1
	end
end

function HonorAssist:GetGroupMembers()
	if IsInRaid() then
		return raidIterator, GetNumGroupMembers(), "raid0"
	elseif IsInGroup() then
		return partyIterator, GetNumSubgroupMembers(), nil
	else
		-- solo!
		return soloIterator, nil, nil
	end
end

function HonorAssist:GetNearbyPartyMemberCount()
	local numPlayers = HonorAssist:GetGroupMembers()
	local countMembers = numPlayers
	return countMembers
end

function HonorAssist:CheckRange(uid)
end
--]]

function HonorAssist:GetBaseHonor(playerLevel, playerRank)

	if HonorAssistDEBUG then
		print("GetBaseHonor HonorTable playerRank Honor: " ..  baseRankHonorTable[tostring(playerRank)] .. " playerLevel Honor: " .. baseLevelHonorTable[tostring(playerLevel)])
	end

	local baseHonor = tonumber(baseRankHonorTable[tostring(playerRank)]) * tonumber(baseLevelHonorTable[tostring(playerLevel)])
	return baseHonor
	
end

function HonorAssist:GetPlayerEstimatedHonor(dailyKillCount, baseHealth, playerLevel, playerRank)

	if HonorAssistDEBUG then
		print("GetPlayerEstimatedHonor dailyKillCount: ".. dailyKillCount .." baseHealth: " .. baseHealth .. " playerLevel: " .. playerLevel .. " playerRank: " .. playerRank)
	end

	local baseHonor = HonorAssist:GetBaseHonor(playerLevel, playerRank)
	local honorPercentLeft, realisticHonor = HonorAssist:CalculateRealisticHonor(dailyKillCount, (baseHonor * baseHealth))

	return honorPercentLeft, realisticHonor
end

