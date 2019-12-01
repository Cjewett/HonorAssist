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
	["YOU_HAVE_KILLED"] = "Você matou";
	["TIME"] = "tempo";
	["TIMES"] = "vezes";
	["THIS_KILL_GRANTED"] = "Esta matança concedida";
	["VALUE_FOR"] = "valor para";
	["THIS_WEEK"] = "Esta Semana";
	["HISTORY"] = "História";
}

HonorAssist.L = L