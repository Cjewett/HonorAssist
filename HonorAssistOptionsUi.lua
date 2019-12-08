local addonName, addonTable = ...
HonorAssist = addonTable
HonorAssist.OptionsUi = {}

local optionsTitleYOffset = -16
local scrollBarYOffset = -12
local scrollBarXOffset = 20
local scrollBarOffset = 24
local historyTitleYOffset = -242
local historyNavButtonsYOffset = -242
local historyPadding = 7
local historyYOffset = -280
local historyDescriptionYOffset = -265
local historyHeight = 282
local historyWidth = 201
local messageHeight = 10

function HonorAssist:LoadOptionsUi()
	HonorAssist.OptionsUi.trackerUiEnable:SetChecked(HonorAssistShowTrackerUi)
	HonorAssist.OptionsUi.nameplateEnable:SetChecked(HonorAssistNameplateToggle)
end

HonorAssist.OptionsUi.optionsFrame = CreateFrame("Frame", addonName .. "Options", InterfaceOptionsFramePanelContainer)
HonorAssist.OptionsUi.optionsFrame.name = addonName
InterfaceOptions_AddCategory(HonorAssist.OptionsUi.optionsFrame)
HonorAssist.OptionsUi.optionsFrame:SetScript("OnShow", 
	function()
		HonorAssist:PushHistoryDataToUi()
	end
);

-- Start Title Section
HonorAssist.OptionsUi.optionsTitle = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
HonorAssist.OptionsUi.optionsTitle:SetPoint("TOP", 0, optionsTitleYOffset)
HonorAssist.OptionsUi.optionsTitle:SetText(HonorAssist:GetTranslation("HONOR_ASSIST"))
-- End Title Section

-- Start Enable Tracker CheckButton Section

HonorAssist.OptionsUi.trackerUiEnable = CreateFrame("CheckButton", nil, HonorAssist.OptionsUi.optionsFrame, "ChatConfigCheckButtonTemplate")
HonorAssist.OptionsUi.trackerUiEnable:SetPoint("TOPLEFT", 16, -32)
HonorAssist.OptionsUi.trackerUiEnable:SetScript("OnClick",
	function()
		HonorAssistShowTrackerUi = not HonorAssistShowTrackerUi
		HonorAssist:ShowTrackerUi(HonorAssistShowTrackerUi)
		HonorAssist.OptionsUi.trackerUiEnable:SetChecked(HonorAssistShowTrackerUi)
	end
);

HonorAssist.OptionsUi.trackerUiEnableLabel = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.OptionsUi.trackerUiEnableLabel:SetPoint("TOPLEFT", 42, -38)
HonorAssist.OptionsUi.trackerUiEnableLabel:SetText(HonorAssist:GetTranslation("OPTIONS_ENABLE_TRACKER_LABEL"))

-- End Enable Tracker CheckButton Section

-- Start Enable Nameplate CheckButton Section

HonorAssist.OptionsUi.nameplateEnable = CreateFrame("CheckButton", nil, HonorAssist.OptionsUi.optionsFrame, "ChatConfigCheckButtonTemplate")
HonorAssist.OptionsUi.nameplateEnable:SetPoint("TOPLEFT", 16, -54)
HonorAssist.OptionsUi.nameplateEnable:SetScript("OnClick",
	function()
		HonorAssistNameplateToggle = not HonorAssistNameplateToggle
		HonorAssist.OptionsUi.nameplateEnable:SetChecked(HonorAssistNameplateToggle)
	end
);

HonorAssist.OptionsUi.nameplateEnableLabel = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.OptionsUi.nameplateEnableLabel:SetPoint("TOPLEFT", 42, -60)
HonorAssist.OptionsUi.nameplateEnableLabel:SetText(HonorAssist:GetTranslation("OPTIONS_ENABLE_NAMEPLATE_LABEL"))

-- End Enable Nameplate CheckButton Section

-- Start History Section

-- History Title 
HonorAssist.OptionsUi.historyTitle = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
HonorAssist.OptionsUi.historyTitle:SetPoint("TOP", 0, historyTitleYOffset)
HonorAssist.OptionsUi.historyTitle:SetText(HonorAssist:GetTranslation("HISTORY"))

-- Previous Button
HonorAssist.OptionsUi.historyPreviousButton = CreateFrame("Button", nil, HonorAssist.OptionsUi.optionsFrame, "OptionsButtonTemplate")
HonorAssist.OptionsUi.historyPreviousButton:SetSize(24, 18)
HonorAssist.OptionsUi.historyPreviousButton:SetPoint("TOPLEFT", historyPadding, historyNavButtonsYOffset);
HonorAssist.OptionsUi.historyPreviousButton:SetText("<")
HonorAssist.OptionsUi.historyPreviousButton:SetScript("OnClick", 
	function()
		HonorAssist:MoveOneDayBack()
	end
);

-- Next Button
HonorAssist.OptionsUi.historyNextButton = CreateFrame("Button", nil, HonorAssist.OptionsUi.optionsFrame, "OptionsButtonTemplate")
HonorAssist.OptionsUi.historyNextButton:SetSize(24, 18)
HonorAssist.OptionsUi.historyNextButton:SetPoint("TOPRIGHT", -historyPadding, historyNavButtonsYOffset);
HonorAssist.OptionsUi.historyNextButton:SetText(">")
HonorAssist.OptionsUi.historyNextButton:SetScript("OnClick", 
	function()
		HonorAssist:MoveOneDayForward()
	end
);

----------------------------------------------------

HonorAssist.OptionsUi.previousHistoryDescription = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.OptionsUi.previousHistoryDescription:SetPoint("TOPLEFT", historyPadding, historyDescriptionYOffset)
HonorAssist.OptionsUi.previousHistoryDescription:SetText("Yesterday") -- Localize

HonorAssist.OptionsUi.previousFrame = CreateFrame("Frame", "HonorAssistPreviousFrame", HonorAssist.OptionsUi.optionsFrame, "OptionsBoxTemplate")
HonorAssist.OptionsUi.previousFrame:SetPoint("TOPLEFT", historyPadding, historyYOffset)
HonorAssist.OptionsUi.previousFrame:SetHeight(historyHeight)
HonorAssist.OptionsUi.previousFrame:SetWidth(historyWidth)

HonorAssist.OptionsUi.previousHistory = CreateFrame("ScrollFrame", "HonorAssistPreviousHistoryScrollFrame", HonorAssist.OptionsUi.previousFrame, "UIPanelScrollFrameTemplate")
HonorAssist.OptionsUi.previousHistory:SetSize(HonorAssist.OptionsUi.previousFrame:GetWidth() - 12, HonorAssist.OptionsUi.previousFrame:GetHeight() - 8)
HonorAssist.OptionsUi.previousHistory:SetPoint("CENTER")
HonorAssist.OptionsUi.previousHistory:SetClipsChildren(true)
HonorAssist.OptionsUi.previousHistory.ScrollBar:ClearAllPoints()
HonorAssist.OptionsUi.previousHistory.ScrollBar:SetPoint("TOPLEFT", HonorAssist.OptionsUi.previousHistory, "TOPRIGHT", scrollBarYOffset, -scrollBarXOffset)
HonorAssist.OptionsUi.previousHistory.ScrollBar:SetPoint("BOTTOMRIGHT", HonorAssist.OptionsUi.previousHistory, "BOTTOMRIGHT", scrollBarYOffset, scrollBarXOffset)

HonorAssist.OptionsUi.previousHistoryContent = CreateFrame("ScrollingMessageFrame", nil, HonorAssist.OptionsUi.previousHistory)
HonorAssist.OptionsUi.previousHistoryContent:SetInsertMode(1)
HonorAssist.OptionsUi.previousHistoryContent:SetMaxLines(100000)
HonorAssist.OptionsUi.previousHistoryContent:SetWidth(HonorAssist.OptionsUi.previousHistory:GetWidth() - scrollBarOffset)
HonorAssist.OptionsUi.previousHistoryContent:SetHeight(HonorAssist.OptionsUi.previousHistory:GetHeight())
HonorAssist.OptionsUi.previousHistoryContent:SetPoint("TOP", 0, 0)
HonorAssist.OptionsUi.previousHistoryContent:SetFont("Fonts\\FRIZQT__.TTF", 8)
HonorAssist.OptionsUi.previousHistoryContent:SetFading(false)
HonorAssist.OptionsUi.previousHistoryContent:SetJustifyH("LEFT")
HonorAssist.OptionsUi.previousHistory:SetScrollChild(HonorAssist.OptionsUi.previousHistoryContent)

function HonorAssist:UpdatePreviousHistoryDescription(description)
	HonorAssist.OptionsUi.previousHistoryDescription:SetText(description)
end

local previousHistoryCount = 0
function HonorAssist:AddPreviousHistoryMessage(message)
	HonorAssist.OptionsUi.previousHistoryContent:AddMessage(message)
	previousHistoryCount = previousHistoryCount + 1
	local newContentHeight = previousHistoryCount * messageHeight

	if (newContentHeight >  HonorAssist.OptionsUi.previousHistoryContent:GetHeight()) then
		HonorAssist.OptionsUi.previousHistoryContent:SetHeight(newContentHeight)
	end
end

function HonorAssist:ClearPreviousHistoryMessages()
	HonorAssist.OptionsUi.previousHistoryContent:Clear()
	HonorAssist.OptionsUi.previousHistoryContent:SetHeight(HonorAssist.OptionsUi.previousHistory:GetHeight())
	previousHistoryCount = 0
end

----------------------------------------------------

HonorAssist.OptionsUi.currentHistoryDescription = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.OptionsUi.currentHistoryDescription:SetPoint("TOP", 0, historyDescriptionYOffset)
HonorAssist.OptionsUi.currentHistoryDescription:SetText("Today") -- Localize

HonorAssist.OptionsUi.currentFrame = CreateFrame("Frame", "HonorAssistCurrentFrame", HonorAssist.OptionsUi.optionsFrame, "OptionsBoxTemplate")
HonorAssist.OptionsUi.currentFrame:SetPoint("TOP", 0, historyYOffset)
HonorAssist.OptionsUi.currentFrame:SetHeight(historyHeight)
HonorAssist.OptionsUi.currentFrame:SetWidth(historyWidth)

HonorAssist.OptionsUi.currentHistory = CreateFrame("ScrollFrame", "HonorAssistCurrentHistoryScrollFrame", HonorAssist.OptionsUi.currentFrame, "UIPanelScrollFrameTemplate")
HonorAssist.OptionsUi.currentHistory:SetSize(HonorAssist.OptionsUi.currentFrame:GetWidth() - 12, HonorAssist.OptionsUi.currentFrame:GetHeight() - 8)
HonorAssist.OptionsUi.currentHistory:SetPoint("CENTER")
HonorAssist.OptionsUi.currentHistory:SetClipsChildren(true)
HonorAssist.OptionsUi.currentHistory.ScrollBar:ClearAllPoints()
HonorAssist.OptionsUi.currentHistory.ScrollBar:SetPoint("TOPLEFT", HonorAssist.OptionsUi.currentHistory, "TOPRIGHT", scrollBarYOffset, -scrollBarXOffset)
HonorAssist.OptionsUi.currentHistory.ScrollBar:SetPoint("BOTTOMRIGHT", HonorAssist.OptionsUi.currentHistory, "BOTTOMRIGHT", scrollBarYOffset, scrollBarXOffset)

HonorAssist.OptionsUi.currentHistoryContent = CreateFrame("ScrollingMessageFrame", nil, HonorAssist.OptionsUi.currentHistory)
HonorAssist.OptionsUi.currentHistoryContent:SetInsertMode(1)
HonorAssist.OptionsUi.currentHistoryContent:SetMaxLines(100000)
HonorAssist.OptionsUi.currentHistoryContent:SetWidth(HonorAssist.OptionsUi.currentHistory:GetWidth() - scrollBarOffset)
HonorAssist.OptionsUi.currentHistoryContent:SetHeight(HonorAssist.OptionsUi.currentHistory:GetHeight())
HonorAssist.OptionsUi.currentHistoryContent:SetPoint("TOP", 0, 0)
HonorAssist.OptionsUi.currentHistoryContent:SetFont("Fonts\\FRIZQT__.TTF", 8)
HonorAssist.OptionsUi.currentHistoryContent:SetFading(false)
HonorAssist.OptionsUi.currentHistoryContent:SetJustifyH("LEFT")
HonorAssist.OptionsUi.currentHistory:SetScrollChild(HonorAssist.OptionsUi.currentHistoryContent)

function HonorAssist:UpdateCurrentHistoryDescription(description)
	HonorAssist.OptionsUi.currentHistoryDescription:SetText(description)
end

local currentHistoryCount = 0
function HonorAssist:AddCurrentHistoryMessage(message)
	HonorAssist.OptionsUi.currentHistoryContent:AddMessage(message)
	currentHistoryCount = currentHistoryCount + 1
	local newContentHeight = currentHistoryCount * messageHeight

	if (newContentHeight >  HonorAssist.OptionsUi.currentHistoryContent:GetHeight()) then
		HonorAssist.OptionsUi.currentHistoryContent:SetHeight(newContentHeight)
	end
end

function HonorAssist:ClearCurrentHistoryMessages()
	HonorAssist.OptionsUi.currentHistoryContent:Clear()
	HonorAssist.OptionsUi.currentHistoryContent:SetHeight(HonorAssist.OptionsUi.currentHistory:GetHeight())
	currentHistoryCount = 0
end

----------------------------------------------------

HonorAssist.OptionsUi.nextHistoryDescription = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
HonorAssist.OptionsUi.nextHistoryDescription:SetPoint("TOPRIGHT", -historyPadding, historyDescriptionYOffset)
HonorAssist.OptionsUi.nextHistoryDescription:SetText("This Week") -- Localize

HonorAssist.OptionsUi.nextFrame = CreateFrame("Frame", "HonorAssistNextFrame", HonorAssist.OptionsUi.optionsFrame, "OptionsBoxTemplate")
HonorAssist.OptionsUi.nextFrame:SetPoint("TOPRIGHT", -historyPadding, historyYOffset)
HonorAssist.OptionsUi.nextFrame:SetHeight(historyHeight)
HonorAssist.OptionsUi.nextFrame:SetWidth(historyWidth)

HonorAssist.OptionsUi.nextHistory = CreateFrame("ScrollFrame", "HonorAssistNextHistoryScrollFrame", HonorAssist.OptionsUi.nextFrame, "UIPanelScrollFrameTemplate")
HonorAssist.OptionsUi.nextHistory:SetSize(HonorAssist.OptionsUi.nextFrame:GetWidth() - 12, HonorAssist.OptionsUi.nextFrame:GetHeight() - 8)
HonorAssist.OptionsUi.nextHistory:SetPoint("CENTER")
HonorAssist.OptionsUi.nextHistory:SetClipsChildren(true)
HonorAssist.OptionsUi.nextHistory.ScrollBar:ClearAllPoints()
HonorAssist.OptionsUi.nextHistory.ScrollBar:SetPoint("TOPLEFT", HonorAssist.OptionsUi.nextHistory, "TOPRIGHT", scrollBarYOffset, -scrollBarXOffset)
HonorAssist.OptionsUi.nextHistory.ScrollBar:SetPoint("BOTTOMRIGHT", HonorAssist.OptionsUi.nextHistory, "BOTTOMRIGHT", scrollBarYOffset, scrollBarXOffset)

HonorAssist.OptionsUi.nextHistoryContent = CreateFrame("ScrollingMessageFrame", nil, HonorAssist.OptionsUi.nextHistory)
HonorAssist.OptionsUi.nextHistoryContent:SetInsertMode(1)
HonorAssist.OptionsUi.nextHistoryContent:SetMaxLines(100000)
HonorAssist.OptionsUi.nextHistoryContent:SetWidth(HonorAssist.OptionsUi.nextHistory:GetWidth() - scrollBarOffset)
HonorAssist.OptionsUi.nextHistoryContent:SetHeight(HonorAssist.OptionsUi.nextHistory:GetHeight())
HonorAssist.OptionsUi.nextHistoryContent:SetPoint("TOP", 0, 0)
HonorAssist.OptionsUi.nextHistoryContent:SetFont("Fonts\\FRIZQT__.TTF", 8)
HonorAssist.OptionsUi.nextHistoryContent:SetFading(false)
HonorAssist.OptionsUi.nextHistoryContent:SetJustifyH("LEFT")
HonorAssist.OptionsUi.nextHistory:SetScrollChild(HonorAssist.OptionsUi.nextHistoryContent)

function HonorAssist:UpdateNextHistoryDescription(description)
	HonorAssist.OptionsUi.nextHistoryDescription:SetText(description)
end

local nextHistoryCount = 0
function HonorAssist:AddNextHistoryMessage(message)
	HonorAssist.OptionsUi.nextHistoryContent:AddMessage(message)
	nextHistoryCount = nextHistoryCount + 1
	local newContentHeight = nextHistoryCount * messageHeight

	if (newContentHeight >  HonorAssist.OptionsUi.nextHistoryContent:GetHeight()) then
		HonorAssist.OptionsUi.nextHistoryContent:SetHeight(newContentHeight)
	end
end

function HonorAssist:ClearNextHistoryMessages()
	HonorAssist.OptionsUi.nextHistoryContent:Clear()
	HonorAssist.OptionsUi.nextHistoryContent:SetHeight(HonorAssist.OptionsUi.nextHistory:GetHeight())
	nextHistoryCount = 0
end

-- End History Section
