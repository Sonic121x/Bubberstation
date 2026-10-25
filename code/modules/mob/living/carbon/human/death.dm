GLOBAL_LIST_EMPTY(dead_players_during_shift)
/mob/living/carbon/human/gib_animation()
	new /obj/effect/temp_visual/gib_animation(loc, dna.species.gib_anim)

/mob/living/carbon/human/spawn_dust(just_ash)
	if(just_ash)
		return ..()

	var/bone_type = /obj/effect/decal/remains/human
	if(isplasmaman(src))
		bone_type = /obj/effect/decal/remains/plasma

	var/obj/effect/decal/remains/human/bones = new bone_type(loc)
	bones.pixel_z = -6
	bones.pixel_w = rand(-1, 1)

/mob/living/carbon/human/death(gibbed)
	if(stat == DEAD)
		return
	stop_sound_channel(CHANNEL_HEARTBEAT)
	var/obj/item/organ/heart/human_heart = get_organ_slot(ORGAN_SLOT_HEART)
	human_heart?.beat = BEAT_NONE
	human_heart?.Stop()

	force_say(list(""), immediate = TRUE)

	. = ..()

	if(client && !HAS_TRAIT(src, TRAIT_SUICIDED) && !(client in GLOB.dead_players_during_shift))
		GLOB.dead_players_during_shift += client

	if(SSticker.HasRoundStarted())
		SSblackbox.ReportDeath(src)
		log_message("已死亡，回合移除 [client?.prefs.read_preference(/datum/preference/toggle/be_round_removed) ? "已启用" : "已禁用或不可用"] (BRUTE: [src.get_brute_loss()], BURN: [src.get_fire_loss()], TOX: [src.get_tox_loss()], OXY: [src.get_oxy_loss()]", LOG_ATTACK) // BUBBER EDIT - Round Removal OPT-IN LOGGING
		if(key) // Prevents log spamming of keyless mob deaths (like xenobio monkeys)
			investigate_log("在 [loc_name(src)] 死亡。<br>\
				BRUTE: [src.get_brute_loss()] BURN: [src.get_fire_loss()] TOX: [src.get_tox_loss()] OXY: [src.get_oxy_loss()] STAM: [src.get_stamina_loss()]<br>\
				<b>脑损伤</b>: [src.get_organ_loss(ORGAN_SLOT_BRAIN) || "0"]<br>\
				<b>[get_bloodtype()?.get_blood_name() || "血液"] 容量</b>: [src.get_blood_volume(apply_modifiers = TRUE)]cl ([round((src.get_blood_volume(apply_modifiers = TRUE) / BLOOD_VOLUME_NORMAL) * 100, 0.1)]%)<br>\
				<b>试剂</b>:<br>[reagents_readout()]", INVESTIGATE_DEATHS)
	to_chat(src, span_warning("你已经死亡。除非尸体完全损毁，大多数情况下你都可以被其他玩家复活。\
		如果你不希望被复活，请使用屏幕底部的“放弃抢救”按钮。"))
	if(SSlag_switch.measures[DISABLE_DEAD_KEYLOOP] && !client?.holder)
		to_chat(src, span_warning("幽灵移动目前已被管理员禁用。要离开你的身体，请使用“幽灵”动词。"))

/mob/living/carbon/human/proc/reagents_readout()
	var/readout = "[get_bloodtype()?.get_blood_name() || "血液"] 血流："
	for(var/datum/reagent/reagent in reagents?.reagent_list)
		readout += "<br>[round(reagent.volume, 0.001)] 单位 [reagent.name]"

	readout += "<br>胃部："
	var/obj/item/organ/stomach/belly = get_organ_slot(ORGAN_SLOT_STOMACH)
	for(var/datum/reagent/bile in belly?.reagents?.reagent_list)
		if(!belly.food_reagents[bile.type])
			readout += "<br>[round(bile.volume, 0.001)] 单位 [bile.name]"

	return readout

/mob/living/carbon/human/proc/makeSkeleton()
	set_species(/datum/species/skeleton)
	var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
	if(head)
		ADD_TRAIT(head, TRAIT_DISFIGURED, INNATE_TRAIT)
	return TRUE

/mob/living/carbon/proc/Drain()
	become_husk(CHANGELING_DRAIN)
	//SKYRAT EDIT REMOVAL START
	/*
	ADD_TRAIT(src, TRAIT_BADDNA, CHANGELING_DRAIN)
	*/
	//SKYRAT EDIT END
	blood_volume = 0
	return TRUE
