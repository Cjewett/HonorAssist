local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "ruRU") then
	return
end

local L = {
	["HONOR_GAINED"] = "Полученная честь";
	["HONOR"] = "Честь";
	["AVERAGE"] = "Среднее";
	["KILLS"] = "Убийства";
	["DAILY"] = "Ежедневно";
	["HOUR"] = "Час";
	["HONOR_ASSIST"] = "Честь Ассистент";
}

HonorAssist.L = L