local sNamePlates = LibStub("AceAddon-3.0"):GetAddon("sNamePlates", true)
if not sNamePlates then return end
local LSM = LibStub("LibSharedMedia-3.0")
local _unpack = unpack
local _format = string.format

sNamePlates.options = {
    name = "sNamePlates",
    childGroups = "tab",
    handler = sNamePlates,
    type = "group",
    args = {
        general = {
            type = "group",
            name = "General",
            desc = "General configuration of the nameplates.",
            order = 1,
            args = {
                nameplateNote = {
                    type = "description",
                    order = 1,
                    name = _format("|cFF00fffb%s|r Features with |cFF00fffb%s|r require a UI reload to work properly due to previous settings being stored in cache.", "Note:", "*"),
                    fontSize = "large",
                    hidden = true,
                },
                nameplateTitle = {
                    type = "header",
                    name = "Nameplate Colors",
                    order = 2
                },
                pvpFlaggedColor = {
                    type = "color",
                    name = "PVP Flagged",
                    order = 3,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.pvpFlaggedColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "nameplateColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.pvpFlaggedColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                nonpvpFlaggedColor = {
                    type = "color",
                    name = "Not PVP Flagged",
                    order = 4,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.nonpvpFlaggedColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "nameplateColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.nonpvpFlaggedColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                neutralColor= {
                    type = "color",
                    name = "Neutral Color",
                    order = 5,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.neutralColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "nameplateColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.neutralColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                hostileColor = {
                    type = "color",
                    name = "Hostile Color",
                    order = 6,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.hostileColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "nameplateColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.hostileColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },         
                nameplateColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset nameplate colors.",
                    order = 7,
                    confirm = function()
                        sNamePlates:RNamePlateColors()
                        sNamePlates.db.profile.optionChanged = "nameplateColor"
                    end, 
                },   
                sizeTitle = {
                    type = "header",
                    name = "Nameplate",
                    order = 20
                },
                nameplateWidth = {
                    type = "range",
                    name = "Width",
                    desc = "The width of the nameplate.",
                    order = 21,
                    min = 3,
                    max= 165,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateWidth = val 
                        sNamePlates.db.profile.optionChanged = "nameplateSize"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateWidth 
                    end,
                },
                nameplateHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the nameplate.",
                    order = 22,
                    min = 3,
                    max= 25,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateHeight = val 
                        sNamePlates.db.profile.optionChanged = "nameplateSize"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateHeight 
                    end,
                },
                nameplateXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the nameplate in the x-axis.",
                    order = 23,
                    min = -10,
                    max= 10,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateXOffset = val 
                        sNamePlates.db.profile.optionChanged = "nameplateXY"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateXOffset 
                    end,
                },
                nameplateYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the nameplate in the y-axis.",
                    order = 24,
                    min = -10,
                    max= 10,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateYOffset = val 
                        sNamePlates.db.profile.optionChanged = "nameplateXY"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateYOffset 
                    end,
                },
                nameplateTexture = {
                    type = "select",
                    name = "Nameplate Texture",
                    desc = "The texture used by the nameplate.",
                    order = 25,
                    width = "normal",
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)          
                        sNamePlates.db.profile.nameplateTexture = key
                        sNamePlates.db.profile.optionChanged = "nameplateTexture"
                    end,
                    get = function()
                        return sNamePlates.db.profile.nameplateTexture 
                    end,
                },
                healthbarBorderColor = {
                    type = "color",
                    name = "Border Color",
                    order = 26,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.healthbarBorderColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "nameplateBorderColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.healthbarBorderColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                hbBorderColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset nameplate border color.",
                    order = 27,
                    confirm = function()
                        sNamePlates:RHBBorderColors()
                        sNamePlates.db.profile.optionChanged = "nameplateBorderColor"
                    end, 
                },
                highlightTitle = {
                    type = "header",
                    name = "Highlight",
                    order = 40
                },
                highlightTexture = {
                    type = "select",
                    name = "Highlight Texture",
                    desc = "The texture used by the nameplate's highlight.",
                    order = 41,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.highlightTexture = key
                        sNamePlates.db.profile.optionChanged = "highlightTexture"
                    end,
                    get = function()
                        return sNamePlates.db.profile.highlightTexture
                    end,
                },   
                highlightColor = {
                    type = "color",
                    name = "Highlight Color",
                    order = 42,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.highlightColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "highlightColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.highlightColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                highlightColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset the highlight color.",
                    order = 43,
                    confirm = function()
                        sNamePlates:RHighlightColors()
                        sNamePlates.db.profile.optionChanged = "highlightColor"
                    end, 
                },   
                backgroundTitle = {
                    type = "header",
                    name = "Background",
                    order = 50
                },
                backgroundTexture = {
                    type = "select",
                    name = "Background Texture",
                    desc = "The texture used by the nameplate's background.",
                    order = 51,
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.backgroundTexture = key
                        sNamePlates.db.profile.optionChanged = "backgroundTexture"
                    end,
                    get = function()
                        return sNamePlates.db.profile.backgroundTexture
                    end,
                },
                backgroundNameplateColor = {
                    type = "color",
                    name = "Background Color",
                    order = 52,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.backgroundNameplateColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "backgroundColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.backgroundNameplateColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                backgroundNameplateColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset background colors.",
                    order = 53,
                    confirm = function()
                        sNamePlates:RNPBackgroundColors()
                        sNamePlates.db.profile.optionChanged = "backgroundColor"
                    end, 
                },   
                AggroTitle = {
                    type = "header",
                    name = "Normal Mode",
                    order = 80,
                },
                NMToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Keep nameplate colors depending of the reaction of the unit.",
                    order = 81,
                    set = function(info, val) 
                        if sNamePlates.db.profile.TMToggle == false and sNamePlates.db.profile.NMToggle == false then 
                            sNamePlates.db.profile.NMToggle = val
                            sNamePlates.db.profile.TMToggle = not val
                        else
                            sNamePlates.db.profile.NMToggle = val
                            sNamePlates.db.profile.TMToggle = not val
                        end
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.NMToggle
                    end,
                },
                NMAttackingColor = {
                    type = "color",
                    name = "Attacking You",
                    order = 82,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.NMToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.NMAttackingColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.NMAttackingColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                NMAboutAttackingColor = {
                    type = "color",
                    name = "About to Attack You",
                    order = 83,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.NMToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.NMAboutAttackingColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.NMAboutAttackingColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                aggroBorderColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset aggro border colors.",
                    order = 84,
                    disabled = function() 
                        return not sNamePlates.db.profile.NMToggle
                    end,
                    confirm = function()
                        sNamePlates:RABOColors()
                    end, 
                },
                NMToggleBorderToo = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Show aggro status color on the borders.",
                    order = 85,
                    disabled = function() 
                        return not sNamePlates.db.profile.NMToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.NMToggleBorderToo = val
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.NMToggleBorderToo
                    end,
                },
                TankModeTitle = {
                    type = "header",
                    name = "Tank Mode",
                    order = 100,
                },
                TMToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Show aggro status color on the nameplate.",
                    order = 101,
                    set = function(info, val) 
                        if sNamePlates.db.profile.TMToggle == false and sNamePlates.db.profile.NMToggle == false then 
                            sNamePlates.db.profile.TMToggle = val
                            sNamePlates.db.profile.NMToggle = not val
                        else
                            sNamePlates.db.profile.TMToggle = val
                            sNamePlates.db.profile.NMToggle = not val
                        end
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TMToggle
                    end,
                },
                TMAttackingColor = {
                    type = "color",
                    name = "Attacking You",
                    order = 102,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.TMToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.TMAttackingColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.TMAttackingColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                TMAboutAttackingColor = {
                    type = "color",
                    name = "About to Attack You",
                    order = 103,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.TMToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.TMAboutAttackingColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.TMAboutAttackingColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                TMColorResetExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset aggro border colors.",
                    order = 104,
                    disabled = function() 
                        return not sNamePlates.db.profile.TMToggle
                    end,
                    confirm = function()
                        sNamePlates:RTMColors()
                    end, 
                },
                TMToggleBorderToo = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Show aggro status color on the borders too.",
                    order = 105,
                    disabled = function() 
                        return not sNamePlates.db.profile.TMToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.TMToggleBorderToo = val
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TMToggleBorderToo
                    end,
                },
            },
        },  
        target = {
            type = "group",
            name = "Target",
            desc = "Configuration of the nameplate when clicked.",
            order = 2,
            args = {
                alphaTitle = {
                    type = "header",
                    name = "Alpha",
                    order = 1,
                    hidden = true,
                    disabled = true,
                },
                alphaToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Change alpha value when a target exist.",
                    order = 2,
                    hidden = true,
                    disabled = true,
                    set = function(info, val) 
                        sNamePlates.db.profile.alphaToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.alphaToggle
                    end,
                },
                alphaValue = {
                    type = "range",
                    name = "Alpha",
                    isPercent = true,
                    disabled = true,
                    desc = "The alpha value of other nameplates when a target exist.",
                    order = 3,
                    hidden = true,
                    min = 0.3,
                    max= 0.8,
                    step = 0.01,
                    disabled = function() 
                        return not sNamePlates.db.profile.alphaToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.alphaValue = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.alphaValue 
                    end,
                },
                tarIndicatorTitle= {
                    type = "header",
                    name = "Target Indicator",
                    order = 4,
                },
                tarIndicatorToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Indicator when a target exist.",
                    order = 5,
                    set = function(info, val) 
                        sNamePlates.db.profile.tarIndicatorToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.tarIndicatorToggle
                    end,
                },
                tarIndicatorSelect = {
                    type = "select",
                    name = "Indicator",
                    desc = "Defines the target indicator.",
                    order = 6,
                    values = {
                        [1] = "Double Arrow 1",
                        [2] = "Double Arrow 2",
                        [3] = "Arrow Broken",
                        [4] = "Arrow Full",
                        [5] = "Arrow Thin",
                        [6] = "Bracket",
                        [7] = "Bracket Thin",
                        [8] = "Single Arrow",
                        [9] = "Hello Kitty",
                    },
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.tarIndicatorSelect = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSelect"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.tarIndicatorSelect
                    end,
                }, 
                inverseSelect = {
                    type = "toggle",
                    name = "Inverse",
                    desc = "Invert the target indicator.",
                    order = 7,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.inverseSelect = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSelect"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.inverseSelect
                    end,
                }, 
                TIWidth = {
                    type = "range",
                    name = "Width",
                    desc = "The width of the target indicator.",
                    order = 8,
                    min = 10,
                    max= 100,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIWidth = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSize"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TIWidth
                    end,
                },
                TIHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the target indicator.",
                    order = 9,
                    min = 10,
                    max= 100,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIHeight = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSize"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TIHeight
                    end,
                },
                TIseparation = {
                    type = "range",
                    name = "Separation",
                    desc = "Separation of the target indicators",
                    order = 10,
                    min = -200,
                    max= 200,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIseparation = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSeparationAndXY"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TIseparation 
                    end,
                },
                TIXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the target indicator in the x-axis.",
                    order = 11,
                    min = -200,
                    max= 200,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIXOffset = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSeparationAndXY"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TIXOffset 
                    end,
                },
                TIYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the target indicator in the y-axis.",
                    order = 12,
                    min = -30,
                    max= 30,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIYOffset = val 
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSeparationAndXY"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.TIYOffset
                    end,
                },
                scaleTitle = {
                    type = "header",
                    name = "Scale",
                    order = 20,
                    disabled = true,
                    hidden = true,
                },
                scaleToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Nameplate scaling when a target exists",
                    order = 21,
                    disabled = true,
                    hidden = true,
                    set = function(info, val) 
                        sNamePlates.db.profile.scaleToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.scaleToggle
                    end,
                },
                scaleValue = {
                    type = "range",
                    name = "Scale",
                    isPercent = true,
                    desc = "The scale value of nameplates when a target exists.",
                    order = 22,
                    min = 0.5,
                    max= 1.5,
                    step = 0.01,
                    disabled = true,
                    hidden = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.scaleToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.scaleValue = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.scaleValue 
                    end,
                },
                TIColorTitle = {
                    type = "header",
                    name = "Target Indicator Color",
                    order = 100,
                },
                TIColor = {
                    type = "color",
                    name = "Target Indicator",
                    order = 101,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.TIColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSeparationColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.TIColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                TIColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset target indicator colors.",
                    order = 102,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    confirm = function()
                        sNamePlates:RTIColors()
                        sNamePlates.db.profile.optionChanged = "tarIndicatorSeparationColor"
                    end, 
                },   
            },
        },
        castbar = {
            type = "group",
            name = "Castbar",
            desc = "Configuration of the castbar on the target.",
            order = 3,
            args = {   
                cbitle = {
                    type = "header",
                    name = "General",
                    order = 6,
                },
                castbarHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the castbar.",
                    order = 7,
                    min = 1,
                    max= 15,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.castbarHeight = val 
                        sNamePlates.db.profile.optionChanged = "castbarElementsSizes"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castbarHeight 
                    end,
                },
                separationValue = {
                    type = "range",
                    name = "Separation",
                    desc = "The separation value of the elements in the nameplate (castbar and castbar icon).",
                    order = 8,
                    min = 0,
                    max= 10,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.separationValue = val 
                        sNamePlates.db.profile.optionChanged = "castbarElementsSizes"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.separationValue
                    end,
                },
                castbarBorderColor = {
                    type = "color",
                    name = "Border Color",
                    order = 9,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.castbarBorderColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "castbarBordersColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.castbarBorderColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                castbarIconBorderColor= {
                    type = "color",
                    name = "Icon Border Color",
                    order = 10,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.castbarIconBorderColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "castbarBordersColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.castbarIconBorderColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                borderColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset border colors.",
                    order = 11,
                    confirm = function()
                        sNamePlates:RCBBorderColors()
                        sNamePlates.db.profile.optionChanged = "castbarBordersColor"
                    end, 
                },
                castbarTextureTitle = {
                    type = "header",
                    name = "Texture",
                    order = 20,
                },
                castbarTexture = {
                    type = "select",
                    name = "Castbar Texture",
                    desc = "The texture used by the castbar.",
                    order = 21,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.castbarTexture = key
                        sNamePlates.db.profile.optionChanged = "castbarTexture"
                    end,
                    get = function()
                        return sNamePlates.db.profile.castbarTexture
                    end,
                },
                castbarBackgroundTexture = {
                    type = "select",
                    name = "Background Texture",
                    desc = "The texture used by the castbar's background.",
                    order = 22,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.castbarBackgroundTexture = key
                        sNamePlates.db.profile.optionChanged = "castbarBackgroundTexture"
                    end,
                    get = function()
                        return sNamePlates.db.profile.castbarBackgroundTexture
                    end,
                },
                backgroundCastbarColor = {
                    type = "color",
                    name = "Castbar Background Color",
                    order = 23,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.backgroundCastbarColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "castbarBackgroundColor"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.backgroundCastbarColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                backgroundCastbarColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset background colors.",
                    order = 24,
                    confirm = function()
                        sNamePlates:RCBBackgroundColors()
                        sNamePlates.db.profile.optionChanged = "castbarBackgroundColor"
                    end, 
                },   
            },
        },   
        raidIcon = {
            type = "group",
            name = "Raid icon",
            desc = "Configuration of the raid icon.",
            order = 4,
            args = {
                RIsizeTitle = {
                    type = "header",
                    name = "Size",
                    order = 1,
                },
                RIwidth = {
                    type = "range",
                    name = "Width",
                    desc = "The width of the raid icon.",
                    order = 2,
                    min = 5,
                    max= 70,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.RIwidth  = val 
                        sNamePlates.db.profile.optionChanged = "RISize"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.RIwidth 
                    end,
                },
                RIheight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the raid icon.",
                    order = 3,
                    min = 5,
                    max= 70,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.RIheight = val 
                        sNamePlates.db.profile.optionChanged = "RISize"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.RIheight 
                    end,
                },
                RIpositionTitle = {
                    type = "header",
                    name = "Position",
                    order = 6,
                },
                RIXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the raid icon in the x-axis.",
                    order = 7,
                    min = -500,
                    max= 500,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.RIXOffset = val 
                        sNamePlates.db.profile.optionChanged = "RIPosition"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.RIXOffset
                    end,
                },
                RIYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the raid icon in the y-axis.",
                    order = 8,
                    min = -500,
                    max= 500,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.RIYOffset = val 
                        sNamePlates.db.profile.optionChanged = "RIPosition"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.RIYOffset
                    end,
                },            
            },
        },   
        font = {
            type = "group",
            name = "Font",
            desc = "Configuration of the fonts.",
            order = 5,
            args = {
                textTitle = {
                    type = "header",
                    name = "Text Colors",
                    order = 1,
                },
                nameColor = {
                    type = "color",
                    name = "Name",
                    order = 2,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.nameColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "fontColors"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.nameColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                healthPercentColor = {
                    type = "color",
                    name = "Health Percent",
                    order = 3,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthPercentToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.healthPercentColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "fontColors"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.healthPercentColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                healthAmmountColor = {
                    type = "color",
                    name = "Health Ammount",
                    order = 4,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthAmmountToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.healthAmmountColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                        sNamePlates.db.profile.optionChanged = "fontColors"
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.healthAmmountColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                textColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset text colors.",
                    order = 7,
                    disabled = function() 
                        if not sNamePlates.db.profile.nameToggle 
                        and not sNamePlates.db.profile.healthPercentToggle
                        and not sNamePlates.db.profile.healthAmmountToggle  then 
                            return true
                        else
                            return false
                        end
                    end,
                    confirm = function()
                        sNamePlates:RTextColors()
                        sNamePlates.db.profile.optionChanged = "fontColors"
                    end, 
                },   
                nameFontTitle = {
                    type = "header",
                    name = "Name",
                    order = 10
                },
                nameToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Name on the nameplates.",
                    order = 11,
                    set = function(info, val) 
                        sNamePlates.db.profile.nameToggle = val 
                        sNamePlates.db.profile.optionChanged = "fontName"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameToggle
                    end,
                },
                nameFontSize = {
                    type = "range",
                    name = "Font Size",
                    desc = "Font size of the name.",
                    order = 12,
                    min = 1,
                    max= 30,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameFontSize = val 
                        sNamePlates.db.profile.optionChanged = "fontName"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameFontSize
                    end,
                },
                nameFont = {
                    type = "select",
                    name = "Font",
                    desc = "The font used on the name.",
                    order = 13,
                    dialogControl = "LSM30_Font",
                    values = AceGUIWidgetLSMlists.font,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.nameFont = key
                        sNamePlates.db.profile.optionChanged = "fontName"
                    end,
                    get = function()
                        return sNamePlates.db.profile.nameFont
                    end,
                },
                nameOutline  = {
                    type = "select",
                    name = "Outline",
                    desc = "Outline of the name.",
                    order = 14,
                    values = {
                        ["MONOCHROMEOUTLINE"] = "MONOCHROMEOUTLINE",
                        ["MONOCHROME"] = "MONOCHROME",
                        ["NONE"] = "None",
                        ["OUTLINE"] = "OUTLINE",
                        ["THICKOUTLINE"] = "THICKOUTLINE",
                    },
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.nameOutline = val 
                        sNamePlates.db.profile.optionChanged = "fontName"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameOutline
                    end,
                }, 
                shNameSelect = {
                    type = "toggle",
                    name = "Shadow",
                    desc = "Display shadow under the name.",
                    order = 15,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.shNameSelect = val 
                        sNamePlates.db.profile.optionChanged = "fontName"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.shNameSelect
                    end,
                },
                healthPercentFontTitle = {
                    type = "header",
                    name = "Health Percent",
                    order = 20
                },
                healthPercentToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Health percent on the nameplates.",
                    order = 21,
                    set = function(info, val) 
                        sNamePlates.db.profile.healthPercentToggle = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.healthPercentToggle
                    end,
                },
                healthPercentFontSize = {
                    type = "range",
                    name = "Font Size",
                    desc = "Font size of the health percent.",
                    order = 22,
                    min = 1,
                    max= 30,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthPercentToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.healthPercentFontSize = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.healthPercentFontSize
                    end,
                },
                healthPercentFont = {
                    type = "select",
                    name = "Font",
                    desc = "The font used on the health percent.",
                    order = 23,
                    dialogControl = "LSM30_Font",
                    values = AceGUIWidgetLSMlists.font,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthPercentToggle 
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.healthPercentFont = key
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function()
                        return sNamePlates.db.profile.healthPercentFont 
                    end,
                },
                healthPercentOutline  = {
                    type = "select",
                    name = "Outline",
                    desc = "Outline of the health percent.",
                    order = 24,
                    values = {
                        ["MONOCHROMEOUTLINE"] = "MONOCHROMEOUTLINE",
                        ["MONOCHROME"] = "MONOCHROME",
                        ["NONE"] = "None",
                        ["OUTLINE"] = "OUTLINE",
                        ["THICKOUTLINE"] = "THICKOUTLINE",
                    },
                    disabled = function() 
                        return not sNamePlates.db.profile.healthPercentToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.healthPercentOutline = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.healthPercentOutline
                    end,
                }, 
                shHealthPercentSelect = {
                    type = "toggle",
                    name = "Shadow",
                    desc = "Display shadow under the health percent.",
                    order = 25,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthPercentToggle  
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.shHealthPercentSelect = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.shHealthPercentSelect
                    end,
                },
                healthAmmountFontTitle = {
                    type = "header",
                    name = "Health Ammount",
                    order = 40
                },
                healthAmmountToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Health Ammount on the nameplates",
                    order = 41,
                    set = function(info, val) 
                        sNamePlates.db.profile.healthAmmountToggle = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.healthAmmountToggle
                    end,
                },
                healthAmmountFontSize = {
                    type = "range",
                    name = "Font Size",
                    desc = "Font size on the health ammount.",
                    order = 42,
                    min = 1,
                    max= 30,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthAmmountToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.healthAmmountFontSize = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.healthAmmountFontSize
                    end,
                },
                healthAmmountFont = {
                    type = "select",
                    name = "Font",
                    desc = "The font used on the health ammount.",
                    order = 43,
                    dialogControl = "LSM30_Font",
                    values = AceGUIWidgetLSMlists.font,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthAmmountToggle 
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.healthAmmountFont = key
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function()
                        return sNamePlates.db.profile.healthAmmountFont 
                    end,
                },
                healthAmmountOutline  = {
                    type = "select",
                    name = "Outline",
                    desc = "Outline of the health ammount.",
                    order = 44,
                    values = {
                        ["MONOCHROMEOUTLINE"] = "MONOCHROMEOUTLINE",
                        ["MONOCHROME"] = "MONOCHROME",
                        ["NONE"] = "None",
                        ["OUTLINE"] = "OUTLINE",
                        ["THICKOUTLINE"] = "THICKOUTLINE",
                    },
                    disabled = function() 
                        return not sNamePlates.db.profile.healthAmmountToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.healthAmmountOutline = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.healthAmmountOutline
                    end,
                }, 
                shHealthAmmountSelect = {
                    type = "toggle",
                    name = "Shadow",
                    desc = "Display shadow under the health ammount.",
                    order = 45,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthAmmountToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.shHealthAmmountSelect = val 
                        sNamePlates.db.profile.optionChanged = "fontHealthPercentAndAmmount"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.shHealthAmmountSelect
                    end,
                },
                infoIfFullTitle = {
                    type = "header",
                    name = "Display",
                    order = 60
                },
                infoIfFullSelect = {
                    type = "toggle",
                    name = "Full health",
                    desc = "Display health ammount or health percent or both if the nameplate is full hp.",
                    order = 61,
                    disabled = function() 
                        return not (sNamePlates.db.profile.healthAmmountToggle or sNamePlates.db.profile.healthPercentToggle)
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.infoIfFullSelect = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.infoIfFullSelect
                    end,
                },
                levelFontTitle = {
                    type = "header",
                    name = "Level",
                    order = 80,
                },
                levelToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Level on the nameplates.",
                    order = 81,
                    set = function(info, val) 
                        sNamePlates.db.profile.levelToggle = val 
                        sNamePlates.db.profile.optionChanged = "fontLevel"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.levelToggle
                    end,
                },
                levelFontSize = {
                    type = "range",
                    name = "Font Size",
                    desc = "Font size of the level.",
                    order = 82,
                    min = 1,
                    max= 30,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.levelToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.levelFontSize = val 
                        sNamePlates.db.profile.optionChanged = "fontLevel"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.levelFontSize
                    end,
                },
                levelFont = {
                    type = "select",
                    name = "Font",
                    desc = "The font used on the level.",
                    order = 83,
                    dialogControl = "LSM30_Font",
                    values = AceGUIWidgetLSMlists.font,
                    disabled = function() 
                        return not sNamePlates.db.profile.levelToggle 
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.levelFont = key
                        sNamePlates.db.profile.optionChanged = "fontLevel"
                    end,
                    get = function()
                        return sNamePlates.db.profile.levelFont 
                    end,
                },
                levelOutline = {
                    type = "select",
                    name = "Outline",
                    desc = "Outline of the level.",
                    order = 84,
                    values = {
                        ["MONOCHROMEOUTLINE"] = "MONOCHROMEOUTLINE",
                        ["MONOCHROME"] = "MONOCHROME",
                        ["NONE"] = "None",
                        ["OUTLINE"] = "OUTLINE",
                        ["THICKOUTLINE"] = "THICKOUTLINE",
                    },
                    disabled = function() 
                        return not sNamePlates.db.profile.levelToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.levelOutline = val 
                        sNamePlates.db.profile.optionChanged = "fontLevel"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.levelOutline
                    end,
                },
                shLevelSelect = {
                    type = "toggle",
                    name = "Shadow",
                    desc = "Display shadow under the level.",
                    order = 85,
                    width = "normal",
                    disabled = function() 
                        return not sNamePlates.db.profile.levelToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.shLevelSelect = val 
                        sNamePlates.db.profile.optionChanged = "fontLevel"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.shLevelSelect
                    end,
                },
            },
        },
        icons = {
            type = "group",
            name = "Icons",
            desc = "Configuration of the colors.",
            order = 6,
            args = {
                SINote = {
                    type = "description",
                    order = 1,
                    name = _format("|cFF00fffb%s|r Features with |cFF00fffb%s|r require a UI reload to set up properly and not collide with changes in other options.", "Note:", "*"),
                    fontSize = "large",
                },
                totemTitle = {
                    type = "header",
                    name = "Icons |cFF00fffb*|r",
                    order = 2,
                },
                iconsToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Special icons for totems and more...",
                    order = 3,
                    set = function(info, val) 
                        sNamePlates.db.profile.iconsToggle = val 
                        sNamePlates.db.profile.optionChanged = "specialIcons"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconsToggle
                    end,
                },
                iconWidth = {
                    type = "range",
                    name = "Width",
                    desc = "The width of the icon.",
                    order = 4,
                    min = 5,
                    max= 80,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconWidth = val 
                        sNamePlates.db.profile.optionChanged = "specialIcons"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconWidth
                    end,
                },
                iconHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the icon.",
                    order = 5,
                    min = 5,
                    max= 35,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconHeight = val 
                        sNamePlates.db.profile.optionChanged = "specialIcons"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconHeight
                    end,
                },
                iconXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the icon in the x-axis.",
                    order = 6,
                    min = -50,
                    max= 50,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconXOffset = val 
                        sNamePlates.db.profile.optionChanged = "specialIcons"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconXOffset 
                    end,
                },
                iconYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the icon in the y-axis.",
                    order = 7,
                    min = -10,
                    max= 10,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconYOffset = val 
                        sNamePlates.db.profile.optionChanged = "specialIcons"
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconYOffset 
                    end,
                },
            },    
        }, 
    },
}

sNamePlates.defaults = {
    profile = {
        optionChanged = nil,
        --Nameplate
        pvpFlaggedColor = {["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1},
        nonpvpFlaggedColor = {["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1},
        neutralColor = {["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1},
        hostileColor = {["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1},

        nameplateWidth = 140,
        nameplateHeight = 14,

        nameplateTexture = "Armory",
        healthbarBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1},
        highlightTexture = "Armory",
        highlightColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 1},
        backgroundTexture = "Armory",
        backgroundNameplateColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 0},

        nameplateXOffset = 0,
        nameplateYOffset = 0,

        separationValue = 4,

        NMToggle = true,
        NMAttackingColor = {["r"] = 0.99, ["g"] = 0, ["b"] = 0, ["a"] = 1},
        NMAboutAttackingColor = {["r"] = 0.99, ["g"] = 0.99, ["b"] = 0.47, ["a"] = 1},
        NMToggleBorderToo = false,

        TMToggle = false,
        TMAttackingColor = {["r"] = 0.29, ["g"] = 0.69, ["b"] = 0.30, ["a"] = 1},
        TMAboutAttackingColor = {["r"] = 0.92, ["g"] = 0.64, ["b"] = 0.16, ["a"] = 1},
        TMToggleBorderToo = false,

        --Target
        alphaToggle = false,
        alphaValue = 0.3,

        tarIndicatorToggle = true,
        tarIndicatorSelect = 8,
        inverseSelect = false,
        TIWidth = 50,
        TIHeight = 45,
        TIseparation = -7,
        TIXOffset = 0,
        TIYOffset = 0,

        TIColor = {["r"] = 0.058, ["g"] = 1, ["b"] = 0.09, ["a"] = 1},

        scaleToggle = false,
        scaleValue = 1,

        --Castbar

        CBColorInterruptible = {["r"] = 0.85, ["g"] = 0.61, ["b"] = 0.15, ["a"] = 1},
        CBColorNotInterruptible = {["r"] = 0.8, ["g"] = 0.1, ["b"] = 0.1, ["a"] = 1},

        castbarHeight = 6,
        castbarBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1},
        castbarIconBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1},

        castbarTexture = "Armory",
        castbarBackgroundTexture = "Armory",
        backgroundCastbarColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 0},

        castNameXOffset = -2,
        castNameYOffset = -12, 

        castTimeXOffset = 2,
        castTimeYOffset = -12,

        --Raid Icon
        RIwidth = 35,
        RIheight = 35,
        RIXOffset = 88,
        RIYOffset = 28,

        --Font
        nameColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},
        healthPercentColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},
        healthAmmountColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},

        nameToggle = true,
        nameFontSize = 13, 
        nameFont = "Continuum Medium",
        nameOutline = "OUTLINE",
        shNameSelect = false,

        healthPercentToggle = true,
        healthPercentFontSize = 13, 
        healthPercentFont = "Continuum Medium",
        healthPercentOutline = "OUTLINE",
        shHealthPercentSelect = false,

        healthAmmountToggle = true,
        healthAmmountFontSize = 13, 
        healthAmmountFont = "Continuum Medium",
        healthAmmountOutline = "OUTLINE",
        shHealthAmmountSelect = false,

        infoIfFullSelect = true,

        levelToggle = true,
        levelFontSize = 13, 
        levelFont = "Continuum Medium",
        levelOutline = "OUTLINE",
        shLevelSelect = false,

        --Icons
        iconsToggle = true,
        iconWidth = 35,
        iconHeight = 20,
        iconXOffset = 0,
        iconYOffset = 5,
    }
}