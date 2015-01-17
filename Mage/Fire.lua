
---------------------------
--   Macks Pyromania    --
---------------------------

ProbablyEngine.rotation.register_custom(63, "|cff00FFFFMacks|r - [|cff69CCF0Fire Mage v2.3|r]", {


-- Pause for Invis
--blastwave target.enemy and exitst
---------------------------
--       MODIFIERS       --
---------------------------
--{ "Ring of Frost", "modifier.lalt", "ground" },
{ "1459", "!player.buffs.spellpower" }, --spellpower
{ "1459", "!player.buffs.crit" }, --scrit
{"Rune of Power",{"!player.moving","modifier.rcontrol"},"mouseover.ground"},
{"Amplify Magic",{"modifier.lalt"},}, 
{"!Ice Block",{"modifier.lshift","!player.spell(157913).exists"}},
{"!157913",{"modifier.lshift","player.spell(157913).exists"}},
{"Alter Time",{"modifer.rshift","player.spell(Alter Time).exists"}},
{"!Combustion",  {"modifier.lcontrol","player.spell(Pyroblast).casted >= 1"}, "target"},
---------------------------
--     SURVIVAL/misc     --
---------------------------
{"#5512", "player.health <= 40" },  --healthstone
{"!Cold Snap",{"player.health < 25","player.spell(Cold Snap).exists"},"player"},
{"Ice Floes",{"player.moving", "!player.buff(108839)", "!lastcast(Ice Floes)", "player.spell(Ice Floes).exists"},"player"},
{"Ice Barrier",{"player.health <= 80", "!player.buff(Ice Barrier)", "player.spell(Ice Barrier).exists"},"player"},
{"!Ice Block",{"!player.spell(157913).exists","player.health <= 15"},"player"},
{"!157913",{"player.spell(157913).exists","player.health <= 15"},"player"},--evanesce
{"!Greater Invisibility",{"player.spell(110959).exists","player.health <= 15"},"player"},

---------------------------
--INTERRUPT & SPELLSTEAL--
---------------------------
-- Interrupts
{ "Counterspell", "modifier.interrupts" },
{"!Inferno Blast",{"player.buff(Heating Up)", "!player.buff(Pyroblast!)","lastcast(Pyroblast)","player.spell(Pyroblast).casted >= 1","target.range <= 40"}, "target" },


---------------------------
--  MI/RoP & METEOR/PC   --
---------------------------

{"Mirror Image", "modifier.cooldowns" },
{"Rune of Power",{"!player.buff(Rune of Power)", "!player.moving", },"player.ground"},

--Meteor combustion setup
{"Meteor",{"target.enemy","player.buff(Heating Up)","player.buff(Pyroblast!)","modifier.cooldowns"},"target.ground"},
{"Fireball",{"lastcast(Meteor)", "!player.moving"},"target"},
{"Pyroblast",{"lastcast(Fireball)", "player.buff(Pyroblast!)","player.spell(Meteor).cooldown > 40"},"target"},
{"Pyroblast",{"lastcast(Meteor)", "player.buff(Pyroblast!)","player.spell(Meteor).cooldown > 40"},"target"},

--PC rotationn
{"Prismatic Crystal",{"target.enemy","player.buff(Heating Up)","player.buff(Pyroblast!)","modifier.cooldowns"},"target.ground"},
{"Fireball",{"lastcast(Prismatic Crystal)", "!player.moving"},"target"},
{"Pyroblast",{"lastcast(Fireball)", "player.buff(Pyroblast!)","player.spell(Prismatic Crystal).cooldown > 80"},"target"},
{"Pyroblast",{"lastcast(Prismatic Crystal)", "player.buff(Pyroblast!)","player.spell(Prismatic Crystal).cooldown > 80"},"target"},
{"Inferno Blast",{"lastcast(Combustion)","player.spell(Combustion).casted >= 1","player.spell(Prismatic Crystal).cooldown > 80"}, "target" },
{"Pyroblast",{"player.totem(Prismatic Crystal)", "player.buff(Pyroblast!)"},"target"},

   


---------------------------
-- PRYOBLAST MANAGEMENT --
---------------------------
--Tier 17
{ "!Pyroblast", { "player.buff(Pyromanic)" }, "target" },
--Chain pryos together
{ "Pyroblast", { "lastcast(Pyroblast)","player.buff(Pyroblast!)" }, "target" },
-- Dont wanna lose our Buff (Bad RNG protection)
{ "!Pyroblast", { "player.buff(Pyroblast!).duration < 3", "!player.buff(Pyroblast!).duration == 0" },"target" }, 


--Cast an extra Fireball before Your Pyros for additional chance for crit (as per Icy Veins Pyro trick)
{"Fireball",{"!player.moving", "player.buff(Heating Up).duration >= 9", "player.buff(Pyroblast!)","!toggle.Trashmode"},"target"},
--Otherwise we wait until we have both Heatingup and Pyro
{ "Pyroblast", { "player.buff(Heating Up)", "player.buff(Pyroblast!)","!toggle.Trashmode" }, "target"}, 
--Dont bother if its Trash
{ "Pyroblast", { "player.buff(Pyroblast!)","toggle.Trashmode" }, "target"}, 

--Proc pryo from heating up
{"Inferno Blast",{"player.buff(Heating Up)", "!player.buff(Pyroblast!)"}, "target" },



---------------------------
--    AUTO COMBUSTION    --
---------------------------

{"Combustion",{"target.debuff(Pyroblast)","target.debuff(155158)","target.debuff(Ignite)","talent(7,3)", "player.spell(Pyroblast).casted >= 1"},"target"},
{"Combustion",{"!player.buff(Pyroblast!)","target.debuff(Ignite)","talent(7,2)", "player.spell(Pyroblast).casted >= 3"},"target"},

{"Inferno Blast",{"lastcast(Combustion)","modifier.multitarget", "!lastcast(Inferno Blast)"}, "target" },

--"toggle.AutoCombust"

---------------------------
--    DoT/Blast Wave     --
---------------------------

{"Living Bomb", {"!target.debuff(Living Bomb)", "talent(5,1)" },"target" }, --Living Bomb

{{  -- Casts when Meteor is on CD. For opener purposes.
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(116267).count >= 4" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(Rune of Power)" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "talent(6,1)" },"target" }, 
},{"toggle.UseBlastWave","talent(7,3)","player.spell(Meteor).cooldown > 0", "!player.buff(Heating Up)"}},

{{  --Casts when PC is on CD. For opener purposes.
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(116267).count >= 4" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(Rune of Power)" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "talent(6,1)" },"target" }, 
},{"toggle.UseBlastWave","talent(7,2)","player.spell(Prismatic Crystal).cooldown > 0", "!player.buff(Pyroblast!)"}},



{{  -- Kindling
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(116267).count >= 4" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(Rune of Power)" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "talent(6,1)" },"target" }, 
},{"toggle.UseBlastWave","talent(7,1)"}},


{{  --Trashmode
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(116267).count >= 4" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "player.buff(Rune of Power)" },"target" }, 
{"Blast Wave", {"target.exists","talent(5,3)", "talent(6,1)" },"target" }, 
},{"toggle.UseBlastWave","toggle.Trashmode", "!player.buff(Heating Up)"}},

---------------------------
--     AOE ROTATION     --
---------------------------

{{
{"Flamestrike",{"target.exists","target.enemy","!player.moving","!target.debuff(Flamestrike)"},"target.ground"},
{ "Dragon's Breath", { "target.enemy", "target.range <= 5" },"target"}, 
},"modifier.multitarget"},


---------------------------
--     SINGLE TARGET     --
---------------------------
{"Dragon's Breath",{"!modifier.raid","!modifier.party","target.range <= 5"},"target"},
{"Ice Ward",{"!modifier.raid","!modifier.party","target.range <= 5","talent(3,2)"},"player"},
{"Ring of Frost",{"!modifier.raid","!modifier.party","target.range <= 5","talent(3,1)"},"player.ground"},

{{
{"Fireball", {"!glyph(61205)"},"target"},
{"Frostfire Bolt", {"glyph(61205)"},"target"},
},"player.buff(Ice Floes)"},  

{"Scorch",{"player.moving"},"target" },

{"Fireball", {"!player.moving", "!glyph(61205)"},"target"},
{"Frostfire Bolt", {"!player.moving", "glyph(61205)"},"target"},
{"Scorch",{"player.moving"},"target" },


{ "/targetenemy [noexists]", { "!target.exists" } },
{ "/targetenemy [dead]", { "target.exists", "target.dead" } },

---------------------------
--!!!!!!END COMBAT!!!!!!!--
---------------------------


  },{


---------------------------
--   OOC / PRE-PULL     --
---------------------------
{ "1459", "!player.buffs.spellpower" }, --spellpower
{ "1459", "!player.buffs.crit" }, --scrit

{"Rune of Power",{"!player.moving","modifier.rcontrol"},"mouseover.ground"},
{"#109218",{"modifier.lcontrol"},"player"},
{"Mirror Image",{"modifier.lcontrol","!lastcast(Mirror Image)","talent(6,1)"}},
{"Pyroblast",{"modifier.lcontrol"},"target"},


--player.buffs.stats  (GetRaidBuffTrayAuraInfo(1))
--player.buffs.stamina  (GetRaidBuffTrayAuraInfo(2))
--player.buffs.attackpower  (GetRaidBuffTrayAuraInfo(3))
--player.buffs.haste  (GetRaidBuffTrayAuraInfo(4))
--player.buffs.spellpower  (GetRaidBuffTrayAuraInfo(5))
--player.buffs.crit  (GetRaidBuffTrayAuraInfo(6))
--player.buffs.mastery  (GetRaidBuffTrayAuraInfo(7))
--player.buffs.multistrike  (GetRaidBuffTrayAuraInfo(8))
--player.buffs.versatility  (GetRaidBuffTrayAuraInfo(9))

}, function()
ProbablyEngine.toggle.create('AutoCombust', 'Interface\\Icons\\spell_fire_sealoffire', 'Automated Combustion','Automated Combustion only works with Meteor talent')
ProbablyEngine.toggle.create('UseBlastWave', 'Interface\\Icons\\spell_holy_excorcism_02', 'Blast Wave','Toggle on for Blastwave usage, off if you want to Pool')
ProbablyEngine.toggle.create('Trashmode', 'Interface\\Icons\\ability_mage_firestarter', 'Trash Burn','Toggle on for trash, off for boss')

end)