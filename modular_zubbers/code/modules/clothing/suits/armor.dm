/obj/item/clothing/suit/armor/vest/collared_vest//Sprite done by offwrldr/Bangle - same person. Recently edited sprite.
	name = "GLP-C“Úlfur”防弹背心"
	desc = "一套通用轻型防护装甲，配有配套护肩和类似颈甲的额外装甲领。这种防弹背心通常配发给身处敌对环境的外交官和新闻界人士，不过也有私营安保部队使用。装甲领设计用于保护颈部和咽喉免受弹片伤害。总的来说，它相当舒适，不过许多不幸的穿戴者常因这副军事化外观而被当作战斗人员。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	icon_state = "vest_worn"
	inhand_icon_state = null
	armor_type = /datum/armor/suit_armor

/datum/atom_skin/collared_vest
	abstract_type = /datum/atom_skin/collared_vest

/datum/atom_skin/collared_vest/red
	preview_name = "红色图案"
	new_icon_state = "vest_worn_red"

/datum/atom_skin/collared_vest/neutral
	preview_name = "中性图案"
	new_icon_state = "vest_worn"

/datum/atom_skin/collared_vest/blue
	preview_name = "蓝色图案"
	new_icon_state = "vest_worn_blue"

/obj/item/clothing/suit/armor/vest/collared_vest/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/collared_vest)

/obj/item/clothing/suit/armor/vest/secjacket // Port from TG Station (DrTuxedo)
	name = "安保夹克"
	desc = "一件安保部红色配色的夹克。上面布满了高可视性条纹。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	icon_state = "secjacket"
	inhand_icon_state = "armor"
	armor_type = /datum/armor/suit_armor
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/secjacket/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

//Maid SEC
//Icon by Onule!
/obj/item/clothing/suit/armor/vest/maid
	name = "C&C 隐蔽护甲背心"
	desc = "一条耐久纤维材质的装甲围裙。这套乍看之下相当无害的服装，实际上是纳米传讯那支臭名昭著的高调“清洁与清除”杀戮小队所穿的专用装备。它比清洁工的对应用品结实得多。背后还缝有挂环，用来固定你的“拖把”。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	icon_state = "security_maid"
	allowed = list(
		/obj/item/access_key,
		/obj/item/assembly/mousetrap,
		/obj/item/clothing/gloves,
		/obj/item/flashlight,
		/obj/item/forcefield_projector,
		/obj/item/grenade/chem_grenade,
		/obj/item/holosign_creator,
		/obj/item/key/janitor,
		/obj/item/lightreplacer,
		/obj/item/melee/flyswatter,
		/obj/item/mop,
		/obj/item/mop/advanced,
		/obj/item/paint/paint_remover,
		/obj/item/plunger,
		/obj/item/pushbroom,
		/obj/item/reagent_containers/cup/bucket,
		/obj/item/reagent_containers/spray,
		/obj/item/soap,
		/obj/item/wirebrush,
	)

/obj/item/clothing/suit/armor/vest/maid/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/armor/elder_atmosian
	desc = "大气设备中的巅峰之作，一套价格高昂的改装大气防火服，表面覆着人类已知最奢华、最坚固的金属之一。它能提供完整的大气防护，又不像防火服那样用沉重材料拖慢穿戴者，同时对大多数伤害来源都有远超寻常的防护力。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	material_flags = NONE
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	flags_inv = HIDEJUMPSUIT | HIDESHOES | HIDEGLOVES | HIDETAIL
	custom_materials = list(/datum/material/metalhydrogen = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/clothing/suit/armor/elder_atmosian/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/fireaxe/metal_h2_axe,
	)
	AddElement(/datum/element/radiation_protected_clothing)

/datum/armor/armor_elder_atmosian
	melee = 40
	bullet = 30
	laser = 40
	energy = 40
	bomb = 100
	bio = 50
	fire = 100
	acid = 50
	wound = 25

//MetroCop armor, by HL13 station.
/obj/item/clothing/suit/armor/vest/alt/sec/metrocop
	name = "都市警察护甲"
	desc = "把那罐子捡起来。采用先进的 GigaSlop 牌矩阵，可实现多种替代外观！"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "civilprotection"

/obj/item/clothing/suit/armor/vest/alt/sec/metrocop/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/metrocop_armor)

/datum/atom_skin/metrocop_armor
	abstract_type = /datum/atom_skin/metrocop_armor

/datum/atom_skin/metrocop_armor/metro_cop
	preview_name = "都市警察"
	new_icon_state = "civilprotection"

/datum/atom_skin/metrocop_armor/metro_coat
	preview_name = "都市警察大衣"
	new_icon_state = "cp_trenchcoat"

/datum/atom_skin/metrocop_armor/medic
	preview_name = "医疗兵"
	new_icon_state = "medicalofficer"

/datum/atom_skin/metrocop_armor/red_trim
	preview_name = "红色饰边"
	new_icon_state = "dv_vest"

/datum/atom_skin/metrocop_armor/overwatch_white
	preview_name = "白色监督者"
	new_icon_state = "overwatch_white"

/datum/atom_skin/metrocop_armor/overwatch
	preview_name = "监督者"
	new_icon_state = "overwatch"

/datum/atom_skin/metrocop_armor/overwatch_red
	preview_name = "红色监督者"
	new_icon_state = "overwatch_red"

// Virosec armor, sprites by axietheaxolotl

/obj/item/clothing/suit/armor/vest/viro
	name = "护甲背心"
	desc = "一件用于抵御各种形式威胁的防弹插板背心。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "sec_platecarrier"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/vest/viro/heavy
	name = "重型护甲背心"
	desc = "一件更厚重的防弹插板背心，用于抵御各种形式的威胁。"
	icon_state = "sec_heavyvest"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/vest/viro/leatherjacket
	name = "安保皮夹克"
	desc = "一件为安保人员准备的皮夹克，配有帅气的红色衣领。"
	icon_state = "sec_leatherjacket"

/obj/item/clothing/suit/armor/vest/viro/softshell
	name = "安保软壳夹克"
	desc = "一件防风雨的软壳夹克，非常适合常有暴风雨的星球。"
	icon_state = "sec_softshell"

/obj/item/clothing/suit/armor/hos/viro
	name = "装甲军大衣"
	desc = "一件用特殊合金强化过的军大衣，为气质威严的人提供额外防护与风度。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hos_greatcoat"
	inhand_icon_state = "greatcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/armor_hos
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/hos/viro/vest
	name = "安保主管防弹插板背心"
	desc = "一件用特殊合金强化过的防弹插板背心，为气质威严的人提供额外防护与风度。"
	icon_state = "hos_platecarrier"
	inhand_icon_state = "armor"

/datum/armor/armor_hos
	melee = 30
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 70
	acid = 90
	wound = 10

/obj/item/clothing/suit/armor/hos/viro/trenchcoat
	name = "装甲风衣"
	desc = "一件用特殊轻质凯夫拉强化过的风衣。战术便装中的典范。"
	icon_state = "hos_overcoat"
	inhand_icon_state = "hostrench"
	flags_inv = 0
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/hos/viro/trenchcoat/winter
	name = "安保主管冬季风衣"
	desc = "一件用特殊轻质凯夫拉强化过的风衣，衣领和内衬填有羊毛。穿上这件大衣，你会莫名感到孤独。"
	icon_state = "hos_wintercoat"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/vest/viro/warden
	name = "看守长夹克"
	desc = "一件藏青色装甲夹克，肩部有蓝色标识，其中一个胸袋上绣着“/Warden/”。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "warden_jacket_v"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	strip_delay = 7 SECONDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/viro/warden/alt
	name = "看守长装甲夹克"
	desc = "一件红色夹克，缀有银色军衔星徽，外面还绑着防弹护甲。"
	icon_state = "warden_alt"

/obj/item/clothing/suit/armor/vest/viro/warden/wintercoat
	name = "看守长冬季大衣"
	desc = "一件冬季大衣，外面罩着护甲背心，衣领和内衬填有羊毛。"
	icon_state = "warden_winterjacket"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/militia
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/hooded/cultrobes
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/head/hooded/cult_hoodie
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/suit/hooded/cultlain_robe
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/head/hooded/cultlain_hood
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'

/obj/item/clothing/suit/hooded/secjuggernaut
	name = "安保重装服"
	desc = "先进安保服通过凯夫拉、钛合金与陶瓷插板的先进分层结构，为穿戴者提供近乎完美的防护。 \
		遗憾的是，这套服装的构造使它无比沉重笨拙，会让穿戴者的速度慢如爬行，行动选择也大受限制。 \
		只有借助近来研发的微型反重力发生器，才能真正穿上这套服装并移动。 \
		还附带一顶内置头盔，可用于舱外活动。"
	icon_state = "security_jugger"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/armor_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	inhand_icon_state = "swat_suit"
	hoodtype = /obj/item/clothing/head/hooded/secjuggernaut
	hood_up_affix = ""
	armor_type = /datum/armor/secjuggernaut
	w_class = WEIGHT_CLASS_HUGE
	siemens_coefficient = 0
	strip_delay = 25 SECONDS
	equip_delay_self = 12 SECONDS
	equip_delay_other = 15 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	item_flags = SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	bubber_obj_flags = TRUE_IMMUTABLE_SLOW
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	slowdown = 5
	drag_slowdown = 5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, TRAIT_PUSHIMMUNE, TRAIT_NEGATES_GRAVITY, TRAIT_NO_SLIP_WATER, TRAIT_NO_VEHICLE, TRAIT_HUGE_CLOTHES, TRAIT_NO_BUCKLE)
	allowed = list(
		/obj/item/tank/internals,
		/obj/item/tank/jetpack/captain,
	)
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 44.8,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 40,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/clothing/suit/hooded/secjuggernaut/examine(mob/user)
	. = ..()
	. += span_warning("穿着这身衣服时，想把自己系在任何东西上都是不可能的——不管是椅子、半机械人、马还是高尔夫球车。")

/obj/item/clothing/suit/hooded/secjuggernaut/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/secjuggernaut
	name = "安保重装头盔"
	desc = "内置于先进安保服中的头盔。它提供近乎完美的防护，代价是永久固定在无比沉重的套装上。 \
		它耐压、防闪光，还内置安保灯，方便在黑暗区域视物。\
		虽然材质与整体构造相同，但内置的伺服机构与驱动器让它比配套套装容易穿戴得多。"
	icon_state = "security_jugger0"
	icon = 'modular_zubbers/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	worn_icon_muzzled = 'modular_zubbers/icons/mob/clothing/head/helmet_muzzled.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/helmet_teshari.dmi'
	armor_type = /datum/armor/secjuggernaut
	flash_protect = FLASH_PROTECTION_WELDER
	strip_delay = 15 SECONDS
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | HEADINTERNALS
	bubber_obj_flags = TRUE_IMMUTABLE_SLOW
	clothing_traits = list(TRAIT_HEAD_INJURY_BLOCKED)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEFACE|HIDESNOUT|SHOWSPRITEEARS
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH|PEPPERPROOF
	resistance_flags = FIRE_PROOF | ACID_PROOF

	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 7
	light_power = 1.0
	light_color = "#99ccff"
	light_on = FALSE
	var/on = FALSE

	var/sound_on = 'sound/items/weapons/magin.ogg'
	var/sound_off = 'sound/items/weapons/magout.ogg'

/obj/item/clothing/head/hooded/secjuggernaut/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddComponent(/datum/component/wearertargeting/earprotection)

/obj/item/clothing/head/hooded/secjuggernaut/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		playsound(src, sound_on, 40, TRUE)
		turn_on(user)
	else
		playsound(src, sound_off, 40, TRUE)
		turn_off(user)
	update_appearance()

/obj/item/clothing/head/hooded/secjuggernaut/update_icon_state()
	icon_state = "security_jugger[on]"
	return ..()

/obj/item/clothing/head/hooded/secjuggernaut/proc/turn_on(mob/user)
	set_light_on(TRUE)

/obj/item/clothing/head/hooded/secjuggernaut/proc/turn_off(mob/user)
	set_light_on(FALSE)

/obj/item/clothing/head/hooded/secjuggernaut/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(on)
		toggle_helmet_light()
		return TRUE

/obj/item/clothing/head/hooded/secjuggernaut/attack_self(mob/living/user)
	toggle_helmet_light(user)

/datum/armor/secjuggernaut
	melee = 80
	bullet = 80
	laser = 70
	energy = 40
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 40

/obj/item/clothing/suit/armor/vest/blueshirt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/alt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/alt/sec
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/warden
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/warden/alt
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/capcarapace
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/blueshield/jacket
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'

/obj/item/clothing/suit/armor/vest/hop
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
