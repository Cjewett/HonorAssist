local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "frFR") then
	return
end

local L = {
	["HONOR_GAINED"] = "Honneur gagné";
	["HONOR"] = "Honneur";
	["AVERAGE"] = "Moyenne"; -- Moyen : Changed from Github
	["KILLS"] = "Tués";
	["DAILY"] = "Journalières"; -- Quêtes journalières : Changed from Github
	["HOUR"] = "Heure";
	["HONOR_ASSIST"] = "Honneur Assistant";
	["YOU_HAVE_KILLED"] = "Tu as tué";
	["TIME"] = "temps";
	["TIMES"] = "fois";
	["THIS_KILL_GRANTED"] = "Cette mise à mort accordée";
	["VALUE_FOR"] = "valeur pour";
}

HonorAssist.L = L