/obj/item/book/granter/crafting_recipe/combat_baking
	name = "无政府主义者食谱"
	desc = "一本在许多地方被列为禁书的食谱，教你烘焙令人欲罢不能、甚至丧命的羊角面包。"
	crafting_recipe_types = list(
		/datum/crafting_recipe/food/throwing_croissant,
	)
	icon_state = "cooking_learing_illegal"
	remarks = list(
		"\"奥地利的？不是法国的？\"",
		"\"黄油的比例必须调对……\"",
		"\"这是切片面包之后最伟大的发明！\"",
		"\"除了面包屑，我不会留下任何痕迹！\"",
		"\"谁能想到面包竟能把人伤得这么重？\"",
	)

/obj/item/book/granter/crafting_recipe/combat_baking/recoil(mob/living/user)
	to_chat(user, span_warning("这本书散成了一堆烧焦的面粉！"))
	new /obj/effect/decal/cleanable/ash(get_turf(src))
	qdel(src)
