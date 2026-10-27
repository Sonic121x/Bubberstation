/obj/item/book/granter/crafting_recipe/regal_condor
	name = "阵亡特工的回忆录"
	desc = "一本破旧的日记，上面似乎沾满了咚克口袋饼的碎屑。"
	crafting_recipe_types = list(
		/datum/crafting_recipe/deagle_prime,
		/datum/crafting_recipe/deagle_prime_mag,
	)
	icon_state = "book1"
	remarks = list(
		"书上说，在接到行动指令之前，她曾是一名助手……",
		"我不觉得手枪能‘吸收’其他手枪，不过随便吧……",
		"等等，做这个到底要多少黄金？",
		"看来猛虎合作社偶尔也能搞出些有意思的东西……",
		"为什么不直接给我一把安瑟姆手枪？我自己去找桶黑漆就好了……",
		"净化一切，或为此而死……",
	)

/obj/item/book/granter/crafting_recipe/regal_condor/recoil(mob/living/user)
	to_chat(user, span_warning("书在你手中化为了尘埃。"))
	qdel(src)
