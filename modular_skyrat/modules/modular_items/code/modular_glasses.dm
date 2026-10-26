#define MODE_OFF "off"
#define MODE_OFF_FLASH_PROTECTION "flash protection"
#define MODE_ON "on"
#define MODE_FREEZE_ANIMATION "freeze"

/obj/item/clothing/glasses/hud/ar
	name = "\improper AR 眼镜"
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_regular"
	desc = "一种能（几乎）实时提供重要信息的头戴式显示器。这副眼镜似乎并不能真正工作。"
	actions_types = list(/datum/action/item_action/toggle_mode)
	glass_colour_type = /datum/client_colour/glass_colour/gray
	/// Defines sound to be played upon mode switching
	var/modeswitch_sound = 'sound/effects/pop.ogg'
	/// Iconstate for when the status is off (TODO:  off_state --> modes_states list for expandability)
	var/off_state = "salesman_fzz"
	/// Sets a list of modes to cycle through
	var/list/modes = list(MODE_OFF, MODE_ON)
	/// The current operating mode
	var/mode
	/// Defines messages that will be shown to the user upon switching modes (e.g. turning it on)
	var/list/modes_msg = list(MODE_ON = "光学矩阵已启用", MODE_OFF = "光学矩阵已禁用")
	/// Because initial() will not work on subtypes from within the parent we need to store a reference to the type of the glasses calling the procs
	var/obj/item/clothing/glasses/hud/ar/glasses_type
	/// Lazylist of traits that will not be removed if we switch modes.
	var/list/permanent_clothing_traits

/// Reuse logic from engine_goggles.dm
/obj/item/clothing/glasses/hud/ar/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_EYES)

	// Set our initial values
	mode = MODE_ON
	glasses_type = type

/obj/item/clothing/glasses/hud/ar/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/glasses/hud/ar/equipped(mob/living/carbon/human/user, slot)
	if(mode != MODE_OFF || slot != slot_flags)
		return ..()
	// when off: don't apply any huds or traits. but keep the list as-is so that we can still add them later
	var/traits = clothing_traits
	clothing_traits = null
	. = ..()
	clothing_traits = traits

/obj/item/clothing/glasses/hud/ar/proc/toggle_mode(mob/user, voluntary)

	if(!istype(user) || user.incapacitated)
		return

	if(mode == modes[mode])
		return // If there is only really one mode to cycle through, early return

	if(mode == MODE_FREEZE_ANIMATION)
		icon = initial(glasses_type.icon) /// Resets icon to initial value after MODE_FREEZE_ANIMATION, since MODE_FREEZE_ANIMATION replaces it with non-animated version of initial

	mode = get_next_mode(mode)

	switch(mode)
		if(MODE_ON)
			balloon_alert(user, "[modes_msg[mode]]")
			reset_vars() // Resets all the vars to their initial values (THIS PRESUMES THE DEFAULT STATE IS ON)
			add_hud(user)
		if(MODE_FREEZE_ANIMATION)
			balloon_alert(user, "[modes_msg[mode]]")
			freeze_animation()
		if(MODE_OFF)
			if(MODE_OFF_FLASH_PROTECTION in modes)
				flash_protect = FLASH_PROTECTION_FLASH
				balloon_alert(user, "[modes_msg[MODE_OFF_FLASH_PROTECTION]]")
			else
				balloon_alert(user, "[modes_msg[mode]]")
			icon_state = off_state
			disable_vars(user)
			remove_hud(user)

	playsound(src, modeswitch_sound, 50, TRUE) // play sound set in vars!
	update_sight(user)
	update_item_action_buttons()
	update_appearance()

/obj/item/clothing/glasses/hud/ar/proc/get_next_mode(current_mode)
	switch(current_mode)
		if(MODE_ON)
			if(MODE_FREEZE_ANIMATION in modes) // AR projectors go from on to freeze animation mode
				return MODE_FREEZE_ANIMATION
			else
				return MODE_OFF
		if(MODE_OFF)
			return MODE_ON
		if(MODE_FREEZE_ANIMATION)
			return MODE_OFF

/obj/item/clothing/glasses/hud/ar/proc/add_hud(mob/user)
	var/mob/living/carbon/human/human = user
	if(!ishuman(user) || human.glasses != src) // Make sure they're a human wearing the glasses first
		return
	for(var/trait in clothing_traits)
		ADD_CLOTHING_TRAIT(human, trait)

/obj/item/clothing/glasses/hud/ar/proc/remove_hud(mob/user)
	var/mob/living/carbon/human/human = user
	if(!ishuman(user) || human.glasses != src) // Make sure they're a human wearing the glasses first
		return
	for(var/trait in (clothing_traits - permanent_clothing_traits)) // yes, you can do /list - null, it has no side effects i can see
		REMOVE_CLOTHING_TRAIT(human, trait)

/obj/item/clothing/glasses/hud/ar/proc/reset_vars()
	worn_icon = initial(glasses_type.worn_icon)
	icon_state = initial(glasses_type.icon_state)
	flash_protect = initial(glasses_type.flash_protect)
	tint = initial(glasses_type.tint)
	color_cutoffs = initial(glasses_type.color_cutoffs)
	vision_flags = initial(glasses_type.vision_flags)

/obj/item/clothing/glasses/hud/ar/proc/disable_vars(mob/user)
	vision_flags = 0 /// Sets vision_flags to 0 to disable meson view mainly
	color_cutoffs = null // Resets lighting_alpha to user's default one

/// Create new icon and worn_icon, with only the first frame of every state and setting that as icon.
/// this practically freezes the animation :)
/obj/item/clothing/glasses/hud/ar/proc/freeze_animation()
	var/icon/frozen_icon = new(icon, frame = 1)
	icon = frozen_icon
	var/icon/frozen_worn_icon = new(worn_icon, frame = 1)
	worn_icon = frozen_worn_icon

// Blah blah, fix vision and update icons
/obj/item/clothing/glasses/hud/ar/proc/update_sight(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		if(human.glasses == src)
			human.update_sight()

/obj/item/clothing/glasses/hud/ar/attack_self(mob/user)
	toggle_mode(user, TRUE)

/obj/item/clothing/glasses/hud/ar/aviator
	name = "飞行员眼镜"
	desc = "一副设计师款太阳镜，配有电致变色变暗镜片！"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	icon_state = "aviator"
	off_state = "aviator_off"
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	flash_protect = FLASH_PROTECTION_FLASH
	modes = list(MODE_OFF, MODE_ON)
	tint = 0

/obj/item/clothing/glasses/fake_sunglasses/aviator
	name = "飞行员眼镜"
	desc = "一副设计师款太阳镜。它似乎挡不住闪光。"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	icon_state = "aviator"
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'

// Security Aviators
/obj/item/clothing/glasses/hud/ar/aviator/security
	name = "安保 HUD 飞行员眼镜"
	desc = "一种头戴式显示器，可扫描视野中的人形生物，并提供其证件状态与安保记录的准确数据。这款 HUD 被装进了一副带可切换电致变色镜片的太阳镜里。"
	icon_state = "aviator_sec"
	off_state = "aviator_sec_flash"
	flash_protect = FLASH_PROTECTION_NONE
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red
	modes = list(MODE_OFF_FLASH_PROTECTION, MODE_ON)
	modes_msg = list(MODE_OFF_FLASH_PROTECTION = "防闪光模式", MODE_ON = "光学矩阵已启用")
	custom_materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2
	)

// Medical Aviators
/obj/item/clothing/glasses/hud/ar/aviator/health
	name = "医疗 HUD 飞行员眼镜"
	desc = "一种头戴式显示器，可扫描视野中的人形生物，并提供其健康状况的准确数据。这款 HUD 被装进了一副太阳镜里。"
	icon_state = "aviator_med"
	flash_protect = FLASH_PROTECTION_NONE
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4,
	)

// (Normal) meson scanner Aviators
/obj/item/clothing/glasses/hud/ar/aviator/meson
	name = "介子 HUD 飞行员眼镜"
	desc = "工程与采矿人员使用的头戴式显示器，可不受光照条件影响，隔着墙壁看到基础结构与地形布局。这款 HUD 被装进了一副太阳镜里。"
	icon_state = "aviator_meson"
	flash_protect = FLASH_PROTECTION_NONE
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	vision_flags = SEE_TURFS
	color_cutoffs = list(5, 15, 5)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	custom_materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4
	)

// diagnostic Aviators
/obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	name = "诊断 HUD 飞行员眼镜"
	desc = "一种能够分析机器人与外骨骼完整性和状态的头戴式显示器。这款 HUD 被装进了一副太阳镜里。"
	icon_state = "aviator_diagnostic"
	flash_protect = FLASH_PROTECTION_NONE
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange
	custom_materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4
	)

// Science Aviators
/obj/item/clothing/glasses/hud/ar/aviator/science
	name = "科学飞行员眼镜"
	desc = "一副俗气的紫色飞行员太阳镜，佩戴者只需一瞥就能辨认各种化合物。"
	icon_state = "aviator_sci"
	flash_protect = FLASH_PROTECTION_NONE
	glass_colour_type = /datum/client_colour/glass_colour/purple
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/aviator_science
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)
	custom_materials = list(
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.7,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 4
	)

/datum/armor/aviator_science
	fire = 80
	acid = 100

/obj/item/clothing/glasses/hud/ar/aviator/security/prescription
	name = "处方款安保 HUD 飞行员眼镜"
	desc = "一种头戴式显示器，可扫描视野中的人形生物，并提供其证件状态与安保记录的准确数据。这款 HUD 被装进了一副带可切换电致变色镜片的太阳镜里，镜片有助于矫正视力。"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED, TRAIT_SECURITY_HUD)
	permanent_clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/health/prescription
	name = "处方款医疗 HUD 飞行员眼镜"
	desc = "一种头戴式显示器，可扫描视野中的人形生物，并提供其健康状况的准确数据。这款 HUD 被装进了一副太阳镜里，其镜片有助于矫正视力。"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED, TRAIT_MEDICAL_HUD)
	permanent_clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
	name = "处方款介子 HUD 飞行员眼镜"
	desc = "工程与采矿人员使用的头戴式显示器，可不受光照条件影响，隔着墙壁看到基础结构与地形布局。这款 HUD 被装进了一副太阳镜里，其镜片有助于矫正视力。"
	clothing_traits = list(TRAIT_MADNESS_IMMUNE, TRAIT_NEARSIGHTED_CORRECTED)
	permanent_clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
	name = "处方款诊断 HUD 飞行员眼镜"
	desc = "一种能够分析机器人与外骨骼完整性和状态的头戴式显示器。这款 HUD 被装进了一副太阳镜里，其镜片有助于矫正视力。"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED, TRAIT_DIAGNOSTIC_HUD)
	permanent_clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/science/prescription
	name = "处方款科学飞行员眼镜"
	desc = "一副俗气的紫色飞行员太阳镜，佩戴者只需一瞥就能辨认各种化合物；其镜片有助于矫正视力。"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER, TRAIT_NEARSIGHTED_CORRECTED)
	permanent_clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

// Retinal projector

/obj/item/clothing/glasses/hud/ar/projector
	name = "视网膜投影器"
	desc = "一副配有扫描镜片和内置视网膜投影器的头戴式设备。它不提供任何眼部防护，但比面罩更不显眼。"
	icon_state = "projector"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	flags_cover = null /// It doesn't actually cover up any parts
	off_state = "projector-off"
	modes = list(MODE_OFF, MODE_ON, MODE_FREEZE_ANIMATION)
	modes_msg = list(MODE_ON = "投影器已启用", MODE_FREEZE_ANIMATION = "持续光束模式", MODE_OFF = "投影器已禁用" )

/obj/item/clothing/glasses/hud/ar/projector/meson
	name = "视网膜投影介子 HUD"
	icon_state = "projector_meson"
	vision_flags = SEE_TURFS
	color_cutoffs = list(10, 30, 10)
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/hud/ar/projector/health
	name = "视网膜投影医疗 HUD"
	icon_state = "projector_med"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/hud/ar/projector/security
	name = "视网膜投影安保 HUD"
	icon_state = "projector_sec"
	clothing_traits = list(TRAIT_SECURITY_HUD)
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 2,
	)

/obj/item/clothing/glasses/hud/ar/projector/diagnostic
	name = "视网膜投影诊断 HUD"
	icon_state = "projector_diagnostic"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

/obj/item/clothing/glasses/hud/ar/projector/science
	name = "科学视网膜投影器"
	icon_state = "projector_sci"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
	)

#undef MODE_OFF
#undef MODE_OFF_FLASH_PROTECTION
#undef MODE_ON
#undef MODE_FREEZE_ANIMATION
