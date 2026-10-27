/datum/heretic_knowledge/tricksters_mask
	name = "诡戏者面具"
	desc = "献祭一条头巾和一罐喷漆，制造能变化外形的面具，让你的声音身份与身份证上的姓名一致。"
	gain_text = "流血诡戏者凭借变幻莫测的面容与身形，始终主宰着这场假面舞会。"
	required_atoms = list(
		/obj/item/clothing/mask/bandana = 1,
		/obj/item/toy/crayon/spraycan = 1,
	)
	result_atoms = list(/obj/item/clothing/mask/chameleon/heretic)
	drafting_tier = 1
	drafting_cost = 0.5
	research_tree_icon_path = 'icons/map_icons/clothing/mask.dmi'
	research_tree_icon_state = "/obj/item/clothing/mask/bandana/white"

/obj/item/clothing/mask/chameleon/heretic

/obj/item/clothing/mask/chameleon/heretic/examine(mob/user)
	. = ..()

	if (IS_HERETIC_OR_MONSTER(user))
		. += span_notice("你认出这是诡戏者面具。戴上后，你说话时的身份会被强制变为当前身份证上所写的姓名。")

/obj/item/clothing/mask/chameleon/heretic/attack_self(mob/user)
	return // you cant disable it
