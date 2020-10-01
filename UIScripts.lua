-- This file is loaded from "UIScripts.toc"
-- http://www.arenajunkies.com/topic/222642-default-ui-scripts/

-- MainMenuBarArtFrame.LeftEndCap:Hide()
-- MainMenuBarArtFrame.RightEndCap:Hide()
-- StatusTrackingBarManager:Hide()
-- ObjectiveTrackerFrame:Hide()

-- FramerateLabel:ClearAllPoints()
-- FramerateText:ClearAllPoints()
-- FramerateLabel:SetPoint("RIGHT",UIParent,"CENTER",-250,0)
-- FramerateText:SetPoint("LEFT",FramerateLabel,"RIGHT")

MainMenuBarArtFrameBackground:Hide()
MainMenuBarArtFrame.PageNumber:Hide()

MicroButtonAndBagsBar.MicroBagBar:Hide()
-- MicroButtonAndBagsBar:ClearAllPoints() 
-- MicroButtonAndBagsBar:SetPoint("CENTER",200,50) MicroButtonAndBagsBar.SetPoint = function() end

CharacterBag0Slot:Hide()
CharacterBag0Slot.IconBorder:Hide()
CharacterBag0SlotIconTexture:Hide()

CharacterBag1Slot:Hide()
CharacterBag1Slot.IconBorder:Hide()
CharacterBag1SlotIconTexture:Hide()

CharacterBag2Slot:Hide()
CharacterBag2Slot.IconBorder:Hide()
CharacterBag2SlotIconTexture:Hide()

CharacterBag3Slot:Hide()
CharacterBag3Slot.IconBorder:Hide()
CharacterBag3SlotIconTexture:Hide()

ActionBarUpButton:SetAlpha(0)
ActionBarDownButton:SetAlpha(0)

StatusTrackingBarManager:Hide();
MainMenuBarArtFrame.RightEndCap:Hide();
MainMenuBarArtFrame.LeftEndCap:Hide();

MainMenuBarArtFrameBackground:ClearAllPoints() 
MainMenuBarArtFrameBackground:SetPoint("CENTER",23,-23) MainMenuBarArtFrameBackground.SetPoint = function() end

-- Hide Target Castbar
SetCVar("showTargetCastbar", 1)

-- Move Player Castbar
CastingBarFrame:ClearAllPoints()
CastingBarFrame:SetPoint("TOP", WorldFrame, "CENTER", 0, -250)
CastingBarFrame.SetPoint = function() end

------------------------------------------------
-- /afk surrender
------------------------------------------------
local function prettyPrint(msg)
    print("|cFFDC143CafkSurrender:|r |cFF40E0D0"..msg.."|r")
end

SlashCmdList["CHAT_AFK"] = function(msg)
    if IsActiveBattlefieldArena() then
        if CanSurrenderArena() then
            prettyPrint("Successfully surrendered arena.")
            SurrenderArena();
        else
            prettyPrint("Failed to surrender arena. Partners still alive.")
        end
    else
        SendChatMessage(msg, "AFK");
    end
end

------------------------------------------------
-- Minimap Tweaks
------------------------------------------------
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if delta > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPRIGHT", -26, 7)

-- Move Tooltip
GameTooltip:SetScript("OnTooltipSetUnit", function(self)
    self:ClearAllPoints()
    self:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", -20, 135)
end)

-- Focus Cast Bar
hooksecurefunc(FocusFrameSpellBar, "Show", function()
    FocusFrameSpellBar:ClearAllPoints()
    FocusFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 0, -100)
    FocusFrameSpellBar:SetScale(1.5)
    FocusFrameSpellBar.SetPoint = function() end
end)

-- Target Cast Bar
-- hooksecurefunc(CastingBarFrame, "Show", function()
--     CastingBarFrame:ClearAllPoints()
--     CastingBarFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -310)
--     CastingBarFrame.SetPoint = function() end
-- end)

------------------------------------------------
-- Move buffs & debuffs
------------------------------------------------
-- hooksecurefunc("UIParent_UpdateTopFramePositions", function()
--     BuffFrame:ClearAllPoints()
--     BuffFrame:SetScale(1.1)
--     BuffFrame:SetPoint("CENTER",PlayerFrame,"CENTER",500,450)
-- end)

-- old
-- function Movebuff() 
--     BuffFrame:ClearAllPoints()
--     BuffFrame:SetScale(1.1)
--     BuffFrame:SetPoint("CENTER",PlayerFrame,"CENTER",560,450)
-- end
-- Movebuff()

-- Hide Talking Head
local function HookTalkingHead()
    hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
        TalkingHeadFrame:Hide()
    end)
end
 
if TalkingHeadFrame then
    HookTalkingHead()
else -- Hook to the loading function.
    hooksecurefunc('TalkingHead_LoadUI', HookTalkingHead)
end

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
