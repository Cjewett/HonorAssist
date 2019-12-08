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
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Ativar rastreador";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Ativar honra na placa de identificação";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "Ativar mensagem curta de honra";
}

HonorAssist.L = L