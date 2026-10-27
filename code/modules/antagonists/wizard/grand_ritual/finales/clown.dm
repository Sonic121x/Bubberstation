/// Dress the crew as magical clowns
/datum/grand_finale/clown
	name = "欢庆"
	desc = "你积聚力量的终极运用！改写时间线，让所有人都上过小丑学院！现在他们会替你互相恶作剧！"
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "clown"
	glow_colour = "#ffff0048"

/datum/grand_finale/clown/trigger(mob/living/carbon/human/invoker)
	for(var/mob/living/carbon/human/victim as anything in GLOB.human_list)
		victim.Unconscious(3 SECONDS)
		if (victim == invoker)
			if(locate(/datum/action/cooldown/spell/pointed/untie_shoes) in invoker.actions)
				continue
			var/datum/action/cooldown/spell/pointed/untie_shoes/newer_spell = new(invoker)
			newer_spell.Grant(invoker)
			for(var/i in 1 to newer_spell.spell_max_level)
				newer_spell.level_spell()
				newer_spell.invocation_type = INVOCATION_SHOUT
			continue
		if (!victim.mind || IS_HUMAN_INVADER(victim))
			continue
		if (HAS_TRAIT(victim, TRAIT_CLOWN_ENJOYER))
			victim.add_mood_event("clown_world", /datum/mood_event/clown_world)
		to_chat(victim, span_notice("世界旋转、消融。你的过去在眼前倒放着闪过。\n\
			生命退回海洋，缩成虚无；行星炸裂成太阳尘埃的风暴，\
			群星在万物之初匆匆相会，然后……你猛地回到当下。 \n\
			一切都与从前一样，一如既往。 \n\n\
			一个念头牢牢占据你的脑海。 \n\
			[span_hypnophrase("我真高兴能在小丑研究站 [station_name()] 工作！")] \n\
			这……对吗？"))
		if (is_clown_job(victim.mind.assigned_role))
			var/datum/action/cooldown/spell/conjure_item/clown_pockets/new_spell = new(victim)
			new_spell.Grant(victim)
			var/datum/action/cooldown/spell/pointed/untie_shoes/newer_spell = new(victim)
			newer_spell.Grant(victim)
			continue
		dress_as_magic_clown(victim)
		if (prob(15))
			create_vendetta(victim.mind, invoker.mind)

/**
 * Clown enjoyers who are effected by this become ecstatic, they have achieved their life's dream.
 * This moodlet is equivalent to the one for simply being a traitor.
 */
/datum/mood_event/clown_world
	mood_change = 4

/datum/mood_event/clown_world/add_effects(param)
	description = "我热爱在小丑研究站 [station_name()] 工作！！"

/// Dress the passed mob as a magical clown, self-explanatory
/datum/grand_finale/clown/proc/dress_as_magic_clown(mob/living/carbon/human/victim)
	var/obj/effect/particle_effect/fluid/smoke/poof = new(get_turf(victim))
	poof.lifetime = 2 SECONDS

	var/obj/item/tank/internal = victim.internal
	// We're about to take off your pants so those are going to fall out
	var/obj/item/pocket_L = victim.get_item_by_slot(ITEM_SLOT_LPOCKET)
	var/obj/item/pocket_R = victim.get_item_by_slot(ITEM_SLOT_RPOCKET)
	var/obj/item/id = victim.get_item_by_slot(ITEM_SLOT_ID)
	var/obj/item/belt = victim.get_item_by_slot(ITEM_SLOT_BELT)

	var/obj/pants = victim.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	var/obj/mask = victim.get_item_by_slot(ITEM_SLOT_MASK)
	QDEL_NULL(pants)
	QDEL_NULL(mask)
	if(isplasmaman(victim))
		victim.equip_to_slot_if_possible(new /obj/item/clothing/under/plasmaman/clown/magic(), ITEM_SLOT_ICLOTHING, disable_warning = TRUE)
		victim.equip_to_slot_if_possible(new /obj/item/clothing/mask/gas/clown_hat/plasmaman(), ITEM_SLOT_MASK, disable_warning = TRUE)
	else
		victim.equip_to_slot_if_possible(new /obj/item/clothing/under/rank/civilian/clown/magic(), ITEM_SLOT_ICLOTHING, disable_warning = TRUE)
		victim.equip_to_slot_if_possible(new /obj/item/clothing/mask/gas/clown_hat(), ITEM_SLOT_MASK, disable_warning = TRUE)

	var/obj/item/clothing/mask/gas/clown_hat/clown_mask = victim.get_item_by_slot(ITEM_SLOT_MASK)
	if (clown_mask)
		var/list/options = GLOB.clown_mask_options
		clown_mask.icon_state = options[pick(clown_mask.clownmask_designs)]
		victim.update_worn_mask()
		clown_mask.update_item_action_buttons()

	equip_to_slot_then_hands(victim, ITEM_SLOT_LPOCKET, pocket_L)
	equip_to_slot_then_hands(victim, ITEM_SLOT_RPOCKET, pocket_R)
	equip_to_slot_then_hands(victim, ITEM_SLOT_ID, id)
	equip_to_slot_then_hands(victim, ITEM_SLOT_BELT, belt)
	victim.internal = internal
