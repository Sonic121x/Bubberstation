/obj/item/book/granter/crafting_recipe/stunstaff_prime
	name = "孤独典狱长的日记"
	desc = "一本还算干净的日记，散发着浓烈的辣椒喷雾和铜的气味。"
	crafting_recipe_types = list(
		/datum/crafting_recipe/stunstaff_prime
	)
	icon_state = "book1"
	remarks = list(
		"整个班次都坐在禁闭室里，确实挺孤独的，对吧……？",
		"有这么多闲暇，你总能琢磨出点什么。",
		"一种更高效的暴力执法方式……",
		"给电容过充……加上钛制加固件……",
		"为什么不干脆用枪呢？",
		"没错，把棍子直接捅进 APC 里。能出什么问题？",
		"两次攻击之间的充电速度到底有多快？！",
	)

/obj/item/book/granter/crafting_recipe/stunstaff_prime/recoil(mob/living/user)
	to_chat(user, span_warning("书在你手中化成了灰。"))
	qdel(src)
