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
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Enable Honor on Nameplate";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "Enable Short Honor Message";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "Enable Battleground Frames";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "Lock Battleground Frames Window";
	["DEAD"] = "DEAD";
	["FLAG_PICK_UP"] = "The (%w+) .lag was picked up by (.+)!";
	["FLAG_RETURN"] = "The (%w+) .lag was returned to its base by (.+)!";
	["FLAG_CAPTURED"] = "(.+) captured the (%w+) flag!";
	["FLAG_DROPPED"] = "The flag has been dropped!";
}

HonorAssist.L = L