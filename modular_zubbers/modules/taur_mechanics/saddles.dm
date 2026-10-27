/obj/item/riding_saddle
	name = "通用骑乘马鞍"
	desc = "有人把基础类型刷出来了！"
	slot_flags = ITEM_SLOT_BELT

	icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon_taur_snake = 'modular_zubbers/icons/mob/taur/saddles.dmi'

/obj/item/riding_saddle/Initialize(mapload)
	. = ..()
	if(type == /obj/item/riding_saddle) // don't even let these prototypes exist
		return INITIALIZE_HINT_QDEL

	AddComponent(/datum/component/carbon_saddle, RIDING_TAUR) // FREE HANDS
	AddComponent(/datum/component/taur_clothing_offset)

/obj/item/riding_saddle/leather
	name = "骑乘马鞍"
	desc = "一副厚实的皮革骑乘马鞍。通常用在动物身上，这一副则是为银河中的半人马们设计的。\n\
		鞍上配有特制的脚踏，让骑手在骑乘时<b>双手都能空出来</b>。"

	icon_state = "saddle_leather_item"
	worn_icon_state = "saddle_leather"

	inhand_icon_state = "syringe_kit" // placeholder
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

/obj/item/riding_saddle/leather/peacekeeper
	name = "和平守护者马鞍"
	icon_state = "saddle_sec_item"
	worn_icon_state = "saddle_sec"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/riding_saddle/leather/peacekeeper/Initialize(mapload)
	. = ..()
	desc += " 这一副涂着和平守护者的涂装，还配有一个挂载手铐与\
	警棍的挂载槽。可惜这使它稍显笨重。"
	create_storage(storage_type = /datum/storage/sec_saddle)

/obj/item/riding_saddle/leather/peacekeeper/update_icon(updates)
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		if(wearer.belt == src)
			wearer.update_worn_belt()

/obj/item/riding_saddle/leather/peacekeeper/worn_overlays(mutable_appearance/standing, isinhands, icon_file, mutant_styles)
	. = ..()
	if(isnull(atom_storage) || isinhands)
		return
	// This is extremely snowflake, if you decide to make saddlebelts(TM)
	// more common, consider using a method similar to /obj/item/storage/belt/update_overlays()
	//
	if(locate(/obj/item/restraints/handcuffs) in contents)
		. += mutable_appearance('modular_zubbers/icons/mob/taur/saddles.dmi', "cuffs_over")
	if(locate(/obj/item/melee/baton/security) in contents)
		. += mutable_appearance('modular_zubbers/icons/mob/taur/saddles.dmi', "baton_over")

/datum/storage/sec_saddle
	max_slots = 2

/datum/storage/sec_saddle/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/restraints/handcuffs,
		/obj/item/melee/baton/security
	))

/obj/item/storage/backpack/saddlebags
	name = "马鞍袋"
	desc = "一组由腰带系在一起的小口袋，因为其出色的储物容量，通常用在驮兽身上。这一套则是为银河中的半人马们设计的。 \n\
		任何人只要<b>按住 Alt 点击</b>佩戴者，就能取用这套鞍袋。\n\
		此外，它还经过改装，加了一个握把，让骑乘时能<b>空出一只手</b>。"
	gender = PLURAL

	slot_flags = ITEM_SLOT_BACK

	icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon_taur_snake = 'modular_zubbers/icons/mob/taur/saddles.dmi'

	storage_type = /datum/storage/saddlebags

	icon_state = "saddle_satchel_item"
	worn_icon_state = "saddle_satchel"

// slightly better than a backpack, but accessable_storage counterbalances this
/datum/storage/saddlebags
	max_total_storage = 26
	max_slots = 21

/obj/item/storage/backpack/saddlebags/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/carbon_saddle, RIDING_TAUR|RIDER_NEEDS_ARM) // one arm
	AddComponent(/datum/component/accessable_storage)
	AddComponent(/datum/component/taur_clothing_offset)
