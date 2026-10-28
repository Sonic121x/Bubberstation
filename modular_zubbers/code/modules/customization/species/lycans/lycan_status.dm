#define BEAST_FORM_EXPOSITION_LINK "beast_form_exposition_link"

/datum/status_effect/beast_form
	id = "lycan_beast_form"
	alert_type = null // TODO - maybe add an alert??
	var/datum/species/initial_species

/datum/status_effect/beast_form/on_apply()
	. = ..()
	if (!.)
		return FALSE

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		return FALSE

	var/obj/item/organ/brain/lycan/lycan_brain = human_owner.get_organ_by_type(/obj/item/organ/brain/lycan)
	if (!istype(lycan_brain))
		return FALSE

	initial_species = human_owner.dna.species

	var/datum/species/human/cursekin/current_wolf = human_owner.dna.species
	if(!istype(current_wolf))
		return FALSE

	human_owner.visible_message(span_warning("[human_owner] 仰头向天嚎叫，身躯急速膨胀，变成一头可怖的野兽！"))

	var/client/target_client = human_owner.client
	if (!isnull(target_client))
		var/name = human_owner.real_name
		var/slot = target_client.prefs.read_preference(/datum/preference/numeric/cursekin_char_slot)
		var/transfer = TRUE
		if (isnull(lycan_brain.last_slot))
			lycan_brain.last_slot = target_client.prefs.savefile.get_entry("default_slot")
		target_client.prefs.load_character(slot)
		if (!ispath(target_client.prefs.read_preference(/datum.preference/choiced/species), current_wolf.lycanthropy_species))
			to_chat(human_owner, span_warning("你选择的角色栏位不是狼人！将改为直接变更你的种族……"))
			target_client.prefs.load_character(lycan_brain.last_slot)
			human_owner.set_species(current_wolf.lycanthropy_species, TRUE, TRUE, FALSE)
			lycan_brain.last_slot = null // allows for easier switching in later procs
			transfer = FALSE

		if (transfer)
			target_client.prefs.safe_transfer_prefs_to_with_damage(human_owner)
			human_owner.real_name = name
			human_owner.name = name
			SSquirks.OverrideQuirks(human_owner, target_client, spawn_items = FALSE)
			human_owner.dna.update_dna_identity()

			target_client.prefs.load_character(lycan_brain.last_slot)

	ADD_TRAIT(human_owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(human_owner, lycan_brain.to_lycan_sfx, 50)

/datum/status_effect/beast_form/on_remove()
	. = ..()

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		return

	var/obj/item/organ/brain/lycan/lycan_brain = human_owner.get_organ_by_type(/obj/item/organ/brain/lycan)
	if (!istype(lycan_brain))
		return

	human_owner.visible_message(span_warning("[human_owner] 身形缩小，皮毛渐渐褪去！"))

	if (lycan_brain.last_slot)
		var/client/target_client = human_owner.client
		if (isnull(target_client))
			human_owner.set_species(initial_species, TRUE, TRUE, FALSE)
		else
			target_client.prefs.load_character(lycan_brain.last_slot)
			target_client.prefs.safe_transfer_prefs_to_with_damage(human_owner)
			SSquirks.OverrideQuirks(human_owner, target_client, spawn_items = FALSE)
			human_owner.dna.update_dna_identity()
	else
		human_owner.set_species(initial_species, TRUE, TRUE, FALSE)

	REMOVE_TRAIT(human_owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(human_owner, lycan_brain.to_human_sfx, 50)

/datum/status_effect/beast_form/tick(seconds_between_ticks)
	. = ..()

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		qdel(src)
		return

	if (human_owner.stat >= HARD_CRIT || human_owner.dna.species.id != SPECIES_LYCAN)
		qdel(src)
		return

/datum/status_effect/beast_form/get_examine_text()
	return span_notice("纳米传讯员工手册中有一条关于该种族的记载…… <a href='byond://?src=[REF(src)];[BEAST_FORM_EXPOSITION_LINK]=1'>回忆一下你读过的内容？</a>")

/datum/status_effect/beast_form/Topic(href, list/href_list)
	. = ..()

	if (href_list[BEAST_FORM_EXPOSITION_LINK])
		print_exposition(usr)

/datum/status_effect/beast_form/proc/print_exposition(mob/user)
	var/list/render_list = list()

	render_list += "关于狼化症与兽形变形者的传说一直存在，但直到一个世纪前，咒裔这一种族 \
	才被猎户臂的大多数政体正式承认。他们所受诅咒的来源可能因咒裔而异——有的源自神明，有的源自基因——但每一个 \
	都有能力变成可怖的野兽，长出剃刀般的利爪。"
	render_list += "<hr>"
	render_list += span_notice("狼人及相关存在形态各异，但它们运作的方式有相似之处。")
	render_list += span_notice("\n狼人拥有[EXAMINE_HINT("格外强壮的利爪")]，强度大约相当于[EXAMINE_HINT("圆锯")]，但没有穿甲能力。")
	render_list += span_notice("\n狼人对钝击伤害有[EXAMINE_HINT("很强的抗性")]，对灼伤的抗性略弱一些。")
	render_list += span_notice("\n不过，狼人[EXAMINE_HINT("无法穿任何衣物")]，也无法拥有合成器官。")
	render_list += span_notice("\n此外，每个狼人都[EXAMINE_HINT("对银有显著弱点")]，受到银制武器攻击时会[EXAMINE_HINT("承受更多伤害")]。")
	render_list += span_notice("\n最后，由于手指粗大，狼人[EXAMINE_HINT("无法使用警棍")]，也[EXAMINE_HINT("无法使用大多数枪械")]。")
	render_list += span_notice("\n狼人形态可以[EXAMINE_HINT("随心意切换")]，也可以通过[EXAMINE_HINT("将其打入重度濒死")]来[EXAMINE_HINT("强行解除")]。")
	render_list += "<hr>"
	render_list += span_warning("虽然狼人大多温顺、被驯化且相对弱小，但据传有些狼人身上潜藏着[EXAMINE_HINT("格外强大")]的诅咒形态。留意以下任何特征：")
	render_list += span_warning("\n	* 极其强大的利爪")
	render_list += span_warning("\n	* 极具侵略性的生命再生")
	render_list += span_warning("\n	* 免疫推撞，并对疼痛与眩晕有抗性")
	render_list += span_warning("\n	* 能够无视任何疼痛继续疾奔")
	render_list += span_warning("\n	* 能够用利爪砸毁气闸和窗户")
	render_list += span_boldwarning("\n如果你发现自己面对的狼人具有这些特征，请采取以下防范措施。")
	render_list += span_warning("\n	* 避免使用物理武器和消耗体力的武器——它们的再生会迅速修复钝伤与体力损耗")
	render_list += span_warning("\n	* 使用银制武器——可造成额外的灼伤伤害")
	render_list += span_warning("\n	* 使用雾化银——它们无法使用呼吸器，接触银便会灼伤")
	render_list += span_warning("\n	* 让狼人进入安抚状态——被安抚时它们无法砸毁窗户或气闸")

	var/output = jointext(render_list, "")

	to_chat(user, custom_boxed_message("blue_box", output), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)

#undef BEAST_FORM_EXPOSITION_LINK
