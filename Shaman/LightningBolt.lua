-------------------------------------
--   Welcome to the Thunderdome    --
-------------------------------------

ProbablyEngine.rotation.register_custom(262, "|cff00FFFFMacks|r - [|cff0000CDELE v1.1|r]", {


--{"",{""},""},

---------------------------
--       MODIFIERS       --
---------------------------
{"/cancelaura Ghost Wolf",{"!player.moving", "player.buff(Ghost Wolf)"}},
{"/cancelaura Ghost Wolf",{"player.buff(79206)", "player.buff(Ghost Wolf)"}},
{"/cancelaura Ghost Wolf",{"player.buff(Lava Surge)", "player.buff(Ghost Wolf)"}},
{"/cancelaura Ghost Wolf",{"!player.spell(Earth Shock).cooldown","player.buff(Lightning Shield).count >= 13","target.debuff(Flame Shock).duration >= 9", "player.buff(Ghost Wolf)"}},

{"Earth Shock",{"player.buff(Lightning Shield).count >= 15", "target.range <= 40","target.debuff(Flame Shock).duration >= 9" },"target" },

{"!Ancestral Guidance",{"modifier.lalt","talent(5,2)"},"player"},
{"!Healing Rain",{"modifier.lalt","talent(5,3)"},"mouseover.ground"},
{"!Ascendance",{"modifier.lcontrol"},"player"},
{ "#trinket1",{"player.buff(Ascendance)" },"player"}, 
{ "#trinket2",{"player.buff(Ascendance)" },"player"}, 
{ "Elemental Mastery",{"player.buff(Ascendance)" },"player"}, 
{ "Fire Elemental Totem",{"player.buff(Ascendance)" },"player"}, 
{ "Blood Fury",{"player.buff(Ascendance)" },"player"}, 
{ "Berserking",{"player.buff(Ascendance)" },"player"}, 

{{	-- Cooldowns (thanks to Ake for this section)
	{ "Ancestral Swiftness" },  
	{ "Fire Elemental Totem" }, 
	{ "Storm Elemental Totem" },  
	{ "Elemental Mastery" },  
	{ "#trinket1", { "player.buff(Ascendance)" } }, 
	{ "#trinket2", { "player.buff(Ascendance)" } }, 
	{ "Ascendance", { "!player.buff(Ascendance)"},"player" },
}, "modifier.cooldowns" },

---------------------------
--     SURVIVAL/misc     --
---------------------------
{ "Lightning Shield",{"!player.buff(Lightning Shield)" },"player"},
{"Windwalk Totem",{"!player.buff","player.state.root","!player.totem(Windwalk Totem)","talent(2,3)"},"player"},
{"Windwalk Totem",{"!player.buff","player.state.snare","!player.totem(Windwalk Totem)","talent(2,3)"},"player"},
{"Shamanistic Rage",{"player.health <= 70"},"player"},
{"Astral Shift",{"player.health <= 55","talent(1,3)"},"player"},
{"Stone Bulwark Totem",{"player.health <= 55","talent(1,2)"},"player"},
{ "#5512", "player.health <= 35","player" },  --healthstone
{ "Stoneform", "player.health <= 65" },
{ "Gift of the Naaru", "player.health <= 70", "player" },
{ "Spiritwalker's Grace", { "player.buff(Ascendance)","player.moving"},"player" },

---------------------------
--INTERRUPT & SPELLSTEAL--
---------------------------
{ "Wind Shear", {"modifier.interrupt","target.range <= 25","target.enemy"},"target" },

---------------------------
--  Keep Up Flameshock   --
---------------------------
{"Flame Shock",{"target.debuff(Flame Shock).duration <= 6","target.enemy","target.range <= 40"},"target"},
{{
{"Flame Shock",{"boss1.debuff(Flame Shock).duration <= 6","boss1.enemy","boss1.range <= 40"},"boss1"},
{"Flame Shock",{"boss2.debuff(Flame Shock).duration <= 6","boss2.enemy","boss2.range <= 40"},"boss2"},
{"Flame Shock",{"boss3.debuff(Flame Shock).duration <= 6","boss3.enemy","boss3.range <= 40"},"boss3"},
{"Flame Shock",{"boss4.debuff(Flame Shock).duration <= 6","boss4.enemy","boss4.range <= 40"},"boss4"},
{"Flame Shock",{"boss5.debuff(Flame Shock).duration <= 6","boss5.enemy","boss5.range <= 40"},"boss5"},
},"!player.buff(Ascendance)"},
{"Flame Shock",{"player.buff(Unleash Flame)","target.debuff(Flame Shock).duration < 19","target.range <= 40" },"target" },

---------------------------
--     AOE ROTATION     --
---------------------------
{{
{"Lava Beam",{ "player.buff(Ascendance)","target.range <= 40","!player.moving" },"target" },
{"Lava Beam",{ "player.buff(Ascendance)","target.range <= 40","player.buff(79206)" },"target" },
{"Earthquake", {"player.buff(Improved Chain Lightning)","!player.moving"}, "target.ground" },
{"Earthquake", {"player.buff(Improved Chain Lightning)","player.buff(79206)"}, "target.ground" },
{"Earth Shock",{"player.buff(Lightning Shield).count >= 18","target.range <= 40" },"target" },
{"Chain Lightning",{"target.range <= 40","!player.moving" },"target" },
{"Chain Lightning",{"target.range <= 40","player.buff(79206)" },"target" },
},"toggle.AoESpam"},
---------------------------
-- SINGLE TARGET/Cleave  --
---------------------------
{ "Elemental Blast", { "player.buff(Ancestral Swiftness)","target.range <= 40" },"target" },
{ "Lava Burst", { "player.buff(Ancestral Swiftness)","target.range <= 40" },"target" },
{ "Lava Burst", { "player.buff(Lava Surge)","target.range <= 40" },"target" },
{ "Unleash Flame", { "talent(6, 1)" } },
{"Lava Burst",{"!player.moving","target.range <= 40"},"target"},
{"Lava Burst",{"player.buff(79206)","target.range <= 40"},"target"},
{"Elemental Blast",{"!player.moving","target.range <= 40"},"target"},
{"Elemental Blast",{"player.buff(79206)","target.range <= 40"},"target"},
{"Earth Shock",{"player.buff(Lightning Shield).count >= 15", "target.range <= 40","target.debuff(Flame Shock).duration >= 9" },"target" },
{"Earth Shock",{"!player.buff(79206)","player.moving","player.buff(Lightning Shield).count >= 10", "target.range <= 40","target.debuff(Flame Shock).duration >= 9" },"target" },
{"Searing Totem", { "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)"} },
{"Earthquake", {"modifier.multitarget","player.buff(Improved Chain Lightning)","!player.moving"}, "target.ground" },
{"Earthquake", {"modifier.multitarget","player.buff(Improved Chain Lightning)","player.buff(79206)"}, "target.ground" },
{"Chain Lightning", {"modifier.multitarget","!player.moving","target.range <= 40"}, "target" },
{"Chain Lightning", {"modifier.multitarget","player.buff(79206)","target.range <= 40"}, "target" },
{"Lightning Bolt", {"!modifier.multitarget","!player.moving","target.range <= 40"}, "target" },
{"Lightning Bolt", {"!modifier.multitarget","player.buff(79206)","target.range <= 40"}, "target" },
{ "Unleash Flame" },

{"Ghost Wolf",{"player.movingfor > 1", "!lastcast(Ghost Wolf)","!player.buff(79206)"},},

---------------------------
--!!!!!!END COMBAT!!!!!!!--
---------------------------
},{
---------------------------
--   OOC / PRE-PULL     --
---------------------------
{ "Lightning Shield",{"!player.buff(Lightning Shield)" },"player"},
{"#109218",{"modifier.lcontrol"},"player"},
{"Unleash Flame",{"modifier.lcontrol"},"player"},
{ "Storm Elemental Totem",{"modifier.lcontrol","talent(7,2)"},"player" },
{ "Fire Elemental Totem",{"modifier.lcontrol","!talent(7,2)"},"player" },
{"Earthquake", {"modifier.lcontrol","!player.moving"}, "target.ground" },

}, function()
ProbablyEngine.toggle.create('AoESpam', 'Interface\\Icons\\spell_nature_chainlightning', 'Spam AOE','Spam Chain Lightning and Earthquake')
--ProbablyEngine.toggle.create('AutoTarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target','Auto Target')

end)