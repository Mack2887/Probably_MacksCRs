--Macks RetHelper- ENjoy!


ProbablyEngine.rotation.register_custom(70, "RetHelper", {


--157048
--144595

	

--Selfless Healer, this will cast your free instant FoL on whoever is the lowest health at the time. 
{"Divine Protection", {"player.health <= 90"},},
{ '!Flash of Light', {'player.buff(Selfless Healer).count = 3', 'lowest.health <= 90' },'lowest'},
{"!Divine Shield","player.health < 15"},
{"!Divine Storm",{"player.buff(144595)","player.buff(157048)"},},
--SAC--- This will SAC your partner if neither enemy is targeting you, and he's below 90%, implying they are focusing him.
--More Detailed Sac Usage coming in future
{"Hand of Sacrifice", {"!modifier.last", '!focus.target(player)', '!target.target(player)', '!party1.buff(Hand of Sacrifice)', 'party1.health < 90'}, 'party1'},
{"Hand of Sacrifice", {"!modifier.last", '!focus.target(player)', '!target.target(player)', '!party2.buff(Hand of Sacrifice)', 'party2.health < 90'}, 'party2'},
{"Hand of Sacrifice", {"!modifier.last", '!party1.buff(Hand of Sacrifice)', 'party1.health < 55'}, 'party1'},
{"Hand of Sacrifice", {"!modifier.last", '!party2.buff(Hand of Sacrifice)', 'party2.health < 55'}, 'party2'},

 -- Hand of Freedom
{ "1044", { "party1.root","!party1.buff(1044)"}, "party1" },
{ "1044", {"party1.snare","!party1.buff(1044)"}, "party1" },
{ "1044", { "party2.root","!party2.buff(1044)"}, "party2" },
{ "1044", {"party2.snare","!party2.buff(1044)"}, "party2" },
{ "1044", { "player.root","!player.buff(1044)"}, "player" },
{ "1044", {"player.snare","!player.buff(1044)"}, "player" },
{"!121783",{"player.snare","!lastcast(121783)"},},
{"!121783",{"player.root","!lastcast(121783)"},},
--save your buddy! or possibly yourself!
--save your buddy! or possibly yourself!
{'Hand of Protection', {'party1.health <= 15',"!party1.debuff(25771)"}, 'party1'},
{'Hand of Protection', {'party2.health <= 15',"!party2.debuff(25771)"}, 'party2'},
--Interrupts @arena1

{'Rebuke', {'focus.casting(Healing Touch)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Flash of Light)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Divine Light)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Healing Wave)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Healing Surge)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Regrowth)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Flash Heal)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Holy Light)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Penance)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Soothing Mist)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Hex)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Polymorph)', 'focus.range <= 5'}, 'focus' },
{'Rebuke', {'focus.casting(Cyclone)', 'focus.range <= 5'}, 'focus' },

--Interrupt @arena2

{'Rebuke', {'target.casting(Healing Touch)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Flash of Light)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Divine Light)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Healing Wave)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Healing Surge)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Regrowth)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Flash Heal)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Holy Light)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Penance)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Soothing Mist)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Hex)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Polymorph)', 'target.range <= 5'}, 'target' },
{'Rebuke', {'target.casting(Cyclone)', 'target.range <= 5'}, 'target' },

--Arcane Torrent (racial) Work in progress-----

--FOcus is casting @himself --out of range
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Healing Touch)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Regrowth)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Divine Light)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Flash of Light)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Healing Wave)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Healing Surge)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Flash Heal)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Penance)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Soothing Mist)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Hex)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Polymorph)'},},
{'Arcane Torrent', { 'focus.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Cyclone)'},},
--focus is casting @ target -- Out of Range
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Healing Touch)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Regrowth)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Divine Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Flash of Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Healing Wave)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Healing Surge)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Flash Heal)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Penance)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Soothing Mist)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Hex)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Polymorph)'},},
{'Arcane Torrent', { 'target.health < 50', 'focus.range > 5', 'focus.range <= 8', 'focus.casting(Cyclone)'},},

--Target is casting @ himself --Out of range
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Healing Touch)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Regrowth)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Divine Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Flash of Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Healing Wave)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Healing Surge)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Flash Heal)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Penance)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Soothing Mist)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Hex)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Polymorph)'},},
{'Arcane Torrent', { 'target.health < 50', 'target.range > 5', 'target.range <= 8', 'target.casting(Cyclone)'},},

------
--FOcus is casting @himself --Rubuke CD

{{
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Healing Touch)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Regrowth)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Divine Light)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Flash of Light)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Healing Wave)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Healing Surge)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Flash Heal)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Penance)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Soothing Mist)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Hex)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Polymorph)'},},
{'Arcane Torrent', { 'focus.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Cyclone)'},},
--focus is casting @ target -- Rubuke CD
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Healing Touch)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Regrowth)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Divine Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Flash of Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Healing Wave)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Healing Surge)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Flash Heal)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Penance)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Soothing Mist)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Hex)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Polymorph)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'focus.range <= 8', 'focus.casting(Cyclone)'},},

--Target is casting @ himself --Rubuke CD
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Healing Touch)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Regrowth)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Divine Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Flash of Light)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Healing Wave)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Healing Surge)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Flash Heal)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Penance)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Soothing Mist)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Hex)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Polymorph)'},},
{'Arcane Torrent', { 'target.health < 50', 'player.spell(Rebuke).cooldown > 0', 'target.range <= 8', 'target.casting(Cyclone)'},},
}, "!lastcast(Rebuke)"},
--Stun if Casting. Focus at Target below 25% hp

{'Fist of Justice', {'target.health < 25','focus.casting(Healing Touch)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Flash of Light)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Divine Light)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Healing Wave)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Healing Surge)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Regrowth)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Flash Heal)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Holy Light)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Penance)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Soothing Mist)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Hex)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Polymorph)', 'focus.range <= 20'}, 'focus' },
{'Fist of Justice', {'target.health < 25','focus.casting(Cyclone)', 'focus.range <= 20'}, 'focus' },

--Stun if Casting. target at Target below 25% hp

{'Fist of Justice', {'target.health < 25','target.casting(Healing Touch)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Flash of Light)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Divine Light)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Healing Wave)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Healing Surge)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Regrowth)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Flash Heal)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Holy Light)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Penance)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Soothing Mist)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Hex)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Polymorph)', 'target.range <= 20'}, 'target' },
{'Fist of Justice', {'target.health < 25','target.casting(Cyclone)', 'target.range <= 20'}, 'target' },



--Targeting and Focus (required)
{ "/targetenemy", "!target.exists" },
--{ "/focus arena2", "!focus.exists" },
{"/focus arena1", "player.target(arena2)"},
{"/focus arena2", "player.target(arena1)"},


},{



})