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
	["YOU_HAVE_KILLED"] = "你殺了";
	["TIME"] = "時間";
	["TIMES"] = "時報";
	["THIS_KILL_GRANTED"] = "這個殺人獎勵";
	["VALUE_FOR"] = "值 對於";
	["THIS_WEEK"] = "本星期";
	["HISTORY"] = "歷史";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "啟用追踪器";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "在銘牌上啟用榮譽";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "啟用榮譽短消息";
}

HonorAssist.L = L