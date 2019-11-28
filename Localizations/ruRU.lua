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
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
}

HonorAssist.L = L