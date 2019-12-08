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
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Enable Tracker";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Display Total Honor Possible By Nameplate (Default UI Only)";
}

HonorAssist.L = L