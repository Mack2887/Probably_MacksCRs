
---------------------------
--   Macks Pyromania    --
---------------------------

ProbablyEngine.rotation.register_custom(63, "Mack Fire v2.1", {


-- Pause for Invis

---------------------------
--       MODIFIERS       --
---------------------------
--{ "Ring of Frost", "modifier.lalt", "ground" },
{"Rune of Power",{"!player.moving","modifier.rcontrol"},"mouseover.ground"},
{"Amplify Magic",{"modifier.lalt"},}, 
{"!Ice Block",{"modifier.lshift","!player.spell(157913).exists"}},
{"!157913",{"modifier.lshift","player.spell(157913).exists"}},
{"Alter Time",{"modifer.rshift","player.spell(Alter Time).exists"}},
{"!Combustion",  {"modifier.lcontrol"}, "target"},
---------------------------
--     SURVIVAL/misc     --
---------------------------
{"#5512", "player.health <= 40" },  --healthstone
{"!Cold Snap",{"player.health < 25","player.spell(Cold Snap).exists"}},
{"!Ice Floes",{"player.moving", "!player.buff(108839)", "!lastcast(Ice Floes)", "player.spell(Ice Floes).exists"}},
{"Ice Barrier",{"player.health <=80", "!player.buff(Ice Barrier)", "player.spell(Ice Barrier).exists"}},
{"!Ice Block",{"!player.spell(157913).exists","player.health <= 15"}},
{"!157913",{"player.spell(157913).exists","player.health <= 15"}},
{"!Greater Invisibility",{"player.spell(110959).exists","player.health <= 15"}},

---------------------------
--INTERRUPT & SPELLSTEAL--
---------------------------
-- Interrupts
{ "2139",{"!lastcast(2139)","modifier.interrupts" }, "target" },


---------------------------
--  MI/RoP & METEOR/PC   --
---------------------------

{"Mirror Image", "modifier.cooldowns" },
{"Rune of Power",{"!player.buff(Rune of Power)", "!player.moving", },"player.ground"},

--Meteor combustion setup
{"Meteor",{"target.enemy","player.buff(Heating Up)","player.buff(Pyroblast!)","modifier.cooldowns"},"target.ground"},
{"Fireball",{"lastcast(Meteor)", "!player.moving"},"target"},
{"Pyroblast",{"lastcast(Fireball)", "player.buff(Pyroblast!)","player.spell(Meteor).cooldown > 40"},"target"},
{"Pyroblast",{"lastcast(Meteor)", "player.moving", "player.buff(Pyroblast!)","player.spell(Meteor).cooldown > 40"},"target"},

--PC coming soon
   


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
{"Fireball",{"!player.moving", "player.buff(Heating Up).duration >= 9", "player.buff(Pyroblast!)"},"target"},
--Otherwise we wait until we have both Heatingup and Pyro
{ "Pyroblast", { "player.buff(Heating Up)", "player.buff(Pyroblast!)" }, "target"}, 
--Proc pryo from heating up
{"Inferno Blast",{"player.buff(Heating Up)", "!player.buff(Pyroblast!)"}, "target" },



---------------------------
--    AUTO COMBUSTION    --
---------------------------

{"Combustion",{"target.debuff(155158)","target.debuff(Ignite)","talent(7,3)", "player.spell(Pyroblast).casted >= 1", "lastcast(Pyroblast)"},"target"},
{"Inferno Blast",{"lastcast(Combustion)","modifier.multitarget", "!lastcast(Inferno Blast)"}, "target" },

--"toggle.AutoCombust"

---------------------------
--    DoT/Blast Wave     --
---------------------------

{"Living Bomb", {"!target.debuff(Living Bomb)", "talent(5,1)" },"target" }, --Living Bomb

{{  --For USE with Meteor Talent. Casts when Meteor is on CD. For opener purposes.
{"Blast Wave", {"talent(5,3)", "player.buff(116267).count >= 4" },"target" }, 
{"Blast Wave", {"talent(5,3)", "player.buff(Rune of Power)" },"target" }, 
{"Blast Wave", {"talent(5,3)", "talent(6,1)" },"target" }, 
},{"toggle.UseBlastWave","talent(7,3)","player.spell(Meteor).cooldown > 0", "!player.buff(Heating Up)"}},

{{  -- Not meteor.
{"Blast Wave", {"talent(5,3)", "player.buff(116267).count >= 4" },"target" }, 
{"Blast Wave", {"talent(5,3)", "player.buff(Rune of Power)" },"target" }, 
{"Blast Wave", {"talent(5,3)", "talent(6,1)" },"target" }, 
},{"toggle.UseBlastWave","!talent(7,3)"}},
---------------------------
--     AOE ROTATION     --
---------------------------

{{
{"Flamestrike",{"!player.moving","!target.debuff(Flamestrike)"},"target.ground"},
{ "Dragon's Breath", { "target.enemy", "target.range <= 5" },"target"}, 
},"modifier.multitarget"},


---------------------------
--     SINGLE TARGET     --
---------------------------
{{
{"Fireball", {"!Glyph(591)"},"target"},
{"Frostfire Bolt", {"Glyph(591)"},"target"},
},"player.buff(Ice Floes)"},  

{"Scorch",{"player.moving"},"target" },

{"Fireball", {"!player.moving", "!Glyph(591)"},"target"},
{"Frostfire Bolt", {"!player.moving", "Glyph(591)"},"target"},





---------------------------
--!!!!!!END COMBAT!!!!!!!--
---------------------------


  },{


---------------------------
--   OOC / PRE-PULL     --
---------------------------
{"Rune of Power",{"!player.moving","modifier.rcontrol"},"mouseover.ground"},
{"#109218",{"modifier.lcontrol"},"player"},
{"Mirror Image",{"modifier.lcontrol","!lastcast(Mirror Image)","talent(6,1)"}},
{"Pyroblast",{"modifier.lcontrol"},"target"},




}, function()
ProbablyEngine.toggle.create('AutoCombust', 'Interface\\Icons\\spell_fire_sealoffire', 'Automated Combustion','Automated Combustion only works with Meteor talent')
ProbablyEngine.toggle.create('UseBlastWave', 'Interface\\Icons\\spell_holy_excorcism_02', 'Blast Wave','Toggle on for Blastwave usage, off if you want to Pool')

end)