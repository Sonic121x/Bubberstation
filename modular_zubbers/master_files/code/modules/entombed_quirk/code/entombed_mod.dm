/datum/mod_theme/entombed
	name = "融合"
	desc = "种种境遇已让这套防护服变成了某人的第二层皮肤。字面意义上的。"
	extended_desc = "某人过往中某种宏大的因素已将他与这台装置永久绑定，无论好坏。"

	default_skin = "standard"
	armor_type = /datum/armor/mod_theme_civilian
	resistance_flags = FIRE_PROOF | ACID_PROOF // It is better to die for the Emperor than live for yourself.
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = DEFAULT_MAX_COMPLEXITY - 2 // Sets the modsuit complexity to a total of 13 (functionally 10 as the default storage module consumes 3. ) to keep it in line with the civilian modsuit.
	charge_drain = DEFAULT_CHARGE_DRAIN
	slowdown_deployed = 0.95
	inbuilt_modules = list(
		/obj/item/mod/module/joint_torsion/entombed
	)
	allowed_suit_storage = list(
		/obj/item/tank/internals,
		/obj/item/flashlight,
	)

/obj/item/mod/module/joint_torsion/entombed
	name = "内部关节扭转适配"
	desc = "你已适应在这套 MOD 套装外壳中的生活，能以特定方式活动，让你行动时略微为套装的内置电池充电，但仅在受重力影响时有效。"
	removable = FALSE
	complexity = 0
	power_per_step = DEFAULT_CHARGE_DRAIN * 0.4

/obj/item/mod/module/plasma_stabilizer/entombed
	name = "菌落稳定的内部密封"
	desc = "你体内的菌落已将套装护板的内侧部分与你的骨骼完全融合，在你与外界之间形成气密密封，使你的大气一丝也逃不出去。这足以让你在收起头盔时仍能用头部观察世界。"
	complexity = 0
	idle_power_cost = 0
	removable = FALSE

/obj/item/mod/control/pre_equipped/entombed
	theme = /datum/mod_theme/entombed
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity
	)

// CUSTOM BEHAVIOR

/obj/item/mod/control/pre_equipped/entombed/canStrip(mob/who)
	return TRUE //you can always try, and it'll hit doStrip below

/obj/item/mod/control/pre_equipped/entombed/doStrip(mob/who)
	// attempt to handle custom stripping behavior - if we have a storage module of some kind
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if (!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(who, span_notice("你把 MOD 套装储物模块中的所有物品都倒了出来！"))
		who.balloon_alert(who, "已清空 MOD 储物模块物品！")
		return TRUE

	to_chat(who, span_warning("这套装似乎已永久融合在对方的躯体上——你无法将其脱下！"))
	who.balloon_alert(who, "无法脱下已融合的 MOD 套装！")
	return ..()

/obj/item/mod/control/pre_equipped/entombed/retract(mob/user, obj/item/part, instant = FALSE)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/equipping/entombed/tomb_quirk = human_user.get_quirk(/datum/quirk/equipping/entombed)
		//check to make sure we're not retracting something we shouldn't be able to
		if (tomb_quirk && tomb_quirk.deploy_locked)
			if (istype(part, /obj/item/clothing)) // make sure it's a modsuit piece and not a module, we retract those too
				if (!istype(part, /obj/item/clothing/head/mod)) // they can only retract the helmet, them's the sticks
					human_user.balloon_alert(human_user, "该部件已与你融合——无法收起！")
					playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
					return
	return ..()

/obj/item/mod/control/pre_equipped/entombed/quick_deploy(mob/user)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/equipping/entombed/tomb_quirk = human_user.get_quirk(/datum/quirk/equipping/entombed)
		//if we're deploy_locked, just disable this functionality entirely
		if (tomb_quirk && tomb_quirk.deploy_locked)
			human_user.balloon_alert(human_user, "你只能收起头盔，而且只能手动操作！")
			playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return
	return ..()

/obj/item/mod/control/pre_equipped/entombed/Initialize(mapload, new_theme, new_skin, new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, QUIRK_TRAIT)

/obj/item/mod/control/pre_equipped/entombed/dropped(mob/user)
	. = ..()
	// we do this so that in the rare event that someone gets gibbed/destroyed, their suit can be retrieved easily w/o requiring admin intervention
	REMOVE_TRAIT(src, TRAIT_NODROP, QUIRK_TRAIT)
