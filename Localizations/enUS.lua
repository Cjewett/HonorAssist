local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "enUS") then
	return
end

local L = {
	["HONOR_GAINED"] = "Honor Gained";
	["HONOR"] = "Honor";
	["AVERAGE"] = "Average";
	["KILLS"] = "Kills";
	["DAILY"] = "Daily";
	["HOUR"] = "Hour";
	["HONOR_ASSIST"] = "Honor Assist";
	["YOU_HAVE_KILLED"] = "You have killed";
	["TIME"] = "time";
	["TIMES"] = "times";
	["THIS_KILL_GRANTED"] = "This kill granted";
	["VALUE_FOR"] = "value for";
	["THIS_WEEK"] = "This Week";
	["HISTORY"] = "History";
}

HonorAssist.L = L