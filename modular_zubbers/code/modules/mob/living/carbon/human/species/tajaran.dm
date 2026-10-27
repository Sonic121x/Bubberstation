//Tajaran Bubber edit
//makes them more like Citrp's tajara aka snow cats

/datum/species/tajaran
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_HATED_BY_DOGS,
		TRAIT_MUTANT_COLORS,
		TRAIT_CATLIKE_INSTINCT,
	)
	mutanteyes = /obj/item/organ/eyes/tajaran
	mutantears = /obj/item/organ/ears/cat/tajaran
	//Cold resistance
	coldmod = 0.45
	heatmod = 1.25
	bodytemp_normal = BODYTEMP_NORMAL + 5 //Even more cold resistant, even more flammable
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 25)// Hopefully shows over heating less
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 35)
	meat = /obj/item/food/meat/slab/human/mutant/feline //you monster! //mmmfghghgf cat meat
	skinned_type = /obj/item/stack/sheet/animalhide/cat

/obj/item/bodypart/chest/mutant/tajaran

//Tajaran tongue
/obj/item/organ/tongue/cat/tajaran
	name = "塔亚拉舌头"
	modifies_speech = TRUE
	languages_native = list(/datum/language/siiktajr)

/obj/item/organ/tongue/cat/tajaran/modify_speech(datum/source, list/speech_args)
	var/static/regex/tajara_roll = new("r+", "g")
	var/static/regex/tajara_roLL = new("R+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = tajara_roll.Replace(message, "rrr")
		message = tajara_roLL.Replace(message, "RRR")
		message = replacetext(message, "r", "r")
//Insert russion translations here (sorry russions)
	speech_args[SPEECH_MESSAGE] = message

/datum/augment_item/organ/tongue/tajaran
	name = "塔亚拉舌头"
	path = /obj/item/organ/tongue/cat/tajaran

//Tajara have the innate ability to see in the dark better than most
/obj/item/organ/eyes/tajaran
	name = "塔亚拉眼睛"
	desc = "它们看起来很像猫的眼睛。"
	flash_protect = FLASH_PROTECTION_SENSITIVE //One layer protection
	color_cutoffs = list(12, 7, 7)

/obj/item/organ/eyes/tajaran/on_mob_insert(mob/living/carbon/human/eyes_owner)
	. = ..()
	if(istype(eyes_owner))
		if(HAS_TRAIT(eyes_owner, TRAIT_NIGHT_VISION)) //prevents double stacking of tajara night vision and the night vision quirk.
			to_chat(eyes_owner, span_danger("你感觉黑暗倏然消退，但转眼间又重新涌了回来！"))
			REMOVE_TRAIT(eyes_owner, TRAIT_NIGHT_VISION, QUIRK_TRAIT)

/obj/item/organ/ears/cat/tajaran
	name = "塔亚拉耳朵"
	desc = "这对耳朵似乎来自某种猫科动物"

/datum/species/tajaran/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "火焰弱点",
			SPECIES_PERK_DESC = "塔亚拉着火后需要更长时间才能冷却下来。"
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "强光敏感",
			SPECIES_PERK_DESC = "塔亚拉需要额外一层闪光防护来保护\
				自己，例如面对安保人员或进行焊接时。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "eye",
			SPECIES_PERK_NAME = "夜视",
			SPECIES_PERK_DESC = "他们的眼睛适应弱光环境，在黑暗中比其他人看得更清楚。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "assistive-listening-systems",
			SPECIES_PERK_NAME = "听觉灵敏",
			SPECIES_PERK_DESC = "塔亚拉对巨响更为敏感，例如闪光弹。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "paw",
			SPECIES_PERK_NAME = "轻盈落地",
			SPECIES_PERK_DESC = "塔亚拉从高处坠落不会受伤，并且总能双脚着地。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
			SPECIES_PERK_NAME = "猫之优雅",
			SPECIES_PERK_DESC = "塔亚拉像猫一样，拥有猫科动物的本能，能让它们双脚直立着地。\
				坠落时你不会被击倒，只会受到短暂的减速。\
				不过，由于他们没有猫的体型和体重，坠落会造成额外伤害。",
		),
	)

	return to_add

/obj/item/bodypart/chest/mutant/tajaran/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_CAT)

/datum/species/tajaran/get_species_description() //Something basic until I make lore later
	return list("塔亚拉是一支人形种族，拥有显著的猫科特征，包括\
	半可卷握的尾巴、覆盖着深浅不一毛皮的身体，以及带肉垫的趾行足。\
	由于他们来自一个严酷冰冷的星球，塔亚拉对高温和火焰十分脆弱。",)
