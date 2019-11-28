local addonName, addonTable = ...
HonorAssist = addonTable

if (GetLocale() ~= "koKR") then
	return
end

local L = {
	["HONOR_GAINED"] = "획득한 명예";
	["HONOR"] = "명예";
	["AVERAGE"] = "보통";
	["KILLS"] = "승수";
	["DAILY"] = "일일";
	["HOUR"] = "시간";
	["HONOR_ASSIST"] = "명예 지원";
	["YOU_HAVE_KILLED"] = "당신은 죽였습니다";
	["TIME"] = "시각";
	["TIMES"] = "타임스";
	["THIS_KILL_GRANTED"] = "이 살인은 허용";
	["VALUE_FOR"] = "에 대한 가치";
}

HonorAssist.L = L