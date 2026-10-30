/obj/item/clothing/glasses/hud
	gender = NEUTER
	name = "HUD"
	desc = "一种平视显示器，能以（几乎）实时的方式提供重要信息。"
	flags_1 = null //doesn't protect eyes because it's a monocle, duh
	actions_types = list(/datum/action/item_action/toggle_wearable_hud)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	/// Whether the HUD info is on or off
	var/display_active = TRUE

/obj/item/clothing/glasses/hud/emp_act(severity)
	. = ..()
	if(obj_flags & EMAGGED || . & EMP_PROTECT_SELF)
		return
	obj_flags |= EMAGGED
	desc = "[desc] 显示屏在轻微闪烁。"

/obj/item/clothing/glasses/hud/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "显示内容已打乱")
	desc = "[desc] 显示屏在轻微闪烁。"
	return TRUE

/obj/item/clothing/glasses/hud/suicide_act(mob/living/user)
	if(user.is_blind())
		return SHAME
	var/mob/living/living_user = user
	user.visible_message(span_suicide("[user] 透过 [src] 看去，被海量信息淹没了！看起来是在试图自杀！"))
	if(living_user.get_organ_loss(ORGAN_SLOT_BRAIN) >= BRAIN_DAMAGE_SEVERE)
		var/mob/thing = pick((/mob in view()) - user)
		if(thing)
			user.say("通缉犯！逮捕他！！")
			user.pointed(thing)
		else
			user.say("为什么我头上有根横条？！！")
	return OXYLOSS

/obj/item/clothing/glasses/hud/equipped(mob/living/user, slot)
	. = ..()
	display_active = TRUE

/obj/item/clothing/glasses/hud/proc/toggle_hud_display(mob/living/carbon/eye_owner)
	if(display_active)
		display_active = FALSE
		for(var/hud_trait in clothing_traits)
			REMOVE_CLOTHING_TRAIT(eye_owner, hud_trait)
		balloon_alert(eye_owner, "HUD 已关闭")
		return

	display_active = TRUE
	for(var/hud_trait in clothing_traits)
		ADD_CLOTHING_TRAIT(eye_owner, hud_trait)
	balloon_alert(eye_owner, "HUD 已开启")

/obj/item/clothing/glasses/hud/health
	name = "生命扫描 HUD"
	desc = "一种平视显示器，可扫描视野中的人形生物并提供其健康状况的准确数据。"
	icon_state = "healthhud"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/medsechud
	name = "生命扫描安保 HUD"
	desc = "一种平视显示器，可扫描视野中的人形生物并提供其健康状况、ID 状态和安保记录的准确数据。"
	icon_state = "medsechud"
	clothing_traits = list(TRAIT_MEDICAL_HUD, TRAIT_SECURITY_HUD)

/obj/item/clothing/glasses/hud/health/night
	name = "夜视生命扫描 HUD"
	desc = "一种先进的医疗平视显示器，能让医生在完全黑暗中找到病人。"
	icon_state = "healthhudnight"
	inhand_icon_state = "glasses"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	// Blue green, dark
	color_cutoffs = list(20, 20, 45)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	actions_types = list(/datum/action/item_action/toggle_nv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3.5)

/obj/item/clothing/glasses/hud/health/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/hud/health/night/meson
	name = "夜视介子生命扫描 HUD"
	desc = "真正做好战斗准备。"
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/hud/health/night/science
	name = "夜视医疗科研扫描 HUD"
	desc = "一种隐秘的医疗科研平视显示器，让特工能在完全黑暗中 \
		既找到垂死的舰长，也找到送他上路的完美毒药。"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_MEDICAL_HUD)

/obj/item/clothing/glasses/hud/health/sunglasses
	gender = PLURAL
	name = "医疗 HUD 墨镜"
	desc = "带医疗 HUD 的墨镜。"
	icon_state = "sunhudmed"
	inhand_icon_state = "sunhudmed"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/blue
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55)

/obj/item/clothing/glasses/hud/health/sunglasses/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsunmedremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/hud/diagnostic
	name = "诊断 HUD"
	desc = "一种平视显示器，能分析机器人和外骨骼的完整性与状态。"
	icon_state = "diagnostichud"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/diagnostic/night
	name = "夜视诊断 HUD"
	desc = "装有光放大器的机器人诊断 HUD。"
	icon_state = "diagnostichudnight"
	inhand_icon_state = "glasses"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	// Pale yellow
	color_cutoffs = list(25, 15, 5)
	glass_colour_type = /datum/client_colour/glass_colour/lightyellow
	actions_types = list(/datum/action/item_action/toggle_nv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/clothing/glasses/hud/diagnostic/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/hud/diagnostic/sunglasses
	gender = PLURAL
	name = "诊断墨镜"
	desc = "带诊断 HUD 的墨镜。"
	icon_state = "sunhuddiag"
	inhand_icon_state = "glasses"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55)

/obj/item/clothing/glasses/hud/diagnostic/sunglasses/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsundiagremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/hud/security
	name = "安保 HUD"
	desc = "一种平视显示器，可扫描视野中的人形生物并提供其 ID 状态和安保记录的准确数据。"
	icon_state = "securityhud"
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/chameleon
	name = "变色龙安保 HUD"
	desc = "一台被窃的安保 HUD，集成了辛迪加变色龙技术。提供闪光防护。"
	flash_protect = FLASH_PROTECTION_FLASH
	actions_types = list(/datum/action/item_action/chameleon/change/glasses/no_preset)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	name = "眼罩 HUD"
	desc = "HUD 墨镜更酷的表亲。"
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	actions_types = list(/datum/action/item_action/flip)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/attack_self(mob/user, modifiers)
	. = ..()
	icon_state = (icon_state == base_icon_state) ? "[base_icon_state]_flipped" : base_icon_state
	user.update_worn_glasses()

/obj/item/clothing/glasses/hud/security/sunglasses
	gender = PLURAL
	name = "安保 HUD 墨镜"
	desc = "带安保 HUD 的墨镜。"
	icon_state = "sunhudsec"
	inhand_icon_state = "sunhudsec"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/darkred
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.55)

/obj/item/clothing/glasses/hud/security/sunglasses/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsunsecremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/hud/security/night
	name = "夜视安保 HUD"
	desc = "一种先进的平视显示器，能在完全黑暗中提供 ID 数据和视野。"
	icon_state = "securityhudnight"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	// Red with a tint of green
	color_cutoffs = list(40, 15, 10)
	glass_colour_type = /datum/client_colour/glass_colour/lightred
	actions_types = list(/datum/action/item_action/toggle_nv)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3.5)

/obj/item/clothing/glasses/hud/security/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	gender = PLURAL
	name = "\improper GAR HUD 墨镜"
	desc = "带 HUD 的 GAR 墨镜。"
	icon_state = "gar_sec"
	inhand_icon_state = "gar_black"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb_continuous = list("slices")
	attack_verb_simple = list("slice")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga
	name = "千兆 HUD GAR 墨镜"
	desc = "带 HUD 的千兆 GAR 墨镜。"
	icon_state = "gigagar_sec"
	force = 12
	throwforce = 12

/obj/item/clothing/glasses/hud/toggle
	name = "切换型 HUD"
	desc = "一台具备多种功能的 HUD。"
	flags_cover = GLASSESCOVERSEYES
	actions_types = list(/datum/action/item_action/switch_hud)

/obj/item/clothing/glasses/hud/toggle/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wearer = user
	if (wearer.glasses != src)
		return

	if (TRAIT_MEDICAL_HUD in clothing_traits)
		detach_clothing_traits(TRAIT_MEDICAL_HUD)
	else if (TRAIT_SECURITY_HUD in clothing_traits)
		detach_clothing_traits(TRAIT_MEDICAL_HUD)
		attach_clothing_traits(TRAIT_SECURITY_HUD)
	else
		detach_clothing_traits(TRAIT_MEDICAL_HUD)
		attach_clothing_traits(TRAIT_SECURITY_HUD)

/datum/action/item_action/switch_hud
	name = "切换 HUD"

/obj/item/clothing/glasses/hud/toggle/thermal
	name = "热成像 HUD 扫描器"
	desc = "墨镜形状的热成像 HUD。"
	icon_state = "thermal"
	vision_flags = SEE_MOBS
	color_cutoffs = list(25, 8, 5)
	glass_colour_type = /datum/client_colour/glass_colour/red
	clothing_traits = list(TRAIT_SECURITY_HUD)

/obj/item/clothing/glasses/hud/toggle/thermal/attack_self(mob/user)
	..()
	var/hud_type
	if (LAZYLEN(clothing_traits))
		hud_type = clothing_traits[1]
	switch (hud_type)
		if (TRAIT_MEDICAL_HUD)
			icon_state = "meson"
			color_cutoffs = list(5, 15, 5)
			change_glass_color(/datum/client_colour/glass_colour/green)
		if (TRAIT_SECURITY_HUD)
			icon_state = "thermal"
			color_cutoffs = list(25, 8, 5)
			change_glass_color(/datum/client_colour/glass_colour/red)
		else
			icon_state = "purple"
			color_cutoffs = list(15, 0, 25)
			change_glass_color(/datum/client_colour/glass_colour/purple)
	user.update_sight()
	user.update_worn_glasses()

/obj/item/clothing/glasses/hud/toggle/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()

/obj/item/clothing/glasses/hud/spacecop
	gender = PLURAL
	name = "警察飞行员墨镜"
	desc = "让你在殴打抗议者和少数族裔时自我感觉帅气。"
	icon_state = "bigsunglasses"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray


/obj/item/clothing/glasses/hud/spacecop/hidden // for the undercover cop
	gender = PLURAL
	name = "墨镜"
	desc = "这副墨镜很特别，能让你看见潜在的罪犯。"
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
