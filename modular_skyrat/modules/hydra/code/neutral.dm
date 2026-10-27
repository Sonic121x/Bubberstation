/datum/quirk/hydra
	name = "九头蛇之首"
	desc = "你是一个三头生物。使用时，请将名字按（Rucks-Sucks-Ducks）的格式书写。"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = span_notice("你听到脑海中有另外两个声音。")
	lose_text = span_danger("你的所有意识合而为一。")
	medical_record_text = "同一具身体上附有多个头部与人格。"
	icon = FA_ICON_HORSE_HEAD
	// remember what the name was before activation
	var/original_name
	var/heads_checked = FALSE
	var/list/heads
	var/datum/action/innate/hydra_head/head_spell
	var/datum/action/innate/hydra_reset/reset_spell

/datum/quirk/hydra/add(client/client_source)
	head_spell = new()
	reset_spell = new()
	head_spell.Grant(quirk_holder)
	reset_spell.Grant(quirk_holder)

/datum/quirk/hydra/remove()
	head_spell.Remove(quirk_holder)
	reset_spell.Remove(quirk_holder)
	QDEL_NULL(head_spell)
	QDEL_NULL(reset_spell)
	quirk_holder.real_name = original_name

/datum/quirk_constant_data/hydra
	associated_typepath = /datum/quirk/hydra
	customization_options = list(
		/datum/preference/text/hydra/name1,
		/datum/preference/text/hydra/name2,
		/datum/preference/text/hydra/name3,
	)

/datum/preference/text/hydra
	abstract_type = /datum/preference/text/hydra
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/text/hydra/name1
	savefile_key = "hydra__head_name1"

/datum/preference/text/hydra/name2
	savefile_key = "hydra__head_name2"

/datum/preference/text/hydra/name3
	savefile_key = "hydra__head_name3"

/datum/preference/text/hydra/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/action/innate/hydra_head
	name = "切换头部"
	desc = "在你身体的各个头部之间切换。"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydra_head/Activate() //Oops, all hydra!
	var/mob/living/carbon/human/hydra = owner
	var/datum/quirk/hydra/hydra_quirk = hydra.get_quirk(/datum/quirk/hydra)
	if(!hydra_quirk.original_name) // sets the archived 'real' name if not set.
		hydra_quirk.original_name = hydra.real_name

	if(!hydra_quirk.check_heads())
		to_chat(hydra, "请先在特质菜单中设置好你所有头部的名字，才能使用此能力。")
		return
	var/selhead = tgui_input_list(hydra, "你想以谁的身份说话？", "选择头部", hydra_quirk.heads)
	hydra.real_name = selhead
	hydra.visible_message(span_notice("[hydra.name] 将其他头部向后收回，把 [selhead] 探到前面。"), \
							span_notice("你现在以 [selhead] 的身份说话！"), ignored_mobs=owner)

/datum/quirk/hydra/proc/check_heads()
	if(heads_checked)
		return TRUE
	heads = list(
		quirk_holder?.client?.prefs?.read_preference(/datum/preference/text/hydra/name1),
		quirk_holder?.client?.prefs?.read_preference(/datum/preference/text/hydra/name2),
		quirk_holder?.client?.prefs?.read_preference(/datum/preference/text/hydra/name3),
	)
	for(var/headname in heads)
		if(headname == "")
			return FALSE
	heads_checked = TRUE
	return TRUE

/datum/action/innate/hydra_reset
	name = "重置说话身份"
	desc = "恢复为作为一个整体说话。"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydra_reset/Activate()
	var/mob/living/carbon/human/hydra = owner
	var/datum/quirk/hydra/hydra_quirk = hydra.get_quirk(/datum/quirk/hydra)
	if(!hydra_quirk.original_name) // sets the archived 'real' name if not set.
		hydra_quirk.original_name = hydra.real_name
	hydra.real_name = hydra_quirk.original_name
	hydra.visible_message(span_notice("[hydra.name] 将三个头一起向前探出，似乎正作为一个整体说话。"), \
							span_notice("你现在以 [hydra_quirk.original_name] 的身份说话！"), ignored_mobs=owner)
