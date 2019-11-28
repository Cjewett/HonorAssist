local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "zhTW") then
	return
end

local L = {
	["HONOR_GAINED"] = "獲得榮譽";
	["HONOR"] = "榮譽";
	["AVERAGE"] = "普通";
	["KILLS"] = "殺敵";
	["DAILY"] = "每日";
	["HOUR"] = "小時";
	["HONOR_ASSIST"] = "榮譽 助攻";
}

HonorAssist.L = L