/obj/item/reagent_containers/hash
	name = "大麻脂"
	desc = "浓缩的大麻提取物，用水烟壶吸食时效果更强。"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hash"
	volume = 20
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc = 15, /datum/reagent/toxin/lipolicide = 5)

/obj/item/reagent_containers/hash/dabs
	name = "大麻浓缩油"
	desc = "从大麻植株提取的油状物，带来另一种吸食体验。"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "dab"
	volume = 40
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc/concentrated = 40) //horrendously powerful

/obj/item/reagent_containers/hashbrick
	name = "大麻脂砖"
	desc = "一块砖状的大麻脂，很适合运输！"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hashbrick"
	volume = 80
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc = 60, /datum/reagent/toxin/lipolicide = 20)


/obj/item/reagent_containers/hashbrick/attack_self(mob/user)
	user.visible_message(span_notice("[user]开始掰碎[src]。"))
	if(do_after(user,10))
		to_chat(user, span_notice("你掰碎了[src]。"))
		for(var/i = 1 to 4)
			new /obj/item/reagent_containers/hash(user.loc)
		qdel(src)

/datum/crafting_recipe/hashbrick
	name = "大麻脂砖"
	result = /obj/item/reagent_containers/hashbrick
	reqs = list(/obj/item/reagent_containers/hash = 4)
	parts = list(/obj/item/reagent_containers/hash = 4)
	time = 20
	category = CAT_CHEMISTRY

//export values
/datum/export/hash
	cost = CARGO_CRATE_VALUE * 0.35
	unit_name = "大麻脂"
	export_types = list(/obj/item/reagent_containers/hash)
	include_subtypes = FALSE

/datum/export/crack/hashbrick
	cost = CARGO_CRATE_VALUE * 2
	unit_name = "大麻脂砖"
	export_types = list(/obj/item/reagent_containers/hashbrick)
	include_subtypes = FALSE

/datum/export/dab
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "大麻浓缩油"
	export_types = list(/obj/item/reagent_containers/hash/dabs)
	include_subtypes = FALSE
