/obj/item/book/granter/crafting_recipe/trash_cannon
	name = "被降职工程师的日记"
	desc = "一本遗失的日记。这名工程师似乎被降职一事逼疯了。"
	crafting_recipe_types = list(
		/datum/crafting_recipe/trash_cannon,
		/datum/crafting_recipe/trashball,
	)
	icon_state = "book1"
	remarks = list(
		"\"我要给他们点颜色看看！我要造一门大炮！\"",
		"\"火药最理想，但我只能凑合着来了……\"",
		"\"我真想看看工程部的墙被我轰塌时，总工程师脸上的表情！\"",
		"\"要是我闹得超物质失控了，那就随它去！\"",
		"\"我已经彻底疯了！\"",
	)

/obj/item/book/granter/crafting_recipe/trash_cannon/recoil(mob/living/user)
	to_chat(user, span_warning("书在你手中化为了尘埃。"))
	qdel(src)
