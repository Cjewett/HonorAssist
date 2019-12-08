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
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Enable Tracker";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Display Total Honor Possible By Nameplate (Default UI Only)";
}

HonorAssist.L = L