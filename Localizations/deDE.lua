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
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
}

HonorAssist.L = L