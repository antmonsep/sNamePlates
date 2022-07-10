local folder, core = ...
local sNamePlates = LibStub("AceAddon-3.0"):NewAddon(core, "sNamePlates", "AceConsole-3.0", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

local lastUpdate = 0
local backdrop = {
	edgeFile = [[Interface\AddOns\sNamePlates\Media\Textures\Glow\glowTex]], edgeSize = 5,
	insets = {left = 20, right = 3, top = 3, bottom = 3}
}
local _format = string.format
local math_max = math.max
local math_floor = math.floor
local unpack = unpack
local targetExist

local cchProgress = 0

local iconFound, iconPath 

local name, _, _, texture, startTime, endTime, _, castID, notInterruptible, spellID 

local FetchFont, FetchStatusbar, sNamePlates_OnUpdate

local mode = CreateFrame("Frame")
local function setTimer(duration, func)
	local endTime = GetTime() + duration;
		mode:SetScript("OnUpdate", function()
		if(endTime < GetTime()) then
			--time is up
			func();
			mode:SetScript("OnUpdate", nil);
		end
	end);
end

function sNamePlates:OnInitialize()

	LSM:Register("statusbar", "Aluminium", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Aluminium]])
	LSM:Register("statusbar", "Armory", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Armory]])
	LSM:Register("statusbar", "BantoBar", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\BantoBar]])
	LSM:Register("statusbar", "Bars", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Bars]])
	LSM:Register("statusbar", "Bumps", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Bumps]])
	LSM:Register("statusbar", "Button", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Button]])
	LSM:Register("statusbar", "Charcoal", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Charcoal]])
	LSM:Register("statusbar", "Cilo", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Cilo]])
	LSM:Register("statusbar", "Cloud", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Cloud]])
	LSM:Register("statusbar", "Combo", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Combo]])
	LSM:Register("statusbar", "Comet", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Comet]])
	LSM:Register("statusbar", "Dabs", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Dabs]])
	LSM:Register("statusbar", "Details", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Details]])
	LSM:Register("statusbar", "Diagonal", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Diagonal]])
	LSM:Register("statusbar", "Falumn", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Falumn]])
	LSM:Register("statusbar", "Fifths", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Fifths]])
	LSM:Register("statusbar", "Flat", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Flat]])
	LSM:Register("statusbar", "Fourths", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Fourths]])
	LSM:Register("statusbar", "Frost", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Frost]])
	LSM:Register("statusbar", "Glamour", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour]])
	LSM:Register("statusbar", "Glamour2", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour2]])
	LSM:Register("statusbar", "Glamour3", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour3]])
	LSM:Register("statusbar", "Glamour4", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour4]])
	LSM:Register("statusbar", "Glamour5", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour5]])
	LSM:Register("statusbar", "Glamour6", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour6]])
	LSM:Register("statusbar", "Glamour7", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glamour7]])
	LSM:Register("statusbar", "Glass", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glass]])
	LSM:Register("statusbar", "Glaze", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glaze]])
	LSM:Register("statusbar", "Glaze2", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Glaze2]])
	LSM:Register("statusbar", "Gloss", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Gloss]])
	LSM:Register("statusbar", "Graphite", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Graphite]])
	LSM:Register("statusbar", "Grid", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Grid]])
	LSM:Register("statusbar", "Hatched", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Hatched]])
	LSM:Register("statusbar", "Healbot", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Healbot]])
	LSM:Register("statusbar", "LiteStep", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\LiteStep]])
	LSM:Register("statusbar", "LiteStepLite", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\LiteStepLite]])
	LSM:Register("statusbar", "Lyfe", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Lyfe]])
	LSM:Register("statusbar", "Melli", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Melli]])
	LSM:Register("statusbar", "MelliDark", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\MelliDark]])
	LSM:Register("statusbar", "Minimalist", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Minimalist]])
	LSM:Register("statusbar", "Otravi", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Otravi]])
	LSM:Register("statusbar", "Outline", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Outline]])
	LSM:Register("statusbar", "Perl2", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Perl2]])
	LSM:Register("statusbar", "Pill", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Pill]])
	LSM:Register("statusbar", "Rain", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Rain]])
	LSM:Register("statusbar", "Rocks", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Rocks]])
	LSM:Register("statusbar", "Round", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Round]])
	LSM:Register("statusbar", "Ruben", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Ruben]])
	LSM:Register("statusbar", "Runes", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Runes]])
	LSM:Register("statusbar", "Serenity", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Serenity]])
	LSM:Register("statusbar", "Skewed", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Skewed]])
	LSM:Register("statusbar", "Smooth v2", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Smoothv2]])
	LSM:Register("statusbar", "Smooth", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Smooth]])
	LSM:Register("statusbar", "Smudge", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Smudge]])
	LSM:Register("statusbar", "Striped", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Striped]])
	LSM:Register("statusbar", "Tube", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Tube]])
	LSM:Register("statusbar", "TukTex", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\TukTex]])
	LSM:Register("statusbar", "Water", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Water]])
	LSM:Register("statusbar", "Wglass", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Wglass]])
	LSM:Register("statusbar", "Wisps", [[Interface\AddOns\sNamePlates\Media\Textures\Statusbar\Wisps]])

	LSM:Register("font", "ABF", [[Interface\AddOns\sNamePlates\Media\Fonts\ABF.ttf]])
	LSM:Register("font", "Accidental Presidency", [[Interface\AddOns\sNamePlates\Media\Fonts\Accidental Presidency.ttf]])
	LSM:Register("font", "Action Man", [[Interface\AddOns\sNamePlates\Media\Fonts\ActionMan.ttf]])
	LSM:Register("font", "Adventure", [[Interface\AddOns\sNamePlates\Media\Fonts\Adventure.ttf]])
	LSM:Register("font", "Continuum Medium", [[Interface\AddOns\sNamePlates\Media\Fonts\ContinuumMedium.ttf]])
	LSM:Register("font", "Diablo", [[Interface\AddOns\sNamePlates\Media\Fonts\Diablo.ttf]])
	LSM:Register("font", "DomyoujiRegular", [[Interface\AddOns\sNamePlates\Media\Fonts\DomyoujiRegular.ttf]])
	LSM:Register("font", "Die Die Die!", [[Interface\AddOns\sNamePlates\Media\Fonts\DieDieDie.ttf]])
	LSM:Register("font", "Dsdig", [[Interface\AddOns\sNamePlates\Media\Fonts\Dsdig.ttf]])
	LSM:Register("font", "Expressway", [[Interface\AddOns\sNamePlates\Media\Fonts\Expressway.ttf]])
	LSM:Register("font", "Forced Square", [[Interface\AddOns\sNamePlates\Media\Fonts\FORCED SQUARE.ttf]])
	LSM:Register("font", "Hooge", [[Interface\AddOns\sNamePlates\Media\Fonts\Hooge.ttf]])
	LSM:Register("font", "Homespun", [[Interface\AddOns\sNamePlates\Media\Fonts\Homespun.ttf]])
	LSM:Register("font", "PT Sans Narrow", [[Interface\AddOns\sNamePlates\Media\Fonts\PTSansNarrow.ttf]])
	LSM:Register("font", "Seagram", [[Interface\AddOns\sNamePlates\Media\Fonts\Seagram.ttf]])
	LSM:Register("font", "Vipnagorgia", [[Interface\AddOns\sNamePlates\Media\Fonts\Vipnagorgiallarg.ttf]])
	LSM:Register("font", "yanone", [[Interface\AddOns\sNamePlates\Media\Fonts\yanone.ttf]])


    LibStub("AceConfig-3.0"):RegisterOptionsTable("sNamePlates", self.options)

    self.db = LibStub("AceDB-3.0"):New("sNamePlatesDB", self.defaults, true)
    --self.optionsFrame = ACD:AddToBlizOptions("sNamePlates", "sNamePlates")
	self.Frame = CreateFrame("Frame"):SetScript("OnUpdate", sNamePlates_OnUpdate)
end

function sNamePlates:OnEnable()
	self:RegisterChatCommand("snameplates", "ChatCommand")
    self:RegisterChatCommand("sNamePlates", "ChatCommand")
    self:RegisterChatCommand("snp", "ChatCommand")
	
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function sNamePlates:OnDisable()
end

function sNamePlates:ChatCommand(input)
    self:OpenOptions()
end

local function sNamePlates_IsValidFrame(frame)
	if frame:GetName() then
		return
	end

	overlayRegion = select(2, frame:GetRegions())

	return overlayRegion and overlayRegion:GetObjectType() == "Texture" and overlayRegion:GetTexture() == [[Interface\Tooltips\Nameplate-Border]]
end

local function IconScaling(X, Y)
	local icon_crop = 0.15-- The abound of Icon zoom (crop of its borders) Can me any value from 0 to 1 but more than 0.3 hardly makes much sence.
	local icon_offset_X = 0.5  -- Horizontal position of the shown texture (0 - shows the leftmost part, 1 shows the rightmost part)
	local icon_offset_Y = 0.5  -- Vertical position of the shown texture (0 - shows the topmost part, 1 shows the bottommost part)

	local length_X = (1 - icon_crop) * (X / math_max(X,Y)) 
	local length_Y = (1 - icon_crop) * (Y / math_max(X,Y)) 
	local axis_X = (icon_crop + length_X) * 0.5 + icon_offset_X * (1 - icon_crop - length_X)   
	local axis_Y = (icon_crop + length_Y) * 0.5 + icon_offset_Y * (1 - icon_crop - length_Y) 
	local X1 = axis_X - length_X * 0.5 
	local X2 = axis_X + length_X * 0.5 
	local Y1 = axis_Y - length_Y * 0.5 
	local Y2 = axis_Y + length_Y * 0.5 

	return X1, X2, Y1, Y2
end

local function sNamePlates_NameplateColoring(r, g, b, a)
	if g + b == 0 then 
		newr = sNamePlates.db.profile.hostileColor.r
		newg = sNamePlates.db.profile.hostileColor.g
		newb = sNamePlates.db.profile.hostileColor.b 
		newa = sNamePlates.db.profile.hostileColor.a	
	elseif r + b == 0 then
		newr = sNamePlates.db.profile.pvpFlaggedColor.r
		newg = sNamePlates.db.profile.pvpFlaggedColor.g
		newb = sNamePlates.db.profile.pvpFlaggedColor.b 
		newa = sNamePlates.db.profile.pvpFlaggedColor.a	
	elseif r + g == 0 then
		newr = sNamePlates.db.profile.nonpvpFlaggedColor.r
		newg = sNamePlates.db.profile.nonpvpFlaggedColor.g
		newb = sNamePlates.db.profile.nonpvpFlaggedColor.b 
		newa = sNamePlates.db.profile.nonpvpFlaggedColor.a
	elseif 2 - (r + g) < 0.2 and b == 0 then
		newr = sNamePlates.db.profile.neutralColor.r
		newg = sNamePlates.db.profile.neutralColor.g
		newb = sNamePlates.db.profile.neutralColor.b 
		newa = sNamePlates.db.profile.neutralColor.a
	else
		newr, newg, newb, newa = r, g, b, a
	end
	return newr, newg, newb, newa
end	

local function sNamePlates_NameplateBorderColoring(self, gr, gg, gb)
	if sNamePlates.db.profile.NMToggle then
		if sNamePlates.db.profile.NMToggleBorderToo then
			if gr > 0.99 and gg == 0 and gb == 0 then 
				self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.NMAttackingColor.r, sNamePlates.db.profile.NMAttackingColor.g, sNamePlates.db.profile.NMAttackingColor.b, sNamePlates.db.profile.NMAttackingColor.a)
				self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.NMAttackingColor.r, sNamePlates.db.profile.NMAttackingColor.g, sNamePlates.db.profile.NMAttackingColor.b, sNamePlates.db.profile.NMAttackingColor.a)
				self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.NMAttackingColor.r, sNamePlates.db.profile.NMAttackingColor.g, sNamePlates.db.profile.NMAttackingColor.b, sNamePlates.db.profile.NMAttackingColor.a)
			elseif gb < 0.5 then
				self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.NMAboutAttackingColor.r, sNamePlates.db.profile.NMAboutAttackingColor.g, sNamePlates.db.profile.NMAboutAttackingColor.b, sNamePlates.db.profile.NMAboutAttackingColor.a)
				self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.NMAboutAttackingColor.r, sNamePlates.db.profile.NMAboutAttackingColor.g, sNamePlates.db.profile.NMAboutAttackingColor.b, sNamePlates.db.profile.NMAboutAttackingColor.a)
				self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.NMAboutAttackingColor.r, sNamePlates.db.profile.NMAboutAttackingColor.g, sNamePlates.db.profile.NMAboutAttackingColor.b, sNamePlates.db.profile.NMAboutAttackingColor.a)
			end
		else 
			self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.healthbarBorderColor.r, sNamePlates.db.profile.healthbarBorderColor.g, sNamePlates.db.profile.healthbarBorderColor.b, sNamePlates.db.profile.healthbarBorderColor.a)
			self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarBorderColor.r, sNamePlates.db.profile.castbarBorderColor.g, sNamePlates.db.profile.castbarBorderColor.b, sNamePlates.db.profile.castbarBorderColor.a)
			self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarIconBorderColor.r, sNamePlates.db.profile.castbarIconBorderColor.g, sNamePlates.db.profile.castbarIconBorderColor.b, sNamePlates.db.profile.castbarIconBorderColor.a)		
		end	
	elseif sNamePlates.db.profile.TMToggle then 
		if gr> 0.99 and gg== 0 and gb == 0 then 
			self.healthbar:SetStatusBarColor(sNamePlates.db.profile.TMAttackingColor.r, sNamePlates.db.profile.TMAttackingColor.g, sNamePlates.db.profile.TMAttackingColor.b, sNamePlates.db.profile.TMAttackingColor.a)
			if sNamePlates.db.profile.TMToggleBorderToo then
				self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.TMAttackingColor.r, sNamePlates.db.profile.TMAttackingColor.g, sNamePlates.db.profile.TMAttackingColor.b, sNamePlates.db.profile.TMAttackingColor.a)
				self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.TMAttackingColor.r, sNamePlates.db.profile.TMAttackingColor.g, sNamePlates.db.profile.TMAttackingColor.b, sNamePlates.db.profile.TMAttackingColor.a)
				self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.TMAttackingColor.r, sNamePlates.db.profile.TMAttackingColor.g, sNamePlates.db.profile.TMAttackingColor.b, sNamePlates.db.profile.TMAttackingColor.a)
			end
		elseif gb < 0.5 then
			self.healthbar:SetStatusBarColor(sNamePlates.db.profile.TMAboutAttackingColor.r, sNamePlates.db.profile.TMAboutAttackingColor.g, sNamePlates.db.profile.TMAboutAttackingColor.b, sNamePlates.db.profile.TMAboutAttackingColor.a)

			if sNamePlates.db.profile.TMToggleBorderToo then
				self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.TMAboutAttackingColor.r, sNamePlates.db.profile.TMAboutAttackingColor.g, sNamePlates.db.profile.TMAboutAttackingColor.b, sNamePlates.db.profile.TMAboutAttackingColor.a)
				self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.TMAboutAttackingColor.r, sNamePlates.db.profile.TMAboutAttackingColor.g, sNamePlates.db.profile.TMAboutAttackingColor.b, sNamePlates.db.profile.TMAboutAttackingColor.a)
				self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.TMAboutAttackingColor.r, sNamePlates.db.profile.TMAboutAttackingColor.g, sNamePlates.db.profile.TMAboutAttackingColor.b, sNamePlates.db.profile.TMAboutAttackingColor.a)
			end
		end	
	end	
	self.oldglowr, self.oldglowg, self.oldglowb = gr, gg, gb
end	

local function sNamePlates_CheckForBorderChange(self)
	if self.oldglow:IsShown() then 
		local glowr, glowg, glowb = self.oldglow:GetVertexColor()
		if not (glowr == self.oldglowr and glowg == self.oldglowg and glowb == self.oldglowb) then 
			sNamePlates_NameplateBorderColoring(self, glowr, glowg, glowb)
			self.borderHidden = true
		end
	else
		if self.borderHidden then 
			if sNamePlates.db.profile.TMToggle then 
				self.healthbar:SetStatusBarColor(sNamePlates_NameplateColoring(self.r, self.g, self.b, self.a))
			end	
			self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.healthbarBorderColor.r, sNamePlates.db.profile.healthbarBorderColor.g, sNamePlates.db.profile.healthbarBorderColor.b, sNamePlates.db.profile.healthbarBorderColor.a)
			self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarBorderColor.r, sNamePlates.db.profile.castbarBorderColor.g, sNamePlates.db.profile.castbarBorderColor.b, sNamePlates.db.profile.castbarBorderColor.a)
			self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarIconBorderColor.r, sNamePlates.db.profile.castbarIconBorderColor.g, sNamePlates.db.profile.castbarIconBorderColor.b, sNamePlates.db.profile.castbarIconBorderColor.a)	
			self.oldglowr, self.oldglowg, self.oldglowb, self.borderHidden = nil, nil, nil, nil
		end
	end	
end

local function sNamePlates_CheckForOptionsChange(self)
	if sNamePlates.db.profile.optionChanged then
		local changed = sNamePlates.db.profile.optionChanged
		if changed == "nameplateColor" then
			self.healthbar:SetStatusBarColor(sNamePlates_NameplateColoring(self.r, self.g, self.b, self.a))
		elseif changed == "nameplateSize" then
			self.healthbar:SetHeight(sNamePlates.db.profile.nameplateHeight)
			self.healthbar:SetWidth(sNamePlates.db.profile.nameplateWidth)
			self.castbar:SetWidth(sNamePlates.db.profile.nameplateWidth)
		elseif changed == "nameplateXY" then
			self.healthbar:SetPoint("CENTER", self.healthbar:GetParent(), sNamePlates.db.profile.nameplateXOffset, sNamePlates.db.profile.nameplateYOffset)
		elseif changed == "nameplateTexture" then
			self.healthbar:SetStatusBarTexture(FetchStatusbar(sNamePlates.db.profile.nameplateTexture))
		elseif changed == "nameplateBorderColor" then 
			self.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.healthbarBorderColor.r, sNamePlates.db.profile.healthbarBorderColor.g, sNamePlates.db.profile.healthbarBorderColor.b, sNamePlates.db.profile.healthbarBorderColor.a)
		elseif changed == "highlightTexture" then
			self.highlight:SetTexture(FetchStatusbar(sNamePlates.db.profile.highlightTexture))
		elseif changed == "highlightColor" then 
			self.highlight:SetVertexColor(sNamePlates.db.profile.highlightColor.r, sNamePlates.db.profile.highlightColor.g, sNamePlates.db.profile.highlightColor.b, sNamePlates.db.profile.highlightColor.a)
		elseif changed == "backgroundTexture" then
			self.hpBackground:SetTexture(FetchStatusbar(sNamePlates.db.profile.backgroundTexture))
		elseif changed == "backgroundColor" then
			self.hpBackground:SetVertexColor(sNamePlates.db.profile.backgroundNameplateColor.r, sNamePlates.db.profile.backgroundNameplateColor.g, sNamePlates.db.profile.backgroundNameplateColor.b, sNamePlates.db.profile.backgroundNameplateColor.a)
		elseif changed == "tarIndicatorSelect" then
			self.rightIndicator:SetTexture(sNamePlates:TargetIndicatorGrabRight())
			self.leftIndicator:SetTexture(sNamePlates:TargetIndicatorGrabLeft())
			if sNamePlates.db.profile.inverseSelect then 
				self.leftIndicator:SetRotation(-3.1416)
				self.rightIndicator:SetRotation(3.1416)
			else
				self.leftIndicator:SetRotation(0)
				self.rightIndicator:SetRotation(0)
			end
		elseif changed == "tarIndicatorSize" then 
			self.rightIndicator:SetWidth(sNamePlates.db.profile.TIWidth)
			self.rightIndicator:SetHeight(sNamePlates.db.profile.TIHeight)
			self.leftIndicator:SetWidth(sNamePlates.db.profile.TIWidth)
			self.leftIndicator:SetHeight(sNamePlates.db.profile.TIHeight)
		elseif changed == "tarIndicatorSeparationAndXY" then
			self.rightIndicator:SetPoint("LEFT", self.healthbar, "RIGHT", sNamePlates.db.profile.TIXOffset + sNamePlates.db.profile.TIseparation , sNamePlates.db.profile.TIYOffset)
			self.leftIndicator:SetPoint("RIGHT", self.healthbar, "LEFT", sNamePlates.db.profile.TIXOffset - sNamePlates.db.profile.TIseparation, sNamePlates.db.profile.TIYOffset)
		elseif changed == "tarIndicatorSeparationColor" then
			self.rightIndicator:SetVertexColor(sNamePlates.db.profile.TIColor.r, sNamePlates.db.profile.TIColor.g, sNamePlates.db.profile.TIColor.b, sNamePlates.db.profile.TIColor.a)
			self.leftIndicator:SetVertexColor(sNamePlates.db.profile.TIColor.r, sNamePlates.db.profile.TIColor.g, sNamePlates.db.profile.TIColor.b, sNamePlates.db.profile.TIColor.a)
		elseif changed == "castbarElementsSizes" then
			self.castbar:SetHeight(sNamePlates.db.profile.castbarHeight)
		elseif changed == "castbarBordersColor" then
			self.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarBorderColor.r, sNamePlates.db.profile.castbarBorderColor.g, sNamePlates.db.profile.castbarBorderColor.b, sNamePlates.db.profile.castbarBorderColor.a)
			self.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarIconBorderColor.r, sNamePlates.db.profile.castbarIconBorderColor.g, sNamePlates.db.profile.castbarIconBorderColor.b, sNamePlates.db.profile.castbarIconBorderColor.a)
		elseif changed == "castbarTexture" then
			self.castbar:SetStatusBarTexture(FetchStatusbar(sNamePlates.db.profile.castbarTexture))
		elseif changed == "castbarBackgroundTexture" then
			self.cbBackground:SetTexture(FetchStatusbar(sNamePlates.db.profile.castbarBackgroundTexture))
		elseif changed == "castbarBackgroundColor" then
			self.cbBackground:SetVertexColor(sNamePlates.db.profile.backgroundCastbarColor.r, sNamePlates.db.profile.backgroundCastbarColor.g, sNamePlates.db.profile.backgroundCastbarColor.b, sNamePlates.db.profile.backgroundCastbarColor.a)
		elseif changed == "RISize" then
			self.raidIcon:SetHeight(sNamePlates.db.profile.RIheight)
			self.raidIcon:SetWidth(sNamePlates.db.profile.RIwidth)
		elseif changed == "RIPosition" then
			self.raidIcon:SetPoint("CENTER", self.healthbar, "CENTER", sNamePlates.db.profile.RIXOffset, sNamePlates.db.profile.RIYOffset)
		elseif changed == "fontColors" then
			self.name:SetTextColor(sNamePlates.db.profile.nameColor.r, sNamePlates.db.profile.nameColor.g, sNamePlates.db.profile.nameColor.b)
			self.hpPercent:SetTextColor(sNamePlates.db.profile.healthPercentColor.r, sNamePlates.db.profile.healthPercentColor.g, sNamePlates.db.profile.healthPercentColor.b, sNamePlates.db.profile.healthPercentColor.a)
			self.hpText:SetTextColor(sNamePlates.db.profile.healthAmmountColor.r, sNamePlates.db.profile.healthAmmountColor.g, sNamePlates.db.profile.healthAmmountColor.b, sNamePlates.db.profile.healthAmmountColor.a)
		elseif changed == "fontName" then
			if sNamePlates.db.profile.nameToggle then 
				self.name:SetFont(FetchFont(sNamePlates.db.profile.nameFont), sNamePlates.db.profile.nameFontSize, sNamePlates.db.profile.nameOutline)
				self.name:Show()
				if sNamePlates.db.profile.shNameSelect  then
					self.name:SetShadowOffset(1.25, -1.25)
				else
					self.name:SetShadowOffset(0, 0)
				end
			else
				self.name:Hide()
			end	 
		elseif changed == "fontHealthPercentAndAmmount" then		
			if sNamePlates.db.profile.healthPercentToggle and sNamePlates.db.profile.healthAmmountToggle then
				self.hpPercent:SetFont(FetchFont(sNamePlates.db.profile.healthPercentFont), sNamePlates.db.profile.healthPercentFontSize, sNamePlates.db.profile.healthPercentOutline)
				self.hpText:SetFont(FetchFont(sNamePlates.db.profile.healthAmmountFont), sNamePlates.db.profile.healthAmmountFontSize, sNamePlates.db.profile.healthAmmountOutline)
				self.hpText:SetPoint("LEFT", self.healthbar, 0, 0)
				self.hpPercent:SetPoint("RIGHT", self.healthbar, 0, 0)
				self.hpPercent:Show()
				self.hpText:Show()
				if sNamePlates.db.profile.shHealthPercentSelect  then
					self.hpPercent:SetShadowOffset(1.25, -1.25)
				else
					self.hpPercent:SetShadowOffset(0, 0)
				end
	
				if sNamePlates.db.profile.shHealthAmmountSelect  then
					self.hpText:SetShadowOffset(1.25, -1.25)
				else
					self.hpText:SetShadowOffset(0, 0)
				end
			elseif sNamePlates.db.profile.healthPercentToggle and not sNamePlates.db.profile.healthAmmountToggle then 
				self.hpPercent:SetFont(FetchFont(sNamePlates.db.profile.healthPercentFont), sNamePlates.db.profile.healthPercentFontSize, sNamePlates.db.profile.healthPercentOutline)
				self.hpPercent:ClearAllPoints()
				self.hpPercent:SetPoint("CENTER", self.healthbar, 0, 0)
				self.hpPercent:Show()
				if sNamePlates.db.profile.shHealthPercentSelect  then
					self.hpPercent:SetShadowOffset(1.25, -1.25)
				else
					self.hpPercent:SetShadowOffset(0, 0)
				end
				self.hpText:Hide()
			elseif not sNamePlates.db.profile.healthPercentToggle and sNamePlates.db.profile.healthAmmountToggle then
				self.hpText:SetFont(FetchFont(sNamePlates.db.profile.healthAmmountFont), sNamePlates.db.profile.healthAmmountFontSize, sNamePlates.db.profile.healthAmmountOutline)
				self.hpText:ClearAllPoints()
				self.hpText:SetPoint("CENTER", self.healthbar, 0, 0)
				self.hpText:Show()
				if sNamePlates.db.profile.shHealthAmmountSelect  then
					self.hpText:SetShadowOffset(1.25, -1.25)
				else
					self.hpText:SetShadowOffset(0, 0)
				end
				self.hpPercent:Hide()
			else
				self.hpPercent:Hide()
				self.hpText:Hide()
			end  
		elseif changed == "fontLevel" then
			if sNamePlates.db.profile.levelToggle then 
				self.level:SetFont(FetchFont(sNamePlates.db.profile.levelFont), sNamePlates.db.profile.levelFontSize, sNamePlates.db.profile.levelOutline)
				self.level:Show()
				if sNamePlates.db.profile.shLevelSelect then 
					self.level:SetShadowOffset(1.25, -1.25)
				else
					self.level:SetShadowOffset(0, 0)
				end
			else
				self.level:Hide()
			end	 
		elseif changed == "specialIcons" then
			iconFound, iconPath = sNamePlates:iconsDB(self.name:GetText())
			if sNamePlates.db.profile.iconsToggle and iconFound then
				self.hpPercent:Hide()
				self.hpText:Hide()

				--Nameplate Coloring
				self.healthbar:SetStatusBarColor(0, 0, 0, 0)

				--Healthbar points
				self.healthbar:SetPoint("CENTER", self.healthbar:GetParent(), sNamePlates.db.profile.iconXOffset, sNamePlates.db.profile.iconYOffset)

				--Icon
				self.specialIcon:SetPoint("CENTER", self.healthbar:GetParent(), sNamePlates.db.profile.iconXOffset, sNamePlates.db.profile.iconYOffset)
				self.specialIcon:SetWidth(sNamePlates.db.profile.iconWidth)
				self.specialIcon:SetHeight(sNamePlates.db.profile.iconHeight)
				self.specialIcon:SetTexCoord(IconScaling(sNamePlates.db.profile.iconWidth, sNamePlates.db.profile.iconHeight))			
				self.specialIcon:SetTexture(iconPath)	
				self.specialIcon:Show()

				self.healthbar:SetHeight(sNamePlates.db.profile.iconHeight)
				self.healthbar:SetWidth(sNamePlates.db.profile.iconWidth)
	
				self.level:Hide()
				self.name:Hide()
			end
		end 
	end
end

local sNamePlates_FormatHealthText
do
    local function sNamePlates_Shorten(num)
        local res

        if num > 1000000000 then
            res = format("%02.3fB", num / 1000000000)
        elseif num > 1000000 then
            res = format("%02.2fM", num / 1000000)
        elseif num > 1000 then
            res = format("%02.1fK", num / 1000)
        else
            res = math_floor(num)
        end

        return res
    end

    function sNamePlates_FormatHealthText(self)
        if not self or not self.healthbar then
            return
        end

        if sNamePlates.db.profile.healthPercentToggle or sNamePlates.db.profile.healthAmmountToggle then
            local minval, maxval = self.healthbar:GetMinMaxValues()
            local curval = self.healthbar:GetValue()

          	if sNamePlates.db.profile.healthAmmountToggle then
				if sNamePlates.db.profile.infoIfFullSelect then
                	self.hpText:SetText(true and sNamePlates_Shorten(curval) or curval)
				else
					if 100 * curval / math_max(1, maxval) == 100.0 then 
						self.hpText:SetText("")
					else
						self.hpText:SetText(true and sNamePlates_Shorten(curval) or curval)
					end
				end
            end

            if sNamePlates.db.profile.healthPercentToggle then
                if sNamePlates.db.profile.infoIfFullSelect then
                    self.hpPercent:SetText(_format("%02.1f%%", 100 * curval / math_max(1, maxval)))
                else 
                    if 100 * curval / math_max(1, maxval) == 100.0 then
                        self.hpPercent:SetText("")
                    else
                        self.hpPercent:SetText(_format("%02.1f%%", 100 * curval / math_max(1, maxval)))
                    end 
                end 
            end
        end
    end
end

local function sNamePlates_FrameOnUpdate(self, elapsed)
	self.elapsed = self.elapsed + elapsed
	if self.elapsed >= 0.025 then
		--Health Format
		self:FormatHealthText()	

		--Options Update
		if ACD.OpenFrames["sNamePlates"] then
			self:CheckForOptionsChange()
		end

		--NM - TM
		self:CheckForBorderChange()

		--On target
		if targetExist and self:GetAlpha() == 1 then	
			self.highlight:Hide()
			if sNamePlates.db.profile.tarIndicatorToggle then
				self.leftIndicator:Show()
				self.rightIndicator:Show()
			else
				self.leftIndicator:Hide()
				self.rightIndicator:Hide()
			end
		else
		 	self.leftIndicator:Hide()
			self.rightIndicator:Hide() 
			--if targetExist then
			--	if sNamePlates.db.profile.alphaToggle then
			--	self:SetAlpha(sNamePlates.db.profile.alphaValue)      **disabled since the addon is not running frame by frame
			--	end	
			--end
		end 
		self.elapsed = 0
	end
end

local function sNamePlates_UpdateFrame(self)
	self.specialIcon:Hide()

	--Nameplate Coloring
	self.r, self.g, self.b, self.a = self.healthbar:GetStatusBarColor()
	--print(self.r.." - "..self.g.." - "..self.b.." - "..self.a)
	self.healthbar:SetStatusBarColor(sNamePlates_NameplateColoring(self.r, self.g, self.b, self.a))

 	self.leftIndicator:Hide()
	self.rightIndicator:Hide()  

	--NM - TM
	self:CheckForBorderChange()

 	--Healthbar
	self.healthbar:SetStatusBarTexture(FetchStatusbar(sNamePlates.db.profile.nameplateTexture))
	self.healthbar:SetHeight(sNamePlates.db.profile.nameplateHeight)
	self.healthbar:SetWidth(sNamePlates.db.profile.nameplateWidth)
	self.healthbar:ClearAllPoints()
	self.healthbar:SetPoint("CENTER", self.healthbar:GetParent(), sNamePlates.db.profile.nameplateXOffset, sNamePlates.db.profile.nameplateYOffset)

	--Highlight
	self.highlight:ClearAllPoints()
	self.highlight:SetAllPoints(self.healthbar) 

	--Castbar
	self.castbar:SetStatusBarTexture(FetchStatusbar(sNamePlates.db.profile.nameplateTexture))
	self.castbar:SetHeight(sNamePlates.db.profile.castbarHeight)
	self.castbar:SetWidth(sNamePlates.db.profile.nameplateWidth)

	--Healthbar Name
	self.name:SetFont(FetchFont(sNamePlates.db.profile.nameFont), sNamePlates.db.profile.nameFontSize, sNamePlates.db.profile.nameOutline)
	self.name:SetTextColor(sNamePlates.db.profile.nameColor.r, sNamePlates.db.profile.nameColor.g, sNamePlates.db.profile.nameColor.b)
	self.name:SetText(self.oldname:GetText())
	self.name:SetPoint("BOTTOMLEFT", self.healthbar, "TOPLEFT", -2, 3)
	self.name:SetPoint("RIGHT", self.healthbar, -18, 3)
	if sNamePlates.db.profile.nameToggle then 
		self.name:Show()
	else
		self.name:Hide()
	end	 

	--Health Percent and Health Ammount
	self.hpPercent:SetFont(FetchFont(sNamePlates.db.profile.healthPercentFont), sNamePlates.db.profile.healthPercentFontSize, sNamePlates.db.profile.healthPercentOutline)
	self.hpText:SetFont(FetchFont(sNamePlates.db.profile.healthAmmountFont), sNamePlates.db.profile.healthAmmountFontSize, sNamePlates.db.profile.healthAmmountOutline)
	self.hpPercent:SetTextColor(sNamePlates.db.profile.healthPercentColor.r, sNamePlates.db.profile.healthPercentColor.g, sNamePlates.db.profile.healthPercentColor.b, sNamePlates.db.profile.healthPercentColor.a)
	self.hpText:SetTextColor(sNamePlates.db.profile.healthAmmountColor.r, sNamePlates.db.profile.healthAmmountColor.g, sNamePlates.db.profile.healthAmmountColor.b, sNamePlates.db.profile.healthAmmountColor.a)
	
	if sNamePlates.db.profile.healthPercentToggle and sNamePlates.db.profile.healthAmmountToggle then
		self.hpPercent:Show()
		self.hpText:Show()
	elseif sNamePlates.db.profile.healthPercentToggle and not sNamePlates.db.profile.healthAmmountToggle then 
		self.hpPercent:Show()
		self.hpText:Hide()
	elseif not sNamePlates.db.profile.healthPercentToggle and sNamePlates.db.profile.healthAmmountToggle then
		self.hpPercent:Hide()
		self.hpText:Show()
	else
		self.hpPercent:Hide()
		self.hpText:Hide()
	end  

	--Healthbar Percent and Ammount points
	if sNamePlates.db.profile.healthPercentToggle and sNamePlates.db.profile.healthAmmountToggle then
		self.hpText:SetPoint("LEFT", self.healthbar, 0, 0)
		self.hpPercent:SetPoint("RIGHT", self.healthbar, 0, 0)
	elseif sNamePlates.db.profile.healthPercentToggle and not sNamePlates.db.profile.healthAmmountToggle then 
		self.hpPercent:SetPoint("CENTER", 0, 0)
	elseif not sNamePlates.db.profile.healthPercentToggle and sNamePlates.db.profile.healthAmmountToggle then
		self.hpText:SetPoint("CENTER", 0, 0)
	end  

	--Raid Icon
	self.raidIcon:SetHeight(sNamePlates.db.profile.RIheight)
	self.raidIcon:SetWidth(sNamePlates.db.profile.RIwidth)
	self.raidIcon:ClearAllPoints()
	self.raidIcon:SetPoint("CENTER", self.healthbar, "CENTER", sNamePlates.db.profile.RIXOffset, sNamePlates.db.profile.RIYOffset)

	--Target Indicator
	if sNamePlates.db.profile.inverseSelect then 
		self.leftIndicator:SetRotation(-3.1416)
		self.rightIndicator:SetRotation(3.1416)
	else
		self.leftIndicator:SetRotation(0)
		self.rightIndicator:SetRotation(0)
	end

	self.rightIndicator:SetWidth(sNamePlates.db.profile.TIWidth)
	self.rightIndicator:SetHeight(sNamePlates.db.profile.TIHeight)
	self.leftIndicator:SetWidth(sNamePlates.db.profile.TIWidth)
	self.leftIndicator:SetHeight(sNamePlates.db.profile.TIHeight)

	self.rightIndicator:SetPoint("LEFT", self.healthbar, "RIGHT", sNamePlates.db.profile.TIXOffset + sNamePlates.db.profile.TIseparation , sNamePlates.db.profile.TIYOffset)
	self.leftIndicator:SetPoint("RIGHT", self.healthbar, "LEFT", sNamePlates.db.profile.TIXOffset - sNamePlates.db.profile.TIseparation, sNamePlates.db.profile.TIYOffset)

	self.rightIndicator:SetVertexColor(sNamePlates.db.profile.TIColor.r, sNamePlates.db.profile.TIColor.g, sNamePlates.db.profile.TIColor.b, sNamePlates.db.profile.TIColor.a)
	self.leftIndicator:SetVertexColor(sNamePlates.db.profile.TIColor.r, sNamePlates.db.profile.TIColor.g, sNamePlates.db.profile.TIColor.b, sNamePlates.db.profile.TIColor.a)

	local level, elite, mylevel = tonumber(self.level:GetText()), self.elite:IsShown(), UnitLevel("player")
	self.level:ClearAllPoints()
	self.level:SetPoint("BOTTOMRIGHT", self.healthbar, "TOPRIGHT", 3, 3)

	if self.boss:IsShown() then
		self.level:SetText("B")
		self.level:SetTextColor(1, 0, 0)
	elseif not elite and level == mylevel then
		--self.level:Hide()
	else
		self.level:SetText(level..(elite and "+" or ""))
	end 

	if sNamePlates.db.profile.levelToggle then
		self.level:Show()
	else
		self.level:Hide()
	end

	--Icon
	iconFound, iconPath = sNamePlates:iconsDB(self.name:GetText())
	if sNamePlates.db.profile.iconsToggle and iconFound then
		self.hpPercent:Hide()
		self.hpText:Hide()

		self.healthbar:SetStatusBarColor(0, 0, 0, 0)
		
		self.healthbar:SetPoint("CENTER", self.healthbar:GetParent(), sNamePlates.db.profile.iconXOffset, sNamePlates.db.profile.iconYOffset)
		self.specialIcon:SetPoint("CENTER", self.healthbar:GetParent(), sNamePlates.db.profile.iconXOffset, sNamePlates.db.profile.iconYOffset)

		self.specialIcon:SetWidth(sNamePlates.db.profile.iconWidth)
		self.specialIcon:SetHeight(sNamePlates.db.profile.iconHeight)
		self.specialIcon:SetTexCoord(IconScaling(sNamePlates.db.profile.iconWidth, sNamePlates.db.profile.iconHeight))	
		self.specialIcon:SetTexture(iconPath)
		self.specialIcon:Show()
		
		self.healthbar:SetHeight(sNamePlates.db.profile.iconHeight)
		self.healthbar:SetWidth(sNamePlates.db.profile.iconWidth)

		self.level:Hide()
		self.name:Hide()
	end
end

local function sNamePlates_OnHide(self)
	self.highlight:Hide()
	self.oldglowr, self.oldglowg, self.oldglowb, self.borderHidden = nil, nil, nil, nil
end

local function sNamePlates_CreateFrame(frame)
	if frame.done then
		return
	end

	local healthBar, castBar = frame:GetChildren()
	local glowRegion, overlayRegion, shieldedRegion, castbarOverlay, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = frame:GetRegions()

	frame.oldname = nameTextRegion
	frame.oldname:Hide()

	spellIconRegion:Hide()
	
	local newNameRegion = frame:CreateFontString()
	newNameRegion:SetJustifyH("LEFT")
	newNameRegion:SetPoint("BOTTOM", healthBar, "TOP", 0, 2)
	if sNamePlates.db.profile.shNameSelect  then
		newNameRegion:SetShadowOffset(1.25, -1.25)
	else
		newNameRegion:SetShadowOffset(0, 0)
	end

	frame.name = newNameRegion

	frame.level = levelTextRegion
	frame.level:SetFont(FetchFont(sNamePlates.db.profile.levelFont), sNamePlates.db.profile.levelFontSize, sNamePlates.db.profile.levelOutline)
	if sNamePlates.db.profile.shLevelSelect then 
		frame.level:SetShadowOffset(1.25, -1.25)
	else
		frame.level:SetShadowOffset(0, 0)
	end
	frame.level:SetJustifyH("RIGHT")
    frame.level:SetJustifyV("BOTTOM")

	glowRegion:SetTexture(nil)
	overlayRegion:SetTexture(nil)
	castbarOverlay:SetTexture(nil)
	stateIconRegion:SetTexture(nil)
	bossIconRegion:SetTexture(nil)
	shieldedRegion:SetTexture(nil)

	frame.highlight = highlightRegion
	frame.highlight:SetTexture(FetchStatusbar(sNamePlates.db.profile.highlightTexture))
	frame.highlight:SetVertexColor(sNamePlates.db.profile.highlightColor.r, sNamePlates.db.profile.highlightColor.g, sNamePlates.db.profile.highlightColor.b, sNamePlates.db.profile.highlightColor.a)

	frame.healthbar = healthBar
	frame.healthbar:SetStatusBarTexture(FetchStatusbar(sNamePlates.db.profile.nameplateTexture))
	frame.healthbar:ClearAllPoints()
	frame.healthbar:SetPoint("CENTER", healthBar:GetParent(), sNamePlates.db.profile.nameplateXOffset, sNamePlates.db.profile.nameplateYOffset)

	raidIconRegion:ClearAllPoints()
	raidIconRegion:SetHeight(sNamePlates.db.profile.RIheight)
	raidIconRegion:SetWidth(sNamePlates.db.profile.RIwidth)
	raidIconRegion:SetPoint("CENTER", frame.healthbar, "CENTER", sNamePlates.db.profile.RIXOffset, sNamePlates.db.profile.RIYOffset)

	castBar:SetScript("OnShow", function() 
		castBar:SetStatusBarTexture(FetchStatusbar(sNamePlates.db.profile.nameplateTexture))
		castBar:SetHeight(sNamePlates.db.profile.castbarHeight)
		castBar:SetWidth(sNamePlates.db.profile.nameplateWidth)
		castBar:SetPoint("BOTTOM", frame.healthbar, "CENTER", -2, -20)
	end)

	frame.castbar = castBar

 	frame.castbarIcon = CreateFrame("Frame", nil, frame.castbar)
	frame.castbarIcon:SetHeight(35)
	frame.castbarIcon:SetWidth(35)
	frame.castbarIcon:SetPoint("BOTTOMLEFT", frame.castbar, "RIGHT", sNamePlates.db.profile.nameplateHeight/2, -sNamePlates.db.profile.nameplateHeight/2) 

	frame.castbarIcon.Texture = spellIconRegion
	frame.castbarIcon.Texture:SetAllPoints(frame.castbarIcon)
	frame.castbarIcon.Texture:SetTexCoord(IconScaling(frame.castbarIcon:GetWidth(),frame.castbarIcon:GetHeight()))

	frame.hpBackground = healthBar:CreateTexture(nil, "BORDER")
	frame.hpBackground:SetAllPoints(healthBar)
	frame.hpBackground:SetTexture(FetchStatusbar(sNamePlates.db.profile.backgroundTexture))
	frame.hpBackground:SetVertexColor(sNamePlates.db.profile.backgroundNameplateColor.r, sNamePlates.db.profile.backgroundNameplateColor.g, sNamePlates.db.profile.backgroundNameplateColor.b, sNamePlates.db.profile.backgroundNameplateColor.a)

	frame.cbBackground = frame.castbar:CreateTexture(nil, "BORDER")
	frame.cbBackground:SetAllPoints(frame.castbar)
	frame.cbBackground:SetTexture(FetchStatusbar(sNamePlates.db.profile.castbarBackgroundTexture))
	frame.cbBackground:SetVertexColor(sNamePlates.db.profile.backgroundCastbarColor.r, sNamePlates.db.profile.backgroundCastbarColor.g, sNamePlates.db.profile.backgroundCastbarColor.b, sNamePlates.db.profile.backgroundCastbarColor.a)

	frame.hpGlow = CreateFrame("Frame", nil, frame.healthbar)
	frame.hpGlow:SetPoint("TOPLEFT", frame.healthbar, "TOPLEFT", -5, 5)
	frame.hpGlow:SetPoint("BOTTOMRIGHT", frame.healthbar, "BOTTOMRIGHT", 5, -5)
	frame.hpGlow:SetBackdrop(backdrop)
	frame.hpGlow:SetBackdropColor(sNamePlates.db.profile.healthbarBorderColor.r, sNamePlates.db.profile.healthbarBorderColor.g, sNamePlates.db.profile.healthbarBorderColor.b, sNamePlates.db.profile.healthbarBorderColor.a)
	frame.hpGlow:SetBackdropBorderColor(sNamePlates.db.profile.healthbarBorderColor.r, sNamePlates.db.profile.healthbarBorderColor.g, sNamePlates.db.profile.healthbarBorderColor.b, sNamePlates.db.profile.healthbarBorderColor.a)
	
	frame.cbGlow = CreateFrame("Frame", nil, frame.castbar)
	frame.cbGlow:SetPoint("TOPLEFT", frame.castbar, "TOPLEFT", -5, 5)
	frame.cbGlow:SetPoint("BOTTOMRIGHT", frame.castbar, "BOTTOMRIGHT", 5, -5)
	frame.cbGlow:SetBackdrop(backdrop)
	frame.cbGlow:SetBackdropColor(sNamePlates.db.profile.castbarBorderColor.r, sNamePlates.db.profile.castbarBorderColor.g, sNamePlates.db.profile.castbarBorderColor.b, sNamePlates.db.profile.castbarBorderColor.a)
	frame.cbGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarBorderColor.r, sNamePlates.db.profile.castbarBorderColor.g, sNamePlates.db.profile.castbarBorderColor.b, sNamePlates.db.profile.castbarBorderColor.a)
		
	frame.castbarIconGlow = CreateFrame("Frame", nil, frame.castbar)
	frame.castbarIconGlow:SetPoint("TOPLEFT", frame.castbarIcon, "TOPLEFT", -5, 5)
	frame.castbarIconGlow:SetPoint("BOTTOMRIGHT", frame.castbarIcon, "BOTTOMRIGHT", 5, -5)
    frame.castbarIconGlow:SetBackdrop(backdrop)
    frame.castbarIconGlow:SetBackdropColor(sNamePlates.db.profile.castbarIconBorderColor.r, sNamePlates.db.profile.castbarIconBorderColor.g, sNamePlates.db.profile.castbarIconBorderColor.b, sNamePlates.db.profile.castbarIconBorderColor.a)
	frame.castbarIconGlow:SetBackdropBorderColor(sNamePlates.db.profile.castbarIconBorderColor.r, sNamePlates.db.profile.castbarIconBorderColor.g, sNamePlates.db.profile.castbarIconBorderColor.b, sNamePlates.db.profile.castbarIconBorderColor.a)

 	local hp = CreateFrame("Frame", nil, frame.healthbar)
    hp:SetHeight(1)
    hp:SetFrameLevel(frame.healthbar:GetFrameLevel() + 1)
	hp:SetPoint("CENTER", 0, 0)
    hp.text = hp:CreateFontString(nil, "OVERLAY")
	hp.text:SetPoint("CENTER")
    hp.text:SetFont(FetchFont(sNamePlates.db.profile.healthAmmountFont), sNamePlates.db.profile.healthAmmountFontSize, sNamePlates.db.profile.healthAmmountOutline)
    hp.text:SetTextColor(sNamePlates.db.profile.healthAmmountColor.r, sNamePlates.db.profile.healthAmmountColor.g, sNamePlates.db.profile.healthAmmountColor.b, sNamePlates.db.profile.healthAmmountColor.a)
	if sNamePlates.db.profile.shHealthAmmountSelect  then
		hp.text:SetShadowOffset(1.25, -1.25)
	else
		hp.text:SetShadowOffset(0, 0)
	end
    hp.text:SetJustifyH("CENTER")
    hp.text:SetJustifyV("MIDDLE")
    hp.text:Hide()
    frame.hpText = hp.text 

	local percent = CreateFrame("Frame", nil, frame.healthbar)
    percent:SetHeight(1)
	percent:SetFrameLevel(frame.healthbar:GetFrameLevel() + 1)
	percent:SetPoint("CENTER", 0, 0)
    percent.text = percent:CreateFontString(nil, "OVERLAY")
    percent.text:SetPoint("CENTER")
    percent.text:SetFont(FetchFont(sNamePlates.db.profile.healthPercentFont), sNamePlates.db.profile.healthPercentFontSize, sNamePlates.db.profile.healthPercentOutline)
    percent.text:SetTextColor(sNamePlates.db.profile.healthPercentColor.r, sNamePlates.db.profile.healthPercentColor.g, sNamePlates.db.profile.healthPercentColor.b, sNamePlates.db.profile.healthPercentColor.a)
	if sNamePlates.db.profile.shHealthPercentSelect  then
		percent.text:SetShadowOffset(1.25, -1.25)
	else
		percent.text:SetShadowOffset(0, 0)
	end
    percent.text:SetJustifyH("CENTER")
    percent.text:SetJustifyV("MIDDLE")
    percent.text:Hide()
    frame.hpPercent = percent.text

	frame.FormatHealthText = sNamePlates_FormatHealthText
	frame.CheckForOptionsChange = sNamePlates_CheckForOptionsChange
	frame.CheckForBorderChange = sNamePlates_CheckForBorderChange

	hp:SetWidth(hp.text:GetWidth())
    percent:SetWidth(percent.text:GetWidth())

	local right = frame:CreateTexture(nil, "BACKGROUND")
	right:SetWidth(20)
	right:SetHeight(20)
	right:SetTexture(sNamePlates:TargetIndicatorGrabRight())
    right:SetPoint("LEFT", frame.healthbar, "RIGHT", -3, 0)
    right:Hide()

    local left = frame:CreateTexture(nil, "BACKGROUND")
	left:SetWidth(20)
	left:SetHeight(20)
	left:SetTexture(sNamePlates:TargetIndicatorGrabLeft())
    left:SetPoint("RIGHT", frame.healthbar, "LEFT", 3, 0)
    left:Hide()

	local SI = frame:CreateTexture(nil, "BACKGROUND")
	SI:SetWidth(sNamePlates.db.profile.iconWidth)
	SI:SetHeight(sNamePlates.db.profile.iconHeight)
	SI:SetTexCoord(IconScaling(sNamePlates.db.profile.iconWidth, sNamePlates.db.profile.iconHeight))
	SI:SetPoint("CENTER", frame.healthbar, "CENTER", sNamePlates.db.profile.iconXOffset, sNamePlates.db.profile.iconYOffset)
	SI:Hide()

	frame.rightIndicator = right
    frame.leftIndicator = left 
	
	frame.specialIcon = SI

	frame.oldglow = glowRegion
	frame.elite = stateIconRegion
	frame.boss = bossIconRegion
	frame.raidIcon = raidIconRegion

	frame.done = true

	sNamePlates_UpdateFrame(frame)

	frame.elapsed = 0

	frame:SetScript("OnShow", sNamePlates_UpdateFrame)
	frame:SetScript("OnHide", sNamePlates_OnHide)
	frame:SetScript("OnUpdate", sNamePlates_FrameOnUpdate)
end

function sNamePlates_OnUpdate(self, elapsed)
    lastUpdate = lastUpdate + elapsed
	if lastUpdate > 0.025 then
        lastUpdate = 0
		for i = 1, select("#", WorldFrame:GetChildren()) do
			frame = select(i, WorldFrame:GetChildren())
			if sNamePlates_IsValidFrame(frame) then
				sNamePlates_CreateFrame(frame)
			end
		end	
    end  
end

function FetchFont(fontkey)
	return LSM:Fetch("font", fontkey)
end 	

function FetchStatusbar(statuskey)
	return LSM:Fetch("statusbar", statuskey)
end 	

function sNamePlates:PLAYER_TARGET_CHANGED() 
	targetExist = UnitExists("target")
end

function sNamePlates:PLAYER_REGEN_DISABLED()
end

function sNamePlates:PLAYER_REGEN_ENABLED()
end

function sNamePlates:OpenOptions()
	ACD:SetDefaultSize("sNamePlates", 720, 600)
	sNamePlates.db.profile.optionChanged = nil
	if not ACD:Close("sNamePlates") then
		ACD:Open("sNamePlates")
	end
end

function sNamePlates:RNamePlateColors()
	sNamePlates.db.profile.pvpFlaggedColor = {["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1}
	sNamePlates.db.profile.nonpvpFlaggedColor = {["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1}
	sNamePlates.db.profile.neutralColor = {["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1}
	sNamePlates.db.profile.hostileColor = {["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1}
end

function sNamePlates:RTextColors()
	if sNamePlates.db.profile.nameToggle then
		sNamePlates.db.profile.nameColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1}
	end
	if sNamePlates.db.profile.healthPercentToggle then
		sNamePlates.db.profile.healthPercentColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1}
	end
	if sNamePlates.db.profile.healthAmmountToggle  then
		sNamePlates.db.profile.healthAmmountColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1}
	end
end

function sNamePlates:RHighlightColors()
	sNamePlates.db.profile.highlightColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 1}
end

function sNamePlates:RNPBackgroundColors()
	sNamePlates.db.profile.backgroundNameplateColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 0}
end	

function sNamePlates:RCBBackgroundColors()
	sNamePlates.db.profile.backgroundCastbarColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 0}
end	

function sNamePlates:RHBBorderColors()
	sNamePlates.db.profile.healthbarBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1}
end

function sNamePlates:RCBBorderColors()
	sNamePlates.db.profile.castbarBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1}
	sNamePlates.db.profile.castbarIconBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1}
end

function sNamePlates:RABOColors()
	sNamePlates.db.profile.NMAttackingColor = {["r"] = 0.99, ["g"] = 0, ["b"] = 0, ["a"] = 1}
	sNamePlates.db.profile.NMAboutAttackingColor = {["r"] = 0.99, ["g"] = 0.99, ["b"] = 0.47, ["a"] = 1}
end

function sNamePlates:RTMColors()
	sNamePlates.db.profile.TMAttackingColor = {["r"] = 0.29, ["g"] = 0.69, ["b"] = 0.30, ["a"] = 1}
	sNamePlates.db.profile.TMAboutAttackingColor = {["r"] = 0.92, ["g"] = 0.64, ["b"] = 0.16, ["a"] = 1}
end

function sNamePlates:RTIColors()
	sNamePlates.db.profile.TIColor = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1}
end

function sNamePlates:TargetIndicatorGrabLeft()
	local c = sNamePlates.db.profile.tarIndicatorSelect
	if c == 1 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowDoubleLeft]]	
	elseif c == 2 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowCompositeLeft]]
	elseif c == 3 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowBrokenLeft]]
	elseif c == 4 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowFullLeft]]
	elseif c == 5 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowThinLeft]]
	elseif c == 6 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\BracketLeft]]
	elseif c == 7 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\BracketThinLeft]]
	elseif c == 8 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowLeft]]
	elseif c == 9 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\HelloKittyLeft]]
	end	
end

function sNamePlates:TargetIndicatorGrabRight()
	local c = sNamePlates.db.profile.tarIndicatorSelect
	if c == 1 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowDoubleRight]]
	elseif c == 2 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowCompositeRight]]
	elseif c == 3 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowBrokenRight]]
	elseif c == 4 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowFullRight]]
	elseif c == 5 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowThinRight]]
	elseif c == 6 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\BracketRight]]
	elseif c == 7 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\BracketThinRight]]
	elseif c == 8 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\ArrowRight]]
	elseif c == 9 then
		return [[Interface\AddOns\sNamePlates\Media\Textures\TargetIndicator\HelloKittyRight]]
	end	
end

local function iconsDB_Name(SpellID)
	return (select(1, GetSpellInfo(SpellID)))
end

local function iconsDB_Icon(SpellID)
	return (select(3, GetSpellInfo(SpellID)))
end

local totem_DB = {
	--Air Totems
	[iconsDB_Name(8177)] = {iconsDB_Icon(8177), 1},
	["Nature Resistance Totem I"] = {iconsDB_Icon(10595), 1},
	["Nature Resistance Totem II"] = {iconsDB_Icon(10600), 1},
	["Nature Resistance Totem III"] = {iconsDB_Icon(10601), 1},
	["Nature Resistance Totem IV"] = {iconsDB_Icon(25574), 1},
	["Nature Resistance Totem V"] = {iconsDB_Icon(58746), 1},
	["Nature Resistance Totem VI"] = {iconsDB_Icon(58749), 1},
	[iconsDB_Name(6495)] = {iconsDB_Icon(6495), 1},
	[iconsDB_Name(8512)] = {iconsDB_Icon(8512), 1},
	[iconsDB_Name(3738)] = {iconsDB_Icon(3738), 1},
	--Earth Totems
	[iconsDB_Name(2062)] = {iconsDB_Icon(2062), 2},
	[iconsDB_Name(2484)] = {iconsDB_Icon(2484), 2},
	["Stoneclaw Totem I"] = {iconsDB_Icon(5730), 2},
	["Stoneclaw Totem II"] = {iconsDB_Icon(6390), 2},
	["Stoneclaw Totem III"] = {iconsDB_Icon(6391), 2},
	["Stoneclaw Totem IV"] = {iconsDB_Icon(6392), 2},
	["Stoneclaw Totem V"] = {iconsDB_Icon(10427), 2},
	["Stoneclaw Totem VI"] = {iconsDB_Icon(10428), 2},
	["Stoneclaw Totem VII"] = {iconsDB_Icon(25525), 2},
	["Stoneclaw Totem VIII"] = {iconsDB_Icon(58580), 2},
	["Stoneclaw Totem IX"] = {iconsDB_Icon(58581), 2},
	["Stoneclaw Totem X"] = {iconsDB_Icon(58582), 2},
	["Stoneskin Totem I"] = {iconsDB_Icon(8071), 2},
	["Stoneskin Totem II"] = {iconsDB_Icon(8154), 2},
	["Stoneskin Totem III"] = {iconsDB_Icon(8155), 2},
	["Stoneskin Totem IV"] = {iconsDB_Icon(10406), 2},
	["Stoneskin Totem V"] = {iconsDB_Icon(10407), 2},
	["Stoneskin Totem VI"] = {iconsDB_Icon(10408), 2},
	["Stoneskin Totem VII"] = {iconsDB_Icon(25508), 2},
	["Stoneskin Totem VIII"] = {iconsDB_Icon(25509), 2},
	["Stoneskin Totem IX"] = {iconsDB_Icon(58751), 2},
	["Stoneskin Totem X"] = {iconsDB_Icon(58753), 2},
	["Strength of Earth Totem I"] = {iconsDB_Icon(8075), 2},
	["Strength of Earth Totem II"] = {iconsDB_Icon(8160), 2},
	["Strength of Earth Totem III"] = {iconsDB_Icon(8161), 2},
	["Strength of Earth Totem IV"] = {iconsDB_Icon(10442), 2},
	["Strength of Earth Totem V"] = {iconsDB_Icon(25361), 2},
	["Strength of Earth Totem VI"] = {iconsDB_Icon(25528), 2},
	["Strength of Earth Totem VII"] = {iconsDB_Icon(57622), 2},
	["Strength of Earth Totem VIII"] = {iconsDB_Icon(58643), 2},
	[iconsDB_Name(8143)] = {iconsDB_Icon(8143), 2},
	--Fire Totems
	[iconsDB_Name(2894)] = {iconsDB_Icon(2894), 3},
	["Flametongue Totem I"] = {iconsDB_Icon(8227), 3},
	["Flametongue Totem II"] = {iconsDB_Icon(8249), 3},
	["Flametongue Totem III"] = {iconsDB_Icon(10526), 3},
	["Flametongue Totem IV"] = {iconsDB_Icon(16387), 3},
	["Flametongue Totem V"] = {iconsDB_Icon(25557), 3},
	["Flametongue Totem VI"] = {iconsDB_Icon(58649), 3},
	["Flametongue Totem VII"] = {iconsDB_Icon(58652), 3},
	["Flametongue Totem VIII"] = {iconsDB_Icon(58656), 3},
	["Frost Resistance Totem I"] = {iconsDB_Icon(8181), 3},
	["Frost Resistance Totem II"] = {iconsDB_Icon(10478), 3},
	["Frost Resistance Totem III"] = {iconsDB_Icon(10479), 3},
	["Frost Resistance Totem IV"] = {iconsDB_Icon(25560), 3},
	["Frost Resistance Totem V"] = {iconsDB_Icon(58741), 3},
	["Frost Resistance Totem VI"] = {iconsDB_Icon(58745), 3},
	["Magma Totem I"] = {iconsDB_Icon(8190), 3},
	["Magma Totem II"] = {iconsDB_Icon(10585), 3},
	["Magma Totem III"] = {iconsDB_Icon(10586), 3},
	["Magma Totem IV"] = {iconsDB_Icon(10587), 3},
	["Magma Totem V"] = {iconsDB_Icon(25552), 3},
	["Magma Totem VI"] = {iconsDB_Icon(58731), 3},
	["Magma Totem VII"] = {iconsDB_Icon(58734), 3},
	["Searing Totem I"] = {iconsDB_Icon(3599), 3},
	["Searing Totem II"] = {iconsDB_Icon(6363), 3},
	["Searing Totem III"] = {iconsDB_Icon(6364), 3},
	["Searing Totem IV"] = {iconsDB_Icon(6365), 3},
	["Searing Totem V"] = {iconsDB_Icon(10437), 3},
	["Searing Totem VI"] = {iconsDB_Icon(10438), 3},
	["Searing Totem VII"] = {iconsDB_Icon(25533), 3},
	["Searing Totem VIII"] = {iconsDB_Icon(58699), 3},
	["Searing Totem IX"] = {iconsDB_Icon(58703), 3},
	["Searing Totem X"] = {iconsDB_Icon(58704), 3},
	["Totem of Wrath I"] = {iconsDB_Icon(30706), 3},
	["Totem of Wrath II"] = {iconsDB_Icon(57720), 3},
	["Totem of Wrath III"] = {iconsDB_Icon(57721), 3},
	["Totem of Wrath IV"] = {iconsDB_Icon(57722), 3},
	--Water Totems
	[iconsDB_Name(8170)] = {iconsDB_Icon(8170), 4},
	["Fire Resistance Totem I"] = {iconsDB_Icon(8184), 4},
	["Fire Resistance Totem II"] = {iconsDB_Icon(10537), 4},
	["Fire Resistance Totem III"] = {iconsDB_Icon(10538), 4},
	["Fire Resistance Totem IV"] = {iconsDB_Icon(25563), 4},
	["Fire Resistance Totem V"] = {iconsDB_Icon(58737), 4},
	["Fire Resistance Totem VI"] = {iconsDB_Icon(58739), 4},
	["Healing Stream Totem I"] = {iconsDB_Icon(5394), 4},
	["Healing Stream Totem II"] = {iconsDB_Icon(6375), 4},
	["Healing Stream Totem III"] = {iconsDB_Icon(6377), 4},
	["Healing Stream Totem IV"] = {iconsDB_Icon(10462), 4},
	["Healing Stream Totem V"] = {iconsDB_Icon(10463), 4},
	["Healing Stream Totem VI"] = {iconsDB_Icon(25567), 4},
	["Healing Stream Totem VII"] = {iconsDB_Icon(58755), 4},
	["Healing Stream Totem VIII"] = {iconsDB_Icon(58756), 4},
	["Healing Stream Totem IX"] = {iconsDB_Icon(58757), 4},
	["Mana Spring Totem I"] = {iconsDB_Icon(5675), 4},
	["Mana Spring Totem II"] = {iconsDB_Icon(10495), 4},
	["Mana Spring Totem III"] = {iconsDB_Icon(10496), 4},
	["Mana Spring Totem IV"] = {iconsDB_Icon(10497), 4},
	["Mana Spring Totem V"] = {iconsDB_Icon(25570), 4},
	["Mana Spring Totem VI"] = {iconsDB_Icon(58771), 4},
	["Mana Spring Totem VII"] = {iconsDB_Icon(58773), 4},
	["Mana Spring Totem VIII"] = {iconsDB_Icon(58774), 4},
	[iconsDB_Name(16190)] = {iconsDB_Icon(16190), 4},

	--Jeeves, Scrapbot
	["Jeeves"] = {"Interface/Icons/INV_Misc_Head_ClockworkGnome_01", 4},
	["Scrapbot"] = {"Interface/Icons/INV_Gizmo_08", 4},
}

function sNamePlates:iconsDB(name)
	if totem_DB[name] then
		return true, totem_DB[name][1]
	end
end
