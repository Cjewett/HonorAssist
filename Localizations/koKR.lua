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
	["THIS_WEEK"] = "이번 주";
	["HISTORY"] = "역사";
	["FROM_BONUS"] = "From Bonus";
	["FROM_KILLS"] = "From Kills";
	["OPTIONS_ENABLE_TRACKER_LABEL"] = "트래커 사용";
	["OPTIONS_ENABLE_NAMEPLATE_LABEL"] = "명판에 명예 활성화";
	["OPTIONS_ENABLE_SHORT_KILL_MSG"] = "단명 메시지 사용";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES"] = "전장 프레임 사용";
	["OPTIONS_ENABLE_BATTLEGROUND_FRAMES_LOCK"] = "전장 프레임 잠금 창";
	["DEAD"] = "죽은";
	["FLAG_PICK_UP"] = "(.+)|1이;가; (.+) 깃발을 손에 넣었습니다!";
	["FLAG_RETURN"] = "(.+)|1이;가; (.+) 깃발을 되찾았습니다!";
	["FLAG_CAPPED"] = "(.+)|1이;가; (.+) 깃발 쟁탈에 성공했습니다!";
	["FLAG_DROPPED"] = "깃발을 떨어뜨렸습니다!";
}

HonorAssist.L = L