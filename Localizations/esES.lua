local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "esES") then
	return
end

local L = {
	["HONOR_GAINED"] = "Honor ganado";
	["HONOR"] = "Honor";
	["AVERAGE"] = "Promedio"; -- Regular : Changed from Github
	["KILLS"] = "Muertos";
	["DAILY"] = "Diaria";
	["HOUR"] = "Hora";
	["HONOR_ASSIST"] = "Asistente de honor";
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
}

HonorAssist.L = L