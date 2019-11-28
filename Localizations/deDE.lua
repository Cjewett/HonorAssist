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
	["HONOR_ASSIST"] = "Honour Assist";
	["YOU_HAVE_KILLED"] = "Du hast getötet";
	["TIME"] = "zeit";
	["TIMES"] = "mal";
	["THIS_KILL_GRANTED"] = "Dieser Mord wurde gewährt";
	["VALUE_FOR"] = "wert für";
}

HonorAssist.L = L