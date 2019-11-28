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
}

HonorAssist.L = L