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
	["YOU_HAVE_KILLED"] = "Hai ucciso";
	["TIME"] = "tempo";
	["TIMES"] = "volte";
	["THIS_KILL_GRANTED"] = "Questa uccisione è stata concessa";
	["VALUE_FOR"] = "valore per";
}

HonorAssist.L = L