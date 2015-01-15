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

ProbablyEngine.rotation.register_custom(105, "|cff00FFFFMacks|r - |cffFF7D0AResto v6.0|r", {




--TO DO LIST
--FIX REBIRTH MOUSEOVER?

---------------------------
--    MODIFIERS/MISC     --
---------------------------
{ "1126", "!player.buffs.stats" }, --stats
{"!Wild Mushroom", "modifier.rcontrol", "mouseover.ground" }, --shroom
{"!26297", "modifier.lalt"}, --Berserking Racial
{"!740", "modifier.lalt"}, --Tranq
{"!33891", "modifier.lcontrol"}, --Incarnation
{"!108294", "modifier.ralt", "talent(6,1)"}, --Heart of the wild
{"!124974", "modifier.ralt", "talent(6,3)"},--Natures Vigil
{"!106898", "modifier.lshift"}, --Stampeding Roar
{"!20484", "modifier.rshift", "mouseover"}, --Rebirth
{"/cancelform",{"player.buff(Stampeding Roar)"},},
{"/cancelform",{"player.buff(Displacer Beast)"},},
---------------------------
--      SURVIVAL        --
---------------------------
{ "22812", { "player.health <= 50" }, "Player" },--barkskin
{ "108238", { "player.health <= 40", "talent(2,2)" }, "Player" },--Renewal
{ "#5512", "player.health <= 30" },  --healthstone
{"Ironbark",{"focus.health <= 40","focus.friend","focus.range <= 40"},"focus"},
{"Ironbark",{"tank.health <= 40","tank.range <= 40"},"tank"},
---------------------------
--      DISPELLS        --
---------------------------
{{
{"88423", {"!lastcast(88423)","player.mana > 10", "@coreHealing.needsDispelled('Corrupted Blood')"}, nil },
{"88423", {"!lastcast(88423)","player.mana > 10", "@coreHealing.needsDispelled('Slow')"}, nil },
},"player.mana > 10" },


---------------------------
--    PROCS AND BUFFS    --
---------------------------
{"Regrowth",{"!player.moving","player.buff(16870)","lowest.range <= 40"},"lowest"},--Omen procs
{"Regrowth",{"!player.moving","player.buff(16870)","tank.range <= 40"},"tank"},--Omen procs
{"Regrowth",{"!player.moving","player.buff(155631)","lowest.range <= 40"},"lowest"}, --Moment of Clarity
{"Regrowth",{"!player.moving","player.buff(155631)","tank.range <= 40"},"tank"}, --Moment of Clarity
{"132158",{"lowest.health <= 90"},},--NS on CD, but not wasted
{"Healing Touch",{"player.buff(132158)","lowest.range <= 40"},"lowest"},--NS lowest
{ "1126", "!player.buffs.stats" }, --stats
{ "1126", "!player.buffs.versatility" }, --stats

---------------------------
--   STANDARD HEALING    --
---------------------------
{{ --  !!Start mana check!!

---------------------------
--       EMERGENCY      --
---------------------------
{"Regrowth",{"!player.moving","focus.health <= 25","focus.range <= 40"},"focus"},
{"Regrowth",{"!player.moving","tank.health <= 28","tank.range <= 40"},"tank"},
{"Regrowth",{"!player.moving","lowest.health <= 28","lowest.range <= 40"},"lowest"},


---------------------------
--         MISC          --
---------------------------
{"Healing Touch", {"!player.moving","player.buff(100977).duration <= 1", "!glyph(116218)", "lowest.range <= 40"}, "lowest"},--Mastery Upkeep
{"Regrowth", {"!player.moving","player.buff(100977).duration <= 1", "glyph(116218)", "lowest.range <= 40"}, "lowest"}, --Mastery Upkeep
{"Lifebloom",{"player.spell(Lifebloom).casted < 1","!lastcast(Lifebloom)","tank.buff(33763).duration <= 1", "tank.range <= 40"},"tank"},--lifebloom "tank" 
{"102351",{"focus.buff(102351).duration <= 1","focus.range <= 40"},"focus"}, --CW focus
{"102351",{"tank.buff(102351).duration <= 1", "!focus.exist", "tank.range <= 40"},"tank"},--CW "tank" if no focus

---------------------------
--     AUTO-SHROOM      --
---------------------------
{{
{ "145205", {"toggle.ShroomPlace" ,"!player.totem(145205)"}, "focus" },
{ "145205", {"toggle.ShroomPlace" ,"!player.totem(145205)"}, "tank" },
{ "145205", {"!toggle.ShroomPlace" ,"!player.totem(145205)"}, "player" },
},"!glyph(146654)"},

--!!!!!!!!!!!   Start Tier 4 Management   !!!!!!!!!!!!!!

---------------------------
--     INCARNATION      --
---------------------------
{{
{{
{"Wild Growth",{"!player.moving","lowest.range <= 40", "@coreHealing.needsHealing(90, 4)"}, "lowest"},
{"Wild Growth",{"!player.moving","tank.range <= 40", "@coreHealing.needsHealing(90, 4)"}, "tank"},
{"Wild Growth",{"!player.moving","focus.range <= 40", "@coreHealing.needsHealing(90, 4)"}, "focus"},
}, "toggle.WildGrowth"},
{"Regrowth",{"lowest.range <= 40", "lowest.health <= 90"}, "lowest"},
{"Regrowth",{"tank.range <= 40", "tank.health <= 90"}, "tank"},
{"Regrowth",{"focus.range <= 40", "focus.health <= 90"}, "focus"},
}, "player.buff(117679)" },


---------------------------
--     FORCE OF NATURE   --
---------------------------
{{
{"102693",{"!lastcast(102693)","player.spell(102693).charges = 3", "lowest.range <= 40", "lowest.health <= 92"},"lowest"},  
{"102693",{"!lastcast(102693)","player.spell(102693).charges = 3", "tank.range <= 40", "tank.health <= 92"},"tank"},  
{"102693",{"!lastcast(102693)","player.spell(102693).charges >= 2", "lowest.range <= 40", "lowest.health <= 70"},"lowest"},  
{"102693",{"!lastcast(102693)","player.spell(102693).charges >= 2", "tank.range <= 40", "tank.health <= 70"},"tank"},  
{"102693",{"!lastcast(102693)","player.spell(102693).charges >= 1", "lowest.range <= 40","@coreHealing.needsHealing(70, 5)"},"lowest"},  
{"102693",{"!lastcast(102693)","player.spell(102693).charges >= 1", "tank.range <= 40","@coreHealing.needsHealing(70, 5)"},"tank"},  
},"talent(4,3)"},
--^^ End Force of Nature Support ^^

---------------------------
--  SOUL OF THE FOREST  --
---------------------------
{{
{{
{"Wild Growth",{"!player.moving","lowest.range <= 40", "@coreHealing.needsHealing(90, 3)"}, "lowest"},
{"Wild Growth",{"!player.moving","tank.range <= 40", "@coreHealing.needsHealing(90, 3)"}, "tank"},
{"Wild Growth",{"!player.moving","focus.range <= 40", "@coreHealing.needsHealing(90, 3)"}, "focus"},
}, "toggle.WildGrowth"},
{"Regrowth",{"!player.moving","lowest.range <= 40", "lowest.health <= 85"}, "lowest"},
{"Regrowth",{"!player.moving","tank.range <= 40", "tank.health <= 85"}, "tank"},
{"Regrowth",{"!player.moving","focus.range <= 40", "focus.health <= 85"}, "focus"},
},"player.buff(114108)" },
--^^ End Soul of the Forest Support ^^--


--!!!^^^^^^^^^^ END Tier 4 Management ^^^^^^^^^^^!!!




---------------------------
--       TIER 6         --
---------------------------
--!!!!!!!!!!!   Start Tier 6 Management   !!!!!!!!!!!!!!
{"Wrath", {"lowest.health >= 80", "!player.moving", "talent(6,2)","!player.buff(114108)","target.enemy","target.range <= 40"},"target"},
{"124974", {"@coreHealing.needsHealing(85, 5)", "talent(6,3)","modifier.cooldowns"},}, -- NatuRes vigil
--!!!!!!!!!!!   END Tier 6 Management   !!!!!!!!!!!!!!


---------------------------
--     BASIC HEALING     --
---------------------------
{{
{"Wild Growth",{"!player.moving","player.mana >= 20","lowest.range <= 40", "@coreHealing.needsHealing(60, 3)"}, "lowest"},
{"Wild Growth",{"!player.moving","player.mana >= 20","tank.range <= 40", "@coreHealing.needsHealing(60, 3)"}, "tank"},
{"Wild Growth",{"!player.moving","player.mana >= 20","focus.range <= 40", "@coreHealing.needsHealing(60, 3)"}, "focus"},
{"Wild Growth",{"!player.moving","player.mana >= 20","lowest.range <= 40", "@coreHealing.needsHealing(80, 5)"}, "lowest"},
{"Wild Growth",{"!player.moving","player.mana >= 20","tank.range <= 40", "@coreHealing.needsHealing(80, 5)"}, "tank"},
{"Wild Growth",{"!player.moving","player.mana >= 20","focus.range <= 40", "@coreHealing.needsHealing(80, 5)"}, "focus"},
}, "toggle.WildGrowth"},




---------------------------
--      SWIFTMEND        --
---------------------------
{{
{ "Rejuvenation", { "lowest.health <= 91","!player.buff(Rejuvenation)"}, "player" }, -- REJUVE check for swiftmend
{ "Swiftmend", {"lowest.range <= 40", "lowest.buff(774)", "lowest.health <= 90"}, "lowest" }, -- Rejuv.
{ "Swiftmend", {"focus.range <= 40", "focus.buff(774)", "focus.health <= 95"}, "focus" }, -- Rejuv.
{ "Swiftmend", {"tank.buff(774)", "tank.health <= 95"}, "tank" }, -- Rejuv.
{ "Swiftmend", { "raid1.range <= 40","raid1.buff(774)", "raid1.health <= 90"}, "raid1" }, -- Rejuv.
{ "Swiftmend", { "player.buff(774)", "player.health <= 90" }, "player" }, -- Rejuv.
{ "Swiftmend", { "raid2.range <= 40","raid2.buff(774)", "raid2.health <= 90"}, "raid2" }, -- Rejuv.
{ "Swiftmend", { "raid3.range <= 40","raid3.buff(774)", "raid3.health <= 90"}, "raid3" }, -- Rejuv.
{ "Swiftmend", { "raid4.range <= 40","raid4.buff(774)", "raid4.health <= 90"}, "raid4" }, -- Rejuv.
{ "Swiftmend", { "raid5.range <= 40","raid5.buff(774)", "raid5.health <= 90"}, "raid5" }, -- Rejuv.
{ "Swiftmend", { "raid6.range <= 40","raid6.buff(774)", "raid6.health <= 90"}, "raid6" }, -- Rejuv.
{ "Swiftmend", { "raid7.range <= 40","raid7.buff(774)", "raid7.health <= 90"}, "raid7" }, -- Rejuv.
{ "Swiftmend", { "raid8.range <= 40","raid8.buff(774)", "raid8.health <= 90"}, "raid8" }, -- Rejuv.
{ "Swiftmend", { "raid9.range <= 40","raid9.buff(774)", "raid9.health <= 90"}, "raid9" }, -- Rejuv.
{ "Swiftmend", { "raid10.range <= 40","raid10.buff(Rejuvenation)", "raid10.health <= 90"}, "raid10" }, -- Rejuv.
{ "Swiftmend", { "raid11.range <= 40","raid11.buff(Rejuvenation)", "raid11.health <= 90"}, "raid11" }, -- Rejuv.
{ "Swiftmend", { "raid12.range <= 40","raid12.buff(Rejuvenation)", "raid12.health <= 90"}, "raid12" }, -- Rejuv.
{ "Swiftmend", { "raid13.range <= 40","raid13.buff(Rejuvenation)", "raid13.health <= 90"}, "raid13" }, -- Rejuv.
{ "Swiftmend", { "raid14.range <= 40","raid14.buff(Rejuvenation)", "raid14.health <= 90"}, "raid14" }, -- Rejuv.
{ "Swiftmend", { "raid15.range <= 40","raid15.buff(Rejuvenation)", "raid15.health <= 90"}, "raid15" }, -- Rejuv.
{ "Swiftmend", { "raid16.range <= 40","raid16.buff(Rejuvenation)", "raid16.health <= 90"}, "raid16" }, -- Rejuv.
{ "Swiftmend", { "raid17.range <= 40","raid17.buff(Rejuvenation)", "raid17.health <= 90"}, "raid17" }, -- Rejuv.
{ "Swiftmend", { "raid18.range <= 40","raid18.buff(Rejuvenation)", "raid18.health <= 90"}, "raid18" }, -- Rejuv.
{ "Swiftmend", { "raid19.range <= 40","raid19.buff(Rejuvenation)", "raid19.health <= 90"}, "raid19" }, -- Rejuv.
{ "Swiftmend", { "raid20.range <= 40","raid20.buff(Rejuvenation)", "raid20.health <= 90"}, "raid20" }, -- Rejuv.
{ "Swiftmend", { "raid21.range <= 40","raid21.buff(Rejuvenation)", "raid21.health <= 90"}, "raid21" }, -- Rejuv.
},"player.moving"},
{{
{ "Rejuvenation", { "lowest.health <= 91","!player.buff(Rejuvenation)"}, "player" }, -- REJUVE check for swiftmend
{ "Swiftmend", {"lowest.range <= 40", "lowest.buff(774)", "lowest.health <= 90"}, "lowest" }, -- Rejuv.
{ "Swiftmend", {"focus.range <= 40", "focus.buff(774)", "focus.health <= 95"}, "focus" }, -- Rejuv.
{ "Swiftmend", {"tank.buff(774)", "tank.health <= 95"}, "tank" }, -- Rejuv.
{ "Swiftmend", { "raid1.range <= 40","raid1.buff(774)", "raid1.health <= 90"}, "raid1" }, -- Rejuv.
{ "Swiftmend", { "player.buff(774)", "player.health <= 90" }, "player" }, -- Rejuv.
{ "Swiftmend", { "raid2.range <= 40","raid2.buff(774)", "raid2.health <= 90"}, "raid2" }, -- Rejuv.
{ "Swiftmend", { "raid3.range <= 40","raid3.buff(774)", "raid3.health <= 90"}, "raid3" }, -- Rejuv.
{ "Swiftmend", { "raid4.range <= 40","raid4.buff(774)", "raid4.health <= 90"}, "raid4" }, -- Rejuv.
{ "Swiftmend", { "raid5.range <= 40","raid5.buff(774)", "raid5.health <= 90"}, "raid5" }, -- Rejuv.
{ "Swiftmend", { "raid6.range <= 40","raid6.buff(774)", "raid6.health <= 90"}, "raid6" }, -- Rejuv.
{ "Swiftmend", { "raid7.range <= 40","raid7.buff(774)", "raid7.health <= 90"}, "raid7" }, -- Rejuv.
{ "Swiftmend", { "raid8.range <= 40","raid8.buff(774)", "raid8.health <= 90"}, "raid8" }, -- Rejuv.
{ "Swiftmend", { "raid9.range <= 40","raid9.buff(774)", "raid9.health <= 90"}, "raid9" }, -- Rejuv.
{ "Swiftmend", { "raid10.range <= 40","raid10.buff(Rejuvenation)", "raid10.health <= 90"}, "raid10" }, -- Rejuv.
{ "Swiftmend", { "raid11.range <= 40","raid11.buff(Rejuvenation)", "raid11.health <= 90"}, "raid11" }, -- Rejuv.
{ "Swiftmend", { "raid12.range <= 40","raid12.buff(Rejuvenation)", "raid12.health <= 90"}, "raid12" }, -- Rejuv.
{ "Swiftmend", { "raid13.range <= 40","raid13.buff(Rejuvenation)", "raid13.health <= 90"}, "raid13" }, -- Rejuv.
{ "Swiftmend", { "raid14.range <= 40","raid14.buff(Rejuvenation)", "raid14.health <= 90"}, "raid14" }, -- Rejuv.
{ "Swiftmend", { "raid15.range <= 40","raid15.buff(Rejuvenation)", "raid15.health <= 90"}, "raid15" }, -- Rejuv.
{ "Swiftmend", { "raid16.range <= 40","raid16.buff(Rejuvenation)", "raid16.health <= 90"}, "raid16" }, -- Rejuv.
{ "Swiftmend", { "raid17.range <= 40","raid17.buff(Rejuvenation)", "raid17.health <= 90"}, "raid17" }, -- Rejuv.
{ "Swiftmend", { "raid18.range <= 40","raid18.buff(Rejuvenation)", "raid18.health <= 90"}, "raid18" }, -- Rejuv.
{ "Swiftmend", { "raid19.range <= 40","raid19.buff(Rejuvenation)", "raid19.health <= 90"}, "raid19" }, -- Rejuv.
{ "Swiftmend", { "raid20.range <= 40","raid20.buff(Rejuvenation)", "raid20.health <= 90"}, "raid20" }, -- Rejuv.
{ "Swiftmend", { "raid21.range <= 40","raid21.buff(Rejuvenation)", "raid21.health <= 90"}, "raid21" }, -- Rejuv.
},"talent(7,3)"},
{{
{ "Rejuvenation", { "lowest.health <= 91","!player.buff(Rejuvenation)"}, "player" }, -- REJUVE check for swiftmend
{ "Swiftmend", {"lowest.range <= 40", "lowest.buff(774)", "lowest.health <= 90"}, "lowest" }, -- Rejuv.
{ "Swiftmend", {"focus.range <= 40", "focus.buff(774)", "focus.health <= 95"}, "focus" }, -- Rejuv.
{ "Swiftmend", {"tank.buff(774)", "tank.health <= 95"}, "tank" }, -- Rejuv.
{ "Swiftmend", { "raid1.range <= 40","raid1.buff(774)", "raid1.health <= 90"}, "raid1" }, -- Rejuv.
{ "Swiftmend", { "player.buff(774)", "player.health <= 90" }, "player" }, -- Rejuv.
{ "Swiftmend", { "raid2.range <= 40","raid2.buff(774)", "raid2.health <= 90"}, "raid2" }, -- Rejuv.
{ "Swiftmend", { "raid3.range <= 40","raid3.buff(774)", "raid3.health <= 90"}, "raid3" }, -- Rejuv.
{ "Swiftmend", { "raid4.range <= 40","raid4.buff(774)", "raid4.health <= 90"}, "raid4" }, -- Rejuv.
{ "Swiftmend", { "raid5.range <= 40","raid5.buff(774)", "raid5.health <= 90"}, "raid5" }, -- Rejuv.
{ "Swiftmend", { "raid6.range <= 40","raid6.buff(774)", "raid6.health <= 90"}, "raid6" }, -- Rejuv.
{ "Swiftmend", { "raid7.range <= 40","raid7.buff(774)", "raid7.health <= 90"}, "raid7" }, -- Rejuv.
{ "Swiftmend", { "raid8.range <= 40","raid8.buff(774)", "raid8.health <= 90"}, "raid8" }, -- Rejuv.
{ "Swiftmend", { "raid9.range <= 40","raid9.buff(774)", "raid9.health <= 90"}, "raid9" }, -- Rejuv.
{ "Swiftmend", { "raid10.range <= 40","raid10.buff(Rejuvenation)", "raid10.health <= 90"}, "raid10" }, -- Rejuv.
{ "Swiftmend", { "raid11.range <= 40","raid11.buff(Rejuvenation)", "raid11.health <= 90"}, "raid11" }, -- Rejuv.
{ "Swiftmend", { "raid12.range <= 40","raid12.buff(Rejuvenation)", "raid12.health <= 90"}, "raid12" }, -- Rejuv.
{ "Swiftmend", { "raid13.range <= 40","raid13.buff(Rejuvenation)", "raid13.health <= 90"}, "raid13" }, -- Rejuv.
{ "Swiftmend", { "raid14.range <= 40","raid14.buff(Rejuvenation)", "raid14.health <= 90"}, "raid14" }, -- Rejuv.
{ "Swiftmend", { "raid15.range <= 40","raid15.buff(Rejuvenation)", "raid15.health <= 90"}, "raid15" }, -- Rejuv.
{ "Swiftmend", { "raid16.range <= 40","raid16.buff(Rejuvenation)", "raid16.health <= 90"}, "raid16" }, -- Rejuv.
{ "Swiftmend", { "raid17.range <= 40","raid17.buff(Rejuvenation)", "raid17.health <= 90"}, "raid17" }, -- Rejuv.
{ "Swiftmend", { "raid18.range <= 40","raid18.buff(Rejuvenation)", "raid18.health <= 90"}, "raid18" }, -- Rejuv.
{ "Swiftmend", { "raid19.range <= 40","raid19.buff(Rejuvenation)", "raid19.health <= 90"}, "raid19" }, -- Rejuv.
{ "Swiftmend", { "raid20.range <= 40","raid20.buff(Rejuvenation)", "raid20.health <= 90"}, "raid20" }, -- Rejuv.
{ "Swiftmend", { "raid21.range <= 40","raid21.buff(Rejuvenation)", "raid21.health <= 90"}, "raid21" }, -- Rejuv.
},"talent(4,1)"},








---------------------------
--        GENESIS       --
---------------------------
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","@coreHealing.needsHealing(60, 6)", "lowest.buff(Rejuvenation).duration >= 1"},},
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","@coreHealing.needsHealing(30, 3)", "lowest.buff(Rejuvenation).duration >= 1"},},
{{
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","lowest.health <= 25", "lowest.buff(Rejuvenation).duration >= 1"},},
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","tank.health <= 25", "tank.buff(Rejuvenation).duration >= 1" },},
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","focus.health <= 25", "focus.buff(Rejuvenation).duration >= 1"},},
}, "talent(7,2)"},
{{
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","lowest.health <= 25"},},
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","tank.health <= 25"},},
{"Genesis", {"!lastcast(Genesis)","player.spell(132158).cooldown >= 2","player.spell(Swiftmend).cooldown >= 1","player.moving","focus.health <= 25"},},
}, "!talent(7,2)"},


---------------------------
--    REJUVE AND GERM    --
---------------------------
---------------------------
--          GERM        --
---------------------------
{{
{ "Rejuvenation", {"lowest.range <= 40", "lowest.health <= 82","!lowest.buff(155777)"}, "lowest" }, --germ.
{ "Rejuvenation", {"focus.range <= 40",  "focus.health <= 85","!focus.buff(155777)"}, "focus" }, -- germ
{ "Rejuvenation", {"tank.range <= 40",  "tank.health <= 85","!tank.buff(155777)"}, "tank" }, -- germ
}, "talent(7,2)"},
---------------------------
--        REJUVE        --
---------------------------
{ "Rejuvenation", {"lowest.range <= 40", "!lowest.buff(774)", "lowest.health <= 88"}, "lowest" }, -- Rejuv.
{ "Rejuvenation", {"focus.range <= 40", "!focus.buff(774)", "focus.health <= 89"}, "focus" }, -- Rejuv.
{ "Rejuvenation", {"tank.range <= 40","!tank.buff(774)", "tank.health <= 87"}, "tank" }, -- Rejuv.



---------------------------
--      PARTY MODE      --
---------------------------
{{--  Rejuventation/germination PARTY mode
--Germ
{{
{ "Rejuvenation", {"party1.range <= 40", "party1.health <= 85","!party1.buff(155777)"}, "party1" }, --germ
{ "Rejuvenation", {"player.health <= 85","!player.buff(155777)"}, "player" }, -- germ
{ "Rejuvenation", {"party2.range <= 40","party2.health <= 85","!party2.buff(155777)"}, "party2" }, -- germ
{ "Rejuvenation", {"party3.range <= 40","party3.health <= 85","!party3.buff(155777)"}, "party3" }, -- germ.
{ "Rejuvenation", {"party4.range <= 40","party4.health <= 85","!party4.buff(155777)"}, "party4" }, -- germ.
{ "Rejuvenation", {"party5.range <= 40","party5.health <= 85","!party5.buff(155777)"}, "party5" }, -- germ.
}, "talent(7,2)"},
--Rejuv
{ "Rejuvenation", { "party1.range <= 40","!party1.buff(Rejuvenation)", "party1.health <= 95"}, "party1" }, -- Rejuv.
{ "Rejuvenation", { "!player.buff(Rejuvenation)", "player.health <= 95" }, "player" }, -- Rejuv.
{ "Rejuvenation", { "party2.range <= 40","!party2.buff(Rejuvenation)", "party2.health <= 95"}, "party2" }, -- Rejuv.
{ "Rejuvenation", { "party3.range <= 40","!party3.buff(Rejuvenation)", "party3.health <= 95"}, "party3" }, -- Rejuv.
{ "Rejuvenation", { "party4.range <= 40","!party4.buff(Rejuvenation)", "party4.health <= 95"}, "party4" }, -- Rejuv.
{ "Rejuvenation", { "party5.range <= 40","!party5.buff(Rejuvenation)", "party5.health <= 95"}, "party5" }, -- Rejuv.
}, "!modifier.raid"},
--!!!!!!!!!!!!!!!!!!!   END Rejuventation/germination Party mode  !!!!!!!!!!!!!!!!!!!!!!!!!


---------------------------
--       RAID MODE      --
---------------------------

{{
--Germ
{{
{ "Rejuvenation", { "raid1.range <= 40","raid1.health <= 75","!raid1.buff(155777)"}, "raid1" }, -- germ.
{ "Rejuvenation", { "player.health <= 80","!player.buff(155777)"}, "player" }, -- germ
{ "Rejuvenation", { "raid2.range <= 40","raid2.health <= 75","!raid2.buff(155777)"}, "raid2" }, -- germ.
{ "Rejuvenation", { "raid3.range <= 40","raid3.health <= 75","!raid3.buff(155777)"}, "raid3" }, -- germ.
{ "Rejuvenation", { "raid4.range <= 40","raid4.health <= 75","!raid4.buff(155777)"}, "raid4" }, -- germ.
{ "Rejuvenation", { "raid5.range <= 40","raid5.health <= 75","!raid5.buff(155777)"}, "raid5" }, -- germ.
{ "Rejuvenation", { "raid6.range <= 40","raid6.health <= 75","!raid6.buff(155777)"}, "raid6" }, -- germ.
{ "Rejuvenation", { "raid7.range <= 40","raid7.health <= 75","!raid7.buff(155777)"}, "raid7" }, -- germ.
{ "Rejuvenation", { "raid8.range <= 40","raid8.health <= 75","!raid8.buff(155777)"}, "raid8" }, -- germ.
{ "Rejuvenation", { "raid9.range <= 40","raid9.health <= 75","!raid9.buff(155777)"}, "raid9" }, -- germ.
{ "Rejuvenation", { "raid10.range <= 40","raid10.health <= 75","!raid10.buff(155777)"}, "raid10" }, -- germ.
{ "Rejuvenation", { "raid11.range <= 40","raid11.health <= 75","!raid11.buff(155777)"}, "raid11" }, -- germ.
{ "Rejuvenation", { "raid12.range <= 40","raid12.health <= 75","!raid12.buff(155777)"}, "raid12" }, -- germ.
{ "Rejuvenation", { "raid13.range <= 40","raid13.health <= 75","!raid13.buff(155777)"}, "raid13" }, -- germ.
{ "Rejuvenation", { "raid14.range <= 40","raid14.health <= 75","!raid14.buff(155777)"}, "raid14" }, -- germ.
{ "Rejuvenation", { "raid15.range <= 40","raid15.health <= 75","!raid15.buff(155777)"}, "raid15" }, -- germ.
{ "Rejuvenation", { "raid16.range <= 40","raid16.health <= 75","!raid16.buff(155777)"}, "raid16" }, -- germ.
{ "Rejuvenation", { "raid17.range <= 40","raid17.health <= 75","!raid17.buff(155777)"}, "raid17" }, -- germ.
{ "Rejuvenation", { "raid18.range <= 40","raid18.health <= 75","!raid18.buff(155777)"}, "raid18" }, -- germ.
{ "Rejuvenation", { "raid19.range <= 40","raid19.health <= 75","!raid19.buff(155777)"}, "raid19" }, -- germ.
{ "Rejuvenation", { "raid20.range <= 40","raid20.health <= 75","!raid20.buff(155777)"}, "raid20" }, -- germ.
{ "Rejuvenation", { "raid21.range <= 40","raid21.health <= 75","!raid21.buff(155777)"}, "raid21" }, -- germ.
}, "talent(7,2)"},
--Rejuv
{ "Rejuvenation", { "raid1.range <= 40","!raid1.buff(Rejuvenation)", "raid1.health <= 85"}, "raid1" }, -- Rejuv.
{ "Rejuvenation", { "!player.buff(Rejuvenation)", "player.health <= 85" }, "player" }, -- Rejuv.
{ "Rejuvenation", { "raid2.range <= 40","!raid2.buff(Rejuvenation)", "raid2.health <= 85"}, "raid2" }, -- Rejuv.
{ "Rejuvenation", { "raid3.range <= 40","!raid3.buff(Rejuvenation)", "raid3.health <= 85"}, "raid3" }, -- Rejuv.
{ "Rejuvenation", { "raid4.range <= 40","!raid4.buff(Rejuvenation)", "raid4.health <= 85"}, "raid4" }, -- Rejuv.
{ "Rejuvenation", { "raid5.range <= 40","!raid5.buff(Rejuvenation)", "raid5.health <= 85"}, "raid5" }, -- Rejuv.
{ "Rejuvenation", { "raid6.range <= 40","!raid6.buff(Rejuvenation)", "raid6.health <= 85"}, "raid6" }, -- Rejuv.
{ "Rejuvenation", { "raid7.range <= 40","!raid7.buff(Rejuvenation)", "raid7.health <= 85"}, "raid7" }, -- Rejuv.
{ "Rejuvenation", { "raid8.range <= 40","!raid8.buff(Rejuvenation)", "raid8.health <= 85"}, "raid8" }, -- Rejuv.
{ "Rejuvenation", { "raid9.range <= 40","!raid9.buff(Rejuvenation)", "raid9.health <= 85"}, "raid9" }, -- Rejuv.
{ "Rejuvenation", { "raid10.range <= 40","!raid10.buff(Rejuvenation)", "raid10.health <= 85"}, "raid10" }, -- Rejuv.
{ "Rejuvenation", { "raid11.range <= 40","!raid11.buff(Rejuvenation)", "raid11.health <= 85"}, "raid11" }, -- Rejuv.
{ "Rejuvenation", { "raid12.range <= 40","!raid12.buff(Rejuvenation)", "raid12.health <= 85"}, "raid12" }, -- Rejuv.
{ "Rejuvenation", { "raid13.range <= 40","!raid13.buff(Rejuvenation)", "raid13.health <= 85"}, "raid13" }, -- Rejuv.
{ "Rejuvenation", { "raid14.range <= 40","!raid14.buff(Rejuvenation)", "raid14.health <= 85"}, "raid14" }, -- Rejuv.
{ "Rejuvenation", { "raid15.range <= 40","!raid15.buff(Rejuvenation)", "raid15.health <= 85"}, "raid15" }, -- Rejuv.
{ "Rejuvenation", { "raid16.range <= 40","!raid16.buff(Rejuvenation)", "raid16.health <= 85"}, "raid16" }, -- Rejuv.
{ "Rejuvenation", { "raid17.range <= 40","!raid17.buff(Rejuvenation)", "raid17.health <= 85"}, "raid17" }, -- Rejuv.
{ "Rejuvenation", { "raid18.range <= 40","!raid18.buff(Rejuvenation)", "raid18.health <= 85"}, "raid18" }, -- Rejuv.
{ "Rejuvenation", { "raid19.range <= 40","!raid19.buff(Rejuvenation)", "raid19.health <= 85"}, "raid19" }, -- Rejuv.
{ "Rejuvenation", { "raid20.range <= 40","!raid20.buff(Rejuvenation)", "raid20.health <= 85"}, "raid20" }, -- Rejuv.
{ "Rejuvenation", { "raid21.range <= 40","!raid21.buff(Rejuvenation)", "raid21.health <= 85"}, "raid21" }, -- Rejuv.
}, {"modifier.raid","player.spell(Rejuvenation).casted <= 6"},},
--!!!!!!!!!!!!!!!!!!!   END Rejuventation/germination RAID mode  !!!!!!!!!!!!!!!!!!!!!!!!!

-----------------------------
--REGROWTH OR HEALING TOUCH--
-----------------------------
---------------------------
--       REGROWTH     --     -- REGROWTH IS BETTER THAN HEALING TOUCH IF GLYPHED
---------------------------
{{
{{ 
{"Regrowth",{"!player.moving","lowest.buff(Rejuvenation)","lowest.range <= 40", "lowest.health <= 50"}, "lowest"},
{"Regrowth",{"!player.moving","tank.buff(Rejuvenation)","tank.range <= 40", "tank.health <= 65"}, "tank"},
{"Regrowth",{"!player.moving","focus.buff(Rejuvenation)","focus.range <= 40", "focus.health <= 65"}, "focus"},
},"!talent(7,2)"},

{{--155777 is germination
{"Regrowth",{"!player.moving","lowest.buff(155777)","lowest.range <= 40", "lowest.health <= 50"}, "lowest"},--155777 is Germination
{"Regrowth",{"!player.moving","tank.buff(155777)","tank.range <= 40", "tank.health <= 65"}, "tank"},
{"Regrowth",{"!player.moving","focus.buff(155777)","focus.range <= 40", "focus.health <= 65"}, "focus"},
},"talent(7,2)"},

},"glyph(116218)"},

---------------------------
--     HEALING TOUCH     ---- Healing touch is better if not glyphed (non emergency)
---------------------------
{{
{{-- IF 
{"Healing Touch",{"!player.moving","lowest.buff(Rejuvenation)","lowest.range <= 40", "lowest.health <= 70"}, "lowest"},
{"Healing Touch",{"!player.moving","tank.buff(Rejuvenation)","tank.range <= 40", "tank.health <= 80"}, "tank"},
{"Healing Touch",{"!player.moving","focus.buff(Rejuvenation)","focus.range <= 40", "focus.health <= 80"}, "focus"},
},"!talent(7,2)"},

{{--155777 is germination
{"Healing Touch",{"!player.moving","lowest.buff(155777)","lowest.range <= 40", "lowest.health <= 70"}, "lowest"},--155777 is Germination
{"Healing Touch",{"!player.moving","tank.buff(155777)","tank.range <= 40", "tank.health <= 80"}, "tank"},
{"Healing Touch",{"!player.moving","focus.buff(155777)","focus.range <= 40", "focus.health <= 80"}, "focus"},
},"talent(7,2)"},

},"!glyph(116218)"},

---------------------------
--      END MANA CHECK  --
---------------------------
--END Mana Check
},"player.mana > 5"},

---------------------------
--      OOM ROTATION     --
---------------------------
{{
{{
--Incarnation OOM Support
{{
{ "Rejuvenation", {"lowest.range <= 40", "lowest.health <= 80","!lowest.buff(155777)"}, "lowest" }, --germ.
{ "Rejuvenation", {"focus.range <= 40",  "focus.health <= 90","!focus.buff(155777)"}, "focus" }, -- germ
{ "Rejuvenation", {"tank.range <= 40",  "tank.health <= 90","!tank.buff(155777)"}, "tank" }, -- germ
}, "talent(7,2)"},
{ "Rejuvenation", {"lowest.range <= 40", "!lowest.buff(774)", "lowest.health <= 90"}, "lowest" }, -- Rejuv.
{ "Rejuvenation", {"focus.range <= 40", "!focus.buff(774)", "focus.health <= 95"}, "focus" }, -- Rejuv.
{ "Rejuvenation", {"tank.range <= 40","!tank.buff(774)", "tank.health <= 95"}, "tank" }, -- Rejuv.
},"player.buff(117679)"},

{"Wrath", {"!player.moving","target.enemy", "talent(6,2)","target.range <= 40"}},--WRATH IF DoC
{"Wrath", {"!player.moving", "player.buff(124974)","target.enemy","target.range <= 40"}},--wrath if Nature Vigil
{"124974", {"talent(6,3)", "!player.buff(117679)"},},--natures vigil
{"Healing Touch", {"!player.moving","tank.range <= 40", "tank.health <= 20"},"tank"},
{"Healing Touch", {"!player.moving","lowest.range <= 40", "lowest.health <= 90"},"lowest"},
},"player.mana <= 10"},

---------------------------
--  TARGETING AND FOCUS  --
---------------------------
{{
{ "/targetenemy [noexists]", "!target.exists" },
{ "/focus [@targettarget]",{ "target.enemy","target(target).friend" } },
{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
}, "toggle.AutoTarget"},




--END COMBAT
},{

---------------------------
--      OUT OF COMBAT    --
---------------------------
{ "1126", "!player.buffs.stats" }, --stats
{"Wild Mushroom", "modifier.rcontrol", "mouseover.ground" }, --Shroom

},function()

ProbablyEngine.toggle.create('WildGrowth', 'Interface\\Icons\\ability_druid_flourish', 'Wild Growth','Toggle on/off use of Wild Growth')
ProbablyEngine.toggle.create('ShroomPlace', 'Interface\\Icons\\druid_ability_wildmushroom_a', 'Auto Shroom no Glyph','On for Tank / Off for Player')
ProbablyEngine.toggle.create('AutoTarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target and Focus','Target boss and focus currently active Tank')

end)