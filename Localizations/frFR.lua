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
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
}

HonorAssist.L = L