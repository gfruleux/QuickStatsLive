local trunc = true;
local truncVal = 2;
function truncate(number, decimals)
    return number - (number % (0.1 ^ decimals));
end
function nl(l)
	return l .. "\n";
end

local playerLocation = PlayerLocation:CreateFromUnit("player");
local className, classFile, classId = C_PlayerInfo.GetClass(playerLocation);

DurabilityStatUtil = {
	populated = false,
	slotIdList = {},
};
function DurabilityStatUtil:Populate()
	if not self.populated then
		local slotId, tn;
	-- Head to Feet
		slotId, tn = GetInventorySlotInfo("HEADSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("NECKSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("SHOULDERSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("SHIRTSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("CHESTSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("TABARDSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("WRISTSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("HANDSSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("WAISTSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("LEGSSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("FEETSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("MAINHANDSLOT");
		table.insert(self.slotIdList, slotId);
		slotId, tn = GetInventorySlotInfo("SECONDARYHANDSLOT");
		table.insert(self.slotIdList, slotId);
		
		self.populated = true;
	end
end
DurabilityStatUtil:Populate();

--[[
	Player
]]--
Player = {
	name = select(1, UnitName("player")),
	class = {
		name = className,
		fileName = classFile,
		id = classId,
	},
}

--[[
	PlayerUtil
]]--
PlayerUtil = {};
-- TODO: Cache values, use tick 
function PlayerUtil:GetHealth() -- implies 'Current Health'
	return UnitHealth("player");
end
function PlayerUtil:GetHealthMax()
	return UnitHealthMax("player");
end
function PlayerUtil:GetPower()
	return UnitPower("player");
end
function PlayerUtil:GetPowerMax()
	return UnitPowerMax("player");
end
function PlayerUtil:GetPowerRegen() -- implies 'Base Mana Regen'
	local base, casting = GetManaRegen()
	if trunc then
		base = truncate(base, truncVal);
	end
	return base*5;
end
function PlayerUtil:GetManaRegenCasting()
	local base, casting = GetManaRegen()
	if trunc then
		casting = truncate(casting, truncVal);
	end
	return casting;
end
function PlayerUtil:GetCritChanceSpell()
	local holySchool = 2;
    local minCrit = GetSpellCritChance(holySchool);
	local spellCrit;
    for i=(holySchool+1), 7 do
        spellCrit = GetSpellCritChance(i);
		minCrit = min(minCrit, spellCrit);
    end
	if trunc then
		minCrit = truncate(minCrit, truncVal);
	end
    return minCrit;
end
function PlayerUtil:GetMeleeDamages()
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player");
	if trunc then
		lowDmg = truncate(lowDmg, 1);
		hiDmg = truncate(hiDmg, 1);
	end
	return lowDmg, hiDmg;
end
function PlayerUtil:GetMeleePower()
	local base, pos, neg = UnitAttackPower("player");
	return (base + pos + neg);
end
function PlayerUtil:GetMeleeCritChance()
	local crit = GetCritChance();
	if trunc then
		crit = truncate(crit, truncVal);
	end
	return crit;
end
function PlayerUtil:GetRangeDamages()
	local speed, lowDmg, hiDmg, posBuff, negBuff, percent = UnitRangedDamage("player");
	if trunc then
		lowDmg = truncate(lowDmg, 1);
		hiDmg = truncate(hiDmg, 1);	
	end
	return lowDmg, hiDmg;
end
function PlayerUtil:GetRangePower()
	return UnitRangedAttackPower("player");
end
function PlayerUtil:GetRangeCritChance()
	local crit = GetRangedCritChance();
	if trunc then
		crit = truncate(crit, truncVal);
	end
	return crit;
end
function PlayerUtil:GetParryChance()
	local parry = GetParryChance();
	if trunc then
		parry = truncate(parry, truncVal);
	end
	return parry;
end
function PlayerUtil:GetBlockChance()
	local block = GetBlockChance();
	if trunc then
		block = truncate(block, truncVal);
	end
	return block;
end
function PlayerUtil:GetDodgeChance()
	local dodge = GetDodgeChance();
	if trunc then
		dodge = truncate(dodge, truncVal);
	end
	return dodge;
end
function PlayerUtil:GetArmor()
	local baseArmor , effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
	return effectiveArmor;
end
function PlayerUtil:GetStrength()
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 1);
	return effectiveStat;
end
function PlayerUtil:GetAgility()
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 2);
	return effectiveStat;
end
function PlayerUtil:GetStamina()
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 3);
	return effectiveStat;
end
function PlayerUtil:GetIntellect()
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 4);
	return effectiveStat;
end
function PlayerUtil:GetSpirit()
	local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 5);
	return effectiveStat;
end
function PlayerUtil:GetFreeSlots()
	local total = 0;
	for bagId=0, 4 do
		local freeSlots, bagType = GetContainerNumFreeSlots(bagId);
		if bagType == 0 then -- only classical bags
			total = total + freeSlots;
		end
	end
	return total;
end
function PlayerUtil:GetDurability()
	local sumCurrentDura, sumMaxDura, finalDura = 0, 0, 0;
	for k, v in pairs(DurabilityStatUtil.slotIdList) do
		local cur, max = GetInventoryItemDurability(v);
		if max then -- cur could be 0
			sumCurrentDura = sumCurrentDura + cur;
			sumMaxDura = sumMaxDura + max;
		end
	end
	if sumMaxDura > 0 then 
		finalDura = (sumCurrentDura / sumMaxDura) * 100;
		if finalDura ~= 100 and trunc then -- prevent trunc on 100% durability
			finalDura = truncate(finalDura, truncVal);
		end
	else
		finalDura = 0;
	end
	return finalDura;
end
--[[
	//Player Util
]]--


DisplayableStatsUtil = {
	"health",
	"health_max",
	"health_regen",
	"power",
	"power_max",
	"power_regen",
	"melee_dmg",
	"melee_power",
	"melee_crit",
	"range_dmg",
	"range_power",
	"range_crit",
	"parry",
	"block",
	"dodge",
	"armor",
	"strength",
	"agility",
	"stamina",
	"intellect",
	"spirit",
	"bag_free_slots",
	"durability",
};

--[[
	MsgUtil
]]--
MsgUtil = {};
function MsgUtil:Health()
	return QuickStatsLiveLocale:GetUIString("Health: #0", PlayerUtil:GetHealth());
end
function MsgUtil:HealthMax()
	return QuickStatsLiveLocale:GetUIString("Health Max: #0", PlayerUtil:GetHealthMax());
end
function MsgUtil:HealthRegen()
	return QuickStatsLiveLocale:GetUIString("Health Regen: #0", "TODO");
end
function MsgUtil:Power()
	return QuickStatsLiveLocale:GetUIString("Power: #0", PlayerUtil:GetPower());
end
function MsgUtil:PowerMax()
	return QuickStatsLiveLocale:GetUIString("Power Max: #0", PlayerUtil:GetPowerMax());
end
function MsgUtil:PowerRegen()
	return QuickStatsLiveLocale:GetUIString("Power Regen: #0", PlayerUtil:GetPowerRegen());
end
--[[function MsgUtil:ManaRegenCast()
	return "Mana Regen Cast: " .. PlayerUtil:GetManaRegenCasting();
end
function MsgUtil:SpellCrit()
	return "Crit Spell: " .. PlayerUtil:GetCritChanceSpell() .. "%";
end]]--
function MsgUtil:MeleeDmg()
	local low, high = PlayerUtil:GetMeleeDamages();
	return QuickStatsLiveLocale:GetUIString("Melee Dmg: #0 - #1", low, high);
end
function MsgUtil:MeleePower()
	return QuickStatsLiveLocale:GetUIString("Melee Pow: #0", PlayerUtil:GetMeleePower());
end
function MsgUtil:MeleeCrit()
	return QuickStatsLiveLocale:GetUIString("Melee Crit: #0%", PlayerUtil:GetMeleeCritChance());
end
function MsgUtil:RangeDmg()
	local low, high = PlayerUtil:GetRangeDamages();
	return QuickStatsLiveLocale:GetUIString("Range Dmg: #0 - #1", low, high);
end
function MsgUtil:RangePower()
	return QuickStatsLiveLocale:GetUIString("Range Pow: #0", PlayerUtil:GetRangePower());
end
function MsgUtil:RangeCrit()
	return QuickStatsLiveLocale:GetUIString("Range Crit: #0%", PlayerUtil:GetRangeCritChance());
end
function MsgUtil:Parry()
	return QuickStatsLiveLocale:GetUIString("Parry: #0%", PlayerUtil:GetParryChance());
end
function MsgUtil:Block()
	return QuickStatsLiveLocale:GetUIString("Block: #0%", PlayerUtil:GetBlockChance());
end
function MsgUtil:Dodge()
	return QuickStatsLiveLocale:GetUIString("Dodge: #0%", PlayerUtil:GetDodgeChance());
end
function MsgUtil:Armor()
	return QuickStatsLiveLocale:GetUIString("Armor: #0", PlayerUtil:GetArmor());
end
function MsgUtil:Strength()
	return QuickStatsLiveLocale:GetUIString("Strength: #0", PlayerUtil:GetStrength());
end
function MsgUtil:Agility()
	return QuickStatsLiveLocale:GetUIString("Agility: #0", PlayerUtil:GetAgility());
end
function MsgUtil:Stamina()
	return QuickStatsLiveLocale:GetUIString("Stamina: #0", PlayerUtil:GetStamina());
end
function MsgUtil:Intellect()
	return QuickStatsLiveLocale:GetUIString("Intellect: #0", PlayerUtil:GetIntellect());
end
function MsgUtil:Spirit()
	return QuickStatsLiveLocale:GetUIString("Spirit: #0", PlayerUtil:GetSpirit());
end
function MsgUtil:BagFreeSlots()
	return QuickStatsLiveLocale:GetUIString("Free slots: #0", PlayerUtil:GetFreeSlots());
end
function MsgUtil:Durability()
	return QuickStatsLiveLocale:GetUIString("Durability: #0%", PlayerUtil:GetDurability());
end

function MsgUtil:UtilToFunc(util)
	local result = {}
    for match in (util.."_"):gmatch("(.-)".."_") do -- Split on '_'
		match = match:gsub("^%l", string.upper) -- Uppercase first letters
        table.insert(result, match)
    end
    return table.concat(result, "")
end
function MsgUtil:GetMessage(db)
	local res = {}
	for idx, stat in ipairs(DisplayableStatsUtil) do
		if db[stat] then -- db.char.stats.health = true
			local fn = MsgUtil:UtilToFunc(stat)
			local msg = MsgUtil[fn]()
			table.insert(res, msg)
		end
	end
	return res
end
--[[
	//MsgUtil
]]--