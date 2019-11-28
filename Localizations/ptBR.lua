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
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
}

HonorAssist.L = L