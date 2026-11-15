-- Experienced: level-up banner
-- Based on Vanilla-NewLevelFrame by alchem1ster
-- (https://github.com/alchem1ster/Vanilla-NewLevelFrame), whose banner art this uses.

local XBP = Experienced
local TEXTURE = "Interface\\AddOns\\Experienced\\newlevel_frame"
local FADE_IN, HOLD, FADE_OUT = 2, 5, 2

local L = {
  enUS = { "You've Reached", "Level %d" },
  ruRU = { "Вы достигли", "%d-го уровня" },
  frFR = { "Vous avez atteint", "Niveau %d" },
  deDE = { "Du hast erreicht", "Stufe %d" },
  esES = { "Has alcanzado", "Nivel %d" },
  esMX = { "Has alcanzado", "Nivel %d" },
  koKR = { "당신은 도달했습니다", "레벨 %d" },
  zhCN = { "你已经达到", "级别 %d" },
  zhTW = { "你已經達到", "級別 %d" },
}
local strings = L[GetLocale()] or L.enUS

local banner = CreateFrame("Frame", "ExperiencedLevelUp", UIParent)
banner:SetWidth(400)
banner:SetHeight(200)
banner:SetFrameStrata("LOW")
banner:SetMovable(true)
banner:RegisterForDrag("LeftButton")
banner:Hide()

local art = banner:CreateTexture(nil, "BACKGROUND")
art:SetTexture(TEXTURE)
art:SetAllPoints(banner)

local header = banner:CreateFontString(nil, "ARTWORK")
header:SetFont("Fonts\\FRIZQT__.TTF", 18)
header:SetPoint("CENTER", banner, "CENTER", 0, 20)
header:SetText(strings[1])

local footer = banner:CreateFontString(nil, "ARTWORK")
footer:SetFont("Fonts\\FRIZQT__.TTF", 30)
footer:SetPoint("CENTER", banner, "CENTER", 0, -20)
footer:SetTextColor(207 / 255, 191 / 255, 20 / 255, 1)

local hint = banner:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
hint:SetPoint("TOP", banner, "BOTTOM", 0, 20)
hint:SetText("Level-up banner: drag to move")

local timer, moving = 0, false

local function Animate()
  timer = timer + arg1
  if timer < FADE_IN then
    banner:SetAlpha(timer / FADE_IN)
  elseif timer < FADE_IN + HOLD then
    banner:SetAlpha(1)
  elseif timer < FADE_IN + HOLD + FADE_OUT then
    banner:SetAlpha(1 - (timer - FADE_IN - HOLD) / FADE_OUT)
  else
    banner:SetScript("OnUpdate", nil)
    banner:Hide()
  end
end

function XBP:ApplyBanner()
  local db = self.db
  banner:SetScale(db.levelUpScale)
  banner:ClearAllPoints()
  if db.levelUpX and db.levelUpY then
    local sc = db.levelUpScale
    banner:SetPoint("CENTER", UIParent, "BOTTOMLEFT", db.levelUpX / sc, db.levelUpY / sc)
  else
    banner:SetPoint("TOP", UIParent, "TOP", 0, -128 / db.levelUpScale)
  end
  -- while the bar is unlocked, the banner stays up so it can be moved too
  moving = not db.locked and db.levelUp
  if moving then
    banner:SetScript("OnUpdate", nil)
    footer:SetText(string.format(strings[2], UnitLevel("player")))
    banner:EnableMouse(true)
    banner:SetAlpha(1)
    hint:Show()
    banner:Show()
  else
    banner:EnableMouse(false)
    hint:Hide()
    if not banner:GetScript("OnUpdate") then banner:Hide() end
  end
end

function XBP:ShowLevelUp(level)
  if moving then return end
  footer:SetText(string.format(strings[2], level or UnitLevel("player")))
  timer = 0
  banner:SetAlpha(0)
  banner:Show()
  banner:SetScript("OnUpdate", Animate)
end

function XBP:ResetBannerPosition()
  self.db.levelUpX, self.db.levelUpY = nil, nil
  self:ApplyBanner()
end

banner:SetScript("OnDragStart", function() if moving then this:StartMoving() end end)
banner:SetScript("OnDragStop", function()
  this:StopMovingOrSizing()
  local x, y = this:GetCenter()
  if x then
    local sc = this:GetScale()
    XBP.db.levelUpX, XBP.db.levelUpY = x * sc, y * sc
    XBP:ApplyBanner()
  end
end)

local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LEVEL_UP")
ev:SetScript("OnEvent", function()
  if XBP.db and XBP.db.levelUp then XBP:ShowLevelUp(arg1) end
end)
