local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "itIT") then
	return
end

local L = {
	["HONOR_GAINED"] = "Onore guadagnato";
	["HONOR"] = "Onore";
	["AVERAGE"] = "Media";
	["KILLS"] = "Uccisioni";
	["DAILY"] = "Giornaliera";
	["HOUR"] = "Ora";
	["HONOR_ASSIST"] = "Onore Assistere";
}

HonorAssist.L = L