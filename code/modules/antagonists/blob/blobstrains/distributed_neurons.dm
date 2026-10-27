//kills unconscious targets and turns them into blob zombies, produces fragile spores when killed.  Spore produced by factories are sentient.
/datum/blobstrain/reagent/distributed_neurons
	name = "分布式神经元"
	description = "会造成中低等毒素伤害，并将昏迷的目标变成变形菌僵尸。"
	effectdesc = "被击杀时还会产生脆弱的孢子。由工厂产生的孢子具有智慧。"
	shortdesc = "会造成中低等毒素伤害，并在受到攻击时杀死所有昏迷的目标。由工厂产生的孢子具有智慧。"
	analyzerdescdamage = "造成中低等毒素伤害，并杀死昏迷的人类。"
	analyzerdesceffect = "被击杀时产生孢子。由工厂产生的孢子具有智慧。"
	color = "#E88D5D"
	complementary_color = "#823ABB"
	message_living = "，而且你感到疲倦"
	reagent = /datum/reagent/blob/distributed_neurons

/datum/blobstrain/reagent/distributed_neurons/damage_reaction(obj/structure/blob/blob_tile, damage, damage_type, damage_flag)
	if((damage_flag == MELEE || damage_flag == BULLET || damage_flag == LASER) && damage <= 20 && blob_tile.get_integrity() - damage <= 0 && prob(15)) //if the cause isn't fire or a bomb, the damage is less than 21, we're going to die from that damage, 15% chance of a shitty spore.
		blob_tile.visible_message(span_boldwarning("一个孢子从变形菌上飘离！"))
		blob_tile.overmind.create_spore(blob_tile.loc, /mob/living/basic/blob_minion/spore/minion/weak)
	return ..()

/datum/reagent/blob/distributed_neurons
	name = "分布式神经元"
	color = "#E88D5D"
	taste_description = "滋滋冒泡"

/datum/reagent/blob/distributed_neurons/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	exposed_mob.apply_damage(0.6*reac_volume, TOX)
	if(ishuman(exposed_mob))
		if(IS_UNCONSCIOUS_AND_ALIVE(exposed_mob))
			exposed_mob.investigate_log("已被分布式神经元（变形菌）杀死。", INVESTIGATE_DEATHS)
			exposed_mob.death() //sleeping in a fight? bad plan.
		if(exposed_mob.stat == DEAD && overmind.can_buy(5))
			var/mob/living/basic/blob_minion/spore/minion/spore = overmind.create_spore(get_turf(exposed_mob))
			spore.zombify(exposed_mob)
			to_chat(overmind, span_notice("花费 5 点资源将[exposed_mob]僵尸化。"))
