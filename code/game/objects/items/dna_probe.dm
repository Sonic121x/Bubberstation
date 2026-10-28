#define DNA_PROBE_SCAN_PLANTS (1<<0)
#define DNA_PROBE_SCAN_ANIMALS (1<<1)
#define DNA_PROBE_SCAN_HUMANS (1<<2)

/**
 * DNA Probe
 *
 * Used for scanning DNA, and can be uploaded to a DNA vault.
 */

/obj/item/dna_probe
	name = "DNA采样器"
	desc = "可以采集几乎任何东西的化学和基因样本。使用前需要连接DNA库。"
	icon = 'icons/obj/medical/syringe.dmi'
	inhand_icon_state = "sampler"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "sampler"
	item_flags = NOBLUDGEON
	///What sources of DNA this sampler can extract from.
	var/allowed_scans = DNA_PROBE_SCAN_PLANTS | DNA_PROBE_SCAN_ANIMALS | DNA_PROBE_SCAN_HUMANS
	///List of all Animal DNA scanned with this sampler.
	var/list/stored_dna_animal = list()
	///List of all Plant DNA scanned with this sampler.
	var/list/stored_dna_plants = list()
	///List of all Human DNA scanned with this sampler.
	var/list/stored_dna_human = list()
	///weak ref to the dna vault
	var/datum/weakref/dna_vault_ref
	/// Things we consider to be animals
	var/static/list/animal_typecache = typecacheof(list(
		/mob/living/basic,
		/mob/living/carbon/alien,
		/mob/living/simple_animal,
		/obj/item/fish,
	))

/obj/item/dna_probe/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/machinery/dna_vault))
		if(dna_vault_ref?.resolve())
			// Weirdly we can upload to any existing DNA vault so long as we're linked to any other existing DNA vault.
			return try_upload_dna(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING
		return try_linking_vault(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

	if (!valid_scan_target(interacting_with))
		return NONE

	if (scan_dna(interacting_with, user))
		return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_BLOCKING

/obj/item/dna_probe/proc/try_linking_vault(obj/machinery/dna_vault/target, mob/user)
	var/obj/machinery/dna_vault/our_vault = dna_vault_ref?.resolve()
	if(!our_vault)
		dna_vault_ref = WEAKREF(target)//linking the dna vault with the probe
		balloon_alert(user, "已连接DNA库")
		playsound(src, 'sound/machines/terminal/terminal_success.ogg', 50)
		return TRUE
	return FALSE

/obj/item/dna_probe/proc/try_upload_dna(obj/machinery/dna_vault/target, mob/user)
	var/uploaded = 0
	stored_dna_plants -= target.plant_dna
	stored_dna_human -= target.human_dna
	stored_dna_animal -= target.animal_dna
	var/plant_dna_length = length(stored_dna_plants)
	var/human_dna_length = length(stored_dna_human)
	var/animal_dna_length = length(stored_dna_animal)
	if(plant_dna_length)
		uploaded += plant_dna_length
		target.plant_dna += stored_dna_plants
		stored_dna_plants.Cut()
	if(human_dna_length)
		uploaded += human_dna_length
		target.human_dna += stored_dna_human
		stored_dna_human.Cut()
	if(animal_dna_length)
		uploaded += animal_dna_length
		target.animal_dna += stored_dna_animal
		stored_dna_animal.Cut()
	target.check_goal()
	playsound(target, 'sound/machines/compiler/compiler-stage1.ogg', 50)
	to_chat(user, span_notice("已上传[uploaded]条新数据。"))
	return uploaded

/obj/item/dna_probe/proc/scan_dna(atom/target, mob/user)
	var/obj/machinery/dna_vault/our_vault = dna_vault_ref?.resolve()
	if(!our_vault)
		playsound(user, 'sound/machines/buzz/buzz-sigh.ogg', 50)
		balloon_alert(user, "需要连接数据库！")
		return FALSE
	if(istype(target, /obj/machinery/hydroponics))
		var/obj/machinery/hydroponics/hydro_tray = target
		if(!hydro_tray.myseed)
			return FALSE
		if(our_vault.plant_dna[hydro_tray.myseed.type])
			balloon_alert(user, "DNA库已有此数据！")
			return FALSE
		if(stored_dna_plants[hydro_tray.myseed.type])
			balloon_alert(user, "扫描器已有此数据！")
			return FALSE
		if(hydro_tray.plant_status != HYDROTRAY_PLANT_HARVESTABLE) // So it's bit harder.
			balloon_alert(user, "植物尚不可收获！")
			return FALSE
		stored_dna_plants[hydro_tray.myseed.type] = TRUE
		playsound(src, 'sound/machines/compiler/compiler-stage2.ogg', 50)
		balloon_alert(user, "已添加数据")
		return TRUE

	if(ishuman(target) && !HAS_TRAIT(target, TRAIT_LESSER_HUMANOID))
		var/mob/living/carbon/human/human_target = target
		if(our_vault.human_dna[human_target.dna.unique_identity])
			balloon_alert(user, "DNA库已有此数据！")
			return FALSE
		if(stored_dna_human[human_target.dna.unique_identity])
			balloon_alert(user, "扫描器已有此数据！")
			return FALSE
		if(!(human_target.mob_biotypes & MOB_ORGANIC))
			balloon_alert(user, "没有兼容的DNA！")
			return FALSE
		stored_dna_human[human_target.dna.unique_identity] = TRUE
		playsound(src, 'sound/machines/compiler/compiler-stage2.ogg', 50)
		balloon_alert(user, "已添加数据")
		return TRUE

	if(!is_type_in_typecache(target, animal_typecache) && !HAS_TRAIT(target, TRAIT_LESSER_HUMANOID))
		return FALSE
	if(our_vault.animal_dna[target.type])
		balloon_alert(user, "DNA库已有此数据！")
		return FALSE
	if(stored_dna_animal[target.type])
		balloon_alert(user, "扫描器已有此数据！")
		return FALSE
	if(isliving(target))
		var/mob/living/living_target = target
		if(!(living_target.mob_biotypes & MOB_ORGANIC))
			balloon_alert(user, "没有兼容的DNA！")
			return FALSE

	stored_dna_animal[target.type] = TRUE
	playsound(src, 'sound/machines/compiler/compiler-stage2.ogg', 50)
	balloon_alert(user, "已添加数据")
	return TRUE

/obj/item/dna_probe/proc/valid_scan_target(atom/target)
	if((allowed_scans & DNA_PROBE_SCAN_PLANTS) && istype(target, /obj/machinery/hydroponics))
		return TRUE
	if((allowed_scans & DNA_PROBE_SCAN_HUMANS) && (ishuman(target) && !HAS_TRAIT(target, TRAIT_LESSER_HUMANOID)))
		return TRUE
	if((allowed_scans & DNA_PROBE_SCAN_ANIMALS) && (is_type_in_typecache(target, animal_typecache) || HAS_TRAIT(target, TRAIT_LESSER_HUMANOID)))
		return TRUE
	return FALSE

#define CARP_MIX_DNA_TIMER (15 SECONDS)

///Used for scanning carps, and then turning yourself into one.
/obj/item/dna_probe/carp_scanner
	name = "太空鲤鱼DNA采样器"
	desc = "可用于采集动物的化学和基因样本。"
	///Whether we have Carp DNA
	var/carp_dna_loaded = FALSE

/obj/item/dna_probe/carp_scanner/examine_more(mob/user)
	. = ..()
	. = list(span_notice("对太空鲤鱼使用可采集其DNA。采集完成后在手中使用，即可将其与自身融合变异。"))

/obj/item/dna_probe/carp_scanner/scan_dna(atom/target, mob/user)
	if(istype(target, /mob/living/basic/carp))
		carp_dna_loaded = TRUE
		playsound(src, 'sound/machines/compiler/compiler-stage2.ogg', 50)
		balloon_alert(user, "已扫描DNA")
	else
		return ..()

/obj/item/dna_probe/carp_scanner/valid_scan_target(atom/target)
	if (istype(target, /mob/living/basic/carp))
		return TRUE
	return ..()

/obj/item/dna_probe/carp_scanner/attack_self(mob/user, modifiers)
	. = ..()
	if(!carp_dna_loaded)
		to_chat(user, span_notice("使用自我变异功能需要太空鲤鱼DNA！"))
		return
	to_chat(user, span_notice("你拉出[src]的针头，拨动开关，开始给自己注射。"))
	if(!do_after(user, CARP_MIX_DNA_TIMER))
		return
	var/mob/living/basic/space_dragon/new_dragon = user.change_mob_type(/mob/living/basic/space_dragon, location = loc, delete_old_mob = TRUE)
	new_dragon.add_filter("anger_glow", 3, list("type" = "outline", "color" = COLOR_CARP_RIFT_RED, "size" = 5))
	new_dragon.add_movespeed_modifier(/datum/movespeed_modifier/dragon_rage)
	priority_announce("在[station_name()]附近检测到大规模有机体能量波动，请保持待命。", "生命信号警报")
	qdel(src)

#undef CARP_MIX_DNA_TIMER

#undef DNA_PROBE_SCAN_PLANTS
#undef DNA_PROBE_SCAN_ANIMALS
#undef DNA_PROBE_SCAN_HUMANS
