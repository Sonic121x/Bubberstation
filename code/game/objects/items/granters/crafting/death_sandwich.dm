/obj/item/book/granter/crafting_recipe/death_sandwich
	name = "\improper 死亡三明治秘密配方"
	desc = "一本古老的作文笔记本，松散的书页上潦草地记着古代终极三明治的制作方法。标题是用永久性记号笔写上去的。"
	crafting_recipe_types = list(
		/datum/crafting_recipe/food/death_sandwich
	)
	icon_state = "cooking_learning_sandwich"
	remarks = list(
		"肉丸潜艇三明治，可它到底有什么特别？",
		"我只要抹上发油，把头发往后梳……？",
		"什么古代文明会穿牛仔短裤？",
		"原来萨拉米香肠折叠的角度真的很重要……",
	)

/obj/item/book/granter/crafting_recipe/death_sandwich/recoil(mob/living/user)
	to_chat(user, span_warning("这本书在你手中滑稽地炸开，没留下一丝痕迹。"))
	qdel(src)
