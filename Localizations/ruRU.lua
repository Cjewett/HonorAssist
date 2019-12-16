local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "ruRU") then
	return
end

local L = {
	["HONOR_GAINED"] = "Полученная честь";
	["HONOR"] = "Честь";
	["AVERAGE"] = "Среднее";
	["KILLS"] = "Убийства";
	["DAILY"] = "Ежедневно";
	["HOUR"] = "Час";
	["HONOR_ASSIST"] = "Честь Ассистент";
	["YOU_HAVE_KILLED"] = "Ты убит";
	["TIME"] = "время";
	["TIMES"] = "раз";
	["THIS_KILL_GRANTED"] = "Это убийство дало";
	["VALUE_FOR"] = "значение для";
	["THIS_WEEK"] = "На этой неделе";
	["HISTORY"] = "история";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Включить трекер";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Включить честь на шильдике";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "Включить короткое сообщение чести";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "Включить рамки боя";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "Окно Блокировка поля битвы";
	["DEAD"] = "МЕРТВЫХ";
}

HonorAssist.L = L