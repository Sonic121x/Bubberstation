/datum/heretic_knowledge/rifle
	drafting_cost = 1

/datum/heretic_knowledge/rifle_ammo
	drafting_cost = 1

/obj/item/gun/ballistic/rifle/lionhunter/examine(mob/user)
	. = ..()

	. += span_notice("猎狮者步枪是一种源于漫宿的武器，能够穿墙射击，也能锁定目标，让弹丸追踪目标，\
	并在命中时将侍徒传送到目标身边。")
