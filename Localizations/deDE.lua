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
}

HonorAssist.L = L
