//File for modular wintercoats that aren't bundled with other stuff
//If the coat is part of a module (i.e. the Blueshield coat) then make sure it's subtyped under wintercoat/skyrat, but don't put it in this file!

//Coat Basetype (The Assistant's Formal Coat)
/obj/item/clothing/suit/hooded/wintercoat/skyrat
	name = "助理的正式冬季外套"
	desc = "一件深灰色的冬季外套，缀有青铜金色细节，拉链头是一个工具箱的形状。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coataformal"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat

//Hood Basetype (The Assistant's Formal Coat Hood)
/obj/item/clothing/head/hooded/winterhood/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/winterhood.dmi'
	icon_state = "hood_aformal"

//Bartender
/obj/item/clothing/suit/hooded/wintercoat/skyrat/bartender
	name = "调酒师的冬季外套"
	desc = "一件用原本从厨师的羊身上偷来的羊毛制成的厚重夹克。这个新设计为了搭配经典的西装领带造型，同时免去失温之苦。"
	icon_state = "coatbar"
	allowed = list(
		/obj/item/reagent_containers/cup/glass/shaker,
		/obj/item/reagent_containers/cup/glass/flask,
		/obj/item/rag
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/bartender

/obj/item/clothing/head/hooded/winterhood/skyrat/bartender
	icon_state = "hood_bar"

//Ratvar-themed
/obj/item/clothing/suit/hooded/wintercoat/skyrat/ratvar
	name = "拉特瓦式冬季外套"
	desc = "一件黄铜镀层的纽扣式冬季外套。拉链头不是拉片，而是一枚嵌着微小红色宝石的黄铜齿轮。"
	icon_state = "coatratvar"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/ratvar

/obj/item/clothing/head/hooded/winterhood/skyrat/ratvar
	icon_state = "hood_ratvar"

//Nar'sie-themed
/obj/item/clothing/suit/hooded/wintercoat/skyrat/narsie
	name = "纳尔西式冬季外套"
	desc = "一件色调沉郁的纽扣外套，灰暗的熵色中透着一道邪恶的绯红拉链。衣面布满繁复的符文与符号，拉链头宛如一滴鲜血。"
	icon_state = "coatnarsie"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/narsie

/obj/item/clothing/head/hooded/winterhood/skyrat/narsie
	desc = "一顶黑色的冬季兜帽，里面满是低语着的秘密，只有她才能知晓。"
	icon_state = "hood_narsie"

//Christmas
/obj/item/clothing/suit/hooded/wintercoat/skyrat/christmas
	name = "圣诞冬季外套"
	desc = "一件喜庆的圣诞外套，温暖的内衬是柔软的白色布料。拉链头是一根小小的拐杖糖！"
	icon_state = "coatchristmas"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/christmas

/obj/item/clothing/head/hooded/winterhood/skyrat/christmas
	icon_state = "hood_christmas"

/obj/item/clothing/suit/hooded/wintercoat/skyrat/christmas/green
	icon_state = "coatchristmas_green"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/christmas/green

/obj/item/clothing/head/hooded/winterhood/skyrat/christmas/green
	icon_state = "hood_christmas_green"
