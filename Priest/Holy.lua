--A Holy Priest rotation by Mack

ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(257, "|cff00FFFFMacks|r - [|cffFFFFFFHoly v1.0|r]", {




---------------------------
--   CHAKRA MANAGEMENT  --
---------------------------
{"Chakra: Sanctuary",{"player.stance != 2","modifier.rshift"}},
{"Chakra: Serenity",{"player.stance != 3","modifier.rshift"}},

---------------------------
--       SURVIVAL        --
---------------------------
{ "!19236", { "player.health <= 40" }, "Player" },--Desperate Prayer
{ "#5512", "player.health <= 50" },  --healthstone
---------------------------
--     MISC/MODIFIERS    --
---------------------------
{ "pause", "player.buff(Divine Hymn)" }, --Pause FOR Hymn
{ "!32375", "modifier.rcontrol", "mouseover.ground" }, --Mass Dispell
{ "586", "target.threat >= 80" },-- Fade
{ "!64843", "modifier.lalt" },  --Divine Hymn
{"724", "modifier.ralt", "mouseover.ground" }, --Lightwell
{"!88685", "modifier.lcontrol","mouseover.ground" },  --Holy Word: Sanctuary
---------------------------
--         MANA         --
---------------------------
{ "123040", {"player.mana < 95","target.spell(123040).range"}, "target" },
{ "129250", {"target.spell(129250).range" }, "target" },

---------------------------
--        DISPELLS       --
---------------------------
{"527", {"!lastcast(527)", "player.mana > 20", "@coreHealing.needsDispelled('Corrupted Blood')"	}, nil },
{"527", {"!lastcast(527)", "player.mana > 20","@coreHealing.needsDispelled('Slow')" }, nil },



---------------------------
--        TIER 6        --
---------------------------
{ "121135", "lowest.health <= 92", "lowest" },  --Cascade
{ "!120517", "modifier.lshift", "player" }, --Halo
{ "!110744", "modifier.lshift", "player" }, --Divine Star


---------------------------
--     PROC HEALING      --
---------------------------
--114255 SoL Buff
{"Flash Heal",{"tank.health <= 40", "player.buff(114255)"},"tank"}, --Surge of Light
{"Flash Heal",{"lowest.health <= 90", "player.buff(114255)", "lowest.range <= 40"},"lowest"}, --Surge of Light
--123267 DI Buff
{"Prayer of Mending",{"tank.health <= 40", "player.buff(123267)", "!lastcast(Prayer of Mending)"},"tank"}, -- Divine Insight
{"Prayer of Mending",{"lowest.health <= 95", "player.buff(123267)", "!lastcast(Prayer of Mending)","lowest.range <= 40"},"lowest"}, --Divine Insight

---------------------------
--     SERENITY BURST    --
--------------------------- 
--Will attempt  Serenity->Flash -> Flash -> Greater Heal combo
--if in correct chakra and nobody else is in danger of dying (good for focus healing)
{{
{"Holy Word: Serenity",{"lowest.health <= 50"},"lowest"},	
{"Heal",{"!player.moving","lowest.health <= 50", "lowest.buff(88684)","lowest.range <= 40" ,"player.buff(63735).count = 2"},"lowest"},--63735 is Serendipity
{"Flash Heal",{"!player.moving","lowest.health <= 50", "lowest.range <= 40" ,"lowest.buff(88684)"},"lowest"},


--Note:  TANK will return FOCUS as target if a Focus EXISTS. SO just focus someone.
{"Holy Word: Serenity",{"tank.health <= 90"},"tank"},	
{"Heal",{"!player.moving","tank.health <= 90", "tank.buff(88684)", "player.buff(63735).count = 2"},"tank"},--63735 is Serendipity
{"Flash Heal",{"!player.moving","tank.health <= 90", "tank.buff(88684)"},"tank"},

},{"!lowest.health <= 20","player.stance = 3" }},


---------------------------
--     SAVE THE TANK!    --
---------------------------
{"!Guardian Spirit",{"tank.health <= 15"},"tank"},
{ "Heal", {"!player.moving", "tank.health <= 25", "tank.spell(2061).range","player.buff(63735).count = 2" }, "tank" },
{ "Heal", {"!player.moving", "lowest.health <= 25", "lowest.spell(2061).range","player.buff(63735).count = 2" }, "lowest" },
{ "Binding Heal", {"!player.moving", "tank.health <= 25", "tank.spell(2061).range", "player.health <= 80" }, "tank" },
{ "Binding Heal", {"!player.moving", "lowest.health <= 25", "lowest.spell(2061).range", "player.health <= 80" }, "lowest" },
{ "Heal", {"!player.moving", "tank.health <= 20", "tank.spell(2061).range","player.buff(63735).count = 2" }, "tank" },
{ "2061", {"!player.moving", "tank.health <= 20", "tank.spell(2061).range" }, "tank" },
{ "2061", {"!player.moving", "focus.health <= 20","focus.spell(2061).range" }, "focus" },
{ "2061", {"!player.moving", "lowest.health <= 15","lowest.spell(2061).range" }, "lowest" },

---------------------------
--       SANCTUARY       --
---------------------------
{{
{"Circle of Healing",{"@coreHealing.needsHealing(95, 3)","lowest.range <= 40"},"lowest"},	
{ "Prayer of Healing", {"@coreHealing.needsHealing(90, 3)","!player.moving", "tank.health <= 90", "tank.range <= 40","player.buff(63735).count = 2" }, "tank" },
{ "Prayer of Healing", {"@coreHealing.needsHealing(95, 3)","!player.moving", "lowest.health <= 90","lowest.range <= 40","player.buff(63735).count = 2" }, "lowest" },
{"Prayer of Mending", {"!player.moving","tank.health <= 99", "tank.range <= 40"},"tank"},
{ "Prayer of Healing", {"@coreHealing.needsHealing(90, 5)","!player.moving", "lowest.range <= 40","!player.spell(Circle of Healing).recharge < 3"}, "lowest" },
{ "Prayer of Healing", {"@coreHealing.needsHealing(85, 4)","!player.moving", "lowest.range <= 40","!player.spell(Circle of Healing).recharge < 3"}, "lowest" },
{ "Prayer of Healing", {"@coreHealing.needsHealing(80, 3)","!player.moving", "lowest.range <= 40","!player.spell(Circle of Healing).recharge < 3"}, "lowest" },
{"Heal",{"lowest.range <= 40", "lowest.health <= 95", "!player.moving", "!player.spell(Circle of Healing).recharge < 3"},"lowest"},
{"Renew",{"lowest.range <= 40", "lowest.health < = 90", "!lowest.buff(Renew)"}, "lowest"},
},"player.stance = 2"},

 
---------------------------
--       SERENITY       --
---------------------------
{{
{"Holy Word: Serenity",{"lowest.health <= 80", "lowest.range <= 40", "lowest.buff(Renew)"},"lowest"},	
{"Holy Word: Serenity",{"tank.health <= 92", "tank.range <= 40", "tank.buff(Renew)"},"tank"},	
{"Prayer of Mending",{"tank.range <= 40", "tank.health <= 90"},"tank"},
{"Heal",{"lowest.health <= 90", "lowest.buff(Renew)", "lowest.range <= 40"},"lowest"},
{"Heal",{"tank.health <= 90", "tank.buff(Renew)", "tank.range <= 40"},"lowest"},
},"player.stance = 3"},


---------------------------
--      Multi-HoTing     --
---------------------------
{ "Renew", {"lowest.range <= 40", "!lowest.buff(Renew)", "lowest.health <= 88"}, "lowest" }, -- Renew.
{ "Renew", {"focus.range <= 40", "!focus.buff(Renew)", "focus.health <= 92"}, "focus" }, -- Renew.
{ "Renew", {"tank.range <= 40","!tank.buff(Renew)", "tank.health <= 92"}, "tank" }, -- Renew.
{{ -- PARTY MODE
{ "Renew", { "party1.range <= 40","!party1.buff(Renew)", "party1.health <= 95"}, "party1" }, -- Renew.
{ "Renew", { "!player.buff(Renew)", "player.health <= 95" }, "player" }, -- Renew.
{ "Renew", { "party2.range <= 40","!party2.buff(Renew)", "party2.health <= 95"}, "party2" }, -- Renew.
{ "Renew", { "party3.range <= 40","!party3.buff(Renew)", "party3.health <= 95"}, "party3" }, -- Renew.
{ "Renew", { "party4.range <= 40","!party4.buff(Renew)", "party4.health <= 95"}, "party4" }, -- Renew.
{ "Renew", { "party5.range <= 40","!party5.buff(Renew)", "party5.health <= 95"}, "party5" }, -- Renew.
}, "!modifier.raid"},
{{ --RAID MODE
{ "Renew", { "raid1.range <= 40","!raid1.buff(Renew)", "raid1.health <= 85"}, "raid1" }, -- Renew.
{ "Renew", { "!player.buff(Renew)", "player.health <= 90" }, "player" }, -- Renew.
{ "Renew", { "raid2.range <= 40","!raid2.buff(Renew)", "raid2.health <= 85"}, "raid2" }, -- Renew.
{ "Renew", { "raid3.range <= 40","!raid3.buff(Renew)", "raid3.health <= 85"}, "raid3" }, -- Renew.
{ "Renew", { "raid4.range <= 40","!raid4.buff(Renew)", "raid4.health <= 85"}, "raid4" }, -- Renew.
{ "Renew", { "raid5.range <= 40","!raid5.buff(Renew)", "raid5.health <= 85"}, "raid5" }, -- Renew.
{ "Renew", { "raid6.range <= 40","!raid6.buff(Renew)", "raid6.health <= 85"}, "raid6" }, -- Renew.
{ "Renew", { "raid7.range <= 40","!raid7.buff(Renew)", "raid7.health <= 85"}, "raid7" }, -- Renew.
{ "Renew", { "raid8.range <= 40","!raid8.buff(Renew)", "raid8.health <= 85"}, "raid8" }, -- Renew.
{ "Renew", { "raid9.range <= 40","!raid9.buff(Renew)", "raid9.health <= 85"}, "raid9" }, -- Renew.
{ "Renew", { "raid10.range <= 40","!raid10.buff(Renew)", "raid10.health <= 85"}, "raid10" }, -- Renew.
{ "Renew", { "raid11.range <= 40","!raid11.buff(Renew)", "raid11.health <= 85"}, "raid11" }, -- Renew.
{ "Renew", { "raid12.range <= 40","!raid12.buff(Renew)", "raid12.health <= 85"}, "raid12" }, -- Renew.
{ "Renew", { "raid13.range <= 40","!raid13.buff(Renew)", "raid13.health <= 85"}, "raid13" }, -- Renew.
{ "Renew", { "raid14.range <= 40","!raid14.buff(Renew)", "raid14.health <= 85"}, "raid14" }, -- Renew.
{ "Renew", { "raid15.range <= 40","!raid15.buff(Renew)", "raid15.health <= 85"}, "raid15" }, -- Renew.
{ "Renew", { "raid16.range <= 40","!raid16.buff(Renew)", "raid16.health <= 85"}, "raid16" }, -- Renew.
{ "Renew", { "raid17.range <= 40","!raid17.buff(Renew)", "raid17.health <= 85"}, "raid17" }, -- Renew.
{ "Renew", { "raid18.range <= 40","!raid18.buff(Renew)", "raid18.health <= 85"}, "raid18" }, -- Renew.
{ "Renew", { "raid19.range <= 40","!raid19.buff(Renew)", "raid19.health <= 85"}, "raid19" }, -- Renew.
{ "Renew", { "raid20.range <= 40","!raid20.buff(Renew)", "raid20.health <= 85"}, "raid20" }, -- Renew.
{ "Renew", { "raid21.range <= 40","!raid21.buff(Renew)", "raid21.health <= 85"}, "raid21" }, -- Renew.
}, "modifier.raid"},




---------------------------
--       DPS MODE       --
---------------------------
{{
{"Chakra: Chastise",{"player.stance != 1"}},
{ "!2061", { "!player.moving", "lowest.health <= 30", "lowest.spell(2061).range" }, "lowest" },--Flash Heal
{ "34861", { "lowest.spell(34861).cooldown < .001",  "@coreHealing.needsHealing(80, 3)", "lowest.spell(34861).range" }, "lowest" },--CoH
{ "139", {  "!lowest.buff(139)",  "lowest.health < 85",  "lowest.spell(139).range" }, "lowest" },--Renew
{ "589", { "target.debuff(589).duration < 2",  "target.spell(589).range"}, "target" },--SW:pain
{ "14914", {  "player.spell(129250).cooldown < .001"  }, "target" },--Hoyl fire
{ "585", {  "player.mana > 30" }, "target"}, -- Smite


},  "toggle.Dps"  },


---------------------------
--  TARGETING AND FOCUS  --
---------------------------
{{
{ "/targetenemy [noexists]", "!target.exists" },
{ "/focus [@targettarget]", "target.enemy" },
{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
},"toggle.AutoTarget"},





},{
---------------------------
--      OUT OF COMBAT    --
---------------------------
{ "1126", "!player.buffs.stamina" }, --stam
{"724", "modifier.ralt", "mouseover.ground" }, --lightwell preplace  
{"!88685", "modifier.lcontrol","mouseover.ground" },  --Holy Word: Sanctuary
{"Chakra: Sanctuary",{"player.stance != 2","modifier.rshift"}},
{"Chakra: Serenity",{"player.stance != 3","modifier.rshift"}},



},function()


ProbablyEngine.toggle.create('Dps', 'Interface\\Icons\\spell_shadow_demonicfortitude', 'DPS MODE','Switch to Chakra Chastise')
ProbablyEngine.toggle.create('AutoTarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target/Focus','Auto Target Boss and Focus Active Tank')


end)

