local AceGUI = LibStub("AceGUI-3.0")
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale("QuickStatsLive")

QuickStatsLive = LibStub("AceAddon-3.0"):NewAddon("QuickStatsLive", "AceEvent-3.0", "AceConsole-3.0")
_QuickStatsLive = {...}

FillLocalizedClassList(LOCALIZED_CLASS_NAMES_MALE)

--[[
	UI Related Functions
--]]
function QuickStatsLive:UpdateUI()
	local cId = Player.class.fileName
	local charEnabled = self.db.char.override_enabled
	local res

	local tablePointer
	if charEnabled then
		tablePointer = self.db.char.stats
	else
		tablePointer = self.db.class[cId]
	end
	
	res = MsgUtil:GetMessage(tablePointer)
	self.liveFrame:ReDraw(res)

	return true
end

function QuickStatsLive:SaveAndApply()
	self:UpdateUI()
end

function QuickStatsLive:Toggles()
	self:UpdateUI()
end

function QuickStatsLive:FrameDisplay(toggle)
	if toggle then
		self.liveFrame:Show()
	else
		self.liveFrame:Hide()
	end
	self:UpdateUI()
end

function QuickStatsLive:FrameMovable(val)
	self.liveFrame:SetMovable(val)
end

--[[ 
	QuickStatsLive Configuration Options
--]]
local _QuickStatsLiveOptions = {...}
-- DataBase default Options
_QuickStatsLiveOptions.defaults = {

	global = {
		locale = 'enUS',
		locale_diff = false,
		selected_class = Player.class.fileName,
		debug = false,
		cmd = 'quickstatslive',
		rgba = {
			text = {
				r = 1.0,
				g = 1.0,
				b = 1.0,
				a = 1.0,
			},
			backdrop = {
				r = 1.0,
				g = 1.0,
				b = 1.0,
				a = 1.0,
			},
		},
	},
	
	char = {
		frame_enabled = true,
		frame_move_enabled = true,
		override_enabled = false,
		addon_loaded = false,
		stats = {
			health = false,
			health_max = false,
			health_regen = false,
			power = false,
			power_max = false,
			mana_regen = false,
			melee_dmg = false,
			melee_power = false,
			melee_crit = false,
			range_dmg = false,
			range_power = false,
			range_crit = false,
			parry = false,
			block = false,
			dodge = false,
			armor = false,
			strength = false,
			agility = false,
			stamina = false,
			intellect = false,
			spirit = false,
			bag_free_slots = false,
			durability = false,
		},
	},
	
	class = {
		WARRIOR = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		PALADIN = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		HUNTER = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		ROGUE = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		PRIEST = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		SHAMAN = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		MAGE = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		WARLOCK = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		DRUID = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		MONK = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		DEATHKNIGHT = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
		DEMONHUNTER = {
			armor = true,
			strength = true,
			agility = true,
			stamina = true,
			intellect = true,
			spirit = true,
			bag_free_slots = true,
			durability = true,
		},
	},
}

-- Command Line options, Uses _QuickStatsLiveOptions but used in bellow options.
function QuickStatsLive:QuickStatsLiveSlash(input)
	if input == "" or not input then -- no args ATM
		QuickStatsLiveConfigFrame:ToggleFrame()
	end
	return 
end
function QuickStatsLive:RenewCmd(old, cmd)
	QuickStatsLive:UnregisterChatCommand(old)
	QuickStatsLive:RegisterChatCommand(cmd, "QuickStatsLiveSlash")
end
function QuickStatsLive:Colorize()
	self.liveFrame:ColorizeText(self.db.global.rgba.text.r, self.db.global.rgba.text.g, self.db.global.rgba.text.b)
	self.liveFrame:ColorizeBackdrop(self.db.global.rgba.backdrop.r, self.db.global.rgba.backdrop.g, self.db.global.rgba.backdrop.b, self.db.global.rgba.backdrop.a)
end

-- Blizzard AddOn-Interface Frame 'content'
local options = {
    name = "QuickStatsLive",
    handler = QuickStatsLive,
    type = "group",
    childGroups = "tab",
    args = {
        general_tab = {
            name = L["General"],
            type = "group",
            order = 1,
            args = {
                addon_enabled = {
                    type = "toggle",
                    order = 1,
                    name = L["Show StatBlock"],
                    desc = L["Show or hide QuickStatsLive' StatBlock."],
                    width = "normal",
                    get = function ()
							return QuickStatsLive.db.char.frame_enabled
						end,
                    set = function (info, value)
							QuickStatsLive.db.char.frame_enabled = value
							QuickStatsLive:FrameDisplay(value)
						end,
                },
				
				general_description_header = {
					type = "header",
					order = 5,
					name = L[" "],
				},
				general_description_QuickStatsLive = {
					type = "description",
					order = 6,
					width = "full",
					fontSize = "medium",
					name = L["QuickStatsLive works with a text block, named 'StatBlock', filled with selected informations. You can move the StatBlock, and change the text and background colors."],
				},
				general_description_profile = {
					type = "description",
					order = 7,
					width = "full",
					fontSize = "medium",
					name = L["QuickStatsLive 'By Class' tab are default display options, shared accross your account so every new character's StatBlock will already have the corresponding class options displayed."],
				},
				general_description_current = {
					type = "description",
					order = 8,
					width = "full",
					fontSize = "medium",
					name = L["QuickStatsLive 'By Char' tab allows you to override the class options, so your actual character can have a custom display options."],
				},
				
				general_locale_header = {
					type = "header",
					order = 10,
					name = L[" "],
				},
				custom_cmd = {
					type = "input",
					order = 11,
					name = L["Change command line"],
					desc = L["Customize the command name for chat acces. You don't need to provide the Slash /"],
					get = function()
						return QuickStatsLive.db.global.cmd
					end,
					set = function(input, value)
						QuickStatsLive:RenewCmd(QuickStatsLive.db.global.cmd, value)
						QuickStatsLive.db.global.cmd = value
					end,
				},
				general_colors_header = {
					type = "header",
					order = 20,
					name = L["Stat Block Options"],
				},
				frame_move_enabled = {
					type = "toggle",
					order = 22,
					name = L["Enable Frame moving"],
					desc = L["Allows you to move the StatBlock, or lock its position."],
					width = "normal",
					get = function()
							return QuickStatsLive.db.char.frame_move_enabled
						end,
					set = function(info, value)
							QuickStatsLive.db.char.frame_move_enabled = value
							QuickStatsLive:FrameMovable(value)
						end,
				},
				text_color_pick = {
					type = "color",
					order = 23,
					width = "full",
					name = L["Change Text color"],
					desc = L["Customize the StatBlock Text color"],
					get = function()
						return QuickStatsLive.db.global.rgba.text.r, QuickStatsLive.db.global.rgba.text.g, QuickStatsLive.db.global.rgba.text.b, QuickStatsLive.db.global.rgba.text.a
					end,
					set = function(input, r, g, b, a)
						QuickStatsLive.db.global.rgba.text.r = r
						QuickStatsLive.db.global.rgba.text.g = g
						QuickStatsLive.db.global.rgba.text.b = b
						QuickStatsLive.db.global.rgba.text.a = a
						QuickStatsLive:Colorize()
					end,
				},
				backdrop_color_pick = {
					type = "range",
					order = 24,
					width = "full",
					name = L["Change Backdrop transparency"],
					desc = L["Customize the StatBlock Backdrop transparency"],
					min = 0,
					max = 1,
					get = function()
						return QuickStatsLive.db.global.rgba.backdrop.a
					end,
					set = function(input, a)
						-- QuickStatsLive.db.global.rgba.backdrop.r = r
						-- QuickStatsLive.db.global.rgba.backdrop.g = g
						-- QuickStatsLive.db.global.rgba.backdrop.b = b
						QuickStatsLive.db.global.rgba.backdrop.a = a
						QuickStatsLive:Colorize()
					end,
				},
			}
		},

		by_class_tab = {
			name = L["By Class"],
			type = "group",
			order = 2,
			args = {
				by_class_dropdown = {
					type = "select",
					order = 1,
					values = {
						['WARRIOR'] = LOCALIZED_CLASS_NAMES_MALE['WARRIOR'],
						['PALADIN'] = LOCALIZED_CLASS_NAMES_MALE['PALADIN'],
						['HUNTER'] = LOCALIZED_CLASS_NAMES_MALE['HUNTER'],
						['ROGUE'] = LOCALIZED_CLASS_NAMES_MALE['ROGUE'],
						['PRIEST'] = LOCALIZED_CLASS_NAMES_MALE['PRIEST'],
						['SHAMAN'] = LOCALIZED_CLASS_NAMES_MALE['SHAMAN'],
						['MAGE'] = LOCALIZED_CLASS_NAMES_MALE['MAGE'],
						['WARLOCK'] = LOCALIZED_CLASS_NAMES_MALE['WARLOCK'],
						['DRUID'] = LOCALIZED_CLASS_NAMES_MALE['DRUID'],
						--[[ Not WoW Classic
						['MONK'] = LOCALIZED_CLASS_NAMES_MALE['MONK'],
						['DEATHKNIGHT'] = LOCALIZED_CLASS_NAMES_MALE['DEATHKNIGHT'],
						['DEMONHUNTER'] = LOCALIZED_CLASS_NAMES_MALE['DEMONHUNTER'],
						]]--
					},
					style = 'dropdown',
					name = L["Select a class"],
					get = function()
							return QuickStatsLive.db.global.selected_class
						end,
					set = function(input, class)
							QuickStatsLive.db.global.selected_class = class
						end,
				},
				
				by_class_sheet_header = {
					type = "header",
					order = 10,
					name = L["General"],
				},
				by_class_health_enabled = {
					type = "toggle",
					order = 11,
					name = L["Show Health"],
					desc = L["Show or hide Health"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].health
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].health = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_health_max_enabled = {
					type = "toggle",
					order = 12,
					name = L["Show Max Health"],
					desc = L["Show or hide Max Health"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].health_max
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].health_max = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_mana_enabled = {
					type = "toggle",
					order = 13,
					name = L["Show Power"],
					desc = L["Show or hide Power (Mana, Energy, Rage...)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].power
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].power = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_mana_max_enabled = {
					type = "toggle",
					order = 14,
					name = L["Show Max Power"],
					desc = L["Show or hide Maximum Power (Mana, Energy, Rage...)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].power_max
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].power_max = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_mana_regen_enabled = {
					type = "toggle",
					order = 15,
					name = L["Show Power Regen"],
					desc = L["Show or hide Power Regen (Mana, Energy, Rage...)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].power_regen
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].power_regen = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_combat_header = {
					type = "header",
					order = 20,
					name = L["Combat Options"],
				},
				by_class_melee_dmg_enabled = {
					type = "toggle",
					order = 21,
					name = L["Show Melee Damages"],
					desc = L["Show or hide Melee Damages"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].melee_dmg
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].melee_dmg = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_melee_pow_enabled = {
					type = "toggle",
					order = 22,
					name = L["Show Melee Power"],
					desc = L["Show or hide Melee Power"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].melee_power
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].melee_power = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_melee_crit_enabled = {
					type = "toggle",
					order = 23,
					name = L["Show Melee Crit"],
					desc = L["Show or hide Melee Critic Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].melee_crit
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].melee_crit = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_range_dmg_enabled = {
					type = "toggle",
					order = 24,
					name = L["Show Range Damages"],
					desc = L["Show or hide Range Damages"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].range_dmg
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].range_dmg = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_range_pow_enabled = {
					type = "toggle",
					order = 25,
					name = L["Show Range Power"],
					desc = L["Show or hide Range Power"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].range_power
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].range_power = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_range_crit_enabled = {
					type = "toggle",
					order = 26,
					name = L["Show Range Crit"],
					desc = L["Show or hide Range Critic Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].range_crit
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].range_crit = value
							QuickStatsLive:Toggles()
						end,
				},				
				by_class_parry_enabled = {
					type = "toggle",
					order = 27,
					name = L["Show Parry"],
					desc = L["Show or hide Parry Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].parry
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].parry = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_block_enabled = {
					type = "toggle",
					order = 28,
					name = L["Show Block"],
					desc = L["Show or hide Block Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].block
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].block = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_dodge_enabled = {
					type = "toggle",
					order = 29,
					name = L["Show Dodge"],
					desc = L["Show or hide Dodge Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].dodge
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].dodge = value
							QuickStatsLive:Toggles()
						end,
				},
				
				by_class_attributes_header = {
					type = "header",
					order = 40,
					name = L["Attributes Options"],
				},
				by_class_armor_enabled = {
					type = "toggle",
					order = 41,
					name = L["Show Armor"],
					desc = L["Show or hide Armor"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].armor
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].armor = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_strength_enabled = {
					type = "toggle",
					order = 42,
					name = L["Show Strength"],
					desc = L["Show or hide Strength"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].strength
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].strength = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_agility_enabled = {
					type = "toggle",
					order = 43,
					name = L["Show Agility"],
					desc = L["Show or hide Agility"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].agility
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].agility = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_stamina_enabled = {
					type = "toggle",
					order = 44,
					name = L["Show Stamina"],
					desc = L["Show or hide Stamina"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].stamina
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].stamina = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_intellect_enabled = {
					type = "toggle",
					order = 45,
					name = L["Show Intellect"],
					desc = L["Show or hide Intellect"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].intellect
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].intellect = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_spirit_enabled = {
					type = "toggle",
					order = 46,
					name = L["Show Spirit"],
					desc = L["Show or hide Spirit"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].spirit
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].spirit = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_free_slots_enabled = {
					type = "toggle",
					order = 47,
					name = L["Show Free Slots"],
					desc = L["Show or hide your classic bags free slots"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].bag_free_slots
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].bag_free_slots = value
							QuickStatsLive:Toggles()
						end,
				},
				by_class_durability_enabled = {
					type = "toggle",
					order = 48,
					name = L["Show Durability"],
					desc = L["Show or hide the durability (in percent)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].durability
						end,
					set = function(input, value)
							QuickStatsLive.db.class[QuickStatsLive.db.global.selected_class].durability = value
							QuickStatsLive:Toggles()
						end,
				},
			}
		},
		
		by_char_tab = {
			name = L["By Char"],
			type = "group",
			order = 3,
			args = {
				by_char_enabled = {
                    type = "toggle",
                    order = 1,
                    name = L["Enable Class override"],
                    desc = L["Allow to use custom options for the current character"],
                    width = "full",
                    get = function ()
							return QuickStatsLive.db.char.override_enabled
						end,
                    set = function (info, value)
							QuickStatsLive.db.char.override_enabled = value
							QuickStatsLive:Toggles()
						end,
                },
				
				by_char_sheet_header = {
					type = "header",
					order = 10,
					name = L["General"],
				},
				by_char_health_enabled = {
					type = "toggle",
					order = 11,
					name = L["Show Health"],
					desc = L["Show or hide Health"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.health
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.health = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_health_max_enabled = {
					type = "toggle",
					order = 12,
					name = L["Show Max Health"],
					desc = L["Show or hide Max Health"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.health_max
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.health_max = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_mana_enabled = {
					type = "toggle",
					order = 13,
					name = L["Show Power"],
					desc = L["Show or hide Power (Mana, Energy, Rage...)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.power
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.power = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_mana_max_enabled = {
					type = "toggle",
					order = 14,
					name = L["Show Max Power"],
					desc = L["Show or hide Maximum Power (Mana, Energy, Rage...)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.power_max
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.power_max = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_mana_regen_enabled = {
					type = "toggle",
					order = 15,
					name = L["Show Power Regen"],
					desc = L["Show or hide Power Regen (Mana, Energy, Rage...)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.power_regen
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.power_regen = value
							QuickStatsLive:Toggles()
						end,
				},
				
				by_by_char_combat_header = {
					type = "header",
					order = 20,
					name = L["Combat Options"],
				},
				by_char_melee_dmg_enabled = {
					type = "toggle",
					order = 21,
					name = L["Show Melee Damages"],
					desc = L["Show or hide Melee Damages"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.melee_dmg
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.melee_dmg = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_melee_pow_enabled = {
					type = "toggle",
					order = 22,
					name = L["Show Melee Power"],
					desc = L["Show or hide Melee Power"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.melee_power
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.melee_power = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_melee_crit_enabled = {
					type = "toggle",
					order = 23,
					name = L["Show Melee Crit"],
					desc = L["Show or hide Melee Critic Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.melee_crit
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.melee_crit = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_range_dmg_enabled = {
					type = "toggle",
					order = 24,
					name = L["Show Range Damages"],
					desc = L["Show or hide Range Damages"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.range_dmg
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.range_dmg = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_range_pow_enabled = {
					type = "toggle",
					order = 25,
					name = L["Show Range Power"],
					desc = L["Show or hide Range Power"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.range_power
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.range_power = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_range_crit_enabled = {
					type = "toggle",
					order = 26,
					name = L["Show Range Crit"],
					desc = L["Show or hide Range Critic Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.range_crit
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.range_crit = value
							QuickStatsLive:Toggles()
						end,
				},				
				by_char_parry_enabled = {
					type = "toggle",
					order = 27,
					name = L["Show Parry"],
					desc = L["Show or hide Parry Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.parry
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.parry = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_block_enabled = {
					type = "toggle",
					order = 28,
					name = L["Show Block"],
					desc = L["Show or hide Block Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.block
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.block = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_dodge_enabled = {
					type = "toggle",
					order = 29,
					name = L["Show Dodge"],
					desc = L["Show or hide Dodge Chance"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.dodge
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.dodge = value
							QuickStatsLive:Toggles()
						end,
				},
				
				by_by_char_attributes_header = {
					type = "header",
					order = 40,
					name = L["Attributes Options"],
				},								
				by_char_armor_enabled = {
					type = "toggle",
					order = 41,
					name = L["Show Armor"],
					desc = L["Show or hide Armor"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.armor
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.armor = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_strength_enabled = {
					type = "toggle",
					order = 42,
					name = L["Show Strength"],
					desc = L["Show or hide Strength"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.strength
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.strength = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_agility_enabled = {
					type = "toggle",
					order = 43,
					name = L["Show Agility"],
					desc = L["Show or hide Agility"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.agility
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.agility = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_stamina_enabled = {
					type = "toggle",
					order = 44,
					name = L["Show Stamina"],
					desc = L["Show or hide Stamina"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.stamina
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.stamina = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_intellect_enabled = {
					type = "toggle",
					order = 45,
					name = L["Show Intellect"],
					desc = L["Show or hide Intellect"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.intellect
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.intellect = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_spirit_enabled = {
					type = "toggle",
					order = 46,
					name = L["Show Spirit"],
					desc = L["Show or hide Spirit"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.spirit
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.spirit = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_free_slots_enabled = {
					type = "toggle",
					order = 47,
					name = L["Show Free Slots"],
					desc = L["Show or hide your classic bags free slots"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.bag_free_slots
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.bag_free_slots = value
							QuickStatsLive:Toggles()
						end,
				},
				by_char_durability_enabled = {
					type = "toggle",
					order = 48,
					name = L["Show Durability"],
					desc = L["Show or hide the durability (in percent)"],
					width = "full",
					get = function()
							return QuickStatsLive.db.char.stats.durability
						end,
					set = function(input, value)
							QuickStatsLive.db.char.stats.durability = value
							QuickStatsLive:Toggles()
						end,
				},
			}
		},
	}
}

function QuickStatsLive:OnInitialize()
	-- Load DB
    self.db = LibStub("AceDB-3.0"):New("QuickStatsLiveConfig", _QuickStatsLiveOptions.defaults, true)
	
	-- Register /QuickStatsLive cmd
    self:RegisterChatCommand(self.db.global.cmd, "QuickStatsLiveSlash")

	-- Main Frame display
	self.liveFrame = QuickStatsLiveFrame:Create()
	self:FrameDisplay(self.db.char.frame_enabled)
	self:Colorize()
	self.liveFrame:SetMovable(self.db.char.frame_move_enabled)

	-- Force default class
	self.db.global.selected_class = Player.class.fileName

	-- Register Options frame to Blizzard > Interface
    LibStub("AceConfig-3.0"):RegisterOptionsTable("QuickStatsLive", options)
    self.configFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("QuickStatsLive", "QuickStatsLive")

	-- Init Event Handler Static
	QuickStatsLiveEventHandler.inst = QuickStatsLive
	
	-- Register Events
	QuickStatsLive:RegisterEvent("PLAYER_ENTERING_WORLD", QuickStatsLiveEventHandler.WORLD_ENTERED)
	
	QuickStatsLive:RegisterEvent("CHARACTER_POINTS_CHANGED", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", QuickStatsLiveEventHandler.CHAR_UPDATE)
	-- Health
	QuickStatsLive:RegisterEvent("UNIT_HEALTH", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("UNIT_MAXHEALTH", QuickStatsLiveEventHandler.CHAR_UPDATE)
	-- Power (Mana, Energy, Rage ...)
	QuickStatsLive:RegisterEvent("UNIT_POWER_UPDATE", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("UNIT_MAXPOWER", QuickStatsLiveEventHandler.CHAR_UPDATE)
	-- Res
	QuickStatsLive:RegisterEvent("UNIT_RESISTANCES", QuickStatsLiveEventHandler.CHAR_UPDATE)
	-- Buff, debuff ...
	QuickStatsLive:RegisterEvent("UNIT_AURA", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("UNIT_ATTACK_POWER", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("UNIT_RANGED_ATTACK_POWER", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("UNIT_ATTACK_SPEED", QuickStatsLiveEventHandler.CHAR_UPDATE)
	-- Bag update
	QuickStatsLive:RegisterEvent("BAG_UPDATE", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("BAG_CLOSED", QuickStatsLiveEventHandler.CHAR_UPDATE)
	QuickStatsLive:RegisterEvent("UNIT_INVENTORY_CHANGED", QuickStatsLiveEventHandler.CHAR_UPDATE)
	
	
	if not self.db.char.addon_loaded then	
		print(QuickStatsLiveLocale:GetUIString('Configure QuickStatsLive by typing /#0 in your chat or open Blizzard Menu with Esc > Interface > Add-ons tab > QuickStatsLive', self.db.global.cmd))
		self.db.char.addon_loaded = true
	end
end

function QuickStatsLive:OnEnable()
	-- 
end

function QuickStatsLive:OnDisable()
	--
end