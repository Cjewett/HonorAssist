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
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "启用追踪器";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "在铭牌上启用荣誉";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "启用荣誉短消息";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "启用战场框架";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "锁定战场框架窗口";
	["DEAD"] = "死";
}

HonorAssist.L = L