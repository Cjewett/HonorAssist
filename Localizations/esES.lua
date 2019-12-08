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
	["YOU_HAVE_KILLED"] = "Has matado";
	["TIME"] = "hora";
	["TIMES"] = "veces";
	["THIS_KILL_GRANTED"] = "Esta muerte concedida";
	["VALUE_FOR"] = "valor por";
	["THIS_WEEK"] = "Esta Semana";
	["HISTORY"] = "Historia";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Habilitar rastreador";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Ativar honra na placa de identificação";
}

HonorAssist.L = L