// Ash drake suit

/obj/item/drake_remains
	name = "龙类残骸"
	desc = "收集起来的龙类残骸。它仍带着热度噼啪作响，散发着明显的硫磺味。"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	icon_state = "dragon"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 10)

/obj/item/drake_remains/Initialize(mapload)
	. = ..()
	add_shared_particles(/particles/bonfire)

/obj/item/drake_remains/Destroy(force)
	remove_shared_particles(/particles/bonfire)
	return ..()

/obj/item/clothing/suit/hooded/cloak/drake
	name = "龙类护甲"
	icon_state = "dragon"
	desc = "一套用灰烬龙残骸制成的护甲。"
	armor_type = /datum/armor/cloak_drake
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 10)

/datum/armor/cloak_drake
	melee = 65
	bullet = 15
	laser = 40
	energy = 40
	bomb = 70
	bio = 60
	fire = 100
	acid = 100
	wound = 10

/obj/item/clothing/suit/hooded/cloak/drake/Initialize(mapload)
	. = ..()
	allowed = GLOB.mining_suit_allowed

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "龙类头盔"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "dragon"
	desc = "一具龙头骨。"
	armor_type = /datum/armor/cloak_drake
	clothing_flags = SNUG_FIT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

// Spectral blade

/obj/item/melee/ghost_sword
	name = "\improper 幽魂之刃"
	desc = "一把锈迹斑斑、刃口钝化的刀。看起来造不成多大伤害。它微微发光。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "spectral"
	inhand_icon_state = "spectral"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_BULKY
	force = 5 // Breakpoint past which something counts as a weapon, usually
	throwforce = 5
	hitsound = 'sound/effects/ghost2.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	attack_verb_continuous = list("攻击着", "劈砍着", "切片着", "撕扯着", "割裂着", "撕开着", "切丁着", "破开着")
	attack_verb_simple = list("攻击", "劈砍", "切片", "撕扯", "割裂", "撕开", "切丁", "破开")
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/list/mob/dead/observer/spirits
	var/list/alt_continuous = list("捅刺着", "刺穿着", "贯穿")
	var/list/alt_simple = list("捅刺", "刺穿", "贯穿")
	COOLDOWN_DECLARE(summon_cooldown)

/obj/item/melee/ghost_sword/Initialize(mapload)
	. = ..()
	spirits = list()
	START_PROCESSING(SSobj, src)
	SSpoints_of_interest.make_point_of_interest(src)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)
	AddComponent(\
		/datum/component/butchering, \
		speed = 15 SECONDS, \
		effectiveness = 90, \
	)

/obj/item/melee/ghost_sword/Destroy()
	for(var/mob/dead/observer/ghost in spirits)
		ghost.RemoveInvisibility(type)
	spirits.Cut()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/melee/ghost_sword/attack_self(mob/user)
	if(!COOLDOWN_FINISHED(src, summon_cooldown))
		to_chat(user, span_warning("你刚刚才求过援。可别惹恼了幽灵！"))
		return

	COOLDOWN_START(src, summon_cooldown, 60 SECONDS)
	to_chat(user, span_notice("你高声求援，试图召唤幽灵来到你身边。"))
	notify_ghosts(
		"[user.real_name] 举起了 [name]，呼唤你的帮助！",
		source = user,
		ignore_key = POLL_IGNORE_SPECTRAL_BLADE,
		header = "幽魂之刃",
	)

/obj/item/melee/ghost_sword/process()
	ghost_check()

/obj/item/melee/ghost_sword/proc/ghost_check()
	var/turf/cur_turf = get_turf(src)
	var/list/contents = cur_turf.get_all_contents()
	var/mob/dead/observer/current_spirits = list()
	for(var/atom/random_thing in contents)
		random_thing.transfer_observers_to(src)

	for(var/mob/dead/observer/ghost in orbiters?.orbiter_list)
		ghost.SetInvisibility(INVISIBILITY_NONE, id = type, priority = INVISIBILITY_PRIORITY_BASIC_ANTI_INVISIBILITY)
		current_spirits |= ghost

	for(var/mob/dead/observer/ghost in spirits - current_spirits)
		ghost.RemoveInvisibility(type)

	var/new_force = clamp((length(current_spirits) * 4), 0, 75)
	var/old_force = clamp((length(spirits) * 4), 0, 75)
	force += new_force - old_force
	spirits = current_spirits
	return length(spirits)

/obj/item/melee/ghost_sword/attack(mob/living/target, mob/living/carbon/human/user)
	var/ghost_counter = ghost_check()
	user.visible_message(span_danger("[user] 以 [ghost_counter] 个复仇幽灵之力发起攻击！"))
	. = ..()

/obj/item/melee/ghost_sword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	var/ghost_counter = ghost_check()
	final_block_chance += clamp((ghost_counter * 5), 0, 75)
	owner.visible_message(span_danger("[owner] 被一圈 [ghost_counter] 个幽灵守护着！"))
	return ..()

// Dragon's blood

/obj/item/dragons_blood
	name = "一瓶龙血"
	desc = "你不会真的打算喝下去吧？"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/dragons_blood/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return

	var/mob/living/carbon/human/consumer = user
	var/random = rand(1,4)

	switch(random)
		if(1)
			to_chat(user, span_danger("你的外貌变成了一只非常小的人形灰烬龙！你只是看起来像个怪胎，却没有那些厉害的能力。"))

			// BUBBER EDIT CHANGE BEGIN
			// consumer.dna.features = list(
			// 	FEATURE_MUTANT_COLOR = "#A02720",
			// 	FEATURE_TAIL_LIZARD = "Dark Tiger",
			// 	FEATURE_TAIL_CAT = "None",
			// 	FEATURE_SNOUT = "Sharp",
			// 	FEATURE_HORNS = "Curled",
			// 	FEATURE_EARS = "None",
			// 	FEATURE_WINGS = "None",
			// 	FEATURE_FRILLS = "None",
			// 	FEATURE_SPINES = "Long",
			// 	FEATURE_LIZARD_MARKINGS = "Dark Tiger Body",
			// 	FEATURE_LEGS = DIGITIGRADE_LEGS,
			consumer.dna.features[FEATURE_MUTANT_COLOR] = "#A02720"
			consumer.dna.mutant_bodyparts[FEATURE_TAIL_GENERIC] = list(
				MUTANT_INDEX_NAME = "Dark Tiger",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.mutant_bodyparts[FEATURE_SNOUT] = list(
				MUTANT_INDEX_NAME = "Sharp",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.mutant_bodyparts[FEATURE_HORNS] = list(
				MUTANT_INDEX_NAME = "Curled",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.mutant_bodyparts[FEATURE_EARS] = list(
				MUTANT_INDEX_NAME = "None",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.mutant_bodyparts[FEATURE_WINGS] = list(
				MUTANT_INDEX_NAME = "None",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.mutant_bodyparts[FEATURE_FRILLS] = list(
				MUTANT_INDEX_NAME = "None",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.mutant_bodyparts[FEATURE_SPINES] = list(
				MUTANT_INDEX_NAME = "Long",
				MUTANT_INDEX_COLOR_LIST = list("#A02720", "#A02720", "#A02720")
			)
			consumer.dna.features[FEATURE_LEGS] = DIGITIGRADE_LEGS
			//BUBBER EDIT CHANGE END

			consumer.set_eye_color("#FEE5A3")
			consumer.set_species(/datum/species/lizard)
			consumer.dna.add_mutation(/datum/mutation/firebreath, MUTATION_SOURCE_MUTATOR)
			var/obj/item/organ/wings/functional/dragon/wings = new()
			wings.Insert(consumer)

		if(2)
			to_chat(user, span_danger("你的血肉开始融化！奇迹般地，除此之外你似乎安然无恙。"))
			consumer.set_species(/datum/species/skeleton)
		if(3)
			to_chat(user, span_danger("力量在你体内奔涌！你现在可以随意变换形态。"))
			var/datum/action/cooldown/spell/shapeshift/dragon/dragon_shapeshift = new(user.mind || user)
			dragon_shapeshift.Grant(user)
		if(4)
			to_chat(user, span_danger("你感觉自己现在可以直接走过熔岩了。"))
			ADD_TRAIT(user, TRAIT_LAVA_IMMUNE, type)

	playsound(user,'sound/items/drink.ogg', 30, TRUE)
	qdel(src)

// Lava staff

/obj/item/lava_staff
	name = "熔岩法杖"
	desc = "能够用熔岩灌满应急穿梭机。人生还有什么不满足的？"
	icon_state = "lavastaff"
	inhand_icon_state = "lavastaff"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon = 'icons/obj/weapons/guns/magic.dmi'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	force = 18
	damtype = BURN
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	attack_verb_continuous = list("灼烧着", "猛敲着", "燃烧着")
	attack_verb_simple = list("灼烧", "猛敲", "燃烧")
	hitsound = 'sound/items/weapons/sear.ogg'
	var/turf_type = /turf/open/lava/smooth/weak
	var/transform_string = "熔岩"
	var/reset_turf_type = /turf/open/misc/asteroid/basalt
	var/reset_string = "玄武岩"
	var/create_cooldown = 10 SECONDS
	var/create_delay = 3 SECONDS
	var/reset_cooldown = 5 SECONDS
	var/static/list/banned_turfs = typecacheof(list(/turf/open/space, /turf/closed))
	COOLDOWN_DECLARE(use_cooldown)

/obj/item/lava_staff/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(interacting_with.atom_storage || SHOULD_SKIP_INTERACTION(interacting_with, src, user))
		return NONE

	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/lava_staff/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!COOLDOWN_FINISHED(src, use_cooldown))
		return NONE

	if(is_type_in_typecache(interacting_with, banned_turfs))
		return NONE

	if(!(interacting_with in view(user.client.view, get_turf(user))))
		return NONE

	var/turf/open/target_turf = get_turf(interacting_with)
	if(!istype(target_turf))
		return NONE

	if(islava(target_turf))
		var/old_name = target_turf.name
		if(target_turf.TerraformTurf(reset_turf_type, flags = CHANGETURF_INHERIT_AIR))
			return ITEM_INTERACT_FAILURE

		COOLDOWN_START(src, use_cooldown, reset_cooldown)
		user.visible_message(span_danger("[user] 把 \the [old_name] 变成了 [reset_string]！"))
		playsound(target_turf,'sound/effects/magic/fireball.ogg', 200, TRUE)
		return ITEM_INTERACT_SUCCESS

	var/obj/effect/temp_visual/lavastaff/lava_visual = new /obj/effect/temp_visual/lavastaff(target_turf)
	lava_visual.alpha = 0
	animate(lava_visual, alpha = 255, time = create_delay)
	user.visible_message(span_danger("[user] 将 [src] 指向 [target_turf]！"))
	COOLDOWN_START(src, use_cooldown, create_delay + 1)

	if(!do_after(user, create_delay, target_turf))
		balloon_alert(user, "被打断！")
		COOLDOWN_RESET(src, use_cooldown)
		qdel(lava_visual)
		return ITEM_INTERACT_FAILURE

	var/old_name = target_turf.name
	if(!target_turf.TerraformTurf(turf_type, flags = CHANGETURF_INHERIT_AIR))
		qdel(lava_visual)
		return ITEM_INTERACT_FAILURE

	user.visible_message(span_danger("[user] 把 \the [old_name] 变成了 [transform_string]！"))
	message_admins("[ADMIN_LOOKUPFLW(user)] 朝 [ADMIN_VERBOSEJMP(target_turf)] 发射了熔岩法杖")
	user.log_message("朝 [AREACOORD(target_turf)] 发射了熔岩法杖。", LOG_ATTACK)
	COOLDOWN_START(src, use_cooldown, create_cooldown)
	playsound(target_turf,'sound/effects/magic/fireball.ogg', 200, TRUE)
	qdel(lava_visual)
	return ITEM_INTERACT_SUCCESS

/obj/effect/temp_visual/lavastaff
	icon_state = "lavastaff_warn"
	duration = 50

/turf/open/lava/smooth/weak
	lava_damage = 10
	lava_firestacks = 10
	temperature_damage = 2500
