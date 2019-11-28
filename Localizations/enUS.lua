local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "enUS") then
	return
end

local L = {
	["HONOR_GAINED"] = "Honor Gained";
	["HONOR"] = "Honor";
	["AVERAGE"] = "Average";
	["KILLS"] = "Kills";
	["DAILY"] = "Daily";
	["HOUR"] = "Hour";
	["HONOR_ASSIST"] = "Honor Assist";
}

HonorAssist.L = L