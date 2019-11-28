local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "esMX") then
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
}

HonorAssist.L = L