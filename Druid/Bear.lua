
---------------------------
--  Macks Beastly Bear   --
---------------------------

ProbablyEngine.rotation.register_custom(104, "|cff00FFFFMacks|r - [|cffFF7D0ABear v2.1|r]", {



---------------------------
--      MODIFIERS       --
---------------------------
{"!108294", "modifier.ralt", "talent(6,1)"}, --Heart of the wild
{"!124974", "modifier.ralt", "talent(6,3)"},--Natures Vigil
{"!106898", "modifier.lshift"}, --Stampeding Roar
{"!20484", "modifier.rshift", "mouseover"}, --Rebirth
---------------------------
--      SURVIVAL        --
---------------------------

{"Cenarion Ward",{"player.health < 85", "player.spell(Cenarion Ward).exists"},"player"},
{ "108238", { "player.health <= 40", "talent(2,2)" }, "Player" },--Renewal
{ "#5512", "player.health <= 30" },  --healthstone
--{"!50334", {"player.health <= 30"}}, 
{"Healing Touch",{"player.buff(145162)","player.health < 90"},"player"},
{"!Survival Instincts",{"target.target(player)","player.health < 50", "!lastcast(Survival Instincts)" ,"!player.buff(Survival Instincts)"}},
{"!barkskin",{"target.target(player)","player.health < 70", "!lastcast(Survival Instincts)" ,"!player.buff(Survival Instincts)"}},
{"5487",{"player.stance != 1"}},
--145162 DoC
--135286  TnC

---------------------------
--      AUTO TAUNT      --
---------------------------
{{
{"Growl",{"!target.target(player)", "focus.debuff(Open Wounds).count >= 2"},"target"},
{"Growl",{"!target.target(player)", "focus.debuff(The Tenderizer)", "!player.debuff(The Tenderizer)"},"target"},
{"/target Brackenspore",{"!boss1.target(player)", "focus.debuff(Rot).count >= 4", "!player.debuff(Rot)"},"boss1"},
{"Growl",{"!target.target(player)", "focus.debuff(Rot).count >= 4", "!player.debuff(Rot)"},"boss1"},
},"toggle.AutoTaunt"},


---------------------------
--      INTERRUPTS       --
---------------------------

{ "Skull Bash", { "modifier.interrupt", "target.interruptAt(40)" },"target" },
{ "Mighty Bash",{ "modifier.interrupt", "player.spell(Skull Bash).cooldown"}, "target" },
---------------------------
--       COOLDOWNS       --
---------------------------

{ "Berserk", "modifier.cooldowns" }, 
{ "Nature's Vigil", "modifier.cooldowns"},
{ "Incarnation", "modifier.cooldowns"},  


---------------------------
--   ACTIVE MITIGATION   --
---------------------------
{{
{"!62606", { "player.health <= 95", "!lastcast(62606)", "!player.buff(132402)", "target.threat >= 100"}},

{"Maul",{"player.buff(Tooth and Claw).count = 3", "target.range <= 6"},"target"},
{"Maul",{"player.buff(Tooth and Claw)","player.rage >= 70","target.range <= 6"},"target"},
{"Maul",{"player.buff(Tooth and Claw)", "target.range <= 6", "player.spell(62606).charges < 1", "player.spell(62606).recharge >= 3"},"target"},
{"Maul",{"player.buff(Tooth and Claw)", "target.range <= 6", "player.buff(132402).duration > 2",},"target"},


{"!Frenzied Regeneration",{"Player.health <= 20", "player.rage >= 20","!player.buff(Tooth and Claw)","player.spell(62606).recharge >= 3"}},
{"!Frenzied Regeneration",{"Player.health <= 85", "player.rage >= 20", "player.spell(62606).charges < 1", "player.spell(62606).recharge > 3"}},
{"!Frenzied Regeneration",{"Player.health <= 90", "player.rage >= 60", "!target.target(player)","target.exists","target.enemy"}},

},"toggle.ActiveMit"},
---------------------------
--    TOOTH AND CLAW     --
---------------------------
{"Maul",{"player.buff(Tooth and Claw)","target.range < 6","!toggle.ActiveMit"},"target"},
{"Maul",{"player.rage > 60", "!target.target(player)"},"target"},
---------------------------
--    COMBAT ROTATION    --
---------------------------
{ "770", {"!target.debuff(770)", "target.boss"} }, -- Faerie Fire
{ "Pulverize", {"target.debuff(Lacerate).count >= 3", "player.buff(Pulverize).duration <= 3", "target.target(player)"} }, -- Pulverize
{ "Mangle" },
		
{ "Thrash", "modifier.multitarget" }, 
{ "Thrash", "target.debuff(77758).duration <= 3" }, 
{ "Lacerate" },



--Targeting & Focus
  { "/targetenemy [noexists]", "!target.exists" },


--END COMBAT
},{


--out of combat
{ "/cancelform", {"!player.buffs.stats", "player.stance = 1" }},
{ "!1126", "!player.buffs.stats" }, --stats
{"5487",{"player.stance != 1"}},

},function()

ProbablyEngine.toggle.create('ActiveMit', 'Interface\\Icons\\ability_druid_enrage', 'Active Mitigation','Auto use of Active Mitigation')
ProbablyEngine.toggle.create('AutoTaunt', 'Interface\\Icons\\ability_physical_taunt', 'Auto TAUNT','BROKEN FOR NOW')

end)