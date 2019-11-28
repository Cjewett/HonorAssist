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
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
}

HonorAssist.L = L