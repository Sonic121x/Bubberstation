/obj/item/clothing/head/helmet
	name = "头盔"
	desc = "标准安保装备。保护头部免受冲击。"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "helmet"
	base_icon_state = "helmet"
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/head_helmet
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 6 SECONDS
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT
	flags_cover = HEADCOVERSEYES|EARS_COVERED
	flags_inv = HIDEHAIR
	dog_fashion = /datum/dog_fashion/head/helmet

/datum/armor/head_helmet
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/head/helmet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/sec
	var/flipped_visor = FALSE
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'
	visor_toggle_up_sound = SFX_VISOR_UP
	visor_toggle_down_sound = SFX_VISOR_DOWN
	hair_mask = /datum/hair_mask/standard_hat_low

/obj/item/clothing/head/helmet/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")

/obj/item/clothing/head/helmet/sec/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!issignaler(tool))
		return ..()

	var/obj/item/assembly/signaler/attached_signaler = tool
	// There's a flashlight in us. Remove it first, or it'll be lost forever!
	var/obj/item/flashlight/seclite/blocking_us = locate() in src
	if(blocking_us)
		to_chat(user, span_warning("[blocking_us] 挡住了，先把它取下来！"))
		return ITEM_INTERACT_BLOCKING

	if(!attached_signaler.secured)
		to_chat(user, span_warning("先把 [attached_signaler] 固定好！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把 [attached_signaler] 装到了 [src] 上。"))

	qdel(attached_signaler)
	var/obj/item/bot_assembly/secbot/secbot_frame = new(drop_location())
	var/held_index = user.is_holding(src)
	qdel(src)
	if (held_index)
		user.put_in_hand(secbot_frame, held_index)
	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/head/helmet/sec/attack_self(mob/user)
	. = ..()
	if(.)
		return
	balloon_alert(user, "[flags_inv & HIDEHAIR ? "松开" : "收紧"]带子……")
	if(!do_after(user, 3 SECONDS, src))
		return
	flags_inv ^= HIDEHAIR
	balloon_alert(user, "[flags_inv & HIDEHAIR ? "已收紧" : "已松开"]带子")
	return TRUE

/obj/item/clothing/head/helmet/sec/click_alt(mob/user)
	flipped_visor = !flipped_visor
	balloon_alert(user, "面罩已翻起")
	// base_icon_state is modified for seclight attachment component
	base_icon_state = "[initial(base_icon_state)][flipped_visor ? "-novisor" : ""]"
	icon_state = base_icon_state
	if (flipped_visor)
		flags_cover &= ~HEADCOVERSEYES
		playsound(src, SFX_VISOR_DOWN, 20, TRUE, -1)
	else
		flags_cover |= HEADCOVERSEYES
		playsound(src, SFX_VISOR_UP, 20, TRUE, -1)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/helmet/press
	name = "记者头盔"
	desc = "一顶蓝色头盔，用于区分<i>非战斗人员</i>“记者”成员——就好像有人在乎似的。"
	icon_state = "helmet_press"
	base_icon_state = "helmet_press"
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/obj/item/clothing/head/helmet/press/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")

/obj/item/clothing/head/helmet/press/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/head/helmet/alt
	name = "防弹头盔"
	desc = "一顶防弹战斗头盔，擅长保护佩戴者抵御传统射弹武器，对爆炸也有一定防护。"
	icon_state = "helmetalt"
	base_icon_state = "helmetalt"
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/helmet_alt
	dog_fashion = null
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/datum/armor/helmet_alt
	melee = 15
	bullet = 60
	laser = 10
	energy = 10
	bomb = 40
	fire = 50
	acid = 50
	wound = 5

/obj/item/clothing/head/helmet/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")

/obj/item/clothing/head/helmet/marine
	name = "战术战斗头盔"
	desc = "一顶黑色战术头盔，用一块玻璃和除此之外不多的东西隔绝外部危险。"
	icon_state = "marine_command"
	base_icon_state = "marine_command"
	inhand_icon_state = "marine_helmet"
	armor_type = /datum/armor/helmet_marine
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE | STACKABLE_HELMET_EXEMPT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	dog_fashion = null
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/datum/armor/helmet_marine
	melee = 50
	bullet = 50
	laser = 30
	energy = 25
	bomb = 50
	bio = 100
	fire = 40
	acid = 50
	wound = 20

/obj/item/clothing/head/helmet/marine/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, starting_light = new /obj/item/flashlight/seclite(src), light_icon_state = "flight")

/obj/item/clothing/head/helmet/marine/security
	name = "陆战重型头盔"
	icon_state = "marine_security"
	base_icon_state = "marine_security"

/obj/item/clothing/head/helmet/marine/engineer
	name = "陆战通用头盔"
	icon_state = "marine_engineer"
	base_icon_state = "marine_engineer"

/obj/item/clothing/head/helmet/marine/medic
	name = "陆战医疗头盔"
	icon_state = "marine_medic"
	base_icon_state = "marine_medic"

/obj/item/clothing/head/helmet/marine/pmc
	icon_state = "marine"
	desc = "一顶黑色战术头盔，用于保护头部免受行动中受到的各种伤害。其出色的生存能力弥补了它不适合太空环境的缺陷。"
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	clothing_flags = null
	armor_type = /datum/armor/pmc

/obj/item/clothing/head/helmet/old
	name = "老化头盔"
	desc = "标准配发的安保头盔。由于老化，头盔面罩会妨碍使用者看清远处。"
	tint = 2
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/obj/item/clothing/head/helmet/blueshirt
	name = "蓝色头盔"
	desc = "一顶可靠的蓝色头盔，提醒你<i>还</i>欠那位工程师一杯啤酒。"
	icon_state = "blueshift"
	inhand_icon_state = "blueshift_helmet"
	custom_premium_price = PAYCHECK_COMMAND
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'


/obj/item/clothing/head/helmet/toggleable
	visor_vars_to_toggle = NONE
	dog_fashion = null

/obj/item/clothing/head/helmet/toggleable/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/head/helmet/toggleable/update_icon_state()
	. = ..()
	base_icon_state = "[initial(base_icon_state)]"
	var/datum/component/seclite_attachable/light = GetComponent(/datum/component/seclite_attachable)
	if(up)
		base_icon_state += "up"
	light?.on_update_icon_state(src)
	if(!light)
		icon_state = base_icon_state

/obj/item/clothing/head/helmet/toggleable/riot
	name = "防暴头盔"
	desc = "一顶专门用来抵御近距离攻击的头盔。"
	icon_state = "riot"
	base_icon_state = "riot"
	inhand_icon_state = "riot_helmet"
	toggle_message = "你拉下面罩。"
	alt_toggle_message = "你推上面罩。"
	armor_type = /datum/armor/toggleable_riot
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDESNOUT
	strip_delay = 8 SECONDS
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'
	visor_toggle_up_sound = SFX_VISOR_UP
	visor_toggle_down_sound = SFX_VISOR_DOWN

/obj/item/clothing/head/helmet/toggleable/riot/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")

/obj/item/clothing/head/helmet/toggleable/riot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 2)

/datum/armor/toggleable_riot
	melee = 50
	bullet = 10
	laser = 10
	energy = 10
	fire = 80
	acid = 80
	wound = 15

/obj/item/clothing/head/helmet/balloon
	name = "气球头盔"
	desc = "一顶用气球制成的头盔。这种头盔在伟大的小丑—默剧战争中大放异彩。出乎意料地耐火。默剧演员当时在做些难以言说的事。"
	icon_state = "helmet_balloon"
	inhand_icon_state = "helmet_balloon"
	armor_type = /datum/armor/balloon
	flags_inv = HIDEHAIR|HIDEEARS|HIDESNOUT
	resistance_flags = FIRE_PROOF
	dog_fashion = null
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3.6)

/datum/armor/balloon
	melee = 10
	fire = 60
	acid = 50

/obj/item/clothing/head/helmet/toggleable/justice
	name = "正义头盔"
	desc = "WEEEEOOO. WEEEEEOOO. WEEEEOOOO."
	icon_state = "justice"
	base_icon_state = "justice"
	inhand_icon_state = "justice_helmet"
	toggle_message = "你关掉了灯。"
	alt_toggle_message = "你打开了灯。"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	///Cooldown for toggling the visor.
	COOLDOWN_DECLARE(visor_toggle_cooldown)
	///Looping sound datum for the siren helmet
	var/datum/looping_sound/siren/weewooloop
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'
	visor_toggle_up_sound = SFX_VISOR_UP
	visor_toggle_down_sound = SFX_VISOR_DOWN

/obj/item/clothing/head/helmet/toggleable/justice/adjust_visor(mob/living/user)
	if(!COOLDOWN_FINISHED(src, visor_toggle_cooldown))
		return FALSE
	COOLDOWN_START(src, visor_toggle_cooldown, 2 SECONDS)
	return ..()

/obj/item/clothing/head/helmet/toggleable/justice/visor_toggling()
	. = ..()
	if(up)
		weewooloop.start()
	else
		weewooloop.stop()

/obj/item/clothing/head/helmet/toggleable/justice/Initialize(mapload)
	. = ..()
	weewooloop = new(src, FALSE, FALSE)

/obj/item/clothing/head/helmet/toggleable/justice/Destroy()
	QDEL_NULL(weewooloop)
	return ..()

/obj/item/clothing/head/helmet/toggleable/justice/escape
	name = "警报头盔"
	desc = "WEEEEOOO. WEEEEEOOO. 拦住那只猴子。WEEEOOOO."
	icon_state = "justice2"
	base_icon_state = "justice2"

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT 头盔"
	desc = "一顶极其坚固、适合太空环境的头盔，涂着邪恶的红黑条纹。"
	icon_state = "swatsyndie"
	inhand_icon_state = "swatsyndie_helmet"
	armor_type = /datum/armor/helmet_swat
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE | STACKABLE_HELMET_EXEMPT
	strip_delay = 8 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	dog_fashion = null
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/obj/item/clothing/head/helmet/swat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 3)

/datum/armor/helmet_swat
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 90
	fire = 100
	acid = 100
	wound = 15

/obj/item/clothing/head/helmet/swat/nanotrasen
	name = "\improper SWAT 头盔"
	desc = "一顶极其坚固的头盔，顶部印有纳米传讯标志。"
	icon_state = "swat"
	base_icon_state = "swat"
	inhand_icon_state = "swat_helmet"
	clothing_flags = STACKABLE_HELMET_EXEMPT
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/helmet/swat/nanotrasen/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/seclite_attachable, light_icon_state = "flight")

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper 雷霆竞技场头盔"
	desc = "<i>“让战斗开始吧！”</i>"
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "thunderdome"
	inhand_icon_state = "thunderdome_helmet"
	armor_type = /datum/armor/helmet_thunderdome
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 8 SECONDS
	dog_fashion = null

/datum/armor/helmet_thunderdome
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 90
	acid = 90

/obj/item/clothing/head/helmet/thunderdome/holosuit
	cold_protection = null
	heat_protection = null
	armor_type = /datum/armor/thunderdome_holosuit

/datum/armor/thunderdome_holosuit
	melee = 10
	bullet = 10

/obj/item/clothing/head/helmet/roman
	name = "\improper 罗马头盔"
	desc = "一顶由青铜和皮革制成的古代头盔。"
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	armor_type = /datum/armor/helmet_roman
	resistance_flags = FIRE_PROOF
	icon_state = "roman"
	inhand_icon_state = "roman_helmet"
	strip_delay = 10 SECONDS
	dog_fashion = null

/datum/armor/helmet_roman
	melee = 25
	laser = 25
	energy = 10
	bomb = 10
	fire = 100
	acid = 50
	wound = 5

/obj/item/clothing/head/helmet/roman/fake
	desc = "一顶由塑料和皮革制成的古代头盔。"
	armor_type = /datum/armor/none

/obj/item/clothing/head/helmet/roman/legionnaire
	name = "\improper 罗马军团头盔"
	desc = "一顶由青铜和皮革制成的古代头盔。顶部有红色盔冠。"
	icon_state = "roman_c"

/obj/item/clothing/head/helmet/roman/legionnaire/fake
	desc = "一顶由塑料和皮革制成的古代头盔。顶部有红色盔冠。"
	armor_type = /datum/armor/none

/obj/item/clothing/head/helmet/gladiator
	name = "角斗士头盔"
	desc = "致敬，皇帝，将死之人向你致意。"
	icon_state = "gladiator"
	inhand_icon_state = "gladiator_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/taghelm
	flags_cover = HEADCOVERSEYES
	// Offer about the same protection as a hardhat.
	armor_type = /datum/armor/helmet_taghelm
	dog_fashion = null
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/datum/armor/helmet_taghelm
	melee = 15
	bullet = 10
	laser = 20
	energy = 10
	bomb = 20
	acid = 50

/obj/item/clothing/head/helmet/taghelm/red
	name = "红色激光对抗头盔"
	desc = "他们选择了自己的结局。"
	icon_state = "redtaghelm"
	inhand_icon_state = "redtag_helmet"

/obj/item/clothing/head/helmet/taghelm/blue
	name = "蓝色激光对抗头盔"
	desc = "他们还需要更多的人手。"
	icon_state = "bluetaghelm"
	inhand_icon_state = "bluetag_helmet"

/obj/item/clothing/head/helmet/knight
	name = "中世纪头盔"
	desc = "一顶经典的金属头盔。"
	icon_state = "knight_green"
	inhand_icon_state = "knight_helmet"
	armor_type = /datum/armor/helmet_knight
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = NONE
	strip_delay = 8 SECONDS
	dog_fashion = null
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)

/obj/item/clothing/head/helmet/knight/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 3)

/datum/armor/helmet_knight
	melee = 50
	bullet = 10
	laser = 10
	energy = 10
	fire = 80
	acid = 80

/obj/item/clothing/head/helmet/knight/blue
	icon_state = "knight_blue"

/obj/item/clothing/head/helmet/knight/yellow
	icon_state = "knight_yellow"

/obj/item/clothing/head/helmet/knight/red
	icon_state = "knight_red"

/obj/item/clothing/head/helmet/knight/greyscale
	name = "骑士头盔"
	desc = "一顶经典的中世纪头盔，倒过来看会发现它其实是个水桶。"
	icon_state = "knight_greyscale"
	inhand_icon_state = null
	armor_type = /datum/armor/knight_greyscale
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Can change color and add prefix

/obj/item/clothing/head/helmet/durathread
	name = "耐久纤维头盔"
	desc = "一顶由耐久纤维和皮革制成的头盔。"
	icon_state = "durathread"
	inhand_icon_state = "durathread_helmet"
	resistance_flags = FLAMMABLE
	armor_type = /datum/armor/helmet_durathread
	strip_delay = 6 SECONDS

/datum/armor/helmet_durathread
	melee = 20
	bullet = 10
	laser = 30
	energy = 40
	bomb = 15
	fire = 40
	acid = 50
	wound = 5

/obj/item/clothing/head/helmet/rus_helmet
	name = "俄式头盔"
	desc = "它能装下一瓶伏特加。"
	icon_state = "rus_helmet"
	inhand_icon_state = "rus_helmet"
	armor_type = /datum/armor/helmet_rus_helmet
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/datum/armor/helmet_rus_helmet
	melee = 25
	bullet = 30
	energy = 10
	bomb = 10
	fire = 20
	acid = 50
	wound = 5

/obj/item/clothing/head/helmet/rus_helmet/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/helmet)

/obj/item/clothing/head/helmet/rus_ushanka
	name = "战斗护耳帽"
	desc = "百分之百熊。"
	icon_state = "rus_ushanka"
	inhand_icon_state = "rus_ushanka"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	armor_type = /datum/armor/helmet_rus_ushanka

/datum/armor/helmet_rus_ushanka
	melee = 25
	bullet = 20
	laser = 20
	energy = 30
	bomb = 20
	bio = 50
	fire = -10
	acid = 50
	wound = 5

/obj/item/clothing/head/helmet/elder_atmosian
	name = "\improper 长老大气师头盔"
	desc = "一顶用人类所能获得的最坚韧、最稀有材料制成的绝佳头盔。"
	icon_state = "h2helmet"
	inhand_icon_state = "h2_helmet"
	armor_type = /datum/armor/helmet_elder_atmosian
	material_flags = MATERIAL_EFFECTS
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/datum/armor/helmet_elder_atmosian
	melee = 25
	bullet = 20
	laser = 30
	energy = 30
	bomb = 85
	bio = 10
	fire = 65
	acid = 40
	wound = 15

/obj/item/clothing/head/helmet/military
	name = "粗制头盔"
	desc = "一顶廉价的水壶盔，额外加装了面甲以保护眼睛和嘴部。"
	icon_state = "military"
	inhand_icon_state = "knight_helmet"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_FLASH
	strip_delay = 8 SECONDS
	dog_fashion = null
	armor_type = /datum/armor/helmet_military
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'

/datum/armor/helmet_military
	melee = 45
	bullet = 25
	laser = 25
	energy = 25
	bomb = 25
	fire = 10
	acid = 50
	wound = 20

/obj/item/clothing/head/helmet/knight/warlord
	name = "金色巴布特头盔"
	desc = "头盔后面没有别人，只有一个可怕的念头。"
	icon_state = "warlord"
	inhand_icon_state = null
	armor_type = /datum/armor/helmet_warlord
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEMASK|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	flash_protect = FLASH_PROTECTION_FLASH
	slowdown = 0.2

/datum/armor/helmet_warlord
	melee = 70
	bullet = 60
	laser = 70
	energy = 70
	bomb = 40
	fire = 50
	acid = 50
	wound = 30

/obj/item/clothing/head/helmet/durability/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	take_damage(1, BRUTE, 0, 0)

/obj/item/clothing/head/helmet/durability/watermelon
	name = "西瓜头盔"
	desc = "用西瓜切成的头盔。也许能挨几下，但别指望它能撑多久。"
	icon_state = "watermelon"
	inhand_icon_state = "watermelon"
	flags_inv = HIDEEARS
	dog_fashion = /datum/dog_fashion/head/watermelon
	armor_type = /datum/armor/helmet_watermelon
	max_integrity = 15

/obj/item/clothing/head/helmet/durability/watermelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/helmet_watermelon_fr

/datum/armor/helmet_watermelon
	melee = 15
	bullet = 10
	energy = 10
	bomb = 10
	fire = 0
	acid = 25
	wound = 5

/datum/armor/helmet_watermelon_fr
	melee = 15
	bullet = 10
	energy = 10
	bomb = 10
	fire = 15
	acid = 30
	wound = 5

/obj/item/clothing/head/helmet/durability/holymelon
	name = "圣瓜头盔"
	desc = "用挖空的圣瓜制成的头盔。也许能挨几下，但别指望它能撑多久。"
	icon_state = "holymelon"
	inhand_icon_state = "holymelon"
	flags_inv = HIDEEARS
	dog_fashion = /datum/dog_fashion/head/holymelon
	armor_type = /datum/armor/helmet_watermelon
	max_integrity = 15

/obj/item/clothing/head/helmet/durability/holymelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/helmet_watermelon_fr

/obj/item/clothing/head/helmet/durability/holymelon/Initialize(mapload)
	. = ..()

	AddComponent(
		/datum/component/anti_magic, \
		antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY, \
		inventory_flags = ITEM_SLOT_OCLOTHING, \
		charges = 1, \
		block_magic = CALLBACK(src, PROC_REF(drain_antimagic)), \
		expiration = CALLBACK(src, PROC_REF(decay)) \
	)

/obj/item/clothing/head/helmet/durability/holymelon/proc/drain_antimagic(mob/user)
	to_chat(user, span_warning("[src] 失去了一点光泽与亮面……"))

/obj/item/clothing/head/helmet/durability/holymelon/proc/decay()
	take_damage(8, BRUTE, 0, 0)

/obj/item/clothing/head/helmet/durability/barrelmelon
	name = "桶瓜头盔"
	desc = "用挖空的桶瓜制成的头盔。和真正的木头一样结实，不过坚硬的构造让它更容易破裂。"
	icon_state = "barrelmelon"
	inhand_icon_state = "barrelmelon"
	flags_inv = HIDEEARS
	dog_fashion = /datum/dog_fashion/head/barrelmelon
	armor_type = /datum/armor/helmet_barrelmelon
	max_integrity = 10

/obj/item/clothing/head/helmet/durability/barrelmelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/helmet_barrelmelon_fr

/datum/armor/helmet_barrelmelon
	melee = 25
	bullet = 20
	energy = 15
	bomb = 10
	fire = 0
	acid = 35
	wound = 10

/datum/armor/helmet_barrelmelon_fr
	melee = 25
	bullet = 20
	energy = 15
	bomb = 10
	fire = 20
	acid = 40
	wound = 10

/obj/item/clothing/head/helmet/dragoon
	name = "龙鳞头盔"
	desc = "一顶锁子甲头盔，骨架上附有龙鳞，外面覆盖着蒙灰的秘银板甲加固层。"
	icon_state = "dragoonhelm"
	base_icon_state = "dragoonhelm"
	inhand_icon_state = "dragoonhelm"
	clothing_flags = SNUG_FIT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	dog_fashion = /datum/dog_fashion/head/dragoon
	sound_vary = TRUE
	equip_sound = 'sound/items/handling/helmet/helmet_equip1.ogg'
	pickup_sound = 'sound/items/handling/helmet/helmet_pickup1.ogg'
	drop_sound = 'sound/items/handling/helmet/helmet_drop1.ogg'
