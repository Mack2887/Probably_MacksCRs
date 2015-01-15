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

ProbablyEngine.rotation.register_custom(264, "|cff00FFFFMacks|r - [|cff0000CDResto v3.3|r]", {





---------------------------
--    BUFFS and STUFF    --
---------------------------
{"/cancelaura Ghost Wolf",{"!player.moving", "player.buff(Ghost Wolf)"}},
{"/cancelaura Ghost Wolf",{"player.buff(79206)", "player.buff(Ghost Wolf)"}},
{ "52127", "!player.buff(52127)" },--Water Shield
{ "!Healing Tide Totem", "modifier.lalt" },-- HTT
{ "!Ascendance", "modifier.ralt" },--Ascendance
{"!98008",{"modifier.rcontrol"},"player"},--Spirit Link
{ "!Healing Rain",{"!player.moving","modifier.lcontrol"} , "mouseover.ground" },
{ "974", {"!player.buff(114052)", "!target.target(player)","focus.buff(974).count < 2","focus.range <= 40", "player.spell(974).casted < 1" }, "focus" }, --Eaarth Shield
{ "974", {"!player.buff(114052)","!target.target(player)", "tank.buff(974).count < 2", "tank.range <= 40", "player.spell(974).casted < 1" }, "tank" }, --Earth Shield
{ "57994", "modifier.interrupt" },   --  Wind Shear
{"79206",{"player.movingfor >= 1", "modifier.cooldowns", "!player.buff(79206)"}},--Spiritwalkers Gravce if Cooldown enabled and moving
{ "#trinket1","modifier.cooldowns" },
{ "#trinket2","modifier.cooldowns" },
{"!Storm Elemental Totem",{"talent(7,2)","modifier.rshift"}},
{"!2894",{"modifier.rshift"}}, 
{"!2062",{"modifier.rshift"}}, 
{{-- Primal Ele + Buffs
{"!2894",{"modifier.rshift"}}, 
{"!2062",{"modifier.rshift"}}, 
{"/cast Empower",{"player.totem(2894)","!player.buff(Empower)"}},
{"/cast Reinforce",{"player.totem(2062)","!player.buff(Reinforce)"}},
},"talent(6,2)"},
---------------------------
--       SURVIVAL        --
---------------------------
{ "!108271", { "player.health <= 45", "talent(1,3)" }, "player" },--Astral shift
{ "!108270", { "player.health <= 45","talent(1,2)" }, "player" },--Bulwark Totem
{ "#5512", "player.health <= 35" },  --healthstone
{ "Stoneform", "player.health <= 65" },
{ "Gift of the Naaru", "player.health <= 70", "player" },




---------------------------
--       DISPELLS        --
---------------------------
{"77130", {"!player.buff(114052)","!lastcast(77130)","player.mana > 10","@coreHealing.needsDispelled('Corrupted Blood')" }, nil },
{"77130", {"!player.buff(114052)","!lastcast(77130)","player.mana > 10","@coreHealing.needsDispelled('Slow')"}, nil },


---------------------------
--  WATER TOTEM/ Rains   --
---------------------------
{{
{"5394",{"!player.totem(108280)", "!player.totem(157153)","!player.totem(5394)"},"player"}, --Healing Stream
{"157153",{"!player.totem(108280)", "!player.totem(5394)","!player.totem(157153)", "talent(7,1)"},"player"}, --Cloud Burst

{{ --Always keep it down if you have Able to use 2 at once
{"5394",{"!player.totem(157153)"},"player"}, --Healing Stream
{"157153",{"!player.totem(5394)","talent(7,1)"},"player"}, --Cloud Burst
},"talent(3,2)"},
--Totem Reset
{ "108285", {"talent(3,1)", "@coreHealing.needsHealing(80, 3)", "player.spell(5394).cooldown >= 10"}, "player" },
--healing Rain
{{
{"Healing Rain",{"!player.moving","toggle.Rains"},"focus.ground"},  
{"Healing Rain",{"!player.moving","!toggle.Rains","!player.buff(Healing Rain)"},"player.ground"},
},"toggle.AutoRains"},
},"!player.buff(114052)"},
---------------------------
--       EMERGENCY     --
---------------------------
{{
{"73685",{"!player.buff(73685)","!lastcast(73685)", "lowest.health <= 90"},"tank"}, --Unleash Life on CD
{"73685",{"!player.buff(73685)","!lastcast(73685)", "player.moving"},"tank"}, --Unleash Life on CD
},"!player.buff(114052)"},
{"16188", {"lowest.health <= 40"}},
{"Healing Wave",{"player.buff(16188)"},"lowest"},
{"Healing Surge",{"!player.moving","tank.health <= 25","tank.range <= 40"},"tank"},
{"Healing Surge",{"!player.moving","lowest.health <= 20","lowest.range <= 40"},"lowest"},
{"Healing Surge",{"!player.moving","lowest.health <= 30","lowest.range <= 40", "player.buff(53390)"},"lowest"},


---------------------------
--       DPS MODE   --
---------------------------
{{
{"Searing Totem","player.totem(Searing Totem).duration <= 2"},
{"Flame Shock",{"target.debuff(Flame Shock).duration <= 8", "target.range <= 25"},"target"},
{"Lava Burst",{ "!player.moving", "target.range <= 30", "target.debuff(Flame Shock)"},"target"},
{"Elemental Blast",{"target.range <= 30", "!player.moving", "talent(6,3)"},"target"},
{"Frost Shock",{"target.debuff(Flame Shock).duration >= 8", "target.range <= 25"},"target"},
{"Lightning Bolt",{"target.range <= 30", "!player.moving"},"target"},
},"toggle.dps"},
 --Elemental Blast if talented Regardless of DPS toggle. For Mana Buff
{"Elemental Blast",{"target.range <= 30", "!player.moving", "talent(6,3)"},"target"},


---------------------------
--     MULTITARGET      --
---------------------------
{{

{{
{ "Chain Heal", {"lowest.range <= 40", "lowest.buff(Riptide)", "lowest.health <= 90"}, "lowest" }, 
{ "Chain Heal", {"focus.range <= 40", "focus.buff(Riptide)", "focus.health <= 30"}, "focus" }, 
{ "Chain Heal", {"tank.buff(Riptide)", "tank.health <= 30"}, "tank" }, 
},"!player.moving"},

{{
{ "Chain Heal", {"lowest.range <= 40", "lowest.buff(Riptide)", "lowest.health <= 90"}, "lowest" }, 
{ "Chain Heal", {"focus.range <= 40", "focus.buff(Riptide)", "focus.health <= 30"}, "focus" }, 
{ "Chain Heal", {"tank.buff(Riptide)", "tank.health <= 30"}, "tank" }, 
},"player.buff(Spiritwalker's Grace)"},

{{--Not Moving  
{ "Chain Heal", {"raid1.range <= 40","raid1.buff(Riptide)", "raid1.health <= 30"}, "raid1" }, 
{ "Chain Heal", {"player.buff(Riptide)", "player.health <= 30" }, "player" },
{ "Chain Heal", {"raid2.range <= 40","raid2.buff(Riptide)", "raid2.health <= 30"}, "raid2" }, 
{ "Chain Heal", {"raid3.range <= 40","raid3.buff(Riptide)", "raid3.health <= 30"}, "raid3" }, 
{ "Chain Heal", {"raid4.range <= 40","raid4.buff(Riptide)", "raid4.health <= 30"}, "raid4" }, 
{ "Chain Heal", {"raid5.range <= 40","raid5.buff(Riptide)", "raid5.health <= 30"}, "raid5" }, 
{ "Chain Heal", {"raid6.range <= 40","raid6.buff(Riptide)", "raid6.health <= 30"}, "raid6" }, 
{ "Chain Heal", {"raid7.range <= 40","raid7.buff(Riptide)", "raid7.health <= 30"}, "raid7" }, 
{ "Chain Heal", {"raid8.range <= 40","raid8.buff(Riptide)", "raid8.health <= 30"}, "raid8" }, 
{ "Chain Heal", {"raid9.range <= 40","raid9.buff(Riptide)", "raid9.health <= 30"}, "raid9" }, 
{ "Chain Heal", {"raid10.range <= 40","raid10.buff(Riptide)", "raid10.health <= 30"}, "raid10" }, 
{ "Chain Heal", {"raid11.range <= 40","raid11.buff(Riptide)", "raid11.health <= 30"}, "raid11" },
{ "Chain Heal", {"raid12.range <= 40","raid12.buff(Riptide)", "raid12.health <= 30"}, "raid12" }, 
{ "Chain Heal", {"raid13.range <= 40","raid13.buff(Riptide)", "raid13.health <= 30"}, "raid13" },
{ "Chain Heal", {"raid14.range <= 40","raid14.buff(Riptide)", "raid14.health <= 30"}, "raid14" },
{ "Chain Heal", {"raid15.range <= 40","raid15.buff(Riptide)", "raid15.health <= 30"}, "raid15" }, 
{ "Chain Heal", {"raid16.range <= 40","raid16.buff(Riptide)", "raid16.health <= 30"}, "raid16" }, 
{ "Chain Heal", {"raid17.range <= 40","raid17.buff(Riptide)", "raid17.health <= 30"}, "raid17" }, 
{ "Chain Heal", {"raid18.range <= 40","raid18.buff(Riptide)", "raid18.health <= 30"}, "raid18" }, 
{ "Chain Heal", {"raid19.range <= 40","raid19.buff(Riptide)", "raid19.health <= 30"}, "raid19" }, 
{ "Chain Heal", {"raid20.range <= 40","raid20.buff(Riptide)", "raid20.health <= 30"}, "raid20" }, 
{ "Chain Heal", {"raid21.range <= 40","raid21.buff(Riptide)", "raid21.health <= 30"}, "raid21" }, 
},"!player.moving"},

{{
{ "Riptide", {"lowest.range <= 40", "!lowest.buff(Riptide)", "lowest.health <= 90"}, "lowest" }, 
{ "Riptide", {"focus.range <= 40", "!focus.buff(Riptide)", "focus.health <= 31"}, "focus" },
{ "Riptide", {"tank.range <= 40","!tank.buff(Riptide)", "tank.health <= 31"}, "tank" }, 
{ "Riptide", { "raid1.range <= 40","!raid1.buff(Riptide)", "raid1.health <= 30"}, "raid1" }, -- Rejuv.
{ "Riptide", { "!player.buff(Riptide)", "player.health <= 30" }, "player" }, -- Rejuv.
{ "Riptide", { "raid2.range <= 40","!raid2.buff(Riptide)", "raid2.health <= 30"}, "raid2" }, -- Rejuv.
{ "Riptide", { "raid3.range <= 40","!raid3.buff(Riptide)", "raid3.health <= 30"}, "raid3" }, -- Rejuv.
{ "Riptide", { "raid4.range <= 40","!raid4.buff(Riptide)", "raid4.health <= 30"}, "raid4" }, -- Rejuv.
{ "Riptide", { "raid5.range <= 40","!raid5.buff(Riptide)", "raid5.health <= 30"}, "raid5" }, -- Rejuv.
{ "Riptide", { "raid6.range <= 40","!raid6.buff(Riptide)", "raid6.health <= 30"}, "raid6" }, -- Rejuv.
{ "Riptide", { "raid7.range <= 40","!raid7.buff(Riptide)", "raid7.health <= 30"}, "raid7" }, -- Rejuv.
{ "Riptide", { "raid8.range <= 40","!raid8.buff(Riptide)", "raid8.health <= 30"}, "raid8" }, -- Rejuv.
{ "Riptide", { "raid9.range <= 40","!raid9.buff(Riptide)", "raid9.health <= 30"}, "raid9" }, -- Rejuv.
{ "Riptide", { "raid10.range <= 40","!raid10.buff(Riptide)", "raid10.health <= 30"}, "raid10" }, -- Rejuv.
{ "Riptide", { "raid11.range <= 40","!raid11.buff(Riptide)", "raid11.health <= 30"}, "raid11" }, -- Rejuv.
{ "Riptide", { "raid12.range <= 40","!raid12.buff(Riptide)", "raid12.health <= 30"}, "raid12" }, -- Rejuv.
{ "Riptide", { "raid13.range <= 40","!raid13.buff(Riptide)", "raid13.health <= 30"}, "raid13" }, -- Rejuv.
{ "Riptide", { "raid14.range <= 40","!raid14.buff(Riptide)", "raid14.health <= 30"}, "raid14" }, -- Rejuv.
{ "Riptide", { "raid15.range <= 40","!raid15.buff(Riptide)", "raid15.health <= 30"}, "raid15" }, -- Rejuv.
{ "Riptide", { "raid16.range <= 40","!raid16.buff(Riptide)", "raid16.health <= 30"}, "raid16" }, -- Rejuv.
{ "Riptide", { "raid17.range <= 40","!raid17.buff(Riptide)", "raid17.health <= 30"}, "raid17" }, -- Rejuv.
{ "Riptide", { "raid18.range <= 40","!raid18.buff(Riptide)", "raid18.health <= 30"}, "raid18" }, -- Rejuv.
{ "Riptide", { "raid19.range <= 40","!raid19.buff(Riptide)", "raid19.health <= 30"}, "raid19" }, -- Rejuv.
{ "Riptide", { "raid20.range <= 40","!raid20.buff(Riptide)", "raid20.health <= 30"}, "raid20" }, -- Rejuv.
{ "Riptide", { "raid21.range <= 40","!raid21.buff(Riptide)", "raid21.health <= 30"}, "raid21" }, -- Rejuv.
},"player.spell(Riptide).casted <= 6"},--This incase you glyphed it

{{--Not Moving  
{ "Chain Heal", {"raid1.range <= 40","raid1.buff(Riptide)", "raid1.health <= 60"}, "raid1" }, 
{ "Chain Heal", {"player.buff(Riptide)", "player.health <= 60" }, "player" },
{ "Chain Heal", {"raid2.range <= 40","raid2.buff(Riptide)", "raid2.health <= 60"}, "raid2" }, 
{ "Chain Heal", {"raid3.range <= 40","raid3.buff(Riptide)", "raid3.health <= 60"}, "raid3" }, 
{ "Chain Heal", {"raid4.range <= 40","raid4.buff(Riptide)", "raid4.health <= 60"}, "raid4" }, 
{ "Chain Heal", {"raid5.range <= 40","raid5.buff(Riptide)", "raid5.health <= 60"}, "raid5" }, 
{ "Chain Heal", {"raid6.range <= 40","raid6.buff(Riptide)", "raid6.health <= 60"}, "raid6" }, 
{ "Chain Heal", {"raid7.range <= 40","raid7.buff(Riptide)", "raid7.health <= 60"}, "raid7" }, 
{ "Chain Heal", {"raid8.range <= 40","raid8.buff(Riptide)", "raid8.health <= 60"}, "raid8" }, 
{ "Chain Heal", {"raid9.range <= 40","raid9.buff(Riptide)", "raid9.health <= 60"}, "raid9" }, 
{ "Chain Heal", {"raid10.range <= 40","raid10.buff(Riptide)", "raid10.health <= 60"}, "raid10" }, 
{ "Chain Heal", {"raid11.range <= 40","raid11.buff(Riptide)", "raid11.health <= 60"}, "raid11" },
{ "Chain Heal", {"raid12.range <= 40","raid12.buff(Riptide)", "raid12.health <= 60"}, "raid12" }, 
{ "Chain Heal", {"raid13.range <= 40","raid13.buff(Riptide)", "raid13.health <= 60"}, "raid13" },
{ "Chain Heal", {"raid14.range <= 40","raid14.buff(Riptide)", "raid14.health <= 60"}, "raid14" },
{ "Chain Heal", {"raid15.range <= 40","raid15.buff(Riptide)", "raid15.health <= 60"}, "raid15" }, 
{ "Chain Heal", {"raid16.range <= 40","raid16.buff(Riptide)", "raid16.health <= 60"}, "raid16" }, 
{ "Chain Heal", {"raid17.range <= 40","raid17.buff(Riptide)", "raid17.health <= 60"}, "raid17" }, 
{ "Chain Heal", {"raid18.range <= 40","raid18.buff(Riptide)", "raid18.health <= 60"}, "raid18" }, 
{ "Chain Heal", {"raid19.range <= 40","raid19.buff(Riptide)", "raid19.health <= 60"}, "raid19" }, 
{ "Chain Heal", {"raid20.range <= 40","raid20.buff(Riptide)", "raid20.health <= 60"}, "raid20" }, 
{ "Chain Heal", {"raid21.range <= 40","raid21.buff(Riptide)", "raid21.health <= 60"}, "raid21" }, 
},"!player.moving"},

{{
{ "Riptide", {"focus.range <= 40", "!focus.buff(Riptide)", "focus.health <= 60"}, "focus" },
{ "Riptide", {"tank.range <= 40","!tank.buff(Riptide)", "tank.health <= 60"}, "tank" }, 
{ "Riptide", { "raid1.range <= 40","!raid1.buff(Riptide)", "raid1.health <= 60"}, "raid1" }, -- Rejuv.
{ "Riptide", { "!player.buff(Riptide)", "player.health <= 60" }, "player" }, -- Rejuv.
{ "Riptide", { "raid2.range <= 40","!raid2.buff(Riptide)", "raid2.health <= 60"}, "raid2" }, -- Rejuv.
{ "Riptide", { "raid3.range <= 40","!raid3.buff(Riptide)", "raid3.health <= 60"}, "raid3" }, -- Rejuv.
{ "Riptide", { "raid4.range <= 40","!raid4.buff(Riptide)", "raid4.health <= 60"}, "raid4" }, -- Rejuv.
{ "Riptide", { "raid5.range <= 40","!raid5.buff(Riptide)", "raid5.health <= 60"}, "raid5" }, -- Rejuv.
{ "Riptide", { "raid6.range <= 40","!raid6.buff(Riptide)", "raid6.health <= 60"}, "raid6" }, -- Rejuv.
{ "Riptide", { "raid7.range <= 40","!raid7.buff(Riptide)", "raid7.health <= 60"}, "raid7" }, -- Rejuv.
{ "Riptide", { "raid8.range <= 40","!raid8.buff(Riptide)", "raid8.health <= 60"}, "raid8" }, -- Rejuv.
{ "Riptide", { "raid9.range <= 40","!raid9.buff(Riptide)", "raid9.health <= 60"}, "raid9" }, -- Rejuv.
{ "Riptide", { "raid10.range <= 40","!raid10.buff(Riptide)", "raid10.health <= 60"}, "raid10" }, -- Rejuv.
{ "Riptide", { "raid11.range <= 40","!raid11.buff(Riptide)", "raid11.health <= 60"}, "raid11" }, -- Rejuv.
{ "Riptide", { "raid12.range <= 40","!raid12.buff(Riptide)", "raid12.health <= 60"}, "raid12" }, -- Rejuv.
{ "Riptide", { "raid13.range <= 40","!raid13.buff(Riptide)", "raid13.health <= 60"}, "raid13" }, -- Rejuv.
{ "Riptide", { "raid14.range <= 40","!raid14.buff(Riptide)", "raid14.health <= 60"}, "raid14" }, -- Rejuv.
{ "Riptide", { "raid15.range <= 40","!raid15.buff(Riptide)", "raid15.health <= 60"}, "raid15" }, -- Rejuv.
{ "Riptide", { "raid16.range <= 40","!raid16.buff(Riptide)", "raid16.health <= 60"}, "raid16" }, -- Rejuv.
{ "Riptide", { "raid17.range <= 40","!raid17.buff(Riptide)", "raid17.health <= 60"}, "raid17" }, -- Rejuv.
{ "Riptide", { "raid18.range <= 40","!raid18.buff(Riptide)", "raid18.health <= 60"}, "raid18" }, -- Rejuv.
{ "Riptide", { "raid19.range <= 40","!raid19.buff(Riptide)", "raid19.health <= 60"}, "raid19" }, -- Rejuv.
{ "Riptide", { "raid20.range <= 40","!raid20.buff(Riptide)", "raid20.health <= 60"}, "raid20" }, -- Rejuv.
{ "Riptide", { "raid21.range <= 40","!raid21.buff(Riptide)", "raid21.health <= 60"}, "raid21" }, -- Rejuv.
},"player.spell(Riptide).casted <= 6"},--This incase you glyphed it

{"Healing Wave",{"!player.moving","player.buff(53390)", "tank.health <= 90"}, "tank"},
{"Healing Wave",{"player.buff(Spiritwalker's Grace)","player.buff(53390)", "tank.health <= 90"}, "tank"},

{{--Not Moving  
{ "Chain Heal", {"raid1.range <= 40","raid1.buff(Riptide)", "raid1.health <= 90"}, "raid1" }, 
{ "Chain Heal", {"player.buff(Riptide)", "player.health <= 90" }, "player" },
{ "Chain Heal", {"raid2.range <= 40","raid2.buff(Riptide)", "raid2.health <= 90"}, "raid2" }, 
{ "Chain Heal", {"raid3.range <= 40","raid3.buff(Riptide)", "raid3.health <= 90"}, "raid3" }, 
{ "Chain Heal", {"raid4.range <= 40","raid4.buff(Riptide)", "raid4.health <= 90"}, "raid4" }, 
{ "Chain Heal", {"raid5.range <= 40","raid5.buff(Riptide)", "raid5.health <= 90"}, "raid5" }, 
{ "Chain Heal", {"raid6.range <= 40","raid6.buff(Riptide)", "raid6.health <= 90"}, "raid6" }, 
{ "Chain Heal", {"raid7.range <= 40","raid7.buff(Riptide)", "raid7.health <= 90"}, "raid7" }, 
{ "Chain Heal", {"raid8.range <= 40","raid8.buff(Riptide)", "raid8.health <= 90"}, "raid8" }, 
{ "Chain Heal", {"raid9.range <= 40","raid9.buff(Riptide)", "raid9.health <= 90"}, "raid9" }, 
{ "Chain Heal", {"raid10.range <= 40","raid10.buff(Riptide)", "raid10.health <= 90"}, "raid10" }, 
{ "Chain Heal", {"raid11.range <= 40","raid11.buff(Riptide)", "raid11.health <= 90"}, "raid11" },
{ "Chain Heal", {"raid12.range <= 40","raid12.buff(Riptide)", "raid12.health <= 90"}, "raid12" }, 
{ "Chain Heal", {"raid13.range <= 40","raid13.buff(Riptide)", "raid13.health <= 90"}, "raid13" },
{ "Chain Heal", {"raid14.range <= 40","raid14.buff(Riptide)", "raid14.health <= 90"}, "raid14" },
{ "Chain Heal", {"raid15.range <= 40","raid15.buff(Riptide)", "raid15.health <= 90"}, "raid15" }, 
{ "Chain Heal", {"raid16.range <= 40","raid16.buff(Riptide)", "raid16.health <= 90"}, "raid16" }, 
{ "Chain Heal", {"raid17.range <= 40","raid17.buff(Riptide)", "raid17.health <= 90"}, "raid17" }, 
{ "Chain Heal", {"raid18.range <= 40","raid18.buff(Riptide)", "raid18.health <= 90"}, "raid18" }, 
{ "Chain Heal", {"raid19.range <= 40","raid19.buff(Riptide)", "raid19.health <= 90"}, "raid19" }, 
{ "Chain Heal", {"raid20.range <= 40","raid20.buff(Riptide)", "raid20.health <= 90"}, "raid20" }, 
{ "Chain Heal", {"raid21.range <= 40","raid21.buff(Riptide)", "raid21.health <= 90"}, "raid21" }, 
},"!player.moving"},

},"modifier.multitarget"},



---------------------------
--     SINGLE TARGET     --
---------------------------

{"Riptide",{"tank.range <= 40", "!player.buff(53390)", "!tank.buff(61295)", "tank.health <= 95"},"tank"}, --to keep up Tidal Waves
{"Riptide",{"lowest.range <= 40", "!player.buff(53390)", "!lowest.buff(61295)", "lowest.health <= 95"},"tank"}, --to keep up Tidal Waves

{"Healing Wave",{"!player.moving","player.buff(53390)", "lowest.health <= 85"}, "lowest"},
{"Healing Wave",{"!player.moving","player.buff(53390)", "tank.health <= 90"}, "tank"},
{{
{"Healing Wave",{"player.buff(53390)", "lowest.health <= 85"}, "lowest"},
{"Healing Wave",{"player.buff(53390)", "tank.health <= 90"}, "tank"},
},"player.buff(Spiritwalker's Grace)"},
---------------------------
--       ghost wolf!     --
---------------------------
{"Ghost Wolf",{"player.movingfor >= 1", "!lastcast(Ghost Wolf)","!player.buff(Spiritwalker's Grace)"},},
{{
{ "/targetenemy [noexists]", "!target.exists" },
{ "/focus [@targettarget]",{ "target.enemy","target(target).friend" } },
{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
}, "toggle.AutoTarget"},


--OOC
},{

{ "52127", "!player.buff(52127)" },--Water Shield

},function()
ProbablyEngine.toggle.create('AutoRains', 'Interface\\Icons\\spell_nature_giftofthewaterspirit', 'AutoMatic Healing Rain','Enable Use of Automatic Healing Rain')
ProbablyEngine.toggle.create('Rains', 'Interface\\Icons\\ability_shaman_fortifyingwaters', 'Healing Rain Selector','On for Tank / Off for Player ONLY WORKS WITH Automatic HR ENABLED')
ProbablyEngine.toggle.create('AutoTarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target and Focus','Target boss and focus currently active Tank')
ProbablyEngine.toggle.create('dps', 'Interface\\Icons\\spell_nature_lightning', 'DPS MODE','Toggle on for DPS')

end)