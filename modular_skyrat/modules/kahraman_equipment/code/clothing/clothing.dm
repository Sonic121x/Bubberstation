// Jumpsuit

/obj/item/clothing/under/frontier_colonist
	name = "边疆连体服"
	desc = "一件厚重的灰色连体服，关节处有额外衬垫，还配有两个巨大的口袋。\
		无论你怎么调整，它总是稍微大了一点。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "jumpsuit"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "jumpsuit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Boots

/obj/item/clothing/shoes/jackboots/frontier_colonist
	name = "重型边疆长靴"
	desc = "一双做工精良的高筒靴，常见于探险家、第一波殖民者\
		以及全银河的真人角色扮演者脚上。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "boots"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "boots"
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = NONE

/obj/item/clothing/shoes/jackboots/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Jackets

/obj/item/clothing/suit/jacket/frontier_colonist
	name = "边疆风衣"
	desc = "一件及膝外套，外层防水，内里相对舒适。\
		夹层呢？只有刚好够挡住偶尔刺入的尖物的保护材料，\
		不过别指望奇迹。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "jacket"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "jacket"
	slot_flags = ITEM_SLOT_OCLOTHING
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = NONE
	allowed = null

/obj/item/clothing/suit/jacket/frontier_colonist/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/clothing/suit/jacket/frontier_colonist/short
	name = "边疆夹克"
	desc = "一件短外套，外层防水，内里相对舒适。\
		夹层呢？只有刚好够挡住偶尔刺入的尖物的保护材料，\
		不过别指望奇迹。"
	icon_state = "jacket_short"
	worn_icon_state = "jacket_short"

/obj/item/clothing/suit/jacket/frontier_colonist/medical
	name = "边疆医疗夹克"
	desc = "一件短外套，外层防水，内里相对舒适。\
		夹层呢？只有刚好够挡住偶尔刺入的尖物的保护材料，\
		不过别指望奇迹。这一件染成了亮红色，并覆有白色\
		条纹，以表明穿着者或许能提供医疗援助。"
	icon_state = "jacket_med"
	worn_icon_state = "jacket_med"

// Flak Jacket

/obj/item/clothing/suit/frontier_colonist_flak
	name = "边疆防破片夹克"
	desc = "一件外层为防水材料的简易防破片夹克。\
		这类夹克常见于想要一些护甲的第一波殖民者身上，\
		因为它们很容易在殖民地核心类机器中制造出来。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "flak"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "flak"
	body_parts_covered = CHEST
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	armor_type = /datum/armor/colonist_armor
	resistance_flags = NONE
	allowed = null

/obj/item/clothing/suit/frontier_colonist_flak/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Various softcaps

/obj/item/clothing/head/soft/frontier_colonist
	name = "边疆帽"
	desc = "一顶结实的棒球帽，呈粗犷的绿色。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "cap"
	soft_type = "cap"
	soft_suffix = null
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "cap"

/obj/item/clothing/head/soft/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/clothing/head/soft/frontier_colonist/medic
	name = "边疆医疗帽"
	desc = "一顶结实的棒球帽，颜色是时髦的红色。帽上有一个白色菱形标志，表示佩戴者或许能提供医疗援助。"
	icon_state = "cap_medical"
	soft_type = "cap_medical"
	worn_icon_state = "cap_medical"

// Helmet (Is it a helmet? Questionable? I'm not sure what to call this thing)

/obj/item/clothing/head/frontier_colonist_helmet
	name = "边疆软盔"
	desc = "一件介于正规头盔与普通帽子之间的奇特头饰。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "tanker"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "tanker"
	armor_type = /datum/armor/colonist_armor
	resistance_flags = NONE
	flags_inv = 0
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT

/obj/item/clothing/head/frontier_colonist_helmet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Headset

/// Charge spent per message sent without a relay
#define FRONTIER_RADIO_TRANSMIT_COST LASER_SHOTS(50, STANDARD_CELL_CHARGE)

/obj/item/radio/headset/headset_frontier_colonist
	name = "边疆无线电耳机"
	desc = "一副笨重的耳机，但愿它比空间站的耳机更能经受风吹日晒。\
		内置电池供电天线，使耳机可以脱离通讯网络独立工作，\
		并可容纳一个加密密钥。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "radio"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "radio"
	alternate_worn_layer = FACEMASK_LAYER + 0.5
	subspace_transmission = FALSE
	radiosound = 'modular_skyrat/modules/kahraman_equipment/sound/morse_signal.wav'
	radio_sound_volume = 20
	freqlock = RADIO_FREQENCY_LOCKED
	/// Powers the antenna when there is no relay
	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell

/obj/item/radio/headset/headset_frontier_colonist/wide
	worn_icon_state = "radio_wide"

/obj/item/radio/headset/headset_frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
	if(ispath(cell))
		cell = new cell(src)

/obj/item/radio/headset/headset_frontier_colonist/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/item/radio/headset/headset_frontier_colonist/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == cell)
		cell = null

/obj/item/radio/headset/headset_frontier_colonist/examine(mob/user)
	. = ..()
	if(isnull(cell))
		. += span_warning("Its battery compartment is <b>empty</b>.")
	else
		. += span_notice("Its [cell.name] is charged to <b>[round(cell.percent())]%</b>. Talking with no relay in range drains it.")
	. += span_notice("The battery and key can be removed with a <b>screwdriver</b>.")

// one key, ignoring the frequency lock
/obj/item/radio/headset/headset_frontier_colonist/install_key(mob/living/user, obj/item/encryptionkey/key)
	if(keyslot)
		loc.balloon_alert(user, "only fits one key!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(key, src))
		loc.balloon_alert(user, "cannot install!")
		return ITEM_INTERACT_BLOCKING
	keyslot = key
	recalculateChannels()
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	loc.balloon_alert(user, "encryption key installed")
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/headset/headset_frontier_colonist/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return ..()
	if(!isnull(cell))
		loc.balloon_alert(user, "already has a battery!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	cell = tool
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	loc.balloon_alert(user, "battery installed")
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/headset/headset_frontier_colonist/screwdriver_act(mob/living/user, obj/item/tool)
	var/removed_anything = length(remove_keys(user)) > 0
	if(!isnull(cell))
		user.put_in_hands(cell)
		removed_anything = TRUE
	if(!removed_anything)
		loc.balloon_alert(user, "nothing to remove!")
		return ITEM_INTERACT_BLOCKING
	tool.play_tool_sound(src, 10)
	loc.balloon_alert(user, "battery and key removed")
	return ITEM_INTERACT_SUCCESS

// only runs when no relay carried the message
/obj/item/radio/headset/headset_frontier_colonist/backup_transmission(datum/signal/subspace/vocal/signal)
	var/turf/our_turf = get_turf(src)
	if(signal.data["done"] && (our_turf?.z in signal.levels))
		return
	if(isnull(cell) || !cell.use(FRONTIER_RADIO_TRANSMIT_COST))
		if(ismob(loc))
			to_chat(loc, span_warning("[src] crackles. There is no relay in range and not enough charge to reach anyone."))
		return
	return ..()

#undef FRONTIER_RADIO_TRANSMIT_COST

// Gloves

/obj/item/clothing/gloves/frontier_colonist
	name = "边疆手套"
	desc = "一双结实的黑色手套，能保护你宝贵的手指免受外界侵袭。\
		它们比大多数手套往上延伸得更高一些，而你不太清楚为什么。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "gloves"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gloves"
	greyscale_colors = "#3a373e"
	siemens_coefficient = 0.25 // Doesn't insulate you entirely, but makes you a little more resistant
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	clothing_traits = list(TRAIT_QUICK_CARRY)

/obj/item/clothing/gloves/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Special mask

/obj/item/clothing/mask/gas/atmos/frontier_colonist
	name = "边疆防毒面具"
	desc = "一种改良型防毒面具，常见于大气不太适合呼吸、\
		但总体尚可居住的地方。它还通过了认证，可抵御大多数\
		生物危害。"
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "mask"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gas_frontier"
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gas/atmos/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

//// Loadout variant
// suit
/obj/item/clothing/suit/jacket/frontier_colonist/loadout
	armor_type = /datum/armor/none

/obj/item/clothing/suit/jacket/frontier_colonist/loadout/Initialize(mapload)
	. = ..()
	allowed = list()

/obj/item/clothing/suit/jacket/frontier_colonist/short/loadout
	armor_type = /datum/armor/none

/obj/item/clothing/suit/jacket/frontier_colonist/short/loadout/Initialize(mapload)
	. = ..()
	allowed = list()

// Gloves
/obj/item/clothing/gloves/frontier_colonist/loadout
	siemens_coefficient = 0.50

// boots
/obj/item/clothing/shoes/jackboots/frontier_colonist/loadout
	name = "边疆长靴"
	armor_type = /datum/armor/shoes_jackboots

// mask
/obj/item/clothing/mask/gas/atmos/frontier_colonist/loadout
	armor_type = /datum/armor/mask_gas
	resistance_flags = NONE
	max_filters = 1

