local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "koKR") then
	return
end

local L = {
	["HONOR_GAINED"] = "획득한 명예";
	["HONOR"] = "명예";
	["AVERAGE"] = "보통";
	["KILLS"] = "승수";
	["DAILY"] = "일일";
	["HOUR"] = "시간";
	["HONOR_ASSIST"] = "명예 지원";
}

HonorAssist.L = L