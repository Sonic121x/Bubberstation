// Memento Mori
/obj/item/clothing/neck/necklace/memento_mori
	name = "勿忘终有一死"
	desc = "一枚神秘的吊坠。上面刻着：“明日必死，意味着今日必生。”"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "memento_mori"
	worn_icon_state = "memento"
	actions_types = list(/datum/action/item_action/hands_free/memento_mori)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/mob/living/carbon/human/active_owner

/obj/item/clothing/neck/necklace/memento_mori/item_action_slot_check(slot)
	return (slot & ITEM_SLOT_NECK)

/obj/item/clothing/neck/necklace/memento_mori/dropped(mob/user)
	. = ..()
	if(active_owner)
		mori()

// Just in case
/obj/item/clothing/neck/necklace/memento_mori/Destroy()
	if(active_owner)
		mori()
	return ..()

/obj/item/clothing/neck/necklace/memento_mori/proc/memento(mob/living/carbon/human/user)
	to_chat(user, span_warning("你感到生命正被吊坠抽走……"))
	if (!do_after(user, 4 SECONDS, target = user))
		return

	to_chat(user, span_notice("你的生命力现在与吊坠相连了！你觉得摘下它就会死，可你本能地知道，在那之前你不会死。"))
	user.add_traits(list(TRAIT_NODEATH, TRAIT_NOHARDCRIT, TRAIT_NOCRITDAMAGE), CLOTHING_TRAIT)
	RegisterSignal(user, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(check_health))
	icon_state = "memento_mori_active"
	active_owner = user
	ADD_TRAIT(src, TRAIT_DANGEROUS_UNEQUIP, TRAIT_GENERIC)

/obj/item/clothing/neck/necklace/memento_mori/proc/mori()
	icon_state = "memento_mori"
	if (!active_owner)
		return
	UnregisterSignal(active_owner, COMSIG_LIVING_HEALTH_UPDATE)
	var/mob/living/carbon/human/stored_owner = active_owner //to avoid infinite looping when dust unequips the pendant
	active_owner = null
	to_chat(stored_owner, span_userdanger("你感到生命正迅速离你而去！"))
	stored_owner.dust(just_ash = TRUE, drop_items = TRUE)
	REMOVE_TRAIT(src, TRAIT_DANGEROUS_UNEQUIP, TRAIT_GENERIC)

/obj/item/clothing/neck/necklace/memento_mori/proc/check_health(mob/living/source)
	SIGNAL_HANDLER

	var/list/guardians = source.get_all_linked_holoparasites()
	if (!length(guardians))
		return
	if (source.health <= source.dead_threshold)
		for (var/mob/guardian in guardians)
			if(guardian.loc == src)
				continue
			consume_guardian(guardian)
	else if (source.health > source.crit_threshold)
		for (var/mob/guardian in guardians)
			if(guardian.loc != src)
				continue
			regurgitate_guardian(guardian)

/obj/item/clothing/neck/necklace/memento_mori/proc/consume_guardian(mob/living/basic/guardian/guardian)
	new /obj/effect/temp_visual/guardian/phase/out(get_turf(guardian))
	guardian.locked = TRUE
	guardian.forceMove(src)
	to_chat(guardian, span_userdanger("你被锁进了召唤者的吊坠里！"))
	guardian.playsound_local(get_turf(guardian), 'sound/effects/magic/summonitems_generic.ogg', 50, TRUE)

/obj/item/clothing/neck/necklace/memento_mori/proc/regurgitate_guardian(mob/living/basic/guardian/guardian)
	guardian.locked = FALSE
	guardian.recall(forced = TRUE)
	to_chat(guardian, span_notice("你从召唤者的吊坠中被放出来了！"))
	guardian.playsound_local(get_turf(guardian), 'sound/effects/magic/repulse.ogg', 50, TRUE)

/datum/action/item_action/hands_free/memento_mori
	check_flags = NONE
	name = "勿忘终有一死"
	desc = "把你的生命与吊坠绑定。"

/datum/action/item_action/hands_free/memento_mori/do_effect(trigger_flags)
	var/obj/item/clothing/neck/necklace/memento_mori/memento = target
	if(memento.active_owner || !ishuman(owner))
		return FALSE
	memento.memento(owner)
	Remove(memento.active_owner) //Remove the action button, since there's no real use in having it now.
	return TRUE

// Concussive Gauntlets

/obj/item/clothing/gloves/gauntlets
	name = "震荡护手"
	desc = "给你的手用的……矿镐！"
	icon_state = "concussive_gauntlets"
	inhand_icon_state = null
	toolspeed = 0.1
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	body_parts_covered = HANDS|ARMS
	resistance_flags = LAVA_PROOF | FIRE_PROOF //they are from lavaland after all
	armor_type = /datum/armor/gloves_gauntlets

/datum/armor/gloves_gauntlets
	melee = 15
	bullet = 25
	laser = 15
	energy = 15
	bomb = 100
	fire = 100
	acid = 30

/obj/item/clothing/gloves/gauntlets/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/boxing/hunter)

/obj/item/clothing/gloves/gauntlets/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_GLOVES))
		return
	tool_behaviour = TOOL_MINING
	RegisterSignal(user, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(rocksmash))
	RegisterSignal(user, COMSIG_MOVABLE_BUMP, PROC_REF(rocksmash))

/obj/item/clothing/gloves/gauntlets/dropped(mob/user)
	. = ..()
	stopmining(user)

/obj/item/clothing/gloves/gauntlets/proc/stopmining(mob/user)
	tool_behaviour = initial(tool_behaviour)
	UnregisterSignal(user, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOVABLE_BUMP))

/obj/item/clothing/gloves/gauntlets/proc/rocksmash(mob/living/carbon/human/user, atom/rocks, proximity)
	SIGNAL_HANDLER
	if(!proximity)
		return NONE
	if(!ismineralturf(rocks) && !isasteroidturf(rocks))
		return NONE
	INVOKE_ASYNC(src, PROC_REF(melee_attack_chain), user, rocks)
	return COMPONENT_CANCEL_ATTACK_CHAIN
