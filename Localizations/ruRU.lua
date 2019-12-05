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
}

HonorAssist.L = L
