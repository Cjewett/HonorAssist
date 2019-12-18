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
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "Activer les cadres de champ de bataille";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "Verrouiller la fenêtre des cadres de champ de bataille";
	["DEAD"] = "décédé";
	["FLAG_PICK_UP"] = "Le Drapeau (%w+) a été pris par (.+) !";
	["FLAG_RETURN"] = "Le Drapeau (%w+) a été renvoyé à la base par (.+) !";
	["FLAG_CAPTURED"] = "(.+) a capturé le drapeau (%w+) !";
	["FLAG_DROPPED"] = "Le drapeau vient d'être laché!";
}

HonorAssist.L = L