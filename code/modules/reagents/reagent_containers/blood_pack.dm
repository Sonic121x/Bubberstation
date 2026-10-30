/obj/item/reagent_containers/blood
	name = "血袋"
	desc = "装有可用于输血的血液。必须接在输液架上。"
	icon = 'icons/obj/medical/bloodpack.dmi'
	icon_state = "bloodpack"
	volume = 200
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)
	var/datum/blood_type/blood_type
	var/labeled = FALSE

/obj/item/reagent_containers/blood/Initialize(mapload, vol)
	. = ..()
	if (!blood_type)
		return
	var/datum/blood_type/bloodtype = get_blood_type(blood_type)
	var/list/blood_data = bloodtype.get_default_blood_data() | list(BLOOD_DATA_SYNTH_CONTENT = 1)

	reagents.add_reagent(bloodtype.reagent_type, volume, blood_data, creation_callback = CALLBACK(src, PROC_REF(on_blood_created)))

/obj/item/reagent_containers/blood/proc/on_blood_created(datum/reagent/new_blood)
	new_blood.AddElement(/datum/element/blood_reagent, null, get_blood_type(blood_type))
	update_appearance()

/obj/item/reagent_containers/blood/update_name(updates)
	. = ..()
	if(!labeled)
		name = "血袋[blood_type ? " - [blood_type::name == "Oil" ? "机油" : blood_type::name]" : ""]"

/obj/item/reagent_containers/blood/random
	icon_state = "random_bloodpack"

/obj/item/reagent_containers/blood/random/Initialize(mapload, vol)
	icon_state = "bloodpack"
	blood_type = pick(get_roundstart_blood_types())
	return ..()

/obj/item/reagent_containers/blood/a_plus
	blood_type = /datum/blood_type/human/a_plus

/obj/item/reagent_containers/blood/a_minus
	blood_type = /datum/blood_type/human/a_minus

/obj/item/reagent_containers/blood/b_plus
	blood_type = /datum/blood_type/human/b_plus

/obj/item/reagent_containers/blood/b_minus
	blood_type = /datum/blood_type/human/b_minus

/obj/item/reagent_containers/blood/o_plus
	blood_type = /datum/blood_type/human/o_plus

/obj/item/reagent_containers/blood/o_minus
	blood_type = /datum/blood_type/human/o_minus

/obj/item/reagent_containers/blood/lizard
	blood_type = /datum/blood_type/lizard

/obj/item/reagent_containers/blood/ethereal
	blood_type = /datum/blood_type/ethereal

/obj/item/reagent_containers/blood/snail
	blood_type = /datum/blood_type/snail

/obj/item/reagent_containers/blood/snail/examine()
	. = ..()
	. += span_notice("摸起来有点黏滑……标签说明这是给蜗牛用的。")

/obj/item/reagent_containers/blood/podperson
	blood_type = /datum/blood_type/water

/obj/item/reagent_containers/blood/podperson/examine()
	. = ..()
	. += span_notice("这看起来是一些贵得离谱的水。")

// for slimepeople
/obj/item/reagent_containers/blood/toxin
	blood_type = /datum/blood_type/slime

/obj/item/reagent_containers/blood/toxin/examine()
	. = ..()
	. += span_notice("标签上印有毒素警示。这是给史莱姆人用的。")

/obj/item/reagent_containers/blood/universal
	blood_type = /datum/blood_type/universal

/obj/item/reagent_containers/blood/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	labeled = TRUE
	return "血袋[input? " - [input]" : null]"
