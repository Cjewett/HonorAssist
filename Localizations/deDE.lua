local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "deDE") then
	return
end

local L = {
	["HONOR_GAINED"] = "Erworbene Ehre";
	["HONOR"] = "Ehre";
	["AVERAGE"] = "Durchschnittlich";
	["KILLS"] = "Siege";
	["DAILY"] = "Täglich";
	["HOUR"] = "Stunde";
	["HONOR_ASSIST"] = "Honor Assist";
	["YOU_HAVE_KILLED"] = "Du hast";
	["TIME"] = "mal getötet";
	["TIMES"] = "mal getötet";
	["THIS_KILL_GRANTED"] = "Dieser Mord gab";
	["VALUE_FOR"] = "für";
	["THIS_WEEK"] = "Diese Woche";
	["HISTORY"] = "Geschichte";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Tracker aktivieren";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Aktivieren Sie die Ehre auf dem Typenschild";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "Kurze Ehrennachricht aktivieren";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "Aktiviere Battleground Frames";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "Fenster Battleground Frames sperren";
	["DEAD"] = "TOT";
	["FLAG_PICK_UP"] = "(.*) hat die Flagge der (%w+) aufgenommen!";
	["FLAG_RETURN"] = "Die Flagge der (%w+) wurde von (.+) zu ihrem Stützpunkt zurückgebracht!";
	["FLAG_CAPTURED"] = "(.+) hat die Flagge der (%w+) errungen!";
	["FLAG_DROPPED"] = "Die Flagge wurde fallengelassen.";
}

HonorAssist.L = L