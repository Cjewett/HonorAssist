local addonName, addonTable = ...
HonorAssist = addonTable
HonorAssist.OptionsUi = {}

local scrollBarYOffset = -12
local scrollBarXOffset = 20
local scrollBarOffset = 24
local historyPadding = 7
local historyYOffset = -280
local historyDescriptionYOffset = -265
local historyHeight = 282
local historyWidth = 201

HonorAssist.OptionsUi.optionsFrame = CreateFrame("Frame", addonName .. "Options", InterfaceOptionsFramePanelContainer)
HonorAssist.OptionsUi.optionsFrame.name = addonName
InterfaceOptions_AddCategory(HonorAssist.OptionsUi.optionsFrame)

-- Start Title Section
HonorAssist.OptionsUi.optionsTitle = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
HonorAssist.OptionsUi.optionsTitle:SetPoint("TOP", 0, -16)
HonorAssist.OptionsUi.optionsTitle:SetText(HonorAssist:GetTranslation("HONOR_ASSIST")) -- Localize
-- End Title Section

-- Start History Section
HonorAssist.OptionsUi.historyTitle = HonorAssist.OptionsUi.optionsFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
HonorAssist.OptionsUi.historyTitle:SetPoint("TOP", 0, -246)
HonorAssist.OptionsUi.historyTitle:SetText("History") -- Localize

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

HonorAssist.OptionsUi.previousHistoryContent = CreateFrame("MessageFrame", nil, HonorAssist.OptionsUi.previousHistory)
HonorAssist.OptionsUi.previousHistoryContent:SetWidth(HonorAssist.OptionsUi.previousHistory:GetWidth() - scrollBarOffset)
HonorAssist.OptionsUi.previousHistoryContent:SetHeight(HonorAssist.OptionsUi.previousHistory:GetHeight())
HonorAssist.OptionsUi.previousHistoryContent:SetPoint("TOP", 0, 0)
HonorAssist.OptionsUi.previousHistoryContent:SetFont("Fonts\\FRIZQT__.TTF", 8)
HonorAssist.OptionsUi.previousHistoryContent:SetFading(false)
HonorAssist.OptionsUi.previousHistoryContent:SetInsertMode("TOP")
HonorAssist.OptionsUi.previousHistoryContent:SetJustifyH("LEFT")
HonorAssist.OptionsUi.previousHistory:SetScrollChild(HonorAssist.OptionsUi.previousHistoryContent)
HonorAssist.OptionsUi.previousHistoryContent:AddMessage("Yesterday")

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

HonorAssist.OptionsUi.currentHistoryContent = CreateFrame("MessageFrame", nil, HonorAssist.OptionsUi.currentHistory)
HonorAssist.OptionsUi.currentHistoryContent:SetWidth(HonorAssist.OptionsUi.currentHistory:GetWidth() - scrollBarOffset)
HonorAssist.OptionsUi.currentHistoryContent:SetHeight(HonorAssist.OptionsUi.currentHistory:GetHeight())
HonorAssist.OptionsUi.currentHistoryContent:SetPoint("TOP", 0, 0)
HonorAssist.OptionsUi.currentHistoryContent:SetFont("Fonts\\FRIZQT__.TTF", 8)
HonorAssist.OptionsUi.currentHistoryContent:SetFading(false)
HonorAssist.OptionsUi.currentHistoryContent:SetInsertMode("TOP")
HonorAssist.OptionsUi.currentHistoryContent:SetJustifyH("LEFT")
HonorAssist.OptionsUi.currentHistory:SetScrollChild(HonorAssist.OptionsUi.currentHistoryContent)
HonorAssist.OptionsUi.currentHistoryContent:AddMessage("Today")

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

HonorAssist.OptionsUi.nextHistoryContent = CreateFrame("MessageFrame", nil, HonorAssist.OptionsUi.nextHistory)
HonorAssist.OptionsUi.nextHistoryContent:SetWidth(HonorAssist.OptionsUi.nextHistory:GetWidth() - scrollBarOffset)
HonorAssist.OptionsUi.nextHistoryContent:SetHeight(HonorAssist.OptionsUi.nextHistory:GetHeight())
HonorAssist.OptionsUi.nextHistoryContent:SetPoint("TOP", 0, 0)
HonorAssist.OptionsUi.nextHistoryContent:SetFont("Fonts\\FRIZQT__.TTF", 8)
HonorAssist.OptionsUi.nextHistoryContent:SetFading(false)
HonorAssist.OptionsUi.nextHistoryContent:SetInsertMode("TOP")
HonorAssist.OptionsUi.nextHistoryContent:SetJustifyH("LEFT")
HonorAssist.OptionsUi.nextHistory:SetScrollChild(HonorAssist.OptionsUi.nextHistoryContent)
HonorAssist.OptionsUi.nextHistoryContent:AddMessage("Today")

-- End History Section
