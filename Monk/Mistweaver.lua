--A MISTWEAVER rotation by Mack

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

ProbablyEngine.rotation.register_custom(270, "MacksMW v5", {


--buffs/pause
{ "115921", "!player.buffs.stats" }, --stats

--Stance Management
{"154436",{"!lastcast(115070)","player.stance = 1","toggle.AutoStanceSwap","target.range <= 5", "target.enemy"},},
{"115070",{"!lastcast(154436)","player.stance = 2","toggle.AutoStanceSwap","target.range > 5",  "target.enemy"},},
{"154436",{"player.stance = 1","modifier.rshift"}},
{"115070",{"player.stance = 2","modifier.rshift"}},

--SURVIVAL
{ "!115203", { "player.health <= 35" }, "Player" },--fortifying brew
{ "#5512", "player.health <= 50" },  --healthstone

--CDs
{ "!115310", "modifier.lalt" },  --Revival
{"!115313", "modifier.rcontrol", "mouseover.ground" }, --statue
{ "#trinket1" },
{ "#trinket2" },

{ "!123986", "modifier.lcontrol", "player" },  --chi burst
{ "124081", {"lowest.health <= 90"}, "lowest" }, --zen shpere
{ "Chi Wave",{"lowest.health <= 100 "}, "lowest" }, --chi wave

--Expel Harm on CD if not channeling
 { "Expel Harm", {"lowest.health <= 100","player.chi < 4"}, "lowest" }, 

--Dispells
-- {"!Detox", {"!lastcast","player.mana > 10","player.spell(Detox).casted < 1", "@coreHealing.needsDispelled('Corrupted Blood')" }, nil },
-- {"!Detox", {"!lastcast","player.mana > 10","player.spell(Detox).casted < 1", "@coreHealing.needsDispelled('Slow')"}, nil },
{"Detox", {"!lastcast(Detox)","player.mana > 10","@coreHealing.needsDispelled('Corrupted Blood')" }, nil },
{"Detox", {"!lastcast(Detox)","player.mana > 10","@coreHealing.needsDispelled('Slow')"}, nil },




--TESTINg
--{ "!115175", { "lowest.health <= 100", "!player.moving", "!lastcast", "lowest.buff(115175).duration <= 1"}, "lowest" }, -- Soothing Mist
--{ "124682", {"player.casting(soothing mist)", "lowest.health <= 100", "player.chi >= 3" }, "lowest" }, -- EnM
--{ "116694", { "player.casting","lowest.health <= 100" }, "lowest" }, -- Surging Mist

--!!!!!!!!!!!!!!!    JADE SERPENT STANCE      !!!!!!!!!!!!!!!!!
  {{

 

  --Need mana Emergency
  { "!115294", { "player.mana < 8", "player.buff(115867).count >= 2","!player.spell(Uplift).casting", "!player.moving"},}, -- mana tea

  --Focus emergency
  {"!Life Cocoon", {"focus.health <= 20", "focus.friend"}, "focus"},
  { "!115175", { "focus.health <= 20", "!player.moving", "!player.spell(Uplift).casting","!lastcast(115175)", "focus.buff(115175).duration <= 1"}, "focus" }, -- Soothing Mist
  { "116680", "focus.health <= 20" , "player" }, -- TFT
  { "124682", { "player.casting", "focus.health <= 20", "player.chi >= 3" }, "focus" }, -- EnM
  { "116694", { "player.casting", "focus.health <= 20" }, "focus" }, -- Surging Mist

  --Tank emergency Healing
  {"!Life Cocoon", {"tank.health <= 25", "focus.friend"}, "tank"},
  { "!115175", { "tank.health <= 15", "!player.moving","!player.spell(Uplift).casting", "!lastcast(115175)",  "tank.buff(115175).duration <= 1"}, "tank" }, -- Soothing Mist
  { "116680", "tank.health <= 15" , "player" }, -- TFT
  { "124682", { "player.casting", "tank.health <= 14", "player.chi >= 3" }, "tank" }, -- EnM
  { "116694", { "player.casting", "tank.health <= 14" }, "tank" }, -- Surging Mist

  --Emergency Healing
  { "!115175", { "lowest.health <= 18", "!player.moving", "!player.spell(Uplift).casting","!lastcast(115175)", "lowest.buff(115175).duration <= 1"}, "lowest" }, -- Soothing Mist
  { "116680", "lowest.health <= 18" , "player" }, -- TFT
  { "124682", { "player.casting", "lowest.health <= 18", "player.chi >= 3" }, "lowest" }, -- EnM
  { "116694", { "player.casting", "lowest.health <= 18" }, "lowest" }, -- Surging Mist

  
 --ReM @3 stacks
  { "!Renewing Mist", { "lowest.buff(119611).duration <= 2","!player.spell(Uplift).casting","player.spell(Renewing Mist).charges = 3" , "player.chi < 4" } , "lowest" }, 
  { "!Renewing Mist", { "tank.buff(119611).duration <= 2","!player.spell(Uplift).casting","player.spell(Renewing Mist).charges = 3" , "player.chi < 4" } ,"tank" }, 
  { "!Renewing Mist", { "focus.buff(119611).duration <= 2","!player.spell(Uplift).casting","player.spell(Renewing Mist).charges = 3" , "player.chi < 4" } ,"focus" }, 
  { "!115151", { "!player.spell(Uplift).casting","player.spell(Renewing Mist).charges = 3" , "player.chi < 4" } , "lowest" }, 

  --MANA
  { "115294", { "!lastcast(115294)","player.mana < 75", "player.buff(115867).count >= 2","!player.moving"},}, -- mana tea



  -------------!!!!  AoE If multitarget is enabled. ReM/Uplift healing  !!!!-------------------
    {{
    { "!Uplift", { "raid.health <= 90","!player.moving", "!player.spell(Uplift).casting", "player.chi >= 2" },"player"}, --Uplift
    { "!116680",{"!player.spell(Uplift).casting"}, "player"},
    { "!Renewing Mist", { "lowest.buff(119611).duration <= 4","!player.spell(Uplift).casting", "player.spell(Renewing Mist).charges > 1" , "player.chi < 4"}, "lowest" }, --ReM 
    { "!Renewing Mist", { "focus.buff(119611).duration <= 4","!player.spell(Uplift).casting", "player.spell(Renewing Mist).charges > 1" , "player.chi < 4"}, "focus" }, --ReM 
    { "!Renewing Mist", { "@coreHealing.needsHealing(80, 5)" ,"!player.spell(Uplift).casting", "player.spell(Renewing Mist).charges > 1" , "player.chi <= 2"}, "lowest" }, --ReM 
    { "!Renewing Mist", { "!player.spell(Uplift).casting","player.chi < 2", "@coreHealing.needsHealing(80, 5)" }, "focus" }, --ReM Need Chi
    { "!Renewing Mist", { "!player.spell(Uplift).casting","player.chi < 2", "@coreHealing.needsHealing(80, 5)" }, "tank" }, --ReM Need Chi
    --Need more Chi for uplift
    { "115175", {"lowest.health <= 100","!lastcast(115175)","!player.spell(Uplift).casting","!player.moving", "lowest.buff(115175).duration <= 1"}, "lowest" }, -- Soothing Mist
    { "116694", {"player.mana >= 20","@coreHealing.needsHealing(85, 5)","lowest.health <= 90", "player.chi < 2"}, "lowest" }, -- Surging Mist

    }, "modifier.multitarget"},
    ----------------------!!!! AoE END !!!!---------------------------




  --!!!!!!!!!!!!!!!      SINGLE TARGET  (multitarget disabled)  !!!!!!!!!!!!!
    --Lowest if below 80% (tank included), tank if below 90%, anyone
    {{
    { "!116680", {"lowest.health <= 60"} , "player" }, -- TFT
    { "!115175", {"lowest.health <= 60","!player.moving", "!lastcast(115175)","lowest.buff(115175).duration <= 1"}, "lowest" }, -- Soothing Mist
    { "124682", { "player.casting", "lowest.health <= 60", "player.chi > 2" }, "lowest" }, -- EnM
    { "116694", { "player.casting", "lowest.health <= 60"}, "lowest" }, -- Surging Mist

    { "!115175", {"lowest.health <= 80","!player.moving", "!lastcast(115175)","lowest.buff(115175).duration <= 1"}, "lowest" }, -- Soothing Mist
    { "124682", { "player.casting", "lowest.health <= 80", "player.chi > 2" }, "lowest" }, -- EnM
    { "116694", { "player.casting", "lowest.health <= 80","!lastcast(116694)" }, "lowest" }, -- Surging Mist
    { "!115175", {"tank.health <= 90","!player.moving", "!lastcast(115175)", "tank.buff(115175).duration <= 1"}, "tank" }, -- Soothing Mist
    { "124682", { "player.casting", "tank.health <= 90", "player.chi > 2" }, "tank" }, -- EnM
    { "116694", { "player.casting", "tank.health <= 90", "!lastcast(116694)" }, "tank" }, -- Surging Mist
    
    { "124682", { "player.casting", "lowest.health <= 92", "player.chi > 2" }, "lowest" }, -- EnM dump chi
    {"!115175", { "lowest.health <= 100", "!player.moving", "lowest.buff(115175).duration <= 1"}, "lowest" }, --soothing

    
    }, "!modifier.multitarget"},
    --!!!!!!!!!!!!!!!      END SINGLE TARGET  (multitarget disabled)  !!!!!!!!!!!!!


  }, "player.stance = 1" },
  --!!!!!!!!!!!!!!!        END SERPANT STANCE HEALING        !!!!!!!!!!!!!!!!!!!!!!




--!!!!!!!!!!!!!!!         CRANE STANCE DPS          !!!!!!!!!!!!!!!!!!!!!!
  {{
  { "Surging Mist", {"player.buff(Vital Mists).count = 5"},"lowest" },
  {"Tiger Palm", {"player.buff(Vital Mists.count = 4", "player.chi > 0" }},
  { "Rising Sun Kick", {"target.debuff(130320).duration < 5", "player.chi > 1"} },
  {"Blackout Kick", {"player.buff(127722).duration < 5", "player.chi > 1" }},
  {"Tiger Palm", {"player.buff(125359).duration < 5", "player.chi > 0" }},
  {"Blackout Kick", "player.chi > 1" },
  {"Jab"}, 

  }, "player.stance = 2"},

  --!!!!!!!!!!!!!       END CRANE STANCE        !!!!!!!!!!!


--Targeting & Focus
  { "/targetenemy [noexists]", "!target.exists" },
  { "/focus [@targettarget]", "target.enemy"  },
  { "/target [target=focustarget, harm, nodead]", "target.range > 40" },

--END COMBAT
},{


--out of combat
{ "115921", "!player.buffs.stats" }, --stats
{"!115313",{"modifier.rcontrol"}, "mouseover.ground" }, --statue

},function()


ProbablyEngine.toggle.create('AutoStanceSwap', 'Interface\\Icons\\monk_stance_redcrane', 'Auto Crane','Auto Stance Swap when in melee')


end)
