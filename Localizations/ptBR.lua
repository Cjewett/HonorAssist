local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "ptBR") then
	return
end

local L = {
	["HONOR_GAINED"] = "Honra conquistada"; -- Honra ganha : Changed from Github
	["HONOR"] = "Honra";
	["AVERAGE"] = "Média"; -- Regular : Changed from Github
	["KILLS"] = "Abates";
	["DAILY"] = "Diariamente";
	["HOUR"] = "Hora";
	["HONOR_ASSIST"] = "Honra Assistente";
}

HonorAssist.L = L