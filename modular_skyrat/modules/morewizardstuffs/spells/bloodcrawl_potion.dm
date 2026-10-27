/obj/item/bloodcrawl_bottle
	name = "瓶装嗜血欲望"
	desc = "喝下它将获得难以想象的力量……以及金属味带来的一丝恶心。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/bloodcrawl_bottle/attack_self(mob/user)
	to_chat(user, span_notice("你喝下了[src]中的液体。"))
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/new_spell =  new(user)
	new_spell.Grant(user)
	user.log_message("学会了血遁法术（[new_spell]）", LOG_ATTACK, color="orange")
	qdel(src)
