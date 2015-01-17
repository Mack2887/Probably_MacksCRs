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

ProbablyEngine.rotation.register_custom(65, "|cff00FFFFMacks|r - [|cffF58CBAHoly v1.3|r]", {


--{"",{""},""},


---------------------------
--Blessings/Buffs/BEACON --
---------------------------
{ "20217", {"!player.buffs.stats" ,"toggle.Blessing" }, "player" },--Lings
{ "19740", { "!player.buffs.mastery" ,"!toggle.Blessing" }, "player" },--Might
{ "20165", {  "player.seal != 2"}, "player" }, --Seal of Insight
{"156910",{"tank.agro","!tank.buff(53563)","!tank.buff(156910)", "talent(7,1)","!lastcast(156910)","player.spell(156910).casted < 1"},"tank"},
{"53563",{"tank.agro","!tank.buff(53563)","!tank.buff(156910)", "!lastcast(53563)","player.spell(53563).casted < 1"},"tank"},
--BoL buff  53563
--Bof buff 156910

---------------------------
--       MODIFIERS     --
---------------------------
{"!Devotion Aura",{"modifier.ralt"},"player"},
{"!Light's Hammer",{"modifier.lcontrol"},"mouseover.ground"},
{"!Avenging Wrath",{"modifier.lalt"},"player"},
{"!Holy Avenger",{"modifier.rcontrol","talent(5,1)"},"player"},
{"Rebuke", {"modifier.interrupts","target.range <= 6"}, "target" }, 
---------------------------
--       SURVIVAL        --
---------------------------
{ "!Divine Shield", { "player.health <= 15" }, "player" },
{ "Divine Protection", { "player.health <= 45" }, "player" },
{ "#5512", "player.health <= 35","player" },  --healthstone
{ "Stoneform", "player.health <= 65" },
{ "Gift of the Naaru", "player.health <= 70", "player" },
{"!633",{"tank.health <= 20", "modifier.cooldowns"},"tank"}, --Lay on Hands
{"!633",{"lowest.health <= 15", "modifier.cooldowns"},"lowest"},
{ "Arcane Torrent", {"@coreHealing.needsHealing(85,5)","player.holypower <= 2","player.spell(Holy Shock).cooldown > 1"},"player" },

---------------------------
--       DISPELLS        --
---------------------------
{{
{"Cleanse", {"!lastcast(88423)","player.mana > 10", "@coreHealing.needsDispelled('Corrupted Blood')"}, nil },
{"Cleanse", {"!lastcast(88423)","player.mana > 10", "@coreHealing.needsDispelled('Slow')"}, nil },
},"player.mana > 10" },
--{ "Cleanse", "player.dispellable(Cleanse)" },
-------------------------
-- HANDS/Emergency     --
-------------------------
{{
{ "!Hand of Protection", {"!lastcast(Hand of Protection)","!player.buff", "player.health <= 10" }, "player" },
{ "!Hand of Protection", {"!target.target(lowest)","!lastcast(Hand of Protection)","!lowest.buff", "lowest.health <= 10" }, "lowest" },
{ "!Hand of Sacrifice", {"!lastcast(Hand of Sacrifice)","!player.buff", "tank.health <= 45" }, "tank" },
{ "!Hand of Sacrifice", {"!lastcast(Hand of Sacrifice)","!lowest.buff", "lowest.health <= 25" }, "lowest" },

{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!player.buff", "player.state.root" }, "player" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!lowest.buff", "lowest.state.root" }, "lowest" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid2.buff", "raid2.state.root" }, "raid2" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid3.buff", "raid3.state.root" }, "raid3" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid4.buff", "raid4.state.root" }, "raid4" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid5.buff", "raid5.state.root" }, "raid5" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid6.buff", "raid6.state.root" }, "raid6" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid7.buff", "raid7.state.root" }, "raid7" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid8.buff", "raid8.state.root" }, "raid8" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid9.buff", "raid9.state.root" }, "raid9" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid10.buff", "raid10.state.root" }, "raid10" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid11.buff", "raid11.state.root" }, "raid11" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid12.buff", "raid12.state.root" }, "raid12" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid13.buff", "raid13.state.root" }, "raid13" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid14.buff", "raid14.state.root" }, "raid14" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid15.buff", "raid15.state.root" }, "raid15" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid16.buff", "raid16.state.root" }, "raid16" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid17.buff", "raid17.state.root" }, "raid17" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid18.buff", "raid18.state.root" }, "raid18" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid19.buff", "raid19.state.root" }, "raid19" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!player.buff", "player.state.snare" }, "player" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!lowest.buff", "lowest.state.snare" }, "lowest" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid2.buff", "raid2.state.snare" }, "raid2" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid3.buff", "raid3.state.snare" }, "raid3" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid4.buff", "raid4.state.snare" }, "raid4" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid5.buff", "raid5.state.snare" }, "raid5" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid6.buff", "raid6.state.snare" }, "raid6" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid7.buff", "raid7.state.snare" }, "raid7" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid8.buff", "raid8.state.snare" }, "raid8" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid9.buff", "raid9.state.snare" }, "raid9" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid10.buff", "raid10.state.snare" }, "raid10" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid11.buff", "raid11.state.snare" }, "raid11" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid12.buff", "raid12.state.snare" }, "raid12" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid13.buff", "raid13.state.snare" }, "raid13" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid14.buff", "raid14.state.snare" }, "raid14" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid15.buff", "raid15.state.snare" }, "raid15" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid16.buff", "raid16.state.snare" }, "raid16" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid17.buff", "raid17.state.snare" }, "raid17" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid18.buff", "raid18.state.snare" }, "raid18" },
{ "Hand of Freedom", {"!lastcast(Hand of Freedom)","!raid19.buff", "raid19.state.snare" }, "raid19" },
},"toggle.AutoHands"},

---------------------------
--      EMERGENCY/Proc   --
---------------------------
{{
{"Flash of Light",{"!player.moving","tank.health <= 60", "tank.range <= 40","player.spell(Holy Shock).cooldown > 1"},"tank"},
{"Flash of Light",{"!player.moving","lowest.health <= 50", "lowest.range <= 40","player.spell(Holy Shock).cooldown > 1"},"lowest"},
{"Flash of Light",{"!player.moving","tank.health <= 50", "tank.range <= 40","player.holypower = 5"},"tank"},
{"Flash of Light",{"!player.moving","lowest.health <= 40", "lowest.range <= 40","player.holypower = 5"},"lowest"},
{"Flash of Light",{"!player.moving","tank.health <= 40", "tank.range <= 40"},"tank"},
{"Flash of Light",{"!player.moving","lowest.health <= 30", "lowest.range <= 40"},"lowest"},
},"!modifier.raid"},

{"Holy Shock",{"lowest.health <= 96", "lowest.range <= 40", "player.holypower < 5","!player.buff(105809)"},"lowest"},
{"Holy Shock",{"lowest.health <= 96", "lowest.range <= 40", "player.holypower < 3","player.buff(105809)"},"lowest"},

{"Execution Sentence",{"tank.health <= 80", "tank.range <= 40", "talent(6,3)","player.spell(Holy Shock).cooldown > 1"},"tank"},
{"Execution Sentence",{"lowest.health <= 70", "lowest.range <= 40","talent(6,3)","player.spell(Holy Shock).cooldown > 1"},"lowest"},
{"Holy Prism",{"@coreHealing.needsHealing(95,3)", "target.range <= 40", "talent(6,1)","target.enemy"},"target"},
{"Execution Sentence",{"tank.health <= 80", "tank.range <= 40", "talent(6,3)","player.holypower = 5"},"tank"},
{"Execution Sentence",{"lowest.health <= 70", "lowest.range <= 40","talent(6,3)","player.holypower = 5"},"lowest"},
{"Holy Prism",{"@coreHealing.needsHealing(95,5)", "target.range <= 40", "talent(6,1)","player.holypower = 5"},"target"},

{"Flash of Light",{"!player.moving","tank.health <= 40", "tank.range <= 40","player.spell(Holy Shock).cooldown > 1"},"tank"},
{"Flash of Light",{"!player.moving","lowest.health <= 30", "lowest.range <= 40","player.spell(Holy Shock).cooldown > 1"},"lowest"},

{"Flash of Light",{"!player.moving","tank.health <= 40", "tank.range <= 40","player.holypower = 5"},"tank"},
{"Flash of Light",{"!player.moving","lowest.health <= 30", "lowest.range <= 40","player.holypower = 5"},"lowest"},


---------------------------
--  SAcRED SHIELD   CR  --
---------------------------
{{--Start SS CR
  --148039 Sacred shield buff
--105809 Holy avenger
{"Light of Dawn",{"!player.moving","@coreHealing.needsHealing(96,2)", "lowest.range <= 40","player.buff(90174)"},"tank"},
--add agro too SS



{"Light of Dawn",{"!player.moving","player.holypower == 5","@coreHealing.needsHealing(96,5)", "lowest.range <= 40"},"lowest"},
{"Light of Dawn",{"!player.moving","player.holypower == 5","@coreHealing.needsHealing(93,4)", "lowest.range <= 40"},"lowest"},
{"Light of Dawn",{"!player.moving","player.holypower == 5","@coreHealing.needsHealing(90,3)", "lowest.range <= 40"},"lowest"},

{"Light of Dawn",{"!player.moving","player.holypower >= 3","@coreHealing.needsHealing(88,5)", "lowest.range <= 40"},"lowest"},
{"Light of Dawn",{"!player.moving","player.holypower >= 3","@coreHealing.needsHealing(80,3)", "lowest.range <= 40"},"lowest"},
{"Light of Dawn",{"!player.moving","player.holypower >= 3","@coreHealing.needsHealing(75,2)", "lowest.range <= 40"},"lowest"},

{"Sacred Shield",{"player.spell(Holy Shock).cooldown > 1","!lastcast(Sacred Shield)","tank.buff(148039).duration <= 5","tank.range <= 40", "tank.health <= 99" },"tank"},
{"Sacred Shield",{"player.spell(Holy Shock).cooldown > 1","!lastcast(Sacred Shield)","lowest.range <= 40", "lowest.buff(148039).duration <= 5","player.spell(Sacred Shield).charges >= 1", "lowest.health <= 95"},"lowest"},
{"Sacred Shield",{"player.holypower = 5","!lastcast(Sacred Shield)","tank.buff(148039).duration <= 5","tank.range <= 40", "tank.health <= 99" },"tank"},
{"Sacred Shield",{"player.holypower = 5","!lastcast(Sacred Shield)","lowest.range <= 40", "lowest.buff(148039).duration <= 5","player.spell(Sacred Shield).charges >= 1", "lowest.health <= 95"},"lowest"},





{{
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(75,6)","player.holypower < 5","!player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(75,6)","player.holypower < 3","player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(65,5)","player.holypower < 5","!player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(65,5)","player.holypower < 3","player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(55,4)","player.holypower < 5","!player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(55,4)","player.holypower < 3","player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(45,3)","player.holypower < 5","!player.buff(105809)"},"lowest"},
{"Holy Radiance",{"player.mana >= 20","@coreHealing.needsHealing(45,3)","player.holypower < 3","player.buff(105809)"},"lowest"},
},"toggle.HRad"},
--{"Word of Glory",{"!@coreHealing.needsHealing(95, 4)","player.holypower = 5","lowest.health <= 77","lowest.range <= 40", "!player.moving"},"lowest"},
--{"Word of Glory",{"!@coreHealing.needsHealing(95, 4)","player.holypower = 5","lowest.health <= 88","tank.range <= 40", "!player.moving"},"tank"},
{"Holy Light",{"lowest.health <= 85","lowest.range <= 40", "!player.moving","player.spell(Holy Shock).cooldown > 1"},"lowest"},
{"Holy Light",{"tank.health <= 92","tank.range <= 40", "!player.moving","player.spell(Holy Shock).cooldown > 1"},"tank"},
{"Holy Light",{"lowest.health <= 85","lowest.range <= 40", "!player.moving","player.holypower = 5"},"lowest"},
{"Holy Light",{"tank.health <= 92","tank.range <= 40", "!player.moving","player.holypower = 5"},"tank"},

},"talent(3,3)"},--End SS CR
















---------------------------
-- TARGETING AND FOCUS  --
---------------------------
{{
{ "/targetenemy [noexists]", "!target.exists" },
{ "/focus [@targettarget]",{ "target.enemy","target(target).friend" } },
{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
}, "toggle.AutoTarget"},






















},{  --OOC


---------------------------
--       Blessings      --
---------------------------
{ "20217", {"!player.buffs.stats" ,"toggle.Blessing" }, "player" },
{ "19740", { "!player.buffs.mastery" ,"!toggle.Blessing" }, "player" }, 



},function()
ProbablyEngine.toggle.create('Blessing', 'Interface\\Icons\\spell_magic_greaterblessingofkings', 'Blessings','On for Kings off for Might')
ProbablyEngine.toggle.create('HRad', 'Interface\\Icons\\spell_paladin_divinecircle', 'Holy Radiance','Toggle on/off use of Holy Radiance')
ProbablyEngine.toggle.create('AutoHands', 'Interface\\Icons\\spell_holy_sealofwisdom', 'Automatic Hands Usage','SAC/BoP/Freedom Automatic Usage Not for Pros')
ProbablyEngine.toggle.create('AutoTarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target and Focus','Target boss and focus currently active Tank')

end)