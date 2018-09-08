CharMap = {};

local LDB = LibStub and LibStub:GetLibrary("LibDataBroker-1.1");

local lower_alpha = {
  "à", "á", "â", "ã", "ä", "å", "æ", "ç",
  "è", "é", "ê", "ë", "ì", "í", "î", "ï",
  "ð", "ñ", "ò", "ó", "ô", "õ", "ö", "ø",
  "ß", "ù", "ú", "û", "ü", "ý", "þ", "ÿ", 
}

local upper_alpha = {
  "À", "Á", "Â", "Ã", "Ä", "Å", "Æ", "Ç",
  "È", "É", "Ê", "Ë", "Ì", "Í", "Î", "Ï",
  "Ð", "Ñ", "Ò", "Ó", "Ô", "Õ", "Ö", "Ø",
   "", "Ù", "Ú", "Û", "Ü", "Ý", "Þ",  ""
};

local symbol_1 = {
  "¡", "¿", "£", "¢", "¥", "¦", "§", "¶",
  "©", "®", "™", "€", "·", "±", "º", "°",
  "¹", "²", "³", "ª", "µ", "‡", "†", "∞",
  "∑", "∏", "√", "∩", "∫", "≈", "≠", "≡",
   "", "¼", "½", "¾", "∂", "≤", "≥", ""
};

local symbol_2 = {
  "•", "…", "‰", "‹", "›", "«", "»", "¬",
  "←", "↑", "→", "↓", "↔", "↕", "♪", "♫",
  "♂", "♀", "◊", "♥", "♦", "♣", "♠", "☼",
  "☻", "∆", "∟", "⌂", "⌠", "⌡", "▪", "▫",
   "", "☺", "▬", "●", "◘", "◙", "◦", ""
};

local drawing_1 = {
  "┌", "┬", "┐", "─", "═", "╔", "╦", "╗",
  "├", "┼", "┤", "│", "║", "╠", "╬", "╣",
  "└", "┴", "┘",  "",  "", "╚", "╩", "╝",
  "░", "▒", "▓", "█", "►", "◄", "▲", "▼",
};

local drawing_2 = {
  "╒", "╤", "╕",  "",  "", "╓", "╥", "╖",
  "╞", "╪", "╡",  "",  "", "╟", "╫", "╢", 
  "╘", "╧", "╛",  "",  "", "╙", "╨", "╜", 
   "", "▀", "▄", "▌", "▐", "■", "□", ""
};

local full = {
  "à", "á", "â", "ã", "ä", "å", "æ", "ç",  "", "•", "…", "‰", "‹", "›", "«", "»", "¬",  "", "┌", "┬", "┐", "╔", "╦", "╗",
  "è", "é", "ê", "ë", "ì", "í", "î", "ï",  "", "©", "®", "™", "€", "·", "±", "º", "°",  "", "├", "┼", "┤", "╠", "╬", "╣",
  "ð", "ñ", "ò", "ó", "ô", "õ", "ö", "ø",  "", "¹", "²", "³", "ª", "µ", "‡", "†", "∞",  "", "└", "┴", "┘", "╚", "╩", "╝",
  "ß", "ù", "ú", "û", "ü", "ý", "þ", "ÿ",  "", "∑", "∏", "√", "∩", "∫", "≈", "≠", "≡",  "", "╒", "╤", "╕", "╓", "╥", "╖",
   "",  "",  "",  "",  "",  "",  "",  "",  "",  "", "¼", "½", "¾", "∂", "≤", "≥", "" ,  "", "╞", "╪", "╡", "╟", "╫", "╢",
  "À", "Á", "Â", "Ã", "Ä", "Å", "Æ", "Ç",  "", "•", "…", "‰", "‹", "›", "«", "»", "¬",  "", "╘", "╧", "╛", "╙", "╨", "╜", 
  "È", "É", "Ê", "Ë", "Ì", "Í", "Î", "Ï",  "", "←", "↑", "→", "↓", "↔", "↕", "♪", "♫",  "", "■", "─", "│", "║", "═", "□", 
  "Ð", "Ñ", "Ò", "Ó", "Ô", "Õ", "Ö", "Ø",  "", "♂", "♀", "◊", "♥", "♦", "♣", "♠", "☼",  "", "░", "▒", "▓", "█", "►", "◄",
   "", "Ù", "Ú", "Û", "Ü", "Ý", "Þ",  "",  "", "☻", "∆", "∟", "⌂", "⌠", "⌡", "▪", "▫",  "", "▀", "▄", "▌", "▐", "▲", "▼", 
   "",  "",  "",  "",  "",  "",  "",  "",  "",  "", "☺", "▬", "●", "◘", "◙", "◦",  "",  "",  "",  "",  "",  "",  "",  ""
}

SLASH_CHARACTERMAP1, SLASH_CHARACTERMAP2, SLASH_CHARACTERMAP3 = "/charactermap", "/charmap", "/cm";
function SlashCmdList.CHARACTERMAP(msg)
  if(msg == "anchor") then
    if(CharacterMapSaved.anchor) then
      CharacterMapSaved.anchor = false;
    else
      CharacterMapSaved.anchor = true;
      CharMap:Anchor();
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFCharacter Map|r anchored to the chat box");
  elseif(msg == "auto") then
    if(CharacterMapSaved.auto) then
      CharMap:Autoshow(false);
      CharacterMapSaved.auto = false;
      DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFCharacter Map|r will no longer auto-show and hide");
    else
      CharMap:Autoshow(true);
      CharacterMapSaved.auto = true;
      DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFCharacter Map|r will auto-show and hide");
    end
  elseif(msg == "hide") then
    CharacterMapFrame:Hide();
  elseif(msg == "mode") then
    DEFAULT_CHAT_FRAME:AddMessage("Mode usage");
  elseif(string.sub(msg, 1, 5) == "mode ") then
    local submsg = string.sub(msg, 6);
    DEFAULT_CHAT_FRAME:AddMessage("Set mode: {"..submsg.."}");
  elseif(msg == "show") then
    CharacterMapFrame:Show();
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFCharacter Map:|r Usage");
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00show|r / |cFFFF0000hide|r - Show or Hide the |cFF8080FFCharacter Map|r");
    DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFanchor|r - Anchor |cFF8080FFCharacter Map|r to the chat box");
    DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFauto|r - ("..((CharacterMapSaved.auto and "|cFF00FF00Enabled|r") or "|cFFFF0000Disabled")..") Auto-show and hide |cFF8080FFCharacter Map|r");
    DEFAULT_CHAT_FRAME:AddMessage("|cFF8080FFmode|r - ("..((CharacterMapSaved.mode == "page" and "Pages") or (CharacterMapSaved.mode == "modifier" and "Modifiers") or "error")..") Set the keyboard display mode");
  end
end

local function add_character_button(text, parent)
  local temp = CreateFrame("BUTTON", "CharacterMapFrameButton"..text, parent);
  -- local temp = CreateFrame("Button", "CharacterMapFrameButton"..text, parent, "GameMenuButtonTemplate")
  -- local temp = CreateFrame("Button", "CharacterMapFrameButton"..text, parent, "CharacterMapSymbolButtonTemplate")
  -- local temp = 	parent:CreateFontString(nil, "OVERLAY", "ChatFontNormal")


  temp:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16, 
    insets = {
      left = 4,
      right = 4,
      top = 4,
      bottom = 4
    }
  });
  temp:SetBackdropColor(0, 0, 0, 1);
  temp:SetFrameStrata("FULLSCREEN_DIALOG");
  temp:SetWidth(25);
  temp:SetHeight(25);
  temp:SetHighlightTexture("Interface\\BUTTONS\\ButtonHilight-SquareQuickslot.blp");
  -- temp:SetNormalFontObject("ChatFontNormal");
  -- temp:SetFontObject("ChatFontNormal");
    -- button.text:SetFontObject("ChatFontNormal")

  -- temp:SetPushedTextOffset(0, 0);
  -- temp:SetPushedTexture("Interface\\BUTTONS\\UI-Common-MouseHilight.blp", 0.5);
  


  -- temp:SetText(text);
  local label = temp:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
  	label:SetPoint("TOPLEFT",temp,"TOPLEFT",0,0)
	label:SetJustifyH("CENTER")
	label:SetJustifyV("MIDDLE")
  label:SetWidth(25);
  label:SetHeight(25);
  label:SetText(text);
	label:SetTextColor(1, 1, 1, 1)
    
  temp:SetScript("OnClick", function() CharMap:AddText(parent, text); end);
  
  return temp;
end

local function create_keyboard(globalname, display, anchor, width, height)
  local f = CreateFrame("MOVIEFRAME", globalname, CharacterMapFrame);
  f:SetFrameStrata("FULLSCREEN_DIALOG");

  f:SetWidth(width);
  f:SetHeight(height);
  
  f:SetPoint(anchor, CharacterMapFrame, anchor);
  
  f.title = CreateFrame("FRAME", globalname.."Title", f);
  f.title:SetFrameStrata("FULLSCREEN_DIALOG");
  f.title:SetHeight(25);
  f.title:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
    tile = true, tileSize = 16, edgeSize = 16, 
    insets = {
      left = 4,
      right = 4,
      top = 4,
      bottom = 4
    }
  });
  f.title:SetBackdropColor(0, 0, 0, 1);
  f.title:SetPoint("BOTTOM", f, "TOP");
  f.title:EnableMouse(true);
  f.title:SetScript("OnMouseDown", function() CharacterMapFrame:StartMoving(); CharacterMapSaved.anchor = false; end);
  f.title:SetScript("OnMouseUp", function() CharacterMapFrame:StopMovingOrSizing() end);
  
  f.text = f.title:CreateFontString(nil, "OVERLAY", "ChatFontNormal");
  f.text:SetText(display);
  f.text:SetPoint("TOP", f.title, "TOP", 0, -5);
  f.text:Show();
  
  f.title:SetWidth(width);

  return f;
end

local function layout_buttons(charlist, f, layout_limit)
  if not(f.layout) then
    f.layout = {x = 10, y = -10}
  end
  for i,v in pairs(charlist) do
    if(f.layout.x > (layout_limit - 27)) then
      f.layout.y = f.layout.y - 27;
      f.layout.x = 10;
    end
    
    local temp = add_character_button(v, f);
    temp:SetPoint("TOPLEFT", f, "TOPLEFT", f.layout.x, f.layout.y);
    if(v == "") then
      temp:Hide();
    end

    f.layout.x = f.layout.x + 27;
  end
end

local scriptFrame = CreateFrame("FRAME");
scriptFrame:RegisterEvent("VARIABLES_LOADED")
scriptFrame:SetScript("OnEvent", function(self, event)
  if not(CharacterMapSaved) then
    CharacterMapSaved = {
      anchored = false;
      autoshow = false,
      mode = "modifier"
    };
  end
  
  CharMap:Autoshow(CharacterMapSaved.auto);
  --set mode
end);

do
  local editbox = nil;
  function CharMap.AutoShowAndHide(self, elapsed)
    local visible = CharacterMapFrame:IsVisible();
    local focus = GetCurrentKeyBoardFocus();
    if(focus ~= editbox) then
      if(CharacterMapSaved.anchor) then
        CharMap:Anchor();
      end
      
      if(focus and not visible) then
        CharacterMapFrame:Show();
      end
      if(visible and not focus) then
        CharacterMapFrame:Hide();
      end
    end
    editbox = focus;
  end
end

function CharacterMapFrame_OnLoad(self)
  DEFAULT_CHAT_FRAME:AddMessage("CM Loaded");
  self:SetBackdrop({
      bgFile = "Interface/Tooltips/UI-Tooltip-Background",
      edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
      tile = true, tileSize = 16, edgeSize = 16, 
      insets = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4
      }
    });
  self:SetBackdropColor(0, 0, 0, 1);
  self:SetFrameStrata("FULLSCREEN_DIALOG");
  tinsert(UISpecialFrames, "CharacterMapFrame")
    
  self.close = CreateFrame("Button", "CharacterMapFrameCloseButton", self, "UIPanelButtonTemplate2");
  self.close:SetText("Close");
  self.close:SetScript("OnClick", function() self:Hide(); end);
  self.close:SetWidth(105);
  self.close:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -10, 10);
  self.close:SetFrameStrata("FULLSCREEN_DIALOG");

  self.edit = CreateFrame("Editbox", "CharacterMapFrameEditBox", self, "InputBoxTemplate")
  self.edit:SetAutoFocus(false);
  self.edit:SetFontObject(ChatFontNormal);
  self.edit:SetScript("OnEnterPressed", function() self.edit:ClearFocus() end);
  self.edit:SetTextInsets(0, 0, 3, 3);
  self.edit:SetMaxLetters(32);
  self.edit:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 17, 10);
  self.edit:SetPoint("RIGHT", self.close, "LEFT");
  self.edit:SetHeight(25);
  self.edit:SetFrameStrata("FULLSCREEN_DIALOG");

  self:SetScript("OnHide", function() self.edit:SetText("") end);
  
  self.sub_frame = 0;
  self.sub_frames = {};
  self.sub_frames[1] = create_keyboard("CharacterMapLowerFrame", "|cFF8080FFCharacter Map:|cFFFFFFFF Lower Case", "TOPLEFT", 234, 151);
  layout_buttons(lower_alpha, self.sub_frames[1], 234);
  self.sub_frames[2] = create_keyboard("CharacterMapUpperFrame", "|cFF8080FFCharacter Map:|cFFFFFFFF Upper Case", "BOTTOMLEFT", 234, 151);
  layout_buttons(upper_alpha, self.sub_frames[2], 234);
  self.sub_frames[3] = create_keyboard("CharacterMapSymbol1Frame", "|cFF8080FFCharacter Map:|cFFFFFFFF Symbol Set 1", "TOP", 234, 178);
  layout_buttons(symbol_1, self.sub_frames[3], 234);
  self.sub_frames[4] = create_keyboard("CharacterMapSymbol2Frame", "|cFF8080FFCharacter Map:|cFFFFFFFF Symbol Set 2", "BOTTOM", 234, 178);
  layout_buttons(symbol_2, self.sub_frames[4], 234);
  self.sub_frames[5] = create_keyboard("CharacterMapDrawing1Frame", "|cFF8080FFCharacter Map:|cFFFFFFFF Drawing Set 1", "TOPRIGHT", 234, 151);
  layout_buttons(drawing_1, self.sub_frames[5], 234);
  self.sub_frames[6] = create_keyboard("CharacterMapDrawing2Frame", "|cFF8080FFCharacter Map:|cFFFFFFFF Drawing Set 2", "BOTTOMRIGHT", 234, 151);
  layout_buttons(drawing_2, self.sub_frames[6], 234);
  self.sub_frames[7] = create_keyboard("CharacterMapFullFrame", "|cFF8080FFCharacter Map:|cFFFFFFFF All Sets", "CENTER", 664, 313);
  layout_buttons(full, self.sub_frames[7], 664);
end

function CharacterMapFrame_OnUpdate(self)
  local modifier = 1;
  if(IsControlKeyDown()) then
    if(IsShiftKeyDown()) then
      if(IsAltKeyDown()) then
        modifier = 7
      else
        modifier = 4;
      end
    else
      modifier = 3;
    end
  elseif(IsAltKeyDown()) then
    if(IsShiftKeyDown()) then
      modifier = 6;
    else
      modifier = 5;
    end
  elseif(IsShiftKeyDown()) then
    modifier = 2;
  else
    modifier = 1;
  end
  if(self.sub_frame ~= modifier) then
    self.sub_frame = modifier;
    for i,v in ipairs(self.sub_frames) do
      if(i == self.sub_frame) then
        v:Show();
      else
        v:Hide();
      end
    end
    CharacterMapFrame:SetWidth(CharacterMapFrame.sub_frames[modifier]:GetWidth());
    CharacterMapFrame:SetHeight(CharacterMapFrame.sub_frames[modifier]:GetHeight());
  end
end

function CharacterMapFrame_OnShow(self)
  if(CharacterMapSaved.anchor) then
    CharMap:Anchor();
  end
end

if(LDB) then
  local CharMapLDB = LDB:NewDataObject("Character Map", {
    type = "launcher",
    text = "CharMap",
    icon = "Interface\\GossipFrame\\DailyActiveQuestIcon",

    OnTooltipShow = function(self)
      self:AddLine("|cFF8080FFCharacter Map");
      self:AddDoubleLine("|cffeda55fClick|r", "Open Character Map");
      self:AddLine("");
      self:AddDoubleLine("|cffeda55fUnmodified|r", "Lower Case");
      self:AddDoubleLine("|cffeda55fShift|r", "Upper Case");
      self:AddDoubleLine("|cffeda55fControl|r", "Symbol Set 1");
      self:AddDoubleLine("|cffeda55fControl-Shift|r", "Symbol Set 2");
      self:AddDoubleLine("|cffeda55fAlt|r", "Drawing Set 1");
      self:AddDoubleLine("|cffeda55fAlt-Shift|r", "Drawing Set 2");
      self:AddDoubleLine("|cffeda55fAlt-Control-Shift|r", "Full (all characters)");
    end,

    OnClick = function(self, button)
      CharMap:Toggle();
    end
  });
end

function CharMap:Toggle()
  if(CharacterMapFrame:IsVisible()) then
    CharacterMapFrame:Hide();
  else
    CharacterMapFrame:Show();
    if not(GetCurrentKeyBoardFocus()) then
      CharacterMapFrameEditBox:SetFocus();
    end
  end
end

function CharMap:Autoshow(enable)
  if(enable) then
    scriptFrame:SetScript("OnUpdate", CharMap.AutoShowAndHide);
  else
    scriptFrame:SetScript("OnUpdate", nil);
  end
end

function CharMap:Anchor()
  local editbox = GetCurrentKeyBoardFocus();
  if(editbox and editbox ~= CharacterMapFrameEditBox) then
    local width = CharacterMapFrame:GetWidth();
    local height = CharacterMapFrame:GetHeight();
    local anchor_x = editbox:GetLeft();
    local anchor_y = editbox:GetTop();
    
    local y_offset = (anchor_y < height and 0) or -25;
    local in_scroll_frame = editbox:GetParent() and editbox:GetParent():GetObjectType() == "ScrollFrame";
    local x_offset = (anchor_x < width and ((in_scroll_frame and 25) or 5)) or -5;
    local anchor_self = ((anchor_y < height and "BOTTOM") or "TOP")..((anchor_x < width and "LEFT") or "RIGHT");
    local anchor_other = ((anchor_y < height and "BOTTOM") or "TOP")..((anchor_x < width and "RIGHT") or "LEFT");
    
    CharacterMapFrame:ClearAllPoints();
    CharacterMapFrame:SetPoint(anchor_self, editbox, anchor_other, x_offset, y_offset);
  end
end

function CharMap:AddText(f, text)

    if ( ChatFrameEditBox:IsVisible() ) then
        ChatFrameEditBox:Insert(text);
    end
    --[[
  local editbox = GetCurrentKeyBoardFocus();
  if(editbox) then
    editbox:Insert(text);
  else
    CharacterMapFrame.edit:Insert(text);
  end
  ]]--
end