-- This file is loaded from "UIScripts.toc"


-- Hide Target Castbar
-- SetCVar("showTargetCastbar", 0)

-- Move Player Castbar
-- CastingBarFrame:ClearAllPoints()
-- CastingBarFrame:SetPoint("TOP", WorldFrame, "CENTER", 0, -350)
-- CastingBarFrame.SetPoint = function() end

-- Dispellable debuffs
-- hooksecurefunc("TargetFrame_UpdateAuras", function(s) for i=1,MAX_TARGET_BUFFS do if select(5,UnitAura(s.unit,i)) == 'Magic' and UnitIsEnemy('player',s.unit) then _G[s:GetName().."Buff"..(i).."Stealable"]:Show() end end end)


-- Move Tooltip
-- GameTooltip:SetScript("OnTooltipSetUnit", function(self)
--     self:ClearAllPoints()
--     self:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", -30, 200)
-- end)


------------------------------------------------
-- Penance Aura
------------------------------------------------
-- local frame = CreateFrame("FRAME")
-- frame:RegisterEvent("UNIT_AURA")

-- frame:SetScript("OnEvent", function(self, event, ...)
--     local unitid = ... if unitid ~= "player" then return end

--     if UnitBuff("player", "Power of the Dark Side") then
--         SpellActivationOverlay_ShowOverlay(SpellActivationOverlayFrame, 198068, "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICTOP_01.BLP", "TOP", 1.2, 139, 65, 239, false, false)
--     else
--         SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame, 198068)
--     end
-- end)


------------------------------------------------
-- Move buffs & debuffs
------------------------------------------------
function Movebuff() BuffFrame:ClearAllPoints() BuffFrame:SetScale(1.1) BuffFrame:SetPoint("CENTER",PlayerFrame,"CENTER",550,500) end  hooksecurefunc("UIParent_UpdateTopFramePositions",Movebuff) Movebuff()

function sp(f,i) tr="TOPRIGHT";f2=f.debuffFrames;s=f2[1]:GetWidth();f3=f2[i];f3:SetSize(s,s);f3:ClearAllPoints();if i>6 then f3:SetPoint("BOTTOMRIGHT",f2[i-3],tr,0,0) else f3:SetPoint(tr,f2[1],tr,-(s*(i-3)),0) end end
function CBF(f,i) bf=CreateFrame("Button",f:GetName().."Debuff"..i,f,"CompactDebuffTemplate");bf.baseSize=22;bf:SetSize(f.buffFrames[1]:GetSize()) end;function mv(f) for i=4,12 do sp(f,i) end end
function mv3(f) CompactUnitFrame_SetMaxDebuffs(f,12); if not f.debuffFrames[4] then for i=4,12 do CBF(f,i) end end mv(f) end;hooksecurefunc("CompactUnitFrame_UpdateDebuffs",function(f) if f:GetName():match("^Compact") then mv3(f) end end);


------------------------------------------------
-- Class Icon Not Portrait
------------------------------------------------
hooksecurefunc("UnitFramePortrait_Update",function(self)
        if self.portrait then
                if UnitIsPlayer(self.unit) then                         
                        local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
                        if t then
                                self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
                                self.portrait:SetTexCoord(unpack(t))
                        end
                else
                        self.portrait:SetTexCoord(0,1,0,1)
                end
        end
end)

------------------------------------------------
-- ColorFrames
------------------------------------------------
-- local ClassColorUnits = {
--     ["target"] = {
--         ["name"] = "TargetFrame",
--         ["back"] = "TargetFrame",
--         ["x-offset"] = -104,
--         ["y-offset"] = 60,
--         ["x-offset2"] = 6,
--         ["y-offset2"] = -22,
--     },
--     ["player"] = {
--         ["name"] = "PlayerFrame",
--         ["back"] = "PlayerFrameBackground",
--         ["x-offset"] = 0,
--         ["y-offset"] = 22,
--         ["x-offset2"] = 0,
--         ["y-offset2"] = 0,
--     },
--     ["focus"] = {
--         ["name"] = "FocusFrame",
--         ["back"] = "FocusFrame",
--         ["x-offset"] = -104,
--         ["y-offset"] = 60,
--         ["x-offset2"] = 6,
--         ["y-offset2"] = -22,
--     },
-- }
-- local function updateClassColor(unit)
--     if(unit and UnitExists(unit)) then
--         local _,class = UnitClass(unit)
--         c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
--         if(class and RAID_CLASS_COLORS[class]) then
--             if(ClassColorUnits[unit]) then
--                 local uf = _G[ClassColorUnits[unit]['name']]
--                 local bg = _G[ClassColorUnits[unit]['back']]
--                 if(not uf['unitClassColorBack']) then
--                     uf['unitClassColorBack'] = uf:CreateTexture(nil, "ARTWORK")
--                     uf['unitClassColorBack']:SetPoint("TOPLEFT", bg, ClassColorUnits[unit]['x-offset2'], ClassColorUnits[unit]['y-offset2'])
--                     uf['unitClassColorBack']:SetPoint("BOTTOMRIGHT", bg, ClassColorUnits[unit]['x-offset'], ClassColorUnits[unit]['y-offset'])
--                     uf['unitClassColorBack']:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
--                 end
--                 if(not UnitIsPlayer(unit)) then
--                     uf['unitClassColorBack']:SetVertexColor(0, 0, 0, 0)
--                 else
--                     uf['unitClassColorBack']:SetVertexColor(c.r, c.g, c.b, 1)
--                 end
--             end
--         end
--     end
-- end

-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
-- frame:RegisterEvent("PLAYER_TARGET_CHANGED")
-- frame:RegisterEvent("PLAYER_ENTERING_WORLD")
-- frame:SetScript("OnEvent", function(self, event)
--     if(event=="PLAYER_FOCUS_CHANGED") then
--         updateClassColor('focus')
--     elseif(event=="PLAYER_TARGET_CHANGED") then
--         updateClassColor('target')
--     elseif(event=="PLAYER_ENTERING_WORLD") then
--         updateClassColor('player')
--         self:UnregisterEvent(event)
--     end
-- end)


------------------------------------------------
-- ClassColoredHealthBars
------------------------------------------------
local function removeAlphaFrom(f)
    f:SetAlpha(0)
    f.SetAlpha = function() end
end
local usc = UnitSelectionColor
function UnitSelectionColor(u, ...)
    if u == TargetFrame.unit or u == FocusFrame.unit then
        return 0, 0, 0, 0.4;
    end
    r, g, b, a = usc(u, ...)
    return r, g, b, a;
end
removeAlphaFrom(PlayerPrestigeBadge);
removeAlphaFrom(PlayerPrestigePortrait);
removeAlphaFrom(TargetFrameTextureFramePrestigeBadge);
removeAlphaFrom(TargetFrameTextureFramePrestigePortrait);
removeAlphaFrom(FocusFrameTextureFramePrestigeBadge);
removeAlphaFrom(FocusFrameTextureFramePrestigePortrait);
PlayerName:SetTextColor(1,1,1,1);
TargetFrameTextureFrameName:SetTextColor(1,1,1,1);
FocusFrameTextureFrameName:SetTextColor(1,1,1,1);

local   UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS =
        UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS
local _, class, c

local function colour(statusbar, unit)
    if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
        _, class = UnitClass(unit)
        c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
        statusbar:SetStatusBarColor(c.r, c.g, c.b)
    end
end

hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
    colour(self, self.unit)
end)

local sb = _G.GameTooltipStatusBar
local addon = CreateFrame("Frame", "StatusColour")
addon:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
addon:SetScript("OnEvent", function()
    colour(sb, "mouseover")
end)


------------------------------------------------
-- infDampening
------------------------------------------------
-- local infDampening = CreateFrame("Frame", "infDampening")
-- infDampening:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)
-- infDampening:RegisterEvent("PLAYER_ENTERING_WORLD")

-- local dampening
-- local dampening_frame

-- Upvalues.
-- local _ = _
-- local _G = _G
-- local IsShown = IsShown
-- local UnitDebuff = UnitDebuff

-- local function create()
--     local anchorPoint = NUM_ALWAYS_UP_UI_FRAMES

--     dampening_frame = CreateFrame("Frame", nil, UIParent)
--     dampening_frame:SetSize(45, 24)
--     dampening_frame:SetPoint("TOP", _G["AlwaysUpFrame"..anchorPoint], "BOTTOM")
--     dampening_frame:Hide()

--     --Dummy texture, doing this to mimic the default WorldState format.
--     --Basically it is so it always lines up perfectly, regardless of UIScale, custom fonts etc.
--     dampening_frame.texture = dampening_frame:CreateTexture(nil, "BACKGROUND")
--     dampening_frame.texture:SetSize(42, 42)
--     dampening_frame.texture:SetPoint("LEFT", -6, 0)

--     dampening_frame.text = dampening_frame:CreateFontString(nil, "BACKGROUND")
--     dampening_frame.text:SetPoint("LEFT", dampening_frame.texture, "RIGHT", -12, 10)
--     dampening_frame.text:SetFontObject(GameFontNormalSmall)
-- end

-- Hide the frame when we enter as well since with 6.0 you can queue for arena without leaving your current one.
-- function infDampening:PLAYER_ENTERING_WORLD()
--     local _, instanceType = IsInInstance()
--     if instanceType == "arena" then
--         dampening = nil
--         self:RegisterUnitEvent("UNIT_AURA", "player")
--         if dampening_frame and dampening_frame:IsShown() then
--             dampening_frame:Hide()
--         end
--     else
--         self:UnregisterEvent("UNIT_AURA")
--         if dampening_frame and dampening_frame:IsShown() then
--             dampening_frame:Hide()
--         end
--     end
-- end

-- Do our frame on UNIT_AURA when dampening is applied as occasionally NUM_ALWAYS_UP_UI_FRAMES is not ready even as late as when ARENA_OPPONENT_UPDATE[seen] fires.
-- The other way would be to do a scheduled check, could work as well.
-- Only create the frame once, always re-use afterwards.
-- function infDampening:UNIT_AURA(_, unit)
--     local _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, perc = UnitDebuff(unit, "Dampening")
--     if perc then
--         if not dampening then
--             if dampening_frame then
--                 local anchorPoint = NUM_ALWAYS_UP_UI_FRAMES
--                 dampening_frame:SetPoint("TOP", _G["AlwaysUpFrame"..anchorPoint], "BOTTOM")
--             else
--                 create()
--             end
--         end

--         if dampening ~= perc then
--             dampening = perc
--             dampening_frame.text:SetText("Dampening: "..perc.."%")
--             if not dampening_frame:IsShown() then
--                 dampening_frame:Show()
--             end
--         end
--     end
-- end


------------------------------------------------
-- SafeQueue
------------------------------------------------
-- local SafeQueue = CreateFrame("Frame")
-- local queueTime
-- local queue = 0
-- local remaining = 0
-- SafeQueueDB = SafeQueueDB or { announce = "self" }

-- PVPReadyDialog.leaveButton:Hide()
-- PVPReadyDialog.leaveButton.Show = function() end -- Prevent other mods from showing the button
-- PVPReadyDialog.enterButton:ClearAllPoints()
-- PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)
-- PVPReadyDialog.label:SetPoint("TOP", 0, -22)

-- local function Print(msg)
--     DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99SafeQueue|r: " .. msg)
-- end

-- local function PrintTime()
--     local announce = SafeQueueDB.announce
--     if announce == "off" then return end
--     local secs, str, mins = floor(GetTime() - queueTime), "Queue popped "
--     if secs < 1 then
--         str = str .. "instantly!"
--     else
--         str = str .. "after "
--         if secs >= 60 then
--             mins = floor(secs/60)
--             str = str .. mins .. "m "
--             secs = secs%60
--         end
--         if secs%60 ~= 0 then
--             str = str .. secs .. "s"
--         end
--     end
--     if announce == "self" or not IsInGroup() then
--         Print(str)
--     else
--         local group = IsInRaid() and "RAID" or "PARTY"
--         SendChatMessage(str, group)
--     end
-- end

-- SafeQueue:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
-- SafeQueue:SetScript("OnEvent", function()
--     local queued
--     for i=1, GetMaxBattlefieldID() do
--         local status = GetBattlefieldStatus(i)
--         if status == "queued" then
--             queued = true
--             if not queueTime then queueTime = GetTime() end
--         elseif status == "confirm" then
--             if queueTime then
--                 PrintTime()
--                 queueTime = nil
--                 remaining = 0
--                 queue = i
--             end                 
--         end
--         break
--     end
--     if not queued and queueTime then queueTime = nil end
-- end)

-- SafeQueue:SetScript("OnUpdate", function(self)
--     if PVPReadyDialog_Showing(queue) then
--         local secs = GetBattlefieldPortExpiration(queue)
--         if secs and secs > 0 and remaining ~= secs then
--             remaining = secs
--             local color = secs > 20 and "f20ff20" or secs > 10 and "fffff00" or "fff0000"
--             PVPReadyDialog.label:SetText("Expires in |cf"..color.. SecondsToTime(secs) .. "|r")
--         end
--     end
-- end)

-- SlashCmdList.SafeQueue = function(msg)
--     msg = msg or ""
--     local cmd, arg = string.split(" ", msg, 2)
--     cmd = string.lower(cmd or "")
--     arg = string.lower(arg or "")
--     if cmd == "announce" then
--         if arg == "off" or arg == "self" or arg == "group" then
--             SafeQueueDB.announce = arg
--             Print("Announce set to " .. arg)
--         else
--             Print("Announce set to " .. SafeQueueDB.announce)
--             Print("Announce types are \"off\", \"self\", and \"group\"")
--         end
--     else
--         DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99SafeQueue v2.7|r")
--         Print("/sq announce : " .. SafeQueueDB.announce)
--     end
-- end
-- SLASH_SafeQueue1 = "/safequeue"
-- SLASH_SafeQueue2 = "/sq"
