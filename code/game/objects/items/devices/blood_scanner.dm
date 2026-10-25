///Pricks people with a big needle and gives the user a bunch of info about bloodtype, tox damage, other such stuff. if you fuck up it stabs the guy a bit.
/obj/item/blood_scanner
	name = "血液分析扫描仪"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "bloodscanner"
	inhand_icon_state = "healthanalyzer"
	worn_icon_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "这款美洛科技牌医疗设备可检测血流或血液成分异常。侧面的按钮可扫描患者血液中是否存在常见药物。"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/blood_scanner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!usable_check(person_scanning = user, scanee = interacting_with))
		return NONE
	var/mob/living/carbon/poked_guy = interacting_with
	var/obj/item/bodypart/poked_bit = poked_guy.get_bodypart(check_zone(user.zone_selected))
	if(!poked_bit)
		return
	user.visible_message(span_notice("[user]用[src]扎了[poked_guy]一下。"), span_notice("你开始用[src]扫描[poked_guy]。"), ignored_mobs = poked_guy)
	to_chat(poked_guy, span_notice("[user]将[src]的针头刺入你的[chinese_body_zone_display(poked_bit.plaintext_zone)]，开始按动按钮。"))
	var/success = do_after(user, 2 SECONDS, poked_guy)
	if(success)
		scan_blood(scanner = user, scanned_person = poked_guy)
	else
		if(prob(25))
			regret(stabber = user, stabbed = poked_guy, to_stab = poked_bit)
		return

	return ITEM_INTERACT_SUCCESS

/obj/item/blood_scanner/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!usable_check(person_scanning = user, scanee = interacting_with))
		return NONE
	var/mob/living/carbon/poked_guy = interacting_with
	var/obj/item/bodypart/poked_bit = poked_guy.get_bodypart(check_zone(user.zone_selected))
	user.visible_message(span_notice("[user]用[src]扎了[poked_guy]一下。"), span_notice("你开始用[src]扫描[poked_guy]。"), ignored_mobs = poked_guy)
	to_chat(poked_guy, span_notice("[user]将[src]的针头刺入你的[chinese_body_zone_display(poked_bit?.plaintext_zone)]，开始按动按钮。"))
	var/success = do_after(user, 2 SECONDS, poked_guy)
	if(success)
		chemscan(user, poked_guy, reagent_types_to_check = /datum/reagent/medicine)
	else
		if(prob(25))
			regret(stabber = user, stabbed = poked_guy, to_stab = poked_bit)
		return

	return ITEM_INTERACT_SUCCESS


/obj/item/blood_scanner/proc/scan_blood(mob/living/scanner, mob/living/carbon/scanned_person)
	var/render_list = list()
	var/oxy_loss = scanned_person.get_oxy_loss()
	var/tox_loss = scanned_person.get_tox_loss()
	render_list += span_info("你查看[src]的屏幕：\n")
	render_list += "<span class='notice ml-1'>血型：[scanned_person?.dna?.blood_type]</span>\n"
	if(oxy_loss > 50)//if they have knockout levels of suffocation damage
		render_list += "<span class='danger ml-1'>警告：血氧水平过低。</span>\n"
	if(scanned_person.get_blood_volume(apply_modifiers = TRUE) <= BLOOD_VOLUME_SAFE)
		render_list += "<span class='danger ml-1'>警告：血流量低至危险水平。</span>\n"
	if(tox_loss > 10)
		render_list += "<span class='danger ml-1'>警告：检测到血液中毒素堆积。</span>\n"
	if(scanned_person.has_status_effect(/datum/status_effect/eigenstasium))
		render_list += "<span class='danger ml-1'>警告：检测到维度不稳定。请施用稳定剂。</span>\n"
	if(scanned_person.has_reagent(/datum/reagent/gold/cursed) || scanned_person.has_status_effect(/datum/status_effect/midas_blight))
		render_list += "<span class='danger ml-1'>警告：存在血液金化诅咒。</span>\n" //can it detect normal things? barely. But ancient greed-cursed magicks? Spot on.
	if(HAS_TRAIT_FROM(scanned_person, TRAIT_NODEATH, /datum/reagent/inverse/penthrite))
		render_list += "<span class='danger ml-1'>警告：正在进行弗兰肯斯坦式复生。</span>\n" //patient is currently an immortal drug-zombie
	if(scanned_person.has_status_effect(/datum/status_effect/high_blood_pressure))
		render_list += "<span class='danger ml-1'>警告：血压高至危险水平。</span>\n"
	if(HAS_TRAIT(scanned_person, TRAIT_IMMUNODEFICIENCY))
		render_list += "<span class='danger ml-1'>警告：免疫细胞浓度过低。</span>\n" //it doe
	to_chat(scanner, boxed_message(jointext(render_list, "")), type = MESSAGE_TYPE_INFO)

/obj/item/blood_scanner/proc/regret(mob/living/stabber, mob/living/stabbed, obj/item/bodypart/to_stab)
	to_stab?.force_wound_upwards(/datum/wound/pierce/bleed/moderate/needle_fail, wound_source = "idiot moved with a needle in them")
	stabber.visible_message(span_warning("[src]的针头被扯出，在[stabbed]的[chinese_body_zone_display(to_stab?.plaintext_zone)]撕开了一个洞！"), span_warning("该死！针头被扯出，在[stabbed]的[chinese_body_zone_display(to_stab?.plaintext_zone)]留下了一个小洞。"), ignored_mobs = stabbed)
	to_chat(stabbed, span_userdanger("<b>好痛！</b>[src]的针头被扯出，在你的[chinese_body_zone_display(to_stab?.plaintext_zone)]撕开了一个小洞！"))

/obj/item/blood_scanner/proc/usable_check(mob/living/person_scanning, atom/scanee)
	if(!isliving(scanee))
		return FALSE
	if(!istype(scanee, /mob/living/carbon))
		to_chat(person_scanning, span_warning("[src]与目标不兼容。"))
		return FALSE
	if(!person_scanning.can_read(src) || person_scanning.is_blind())
		to_chat(person_scanning, span_warning("你无法看清[src]的屏幕！"))
		return FALSE
	return TRUE
