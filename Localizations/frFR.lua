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
	["THIS_WEEK"] = "Cette Semaine";
	["HISTORY"] = "Histoire";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Activer le traqueur";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Activer l'honneur sur la plaque signalétique";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "Activer le court message d'honneur";
}

HonorAssist.L = L