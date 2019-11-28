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
}

HonorAssist.L = L