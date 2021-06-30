local sNamePlates = LibStub("AceAddon-3.0"):GetAddon("sNamePlates", true)
if not sNamePlates then return end
local LSM = LibStub("LibSharedMedia-3.0")
local _unpack = unpack

sNamePlates.options = {
    name = "sNamePlates",
    childGroups = "tab",
    handler = sNamePlates,
    type = "group",
    args = {
        nameplate = {
            type = "group",
            name = "Nameplate",
            desc = "Configuration of the nameplates.",
            order = 1,
            args = {
                sizeTitle = {
                    type = "header",
                    name = "Size",
                    order = 1
                },
                nameplateWidth = {
                    type = "range",
                    name = "Width",
                    desc = "The width of the nameplate.",
                    order = 2,
                    min = 10,
                    max= 400,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateWidth = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateWidth 
                    end,
                },
                nameplateHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the nameplate.",
                    order = 3,
                    min = 5,
                    max= 70,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateHeight = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateHeight 
                    end,
                },
                textureTitle = {
                    type = "header",
                    name = "Texture",
                    order = 4
                },
                nameplateTexture = {
                    type = "select",
                    name = "Nameplate Texture",
                    desc = "The texture used by the nameplate.",
                    order = 5,
                    width = "normal",
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.nameplateTexture = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.nameplateTexture 
                    end,
                },
                highlightTexture = {
                    type = "select",
                    name = "Highlight Texture",
                    desc = "The texture used by the nameplate's highlight.",
                    order = 6,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.highlightTexture = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.highlightTexture
                    end,
                },   
                backgroundTexture = {
                    type = "select",
                    name = "Background Texture",
                    desc = "The texture used by the nameplate's background.",
                    order = 7,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.backgroundTexture = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.backgroundTexture
                    end,
                },
                positionTitle = {
                    type = "header",
                    name = "Position",
                    order = 8,
                },
                nameplateXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the nameplate in the x-axis.",
                    order = 9,
                    min = -500,
                    max= 500,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateXOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateXOffset 
                    end,
                },
                nameplateYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the nameplate in the y-axis.",
                    order = 10,
                    min = -500,
                    max= 500,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameplateYOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameplateYOffset 
                    end,
                },
                separationTitle = {
                    type = "header",
                    name = "Separation",
                    order = 11,
                },
                separationValue = {
                    type = "range",
                    name = "Separation Value",
                    desc = "The separation value of the elements in the nameplate.",
                    order = 12,
                    min = 0,
                    max= 10,
                    step = 1,
                    set = function(info,val) 
                        sNamePlates.db.profile.separationValue = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.separationValue
                    end,
                },
                AggroTitle = {
                    type = "header",
                    name = "Aggro Border",
                    order = 40,
                },
                aggroBorderToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Show aggro status colors on the border of the elements of the nameplate.",
                    order = 41,
                    set = function(info, val) 
                        sNamePlates.db.profile.aggroBorderToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.aggroBorderToggle
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
                },
                alphaToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Change alpha value when a target exist.",
                    order = 2,
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
                    desc = "The alpha value of other nameplates when a target exist.",
                    order = 3,
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
                    min = -500,
                    max= 500,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIXOffset = val 
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
                    min = -500,
                    max= 500,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.TIYOffset = val 
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
            },
        },
        castbar = {
            type = "group",
            name = "Castbar",
            desc = "Configuration of the castbar on the target.",
            order = 3,
            args = {
                castbarToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Show castbar on the nameplates.",
                    order = 1,
                    set = function(info, val) 
                        sNamePlates.db.profile.castbarToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castbarToggle
                    end,
                },
                cbSizeTitle = {
                    type = "header",
                    name = "General",
                    order = 2,
                },
                cbSizeTitle = {
                    type = "header",
                    name = "Size",
                    order = 3,
                },
                castbarHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the castbar.",
                    order = 4,
                    min = 1,
                    max= 15,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.castbarHeight = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castbarHeight 
                    end,
                },
                castbarSizeTitle = {
                    type = "header",
                    name = "Texture",
                    order = 10,
                },
                castbarTexture = {
                    type = "select",
                    name = "Castbar Texture",
                    desc = "The texture used by the castbar.",
                    order = 11,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    values = AceGUIWidgetLSMlists.statusbar,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.castbarTexture = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.castbarTexture
                    end,
                },
                castbarBackgroundTexture = {
                    type = "select",
                    name = "Background Texture",
                    desc = "The texture used by the castbar's background.",
                    order = 12,
                    width = 'normal',
                    dialogControl = "LSM30_Statusbar",
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    values = AceGUIWidgetLSMlists.statusbar,
                    set = function(self,key)
                        sNamePlates.db.profile.castbarBackgroundTexture = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.castbarBackgroundTexture
                    end,
                },
                namePositionTitle = {
                    type = "header",
                    name = "Name Position",
                    order = 40,
                },
                castNameXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the cast name in the x-axis.",
                    order = 41,
                    min = -500,
                    max= 500,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.castNameXOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castNameXOffset 
                    end,
                },
                castNameYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the cast name in the y-axis.",
                    order = 42,
                    min = -500,
                    max= 500,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.castNameYOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castNameYOffset 
                    end,
                },
                timePositionTitle = {
                    type = "header",
                    name = "Time Position",
                    order = 60,
                },
                castTimeXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the cast time in the x-axis.",
                    order = 61,
                    min = -500,
                    max= 500,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.castTimeXOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castTimeXOffset
                    end,
                },
                castTimeYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the cast time in the y-axis.",
                    order = 62,
                    min = -500,
                    max= 500,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.castTimeYOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castTimeYOffset
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
                nameFontTitle = {
                    type = "header",
                    name = "Name",
                    order = 1
                },
                nameToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Name on the nameplates.",
                    order = 2,
                    set = function(info, val) 
                        sNamePlates.db.profile.nameToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameToggle
                    end,
                },
                nameFontSize = {
                    type = "range",
                    name = "Font Size",
                    desc = "Font size of the name.",
                    order = 3,
                    min = 1,
                    max= 30,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.nameFontSize = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameFontSize
                    end,
                },
                nameFont = {
                    type = "select",
                    name = "Font",
                    desc = "The font used on the name.",
                    order = 4,
                    dialogControl = "LSM30_Font",
                    values = AceGUIWidgetLSMlists.font,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.nameFont = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.nameFont
                    end,
                },
                nameOutline  = {
                    type = "select",
                    name = "Outline",
                    desc = "Outline of the name.",
                    order = 5,
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
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.nameOutline
                    end,
                }, 
                shNameSelect = {
                    type = "toggle",
                    name = "Shadow",
                    desc = "Display shadow under the name.",
                    order = 6,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle 
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.shNameSelect = val 
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
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.shLevelSelect
                    end,
                },

                castbarFontTitle = {
                    type = "header",
                    name = "Castbar",
                    order = 100
                },
                castbarFontToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Font on the castbar.",
                    order = 101,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.castbarFontToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castbarFontToggle
                    end,
                },
                castbarFontSize = {
                    type = "range",
                    name = "Font Size",
                    desc = "Font size of the castbar elements.",
                    order = 102,
                    min = 1,
                    max= 20,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarFontToggle or not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.castbarFontSize = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castbarFontSize
                    end,
                },
                castbarFont = {
                    type = "select",
                    name = "Font",
                    desc = "The font used on the castbar elements.",
                    order = 103,
                    dialogControl = "LSM30_Font",
                    values = AceGUIWidgetLSMlists.font,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarFontToggle or not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(self,key)
                        sNamePlates.db.profile.castbarFont = key
                    end,
                    get = function()
                        return sNamePlates.db.profile.castbarFont 
                    end,
                },
                castbarFontOutline = {
                    type = "select",
                    name = "Outline",
                    desc = "Outline of the castbar elements.",
                    order = 104,
                    values = {
                        ["MONOCHROMEOUTLINE"] = "MONOCHROMEOUTLINE",
                        ["MONOCHROME"] = "MONOCHROME",
                        ["NONE"] = "None",
                        ["OUTLINE"] = "OUTLINE",
                        ["THICKOUTLINE"] = "THICKOUTLINE",
                    },
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarFontToggle or not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.castbarFontOutline = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.castbarFontOutline
                    end,
                },
                shCastbarSelect = {
                    type = "toggle",
                    name = "Shadow",
                    desc = "Display shadow under the castbar text.",
                    order = 105,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarFontToggle or not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(info, val) 
                        sNamePlates.db.profile.shCastbarSelect = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.shCastbarSelect 
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
                totemTitle = {
                    type = "header",
                    name = "Icons",
                    order = 1,
                },
                iconsToggle = {
                    type = "toggle",
                    name = "Enable",
                    desc = "Special icons for totems and more...",
                    order = 2,
                    set = function(info, val) 
                        sNamePlates.db.profile.iconsToggle = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconsToggle
                    end,
                },
                iconWidth = {
                    type = "range",
                    name = "Width",
                    desc = "The width of the icon.",
                    order = 3,
                    min = 5,
                    max= 80,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconWidth = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconWidth
                    end,
                },
                iconHeight = {
                    type = "range",
                    name = "Height",
                    desc = "The height of the icon.",
                    order = 4,
                    min = 5,
                    max= 80,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconHeight = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconHeight
                    end,
                },
                iconXOffset = {
                    type = "range",
                    name = "X Offset",
                    desc = "Position of the icon in the x-axis.",
                    order = 5,
                    min = -50,
                    max= 50,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconXOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconXOffset 
                    end,
                },
                iconYOffset = {
                    type = "range",
                    name = "Y Offset",
                    desc = "Position of the icon in the y-axis.",
                    order = 6,
                    min = -50,
                    max= 50,
                    step = 1,
                    disabled = function() 
                        return not sNamePlates.db.profile.iconsToggle
                    end,
                    set = function(info,val) 
                        sNamePlates.db.profile.iconYOffset = val 
                    end,
                    get = function(info) 
                        return sNamePlates.db.profile.iconYOffset 
                    end,
                },
            },    
        }, 
        color = {
            type = "group",
            name = "Color",
            desc = "Configuration of the colors.",
            order = 7,
            args = {
                nameplateTitle = {
                    type = "header",
                    name = "Nameplate Colors",
                    order = 1
                },
                pvpFlaggedColor = {
                    type = "color",
                    name = "PVP Flagged",
                    order = 2,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.pvpFlaggedColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.pvpFlaggedColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                nonpvpFlaggedColor = {
                    type = "color",
                    name = "Not PVP Flagged",
                    order = 3,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.nonpvpFlaggedColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.nonpvpFlaggedColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                neutralColor= {
                    type = "color",
                    name = "Neutral Color",
                    order = 4,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.neutralColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.neutralColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                hostileColor = {
                    type = "color",
                    name = "Hostile Color",
                    order = 5,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.hostileColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
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
                    order = 6,
                    width = "full",
                    confirm = function()
                        sNamePlates:RNamePlateColors()
                    end, 
                },   
                textTitle = {
                    type = "header",
                    name = "Text Colors",
                    order = 20,
                },
                nameColor = {
                    type = "color",
                    name = "Name",
                    order = 21,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.nameToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.nameColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.nameColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                healthPercentColor = {
                    type = "color",
                    name = "Health Percent",
                    order = 22,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthPercentToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.healthPercentColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.healthPercentColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                healthAmmountColor = {
                    type = "color",
                    name = "Health Ammount",
                    order = 23,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.healthAmmountToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.healthAmmountColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.healthAmmountColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                castbarNameColor = {
                    type = "color",
                    name = "Cast Name",
                    order = 24,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle or not sNamePlates.db.profile.castbarFontToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.castbarNameColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.castbarNameColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                castbarTimeColor = {
                    type = "color",
                    name = "Cast Time",
                    order = 25,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle or not sNamePlates.db.profile.castbarFontToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.castbarTimeColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.castbarTimeColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                textColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset text colors.",
                    order = 26,
                    width = "full",
                    disabled = function() 
                        if not sNamePlates.db.profile.nameToggle 
                        and not sNamePlates.db.profile.healthPercentToggle
                        and not sNamePlates.db.profile.healthAmmountToggle 
                        and (not sNamePlates.db.profile.castbarToggle or not sNamePlates.db.profile.castbarFontToggle) then 
                            return true
                        else
                            return false
                        end
                    end,
                    confirm = function()
                        sNamePlates:RTextColors()
                    end, 
                },   
                highlightTitle = {
                    type = "header",
                    name = "Highlight Color",
                    order = 40,
                },
                highlightColor = {
                    type = "color",
                    name = "Highlight",
                    order = 41,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.highlightColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
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
                    order = 42,
                    width = "full",
                    confirm = function()
                        sNamePlates:RHighlightColors()
                    end, 
                },   
                backgroundTitle = {
                    type = "header",
                    name = "Background Colors",
                    order = 43,
                },
                backgroundNameplateColor = {
                    type = "color",
                    name = "Nameplate",
                    order = 44,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.backgroundNameplateColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.backgroundNameplateColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                backgroundCastbarColor = {
                    type = "color",
                    name = "Castbar",
                    order = 45,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.backgroundCastbarColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.backgroundCastbarColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                backgroundColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset background colors.",
                    order = 46,
                    width = "full",
                    confirm = function()
                        sNamePlates:RBackgroundColors()
                    end, 
                },   
                borderTitle = {
                    type = "header",
                    name = "Border Colors",
                    order = 60,
                },
                healthbarBorderColor = {
                    type = "color",
                    name = "Nameplate",
                    order = 61,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.healthbarBorderColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.healthbarBorderColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                castbarBorderColor = {
                    type = "color",
                    name = "Castbar",
                    order = 62,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.castbarBorderColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.castbarBorderColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                castbarIconBorderColor= {
                    type = "color",
                    name = "Castbar Icon",
                    order = 63,
                    hasAlpha = true,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.castbarIconBorderColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
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
                    order = 64,
                    width = "full",
                    confirm = function()
                        sNamePlates:RBorderColors()
                    end, 
                },
                aggroBorderColorTitle = {
                    type = "header",
                    name = "Aggro Border Colors",
                    order = 80,
                },
                aggroBorderAttackingColor = {
                    type = "color",
                    name = "Attacking You",
                    order = 81,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.aggroBorderToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.aggroBorderAttackingColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.aggroBorderAttackingColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                aggroBorderAboutAttackingColor = {
                    type = "color",
                    name = "About to Attack You",
                    order = 82,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.aggroBorderToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.aggroBorderAboutAttackingColor = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.aggroBorderAboutAttackingColor
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                aggroBorderColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset aggro border colors.",
                    order = 83,
                    width = "full",
                    disabled = function() 
                        return not sNamePlates.db.profile.aggroBorderToggle
                    end,
                    confirm = function()
                        sNamePlates:RAggroBorderColors()
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
                    width = "full",
                    disabled = function() 
                        return not sNamePlates.db.profile.tarIndicatorToggle
                    end,
                    confirm = function()
                        sNamePlates:RTIColors()
                    end, 
                },   
                CBColorTitle = {
                    type = "header",
                    name = "Castbar Color",
                    order = 120,
                },
                CBColorInterruptible = {
                    type = "color",
                    name = "interruptible",
                    order = 121,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.CBColorInterruptible = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.CBColorInterruptible
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                CBColorNotInterruptible = {
                    type = "color",
                    name = "Not Interruptible",
                    order = 122,
                    hasAlpha = true,
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle
                    end,
                    set = function(info, r, g, b, a)
                        sNamePlates.db.profile.CBColorNotInterruptible = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = a}
                    end,
                    get = function(info, r, g, b, a) 
                        local c = sNamePlates.db.profile.CBColorNotInterruptible
					    return c.r, c.g, c.b, c.a      
                    end,
                },
                CBColorExecute = {
                    type = "execute",
                    name = "Reset",
                    desc = "Reset castbar colors.",
                    order = 123,
                    width = "full",
                    disabled = function() 
                        return not sNamePlates.db.profile.castbarToggle
                    end,
                    confirm = function()
                        sNamePlates:RCBColors()
                    end, 
                },
            },
        },
    },
}

sNamePlates.defaults = {
    profile = {
        --Nameplate
        nameplateWidth = 130,
        nameplateHeight = 14,

        nameplateTexture = "Armory",
        highlightTexture = "Armory",
        backgroundTexture = "Armory",

        nameplateXOffset = 0,
        nameplateYOffset = 0,

        separationValue = 4,

        aggroBorderToggle = true,

        --Target
        alphaToggle = false,
        alphaValue = 0.3,

        tarIndicatorToggle = true,
        tarIndicatorSelect = 2,
        inverseSelect = true,
        TIWidth = 57,
        TIHeight = 56,
        TIseparation = 0,
        TIXOffset = 0,
        TIYOffset = 0,

        scaleToggle = false,
        scaleValue = 1,

        --Castbar
        castbarToggle = true,
        castbarHeight = 6,
        castbarTexture = "Armory",
        castbarBackgroundTexture = "Armory",

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

        castbarFontToggle = true,
        castbarFontSize = 13,
        castbarFont = "Continuum Medium",
        castbarFontOutline = "OUTLINE",
        shCastbarSelect = false,

        --Icons
        iconsToggle = true,
        iconWidth = 35,
        iconHeight = 20,
        iconXOffset = 0,
        iconYOffset = 5,

        --Color
        pvpFlaggedColor = {["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1},
        nonpvpFlaggedColor = {["r"] = 0, ["g"] = 0, ["b"] = 1, ["a"] = 1},
        neutralColor = {["r"] = 1, ["g"] = 1, ["b"] = 0, ["a"] = 1},
        hostileColor = {["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1},

        nameColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},
        healthPercentColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},
        healthAmmountColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},
        castbarNameColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},
        castbarTimeColor = {["r"] =  0.84, ["g"] = 0.75, ["b"] =0.65, ["a"] = 1},

        highlightColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 1},

        backgroundNameplateColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 1},
        backgroundCastbarColor = {["r"] = 0.25, ["g"] = 0.25, ["b"] = 0.25, ["a"] = 1},

        healthbarBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1},
        castbarBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1},
        castbarIconBorderColor = {["r"] = 0, ["g"] = 0, ["b"] = 0, ["a"] = 1},

        aggroBorderAttackingColor = {["r"] = 0.99, ["g"] = 0, ["b"] = 0, ["a"] = 1},
        aggroBorderAboutAttackingColor = {["r"] = 0.99, ["g"] = 0.99, ["b"] = 0.47, ["a"] = 1},

        TIColor = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1},

        CBColorInterruptible = {["r"] = 0.85, ["g"] = 0.61, ["b"] = 0.15, ["a"] = 1},
        CBColorNotInterruptible = {["r"] = 0.8, ["g"] = 0.1, ["b"] = 0.1, ["a"] = 1},
    }
}