/obj/structure/closet/crate/secure/syndicrate
	name = "盈余辛迪加箱"
	desc = "一个印着辛迪加标志的显眼板条箱。你不知道该怎么打开它。"
	icon_state = "syndicrate"
	base_icon_state = "syndicrate"
	max_integrity = 500
	armor_type = /datum/armor/crate_syndicrate
	resistance_flags = FIRE_PROOF | ACID_PROOF
	integrity_failure = 0 //prevents bust_open from activating
	paint_jobs = null
	/// variable that only lets the crate open if opened by a key from the uplink
	var/created_items = FALSE
	/// this is what will spawn when it is opened with a syndicrate key
	var/list/unlock_contents = list()

/// if the crate takes damage it will explode 25% of the time
/datum/armor/crate_syndicrate
	melee = 30
	bullet = 50
	laser = 50
	energy = 100

/obj/structure/closet/crate/secure/syndicrate/before_open(mob/living/user, force)
	. = ..()
	if(!.)
		return FALSE

	if(!broken && !force && !created_items)
		balloon_alert(user, "已上锁！")
		return FALSE

	return TRUE

/obj/structure/closet/crate/secure/syndicrate/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(created_items)
		return ..()
	if(damage_amount < DAMAGE_PRECISION)
		return ..()
	if(prob(75))
		return ..()
	visible_message(span_danger("辛迪加箱的防拆卸系统启动了！"))
	explosion(src, heavy_impact_range = 1, light_impact_range = 2, flash_range = 2)
	qdel(src)

///ensures that the syndicrate can only be unlocked by opening it with a syndicrate_key
/obj/structure/closet/crate/secure/syndicrate/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/syndicrate_key) || created_items)
		return ..()
	created_items = TRUE
	for(var/item_path in unlock_contents)
		new item_path(src)
	unlock_contents = list()
	qdel(tool)
	to_chat(user, span_notice("你将钥匙同时拧入两把锁中，打开了板条箱。"))
	playsound(src, 'sound/machines/airlock/boltsup.ogg', 50, vary = FALSE)
	togglelock(user)
	return ITEM_INTERACT_SUCCESS

/obj/structure/closet/crate/secure/syndicrate/togglelock(mob/living/user, silent)
	if(broken || !created_items)
		return
	if(iscarbon(user))
		add_fingerprint(user)
	locked = !locked
	user.visible_message(
		span_notice("[user][locked ? "锁上了" : "解开了"] [src]。"),
		span_notice("你[locked ? "锁上了" : "解开了"] [src]。"),
	)
	update_appearance()

/obj/structure/closet/crate/secure/syndicrate/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	return ITEM_INTERACT_BLOCKING

/obj/item/syndicrate_key
	name = "辛迪加箱钥匙"
	desc = "一件带有蛇形徽记的装置，能自行分裂成两把钥匙。可用于打开一个辛迪加箱。"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "syndicrate_key"
	w_class = WEIGHT_CLASS_TINY

/obj/item/syndicrate_key/Initialize(mapload)
	. = ..()
	register_item_context()

/obj/item/syndicrate_key/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	. = ..()

	var/obj/structure/closet/crate/secure/syndicrate/target_structure = target
	if(!istype(target_structure))
		return NONE
	if(target_structure.created_items)
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = "解锁辛迪加箱"
	return CONTEXTUAL_SCREENTIP_SET
