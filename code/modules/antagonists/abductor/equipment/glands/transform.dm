/obj/item/organ/heart/gland/transform
	abductor_hint = "拟人化形态转换器。被绑架者会偶尔改变外形和种族。"
	cooldown_low = 900
	cooldown_high = 1800
	uses = -1
	human_only = TRUE
	icon_state = "species"
	mind_control_uses = 7
	mind_control_duration = 300

/obj/item/organ/heart/gland/transform/activate()
	to_chat(owner, span_notice("你感觉自己不像自己了。"))
	randomize_human(owner)
	var/species = pick(list(/datum/species/human, /datum/species/lizard, /datum/species/moth, /datum/species/fly))
	owner.set_species(species)
