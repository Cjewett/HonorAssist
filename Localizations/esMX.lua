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
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "Habilitar mensaje de honor corto";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "Habilitar marcos de campo de batalla";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "Bloquear ventana de marcos de campo de batalla";
	["DEAD"] = "MUERTO";
	["FLAG_PICK_UP"] = "¡(.+) ha cogido la bandera de la (%w+)!";
	["FLAG_RETURN"] = "¡(.+) ha devuelto la bandera de la (%w+) a su base!";
	["FLAG_CAPTURED"] = "¡(.+) ha capturado la bandera de la (%w+)!";
	["FLAG_DROPPED"] = "¡Ha caído la bandera!";
}

HonorAssist.L = L