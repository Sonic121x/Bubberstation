// Wendigo blood

/obj/item/wendigo_blood
	name = "一瓶温迪戈之血"
	desc = "一瓶黏稠的红色液体……你该不会真打算喝下去吧？"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/wendigo_blood/attack_self(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(!human_user.mind)
		return
	to_chat(human_user, span_danger("力量在你体内奔涌！现在你可以随心所欲地改变形态。"))
	var/datum/action/cooldown/spell/shapeshift/polar_bear/transformation_spell = new(user.mind || user)
	transformation_spell.Grant(user)
	playsound(human_user.loc, 'sound/items/drink.ogg', rand(10,50), TRUE)
	qdel(src)

// Wendigo skull

/obj/item/wendigo_skull
	name = "温迪戈头骨"
	desc = "从凶残野兽身上扯下的血淋淋头骨，空洞的眼窝似乎总在追踪你的动作。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "wendigo_skull"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
