// Gel skins
/datum/atom_skin/med_gel
	abstract_type = /datum/atom_skin/med_gel

/datum/atom_skin/med_gel/blue
	preview_name = "蓝色"
	new_icon_state = "medigel_blue"

/datum/atom_skin/med_gel/cyan
	preview_name = "青色"
	new_icon_state = "medigel_cyan"

/datum/atom_skin/med_gel/green
	preview_name = "绿色"
	new_icon_state = "medigel_green"

/datum/atom_skin/med_gel/red
	preview_name = "红色"
	new_icon_state = "medigel_red"

/datum/atom_skin/med_gel/orange
	preview_name = "橙色"
	new_icon_state = "medigel_orange"

/datum/atom_skin/med_gel/purple
	preview_name = "紫色"
	new_icon_state = "medigel_purple"

/obj/item/reagent_containers/medigel
	name = "医疗凝胶"
	desc = "一瓶医疗凝胶涂抹剂，专为精准涂抹设计，瓶盖可旋开。"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "medigel"
	inhand_icon_state = "spraycan"
	worn_icon_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	item_flags = NOBLUDGEON
	obj_flags = UNIQUE_RENAME
	initial_reagent_flags = OPENCONTAINER | NO_SPLASH
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10)
	volume = 60
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	var/can_fill_from_container = TRUE
	var/apply_type = PATCH
	var/apply_method = "喷洒" //the thick gel is sprayed and then dries into patch like film.
	var/self_delay = 30
	custom_price = PAYCHECK_CREW * 2

/obj/item/reagent_containers/medigel/setup_reskins()
	if(icon_state == "medigel") // oh yeah baby raw icon state check to make sure we can't reskin preset gels
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/med_gel)

/obj/item/reagent_containers/medigel/mode_change_message(mob/user)
	var/squirt_mode = amount_per_transfer_from_this == initial(amount_per_transfer_from_this)
	to_chat(user, span_notice("你现在会以[squirt_mode ? "持续喷洒":"短促喷射"]的方式施加医疗凝胶。每次使用将消耗 [amount_per_transfer_from_this] 单位。"))

/obj/item/reagent_containers/medigel/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("[src] 是空的！"))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(interacting_with == user)
		interacting_with.visible_message(span_notice("[user] 试图往 [user.p_them()] 自己身上[apply_method][src]。"))
		if(self_delay)
			if(!do_after(user, self_delay, interacting_with))
				return ITEM_INTERACT_BLOCKING
			if(!reagents || !reagents.total_volume)
				return ITEM_INTERACT_BLOCKING
		to_chat(interacting_with, span_notice("你往自己身上[apply_method]了[src]。"))

	else
		log_combat(user, interacting_with, "试图涂抹", src, reagents.get_reagent_log_string())
		interacting_with.visible_message(
			span_danger("[user] 试图往 [interacting_with] 身上[apply_method][src]。"),
			span_userdanger("[user] 试图往你身上[apply_method][src]。"),
		)
		if(!do_after(user, CHEM_INTERACT_DELAY(3 SECONDS, user), interacting_with))
			return ITEM_INTERACT_BLOCKING
		if(!reagents || !reagents.total_volume)
			return ITEM_INTERACT_BLOCKING
		interacting_with.visible_message(
			span_danger("[user] 用 [src] 往 [interacting_with] 身上[apply_method]了一通。"),
			span_userdanger("[user] 用 [src] 往你身上[apply_method]了一通。"),
		)

	log_combat(user, interacting_with, "涂抹", src, reagents.get_reagent_log_string())
	playsound(src, 'sound/effects/spray.ogg', 30, TRUE, -6)
	reagents.trans_to(interacting_with, amount_per_transfer_from_this, transferred_by = user, methods = apply_type)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/medigel/libital
	name = "医疗凝胶（利比妥）"
	desc = "一瓶医疗凝胶涂抹剂，专为精准涂抹设计，瓶盖可旋开。这瓶含有利比妥，用于治疗割伤和瘀伤。利比妥会造成轻微肝脏损伤。已用格拉尼比妥稀释。"
	icon_state = "brutegel"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 24, /datum/reagent/medicine/granibitaluri = 36)

/obj/item/reagent_containers/medigel/aiuri
	name = "医疗凝胶（艾尤里）"
	desc = "一瓶医疗凝胶涂抹剂，专为精准涂抹设计，瓶盖可旋开。这瓶含有艾尤里，可用于治疗烧伤。艾尤里会造成轻微眼部损伤。已用格拉尼比妥稀释。"
	icon_state = "burngel"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 24, /datum/reagent/medicine/granibitaluri = 36)

/obj/item/reagent_containers/medigel/synthflesh
	name = "医疗凝胶（合成肉液）"
	desc = "一瓶医疗凝胶涂抹剂，专为精准涂抹设计，瓶盖可旋开。这瓶含有合成肉液，一种略带毒性的药物，可治疗瘀伤、烧伤和焦尸。"
	icon_state = "synthgel"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 60)
	list_reagents_purity = 1
	amount_per_transfer_from_this = 60
	possible_transfer_amounts = list(5, 10, 60)
	custom_price = PAYCHECK_CREW * 5

/obj/item/reagent_containers/medigel/synthflesh/examine(mob/user)
	. = ..()
	if(reagents.total_volume >= 60)
		. += span_info("一整瓶就能让被烧成焦尸的尸体恢复原状。")

/obj/item/reagent_containers/medigel/synthflesh/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(iscarbon(interacting_with) && reagents?.total_volume)
		var/mob/living/carbon/carbies = interacting_with
		if(HAS_TRAIT_FROM(carbies, TRAIT_HUSK, BURN) && carbies.get_fire_loss() > UNHUSK_DAMAGE_THRESHOLD * 2.5)
			// give them a warning if the mob is a husk but synthflesh won't unhusk yet
			carbies.visible_message(span_boldwarning("需要先修复 [carbies] 的烧伤，合成肉液才能让其脱离焦尸状态！"))

	return ..()

/obj/item/reagent_containers/medigel/sterilizine
	name = "消毒凝胶"
	desc = "装有无毒消毒剂的凝胶瓶。常用于手术准备。"
	icon_state = "medigel_blue"
	list_reagents = list(/datum/reagent/space_cleaner/sterilizine = 60)
	custom_price = PAYCHECK_CREW * 2
