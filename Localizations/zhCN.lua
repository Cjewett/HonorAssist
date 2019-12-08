local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "zhCN") then
	return
end

local L = {
	["HONOR_GAINED"] = "获得荣誉";
	["HONOR"] = "荣誉";
	["AVERAGE"] = "普通";
	["KILLS"] = "杀敌";
	["DAILY"] = "日常";
	["HOUR"] = "小时";
	["HONOR_ASSIST"] = "荣誉 助攻";
	["YOU_HAVE_KILLED"] = "你杀了";
	["TIME"] = "时间";
	["TIMES"] = "时报";
	["THIS_KILL_GRANTED"] = "这样的杀人奖励";
	["VALUE_FOR"] = "值 对于";
	["THIS_WEEK"] = "本星期";
	["HISTORY"] = "历史";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "Enable Tracker";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "Display Total Honor Possible By Nameplate (Default UI Only)";
}

HonorAssist.L = L