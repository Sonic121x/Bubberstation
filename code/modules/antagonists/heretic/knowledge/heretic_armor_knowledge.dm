/datum/heretic_knowledge/armor
	name = "甲匠仪式"
	desc = "制作一套邪异护甲。 \
		邪异护甲能提供出色的防护，戴起兜帽时还可作为法器。"
	transmute_text = "转化一张桌子（或一件套装）和一个面具。"
	gain_text = "锈蚀群丘以慷慨之姿迎接了铁匠。而铁匠 \
		也以同样的慷慨回报了他们。"

	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
	)
	abstract_type = /datum/heretic_knowledge/armor
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch)
	cost = 1

	research_tree_icon_path = 'icons/obj/clothing/suits/armor.dmi'
	research_tree_icon_state = "eldritch_armor"
	research_tree_icon_frame = 1
// BUBBER EDIT REMOVAL - You have to pay for your upgrades now
/*/datum/heretic_knowledge/armor/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(!heretic_datum)
		return
	SEND_SIGNAL(heretic_datum, COMSIG_HERETIC_PASSIVE_UPGRADE_FIRST)
	heretic_datum.gain_knowledge(/datum/heretic_knowledge/knowledge_ritual)*/
