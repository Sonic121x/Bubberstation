//works similar to the experiment machine (experiment.dm) except it just holds more and more prisoners

/obj/machinery/fugitive_capture
	name = "蓝空间捕获机"
	desc = "内部空间比外面大得多得多，可安全运输囚犯。"
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "bluespace-prison"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF //ha ha no getting out!!
	interaction_flags_mouse_drop = NEED_DEXTERITY

/obj/machinery/fugitive_capture/examine(mob/user)
	. = ..()
	. += span_notice("将囚犯拖入机器即可将其收押。")

/obj/machinery/fugitive_capture/mouse_drop_receive(mob/target, mob/user, params)
	var/mob/living/fugitive_hunter = user
	if(!isliving(fugitive_hunter) || !ishuman(target))
		return
	var/mob/living/carbon/human/fugitive = target
	var/datum/antagonist/fugitive/fug_antag = fugitive.mind.has_antag_datum(/datum/antagonist/fugitive)
	if(!fug_antag)
		to_chat(fugitive_hunter, span_warning("这不是通缉逃犯！"))
		return
	if(do_after(fugitive_hunter, 5 SECONDS, target = fugitive))
		add_prisoner(fugitive, fug_antag)

/obj/machinery/fugitive_capture/proc/add_prisoner(mob/living/carbon/human/fugitive, datum/antagonist/fugitive/antag)
	fugitive.forceMove(src)
	antag.is_captured = TRUE
	to_chat(fugitive, span_userdanger("你被抛入一片广袤的蓝空间虚空，随着你不断坠入更深的湮灭，那个相对渺小的现实入口越来越小，直到你再也看不见它。你未能逃脱抓捕。"))
	fugitive.ghostize(TRUE) //so they cannot suicide, round end stuff.
	use_energy(active_power_usage)

/obj/machinery/computer/shuttle/hunter
	name = "穿梭机控制台"
	shuttleId = "huntership"
	possible_destinations = "huntership_home;huntership_custom;whiteship_home;syndicate_nw"
	req_access = list(ACCESS_HUNTER)

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/hunter
	name = "穿梭机导航计算机"
	desc = "用于指定精确的目的地位置。"
	shuttleId = "huntership"
	lock_override = CAMERA_LOCK_STATION
	shuttlePortId = "huntership_custom"
	see_hidden = FALSE
	jump_to_ports = list("huntership_home" = 1, "whiteship_home" = 1, "syndicate_nw" = 1)
	view_range = 4.5

/obj/structure/closet/crate/eva
	name = "EVA 板条箱"
	icon_state = "o2crate"
	base_icon_state = "o2crate"

/obj/structure/closet/crate/eva/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/space/eva(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/space/eva(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/mask/breath(src)
	for(var/i in 1 to 3)
		new /obj/item/tank/internals/oxygen(src)

///Psyker-friendly shuttle gear!

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/hunter/psyker
	name = "灵能者导航扭曲器"
	desc = "利用放大的脑波为灵能者穿梭机指定并测绘精确的目的地位置。"
	icon_state = MAP_SWITCH("computer", "/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/hunter/psyker")
	icon_screen = "recharge_comp_on"
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON //blind friendly
	x_offset = 0
	y_offset = 11

/obj/machinery/fugitive_capture/psyker
	name = "灵能者娱乐舱"
	desc = "一个被改造的娱乐舱，灵能者常使用它，通过响亮的噪音和痛苦的刺激来“安抚”使用者。现被改作关押囚犯之用，对被迫进入其中的非灵能者应该没有（持久）副作用。"

/obj/machinery/fugitive_capture/psyker/process() //I have no fucking idea how to make click-dragging work for psykers so this one just sucks them in.
	for(var/mob/living/carbon/human/potential_victim in range(1, get_turf(src)))
		var/datum/antagonist/fugitive/fug_antag = potential_victim.mind.has_antag_datum(/datum/antagonist/fugitive)
		if(fug_antag)
			potential_victim.visible_message(span_alert("[potential_victim]被猛烈地吸进了[src]！"))
			add_prisoner(potential_victim, fug_antag)

/// Psyker gear
/obj/item/reagent_containers/hypospray/medipen/gore
	name = "血污自动注射器"
	desc = "自制外观的自动注射器，里面装满了“血污”，也就是劣质克隆卡因。你大概不该在上班时用它，但它是种超级兴奋剂。别一次打两支。"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/drug/kronkaine/gore = 15)
	icon_state = "maintenance"
	base_icon_state = "maintenance"
	label_examine = FALSE

//Captain's special mental recharge gear

/obj/item/clothing/suit/armor/reactive/psykerboost
	name = "反应式灵能增幅装甲"
	desc = "灵能者用来进一步拓展心智的实验性装甲。遇到敌意目标时会强化穿戴者的灵能能力。"
	cooldown_message = span_danger("灵能增幅装甲的心智线圈仍在冷却中！")
	emp_message = span_danger("灵能增幅装甲的心智线圈伴随一声轻响重新校准了片刻。")
	color = "#d6ad8b"

/obj/item/clothing/suit/armor/reactive/psykerboost/cooldown_activation(mob/living/carbon/human/owner)
	do_sparks(1, TRUE, src)
	return ..()

/obj/item/clothing/suit/armor/reactive/psykerboost/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src]挡下了[attack_text]，灵能增幅了[owner]的心智力量！"))
	for(var/datum/action/cooldown/spell/psychic_ability in owner.actions)
		if(psychic_ability.school == SCHOOL_PSYCHIC)
			psychic_ability.reset_spell_cooldown()
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/psykerboost/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src]挡下了[attack_text]，汲取了[owner]的心智力量！"))
	for(var/datum/action/cooldown/spell/psychic_ability in owner.actions)
		if(psychic_ability.school == SCHOOL_PSYCHIC)
			psychic_ability.StartCooldown()
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/structure/bouncy_castle
	name = "充气城堡"
	desc = "如果你吸毒，你会在死之前先下地狱。拜托了。"
	icon = 'icons/obj/toys/bouncy_castle.dmi'
	icon_state = "bouncy_castle"
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER

/obj/structure/bouncy_castle/Initialize(mapload, mob/gored)
	. = ..()
	if(gored)
		name = gored.real_name

	AddComponent(
		/datum/component/blood_walk,\
		blood_type = /obj/effect/decal/cleanable/blood,\
		blood_spawn_chance = 66.6,\
		max_blood = INFINITY,\
	)

	AddComponent(/datum/component/bloody_spreader)

/obj/structure/bouncy_castle/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/blob/attackblob.ogg', 50, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/item/paper/crumpled/fluff/fortune_teller
	name = "潦草的字条"
	default_raw_text = "<b>记住！</b>顾客们特别喜欢我们当水晶球用的那颗口香糖球。\
		即使它对我们完全没用，也要忍住别去嚼它。"

/**
 * # Bounty Locator
 *
 * Locates a random, living fugitive and reports their name/location on a 40 second cooldown.
 *
 * Locates a random fugitive antagonist via the GLOB.antagonists list, and reads out their real name and area name.
 * Captured or dead fugitives are not reported.
 */
/obj/machinery/fugitive_locator
	name = "赏金定位器"
	desc = "追踪你所在星区内赏金目标的信号。没人真正知道这台机器用什么原理追踪目标。\
		无论是蓝空间纠缠还是简单的 RFID 植入体，这台机器都能帮你找到你要找的人，无论他们藏在哪。"
	icon = 'icons/obj/machines/dominator.dmi'
	icon_state = "dominator-Purple"
	density = TRUE
	/// Cooldown on locating a fugitive.
	COOLDOWN_DECLARE(locate_cooldown)

/obj/machinery/fugitive_locator/interact(mob/user)
	if(!COOLDOWN_FINISHED(src, locate_cooldown))
		balloon_alert_to_viewers("定位器正在充能！", vision_distance = 3)
		return
	var/mob/living/bounty = locate_fugitive()
	if(!bounty)
		say("未检测到赏金目标。")
	else
		say("已定位赏金目标。赏金 ID：[bounty.real_name]。位置：[get_area_name(bounty)]")

	COOLDOWN_START(src, locate_cooldown, 40 SECONDS)

///Locates a random fugitive via their antag datum and returns them.
/obj/machinery/fugitive_locator/proc/locate_fugitive()
	var/list/datum_list = shuffle(GLOB.antagonists)
	for(var/datum/antagonist/fugitive/fugitive_datum in datum_list)
		if(!fugitive_datum.owner)
			stack_trace("Fugitive locator tried to locate a fugitive antag datum with no owner.")
			continue
		if(fugitive_datum.is_captured)
			continue
		var/mob/living/found_fugitive = fugitive_datum.owner.current
		if(found_fugitive.stat == DEAD)
			continue

		return found_fugitive

/obj/item/radio/headset/psyker
	name = "灵能耳机"
	desc = "一款用于增强灵能波动的耳机。可保护耳朵免受闪光弹伤害。"
	icon_state = "psyker_headset"
	worn_icon_state = "syndie_headset"
	freerange = TRUE

/obj/item/radio/headset/psyker/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)
	set_frequency(FREQ_FUGITIVE_HUNTER)

/obj/item/radio/headset/psyker/equipped(mob/user, slot, initial)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_ECHOLOCATOR))
		ADD_TRAIT(user, TRAIT_SIGHT_BYPASS, REF(src))
	else
		REMOVE_TRAIT(user, TRAIT_SIGHT_BYPASS, REF(src))

/obj/item/radio/headset/psyker/dropped(mob/user, silent)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_SIGHT_BYPASS, REF(src))

/obj/item/radio/headset/psyker_seer
	name = "灵能先知耳机"
	desc = "为精英灵能先知设计的灵能耳机。"
	icon_state = "med_headset_alt"
	worn_icon_state = "med_headset_alt"
	freerange = TRUE

/obj/item/radio/headset/psyker_seer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)
	set_frequency(FREQ_FUGITIVE_HUNTER)

/obj/item/storage/belt/holster/psyker

/obj/item/storage/belt/holster/psyker/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5
	atom_storage.max_total_storage = /obj/item/gun/ballistic/revolver/c38::w_class + (4 * /obj/item/ammo_box/speedloader/c38::w_class)
