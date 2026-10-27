/obj/item/clothing/suit/armor
	name = "护甲"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	abstract_type = /obj/item/clothing/suit/armor
	allowed = null
	body_parts_covered = CHEST
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	max_integrity = 250
	resistance_flags = NONE
	armor_type = /datum/armor/suit_armor

/datum/armor/suit_armor
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/Initialize(mapload)
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/armor/apply_fantasy_bonuses(bonus)
	. = ..()
	slowdown = modify_fantasy_variable("slowdown", slowdown, -bonus * 0.1, 0)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/remove_fantasy_bonuses(bonus)
	slowdown = reset_fantasy_variable("slowdown", slowdown)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	return ..()

/obj/item/clothing/suit/armor/vest
	name = "护甲背心"
	desc = "一件轻薄的 I 型护甲背心，对大多数类型的伤害都能提供不错的防护。"
	icon_state = "armoralt"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back/armorvest

/obj/item/clothing/suit/armor/vest/alt
	desc = "一件 I 型护甲背心，对大多数类型的伤害都能提供不错的防护。"
	icon_state = "armor"
	inhand_icon_state = "armor"

/obj/item/clothing/suit/armor/vest/alt/sec
	icon_state = "armor_sec"

/obj/item/clothing/suit/armor/vest/press
	name = "记者护甲背心"
	desc = "一件蓝色护甲背心，用于区分<i>非战斗人员</i>中的“记者”成员，前提是有人在乎的话。"
	icon_state = "armor_press"

/obj/item/clothing/suit/armor/vest/press/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/suit/armor/vest/marine
	name = "战术护甲背心"
	desc = "一套用最优质的量产冲压塑钢甲板制成的护甲，内置环境防护单元，适合在全天候条件下踹门。"
	icon_state = "marine_command"
	inhand_icon_state = "armor"
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/vest_marine
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/vest_marine
	melee = 50
	bullet = 50
	laser = 30
	energy = 25
	bomb = 50
	bio = 100
	fire = 40
	acid = 50
	wound = 20

/datum/armor/pmc
	melee = 40
	bullet = 50
	laser = 60
	energy = 50
	bomb = 50
	bio = 100
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/vest/marine/security
	name = "大号战术护甲背心"
	icon_state = "marine_security"

/obj/item/clothing/suit/armor/vest/marine/engineer
	name = "战术多功能护甲背心"
	icon_state = "marine_engineer"

/obj/item/clothing/suit/armor/vest/marine/medic
	name = "战术医疗兵护甲背心"
	icon_state = "marine_medic"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/armor/vest/marine/pmc
	desc = "一套用最优质的量产冲压塑钢甲板制成的护甲，可全方位踹门与揍人。它出色的生存能力弥补了不具备太空适应性的缺点"
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/pmc

/obj/item/clothing/suit/armor/vest/old
	name = "老化护甲背心"
	desc = "较老一代的 I 型护甲背心。由于随时间老化，这件背心活动起来远没有那么灵活。"
	icon_state = "armor"
	inhand_icon_state = "armor"
	slowdown = 1

/obj/item/clothing/suit/armor/vest/blueshirt
	name = "大号护甲背心"
	desc = "一件宽大却舒适的护甲，能保护你免受部分威胁。"
	icon_state = "blueshift"
	inhand_icon_state = null
	custom_premium_price = PAYCHECK_COMMAND

/obj/item/clothing/suit/armor/vest/cuirass
	name = "胸甲"
	desc = "一件更轻便的板甲，仍能挡住那些讨厌的箭矢，同时保留活动能力。"
	icon_state = "cuirass"
	inhand_icon_state = "armor"
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/cuirass/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)

/obj/item/clothing/suit/armor/hos
	name = "装甲军大衣"
	desc = "一件以特殊合金强化的大衣，为气度威严者提供额外的防护与风采。"
	icon_state = "hos"
	inhand_icon_state = "greatcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/armor_hos
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 8 SECONDS

/datum/armor/armor_hos
	melee = 30
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 70
	acid = 90
	wound = 10

/obj/item/clothing/suit/armor/hos/trenchcoat
	name = "装甲风衣"
	desc = "一件以特殊轻质凯夫拉强化的风衣。战术便装中的典范。"
	icon_state = "hostrench"
	inhand_icon_state = "hostrench"
	flags_inv = 0
	strip_delay = 8 SECONDS

/obj/item/clothing/suit/armor/hos/trenchcoat/winter
	name = "安保主管冬季风衣"
	desc = "一件以特殊轻质凯夫拉强化、领口与内衬加绒的风衣。穿着这件大衣时，你莫名感到孤独。"
	icon_state = "hoswinter"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/hos/hos_formal
	name = "\improper 安保主管阅兵夹克"
	desc = "当护甲背心不够时髦时穿它。"
	icon_state = "hosformal"
	inhand_icon_state = "hostrench"
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/hos/hos_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/warden
	name = "看守长夹克"
	desc = "一件海军蓝装甲夹克，带有蓝色肩章，其中一个胸袋上绣着“/Warden/”。"
	icon_state = "warden_alt"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	strip_delay = 7 SECONDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/warden/alt
	name = "看守长装甲夹克"
	desc = "一件红色夹克，配有银色军衔标记，并外绑着护甲。"
	icon_state = "warden_jacket"

/obj/item/clothing/suit/armor/vest/secjacket
	name = "安保夹克"
	desc = "一件安保配色为红色的红色夹克。整件衣服布满高可视度条纹。"
	icon_state = "secjacket"
	inhand_icon_state = "armor"
	armor_type = /datum/armor/armor_secjacket
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/secjacket/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/datum/armor/armor_secjacket //Gotta compensate those extra covered limbs
	melee = 25
	bullet = 25
	laser = 25
	energy = 35
	bomb = 20
	fire = 30
	acid = 30
	wound = 5

/obj/item/clothing/suit/armor/vest/leather
	name = "安保大衣"
	desc = "一件轻装甲皮革大衣，供高级军官日常穿着。上面印有纳米传讯安保部的徽记。"
	icon_state = "leathercoat-sec"
	inhand_icon_state = "hostrench"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/capcarapace
	name = "船长胸甲"
	desc = "一件防火装甲胸甲，用陶瓷板与塑钢肩甲加固，在提供额外防护的同时仍保持最大的机动性与灵活性。只发给空间站里最优秀的人，不过它确实会磨得你乳头发疼。"
	icon_state = "capcarapace"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	armor_type = /datum/armor/vest_capcarapace
	dog_fashion = null
	resistance_flags = FIRE_PROOF

/datum/armor/vest_capcarapace
	melee = 50
	bullet = 40
	laser = 50
	energy = 50
	bomb = 25
	fire = 100
	acid = 90
	wound = 10

/obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	name = "辛迪加船长背心"
	desc = "一件外形邪恶的先进护甲背心，穿在黑色与红色相间的防火夹克外。金色的衣领与肩部表明它属于一位辛迪加高级军官。"
	icon_state = "syndievest"

/obj/item/clothing/suit/armor/vest/capcarapace/captains_formal
	name = "船长阅兵大衣"
	desc = "当护甲背心不够时髦时穿它。"
	icon_state = "capformal"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/captains_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/riot
	name = "防暴服"
	desc = "一套半柔性聚碳酸酯护甲，配厚重衬垫，用于抵御近战攻击。可帮助穿戴者在近身搏斗中抵抗推搡。"
	icon_state = "riot"
	inhand_icon_state = "swat_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/armor_riot
	strip_delay = 8 SECONDS
	equip_delay_other = 6 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

/obj/item/clothing/suit/armor/riot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)
	init_rustle_component()

/obj/item/clothing/suit/armor/riot/proc/init_rustle_component()
	AddComponent(/datum/component/item_equipped_movement_rustle)

/datum/armor/armor_riot
	melee = 50
	bullet = 10
	laser = 10
	energy = 10
	fire = 80
	acid = 80
	wound = 20

/obj/item/clothing/suit/armor/balloon_vest
	name = "气球背心"
	desc = "一件完全由气球制成的背心，能抵御哑剧演员向你投来的任何邪恶力量，包括电击和火焰。不过，只要被尖锐的东西一戳就……"
	icon_state = "balloon-vest"
	inhand_icon_state = "balloon_armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/balloon_vest
	siemens_coefficient = 0
	strip_delay = 7 SECONDS
	equip_delay_other = 5 SECONDS
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 10.8)

/datum/armor/balloon_vest
	melee = 10
	laser = 10
	energy = 10
	fire = 60
	acid = 50

/obj/item/clothing/suit/armor/balloon_vest/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(isitem(hitby))
		var/obj/item/item_hit = hitby
		if(item_hit.get_sharpness())
			pop()

	if(istype(hitby, /obj/projectile/bullet))
		pop()

	return ..()

/obj/item/clothing/suit/armor/balloon_vest/proc/pop()
	playsound(src, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 50, vary = TRUE)
	qdel(src)


/obj/item/clothing/suit/armor/bulletproof
	name = "防弹护甲"
	desc = "一件 III 型重型防弹背心，擅长保护穿戴者抵御传统投射武器，并在一定程度上抵御爆炸物。"
	icon_state = "bulletproof"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_bulletproof
	strip_delay = 7 SECONDS
	equip_delay_other = 5 SECONDS

/datum/armor/armor_bulletproof
	melee = 15
	bullet = 60
	laser = 10
	energy = 10
	bomb = 40
	fire = 50
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/laserproof
	name = "反射背心"
	desc = "一件擅长保护穿戴者抵御能量投射物、并偶尔将其反射回去的背心。"
	icon_state = "armor_reflec"
	inhand_icon_state = "armor_reflec"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	armor_type = /datum/armor/armor_laserproof
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	var/hit_reflect_chance = 50

/datum/armor/armor_laserproof
	melee = 10
	bullet = 10
	laser = 60
	energy = 60
	fire = 100
	acid = 100

/obj/item/clothing/suit/armor/laserproof/IsReflect(def_zone)
	if(!(def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))) //If not shot where ablative is covering you, you don't get the reflection bonus!
		return FALSE
	if (prob(hit_reflect_chance))
		return TRUE

/obj/item/clothing/suit/armor/vest/det_suit
	name = "侦探防弹背心"
	desc = "一件印有侦探徽章的护甲背心。"
	icon_state = "detective-armor"
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/det_suit/Initialize(mapload)
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/armor/swat
	name = "MK.I SWAT 制服"
	desc = "一套战术制服，最初由已解散的 IS-ERI 与纳米传讯于 2321 年联合研发，用于军事行动。 \
		它会造成轻微的减速，但提供不错的防护，并帮助穿戴者在近身搏斗中抵抗推搡。"
	icon_state = "heavy"
	inhand_icon_state = "swat_suit"
	armor_type = /datum/armor/armor_swat
	strip_delay = 12 SECONDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	slowdown = 0.7
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

/obj/item/clothing/suit/armor/swat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)
	init_rustle_component()

/obj/item/clothing/suit/armor/swat/proc/init_rustle_component()
	AddComponent(/datum/component/item_equipped_movement_rustle)


//All of the armor below is mostly unused

/datum/armor/armor_swat
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 90
	fire = 100
	acid = 100
	wound = 15

/obj/item/clothing/suit/armor/heavy
	name = "重型护甲"
	desc = "一套重装甲制服，可抵御中等程度的伤害。"
	icon_state = "heavy"
	inhand_icon_state = "swat_suit"
	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor_type = /datum/armor/armor_heavy

/datum/armor/armor_heavy
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 90
	acid = 90

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/armor_tdome

/datum/armor/armor_tdome
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 90
	acid = 90

/obj/item/clothing/suit/armor/tdome/red
	name = "雷霆竞技场制服"
	desc = "偏红色的护甲。"
	icon_state = "tdred"
	inhand_icon_state = "tdred"

/obj/item/clothing/suit/armor/tdome/green
	name = "雷霆竞技场制服"
	desc = "令人作呕的护甲。" //classy.
	icon_state = "tdgreen"
	inhand_icon_state = "tdgreen"

/obj/item/clothing/suit/armor/tdome/holosuit
	name = "雷霆竞技场制服"
	armor_type = /datum/armor/tdome_holosuit
	cold_protection = null
	heat_protection = null

/datum/armor/tdome_holosuit
	melee = 10
	bullet = 10

/obj/item/clothing/suit/armor/tdome/holosuit/red
	desc = "偏红色的护甲。"
	icon_state = "tdred"
	inhand_icon_state = "tdred"

/obj/item/clothing/suit/armor/tdome/holosuit/green
	desc = "令人作呕的护甲。"
	icon_state = "tdgreen"
	inhand_icon_state = "tdgreen"

/obj/item/clothing/suit/armor/riot/knight
	name = "板甲"
	desc = "一套经典的板甲，在阻挡近战攻击方面极为有效。"
	icon_state = "knight_green"
	inhand_icon_state = null
	allowed = list(
		/obj/item/banner,
		/obj/item/claymore,
		/obj/item/nullrod,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		)
/obj/item/clothing/suit/armor/riot/knight/init_rustle_component()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)

/obj/item/clothing/suit/armor/riot/knight/yellow
	icon_state = "knight_yellow"
	inhand_icon_state = null

/obj/item/clothing/suit/armor/riot/knight/blue
	icon_state = "knight_blue"
	inhand_icon_state = null

/obj/item/clothing/suit/armor/riot/knight/red
	icon_state = "knight_red"
	inhand_icon_state = null

/obj/item/clothing/suit/armor/riot/knight/greyscale
	name = "骑士护甲"
	desc = "一套经典的护甲，可用多种不同材料制成。"
	icon_state = "knight_greyscale"
	inhand_icon_state = null
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS // Can change color and add prefix
	armor_type = /datum/armor/knight_greyscale

/datum/armor/knight_greyscale
	melee = 35
	bullet = 10
	laser = 10
	energy = 10
	bomb = 10
	bio = 10
	fire = 40
	acid = 40

/obj/item/clothing/suit/armor/vest/durathread
	name = "耐久纤维背心"
	desc = "一件由耐久纤维制成的背心，用皮革条作为缓冲甲板。"
	icon_state = "durathread"
	inhand_icon_state = null
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	max_integrity = 200
	resistance_flags = FLAMMABLE
	armor_type = /datum/armor/vest_durathread
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/durathread/Initialize(mapload)
	. = ..()
	allowed |= /obj/item/clothing/suit/apron::allowed

/datum/armor/vest_durathread
	melee = 20
	bullet = 10
	laser = 30
	energy = 40
	bomb = 15
	fire = 40
	acid = 50

/obj/item/clothing/suit/armor/vest/russian
	name = "俄式背心"
	desc = "一件森林迷彩防弹背心。好在这里周围有的是森林可以躲，对吧？"
	icon_state = "rus_armor"
	inhand_icon_state = null
	armor_type = /datum/armor/vest_russian
	dog_fashion = null

/datum/armor/vest_russian
	melee = 25
	bullet = 30
	energy = 10
	bomb = 10
	fire = 20
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/vest/russian_coat
	name = "俄式战地大衣"
	desc = "用于极寒前线，由真正的熊制成。"
	icon_state = "rus_coat"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/vest_russian_coat
	dog_fashion = null

/datum/armor/vest_russian_coat
	melee = 25
	bullet = 20
	laser = 20
	energy = 30
	bomb = 20
	bio = 50
	fire = -10
	acid = 50
	wound = 10

/obj/item/clothing/suit/armor/elder_atmosian
	name = "\improper 长老大气技师护甲"
	desc = "一件用人类所能获得的最坚韧、最稀有材料制成的卓越护甲。"
	icon_state = "h2armor"
	inhand_icon_state = null
	material_flags = MATERIAL_EFFECTS
	armor_type = /datum/armor/armor_elder_atmosian
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/elder_atmosian/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/gun/ballistic/rifle/rebarxbow,
	)

/datum/armor/armor_elder_atmosian
	melee = 25
	bullet = 20
	laser = 30
	energy = 30
	bomb = 85
	bio = 10
	fire = 65
	acid = 40
	wound = 15

/obj/item/clothing/suit/armor/centcom_formal
	name = "\improper 中央指挥部礼服大衣"
	desc = "一件发给中央指挥部指挥官的时尚大衣。非常适合颇有风采地把紧急响应小队送进自杀任务！"
	icon_state = "centcom_formal"
	inhand_icon_state = "centcom"
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/armor_centcom_formal

/datum/armor/armor_centcom_formal
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/obj/item/clothing/suit/armor/centcom_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/hop
	name = "人事主管大衣"
	desc = "一件发给人事主管的时尚大衣。"
	icon_state = "hop_coat"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/clothing/suit/armor/militia
	name = "空间站守卫大衣"
	desc = "一件边疆民兵广泛穿着的旧制服，厚实的衬垫很适合缓冲打击。"
	icon_state = "militia"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor_type = /datum/armor/coat_militia

/datum/armor/coat_militia
	melee = 40
	bullet = 40
	laser = 30
	energy = 25
	bomb = 50
	fire = 40
	acid = 50
	wound = 30

/obj/item/clothing/suit/armor/vest/military
	name = "粗糙胸甲"
	desc = "它看起来粗糙、生锈、破烂，但其实也就是用废料做的，穿上还很不舒服。"
	icon_state = "military"
	inhand_icon_state = "armor"
	dog_fashion = null
	armor_type = /datum/armor/military
	allowed = list(
		/obj/item/banner,
		/obj/item/claymore/shortsword,
		/obj/item/nullrod,
		/obj/item/spear,
		/obj/item/gun/ballistic/bow
	)

/obj/item/clothing/suit/armor/vest/military/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)

/datum/armor/military
	melee = 45
	bullet = 25
	laser = 25
	energy = 25
	bomb = 25
	fire = 10
	acid = 50
	wound = 20

/obj/item/clothing/suit/armor/riot/knight/warlord
	name = "金色板甲"
	desc = "这套笨重的护甲表面覆着一层闪亮的黄金。它似乎几乎能反射所有光源。"
	icon_state = "warlord"
	inhand_icon_state = null
	armor_type = /datum/armor/armor_warlord
	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = THICKMATERIAL
	slowdown = 0.8

/datum/armor/armor_warlord
	melee = 70
	bullet = 60
	laser = 70
	energy = 70
	bomb = 40
	fire = 50
	acid = 50
	wound = 30

/obj/item/clothing/suit/armor/durability
	abstract_type = /obj/item/clothing/suit/armor/durability

/obj/item/clothing/suit/armor/durability/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	take_damage(1, BRUTE, 0, 0)

/obj/item/clothing/suit/armor/durability/watermelon
	name = "西瓜护甲"
	desc = "一件用西瓜制成的护甲。大概挨不了几下，但至少看起来很严肃……和穿在身上的西瓜所能达到的严肃程度一样。"
	icon_state = "watermelon"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/watermelon
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	max_integrity = 15

/obj/item/clothing/suit/armor/durability/watermelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/watermelon_fr

/datum/armor/watermelon
	melee = 15
	bullet = 10
	energy = 10
	bomb = 10
	fire = 0
	acid = 25
	wound = 5

/datum/armor/watermelon_fr
	melee = 15
	bullet = 10
	energy = 10
	bomb = 10
	fire = 15
	acid = 30
	wound = 5

/obj/item/clothing/suit/armor/durability/holymelon
	name = "圣瓜护甲"
	desc = "一件用圣瓜制成的护甲。它会激励你去发起某种十字军远征……也许是把菠菜分发给孩子们？"
	icon_state = "holymelon"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/watermelon
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	max_integrity = 15

/obj/item/clothing/suit/armor/durability/holymelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/watermelon_fr

/obj/item/clothing/suit/armor/durability/holymelon/Initialize(mapload)
	. = ..()

	AddComponent(
		/datum/component/anti_magic, \
		antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY, \
		inventory_flags = ITEM_SLOT_OCLOTHING, \
		charges = 1, \
		block_magic = CALLBACK(src, PROC_REF(drain_antimagic)), \
		expiration = CALLBACK(src, PROC_REF(decay)) \
	)

/obj/item/clothing/suit/armor/durability/holymelon/proc/drain_antimagic(mob/user)
	to_chat(user, span_warning("[src] 的光泽黯淡了一些……"))

/obj/item/clothing/suit/armor/durability/holymelon/proc/decay()
	take_damage(8, BRUTE, 0, 0)


/obj/item/clothing/suit/armor/durability/barrelmelon
	name = "桶瓜护甲"
	desc = "一件用桶瓜制成的护甲。散发着麦酒的味道，激励人去做英勇事迹。或者，也许是去酒馆打一架。"
	icon_state = "barrelmelon"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/barrelmelon
	strip_delay = 6 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)
	max_integrity = 10

/obj/item/clothing/suit/armor/durability/barrelmelon/fire_resist
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/barrelmelon_fr

/datum/armor/barrelmelon
	melee = 25
	bullet = 20
	energy = 15
	bomb = 10
	fire = 0
	acid = 35
	wound = 10

/datum/armor/barrelmelon_fr
	melee = 25
	bullet = 20
	energy = 15
	bomb = 10
	fire = 20
	acid = 40
	wound = 10

/obj/item/clothing/suit/armor/dragoon
	name = "龙鳞锁甲"
	desc = "一件锁子甲，骨架上附着龙鳞，外层覆有布满灰烬的秘银板加固。"
	icon_state = "dragoon"
	inhand_icon_state = "dragoon"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	allowed = list(/obj/item/spear/skybulge)
