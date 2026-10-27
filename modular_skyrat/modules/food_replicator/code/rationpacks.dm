/obj/item/food/colonial_course
	name = "未定义的殖民地餐品"
	desc = "某种你不该看到的东西。但可以吃。"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borgir"
	base_icon_state = "borgir"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("蜡笔粉" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE

/obj/item/food/colonial_course/attack_self(mob/user, modifiers)
	if(preserved_food)
		preserved_food = FALSE
		icon_state = "[base_icon_state]_unwrapped"
		to_chat(user, span_notice("你拆开了 [src] 的包装。"))
		playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)

/obj/item/food/colonial_course/attack(mob/living/target, mob/user, def_zone)
	if(preserved_food)
		to_chat(user, span_warning("[src] 还带着包装！"))
		return FALSE

	return ..()

/obj/item/food/colonial_course/pljeskavica
	name = "普列斯卡维察"
	desc = "刚打印出来、热气腾腾的汉堡，用生物发生器生产、仿手工制作的面包夹着肉饼，还配有各种蔬菜和酱料。\
		<br> 对于这种复制食品来说，看起来<i>还算</i>不错。包装上写满了关于营养成分、内容和保质期的信息。可惜全是泛斯拉夫语写的。"
	trash_type = /obj/item/trash/pljeskavica
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("面包" = 2, "香料肉饼" = 10, "素食主义的死亡" = 3)
	foodtypes = VEGETABLES | GRAIN | MEAT

/obj/item/food/colonial_course/nachos
	name = "原味玉米片托盘"
	desc = "真空密封包装，里面似乎是分量十足的三角形玉米片，还留有三个隔间分别放萨尔萨酱、奶酪酱和牛油果酱。\
		<br> 这大概是你在这批口粮里能找到卖相最好的食物了，也许是因为它足够简单。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	trash_type = /obj/item/trash/nachos
	icon_state = "nacho"
	base_icon_state = "nacho"
	tastes = list("玉米片" = 5, "“人工”有机酱料" = 5)
	foodtypes = GRAIN | FRIED | DAIRY

/obj/item/food/colonial_course/blins
	name = "炼乳可丽饼"
	desc = "真空密封的四只装夹心可丽饼，包装上标记很少。老实说，除此之外没什么特别的。\
		<br> 卖相虽普通，味道却出奇地好——只要你没有乳糖不耐受、不在节食，也不是素食者。包装背面印满了详细介绍产品的信息。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/milk = 4,
	)
	trash_type = /obj/item/trash/blins
	icon_state = "blin"
	base_icon_state = "blin"
	tastes = list("甜得发疯" = 10, "可丽饼" = 3)
	foodtypes = SUGAR | GRAIN | DAIRY | BREAKFAST

/obj/item/reagent_containers/cup/glass/coffee/colonial
	name = "殖民地保温杯"
	desc = "严格来说，它是用来喝热饮的。但既然这是当时唯一能搞到的杯型，就只能凑合用了。杯身侧面印有说明。 \
	<br> 这一只预先装有一份咖啡粉。"
	special_desc = "侧面印着一小段说明：<i>“用于食品复制机；将水与粉末溶液按一比一比例混合。 \
	<br> 若制作可可，将牛奶与粉末溶液按一比一比例混合。”</i>"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	list_reagents = list(/datum/reagent/consumable/powdered_coffee = 25)

/obj/item/reagent_containers/cup/glass/coffee/colonial/empty
	desc = "严格来说，它是用来喝热饮的。但既然这是当时唯一能搞到的杯型，就只能凑合用了。杯身侧面印有说明。"
	list_reagents = null

/obj/item/trash/pljeskavica
	name = "普列斯卡维察包装纸"
	desc = "内侧沾满酱汁涂抹痕迹和食物的碎块，已被揉成一团。最好把它处理掉。"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borgir_trash"

/obj/item/trash/nachos
	name = "空玉米片托盘"
	desc = "内侧沾满酱汁涂抹痕迹和食物碎块，这个塑料食品托盘已经没什么用了。最好把它处理掉或回收。"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "nacho_trash"

/obj/item/trash/blins
	name = "空可丽饼包装纸"
	desc = "原本装着某种甜得离谱的东西的空包装纸，已被撕破。最好回收它。"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	icon_state = "blin_trash"

/obj/item/storage/box/gum/colonial
	name = "混合口香糖包"
	desc = "包装上全用泛斯拉夫语书写，只有一小段通用语简介。不过字印得很小，你得仔细看看才能读清。"
	special_desc = "细看小字，内容如下：<i>“外国殖民口粮，J 型：混合来源，成人用。口香糖包装，药用，休闲用。 <br>\
		请勿过量食用。部分条装含尼古丁。”</i>"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "bubblegum"

/obj/item/storage/box/gum/colonial/PopulateContents()
	new /obj/item/food/bubblegum(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/food/bubblegum/nicotine(src)
	new /obj/item/food/bubblegum/nicotine(src)

/obj/item/storage/box/utensils
	name = "餐具包"
	desc = "一个小包装，内含<i>人类</i>食用各种食物所需的各种餐具。 \
	正常情况下包含一把塑料叉、一把塑料勺和两张餐巾。"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "utensil_box"
	w_class = WEIGHT_CLASS_TINY
	illustration = null
	foldable_result = null

/obj/item/storage/box/utensils/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(
		/obj/item/kitchen/spoon/plastic,
		/obj/item/kitchen/fork/plastic,
		/obj/item/serviette,
	))
	atom_storage.max_slots = 4

/obj/item/storage/box/utensils/PopulateContents()
	new /obj/item/kitchen/spoon/plastic(src)
	new /obj/item/kitchen/fork/plastic(src)
	new /obj/item/serviette/colonial(src)
	new /obj/item/serviette/colonial(src)

/obj/item/serviette/colonial
	name = "殖民地餐巾"
	desc = "用来清理所有污渍。采用定制的红蓝<i>组合</i>设计。"
	icon_state = "napkin_unused"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	used_serviette = /obj/item/serviette_used/colonial

/obj/item/serviette_used/colonial
	name = "脏的殖民地餐巾"
	desc = "已经没用了，脏得离谱，或者湿透了，或者都认不出来了。"
	icon_state = "napkin_used"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'

/obj/item/storage/box/colonial_rations
	name = "外国殖民口粮"
	desc = "一份刚打印出来的民用单兵口粮，更准确地说是一份午餐食品包，供如今被称为 NRI 的最初殖民者在早期拓殖时期使用。 <br>\
		包装上没有任何印制日期，再加上其来源是<i>食品复制机</i>，这应该足以提示你：它的保质期很短，但也算合理。"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "mre_package"
	foldable_result = null
	illustration = null

/obj/item/storage/box/colonial_rations/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 6
	atom_storage.locked = TRUE

/obj/item/storage/box/colonial_rations/attack_self(mob/user, modifiers)
	if(user)
		if(atom_storage.locked == TRUE)
			atom_storage.locked = FALSE
			icon_state = "mre_package_open"
			balloon_alert(user, "已开封！")
			return ..()
		else
			atom_storage.locked = TRUE
			atom_storage.close_all()
			icon_state = "mre_package"
			balloon_alert(user, "已重新封好！")
			return

/obj/item/storage/box/colonial_rations/PopulateContents()
	new /obj/item/food/colonial_course/pljeskavica(src)
	new /obj/item/food/colonial_course/nachos(src)
	new /obj/item/food/colonial_course/blins(src)
	new /obj/item/reagent_containers/cup/glass/coffee/colonial(src)
	new /obj/item/storage/box/gum/colonial(src)
	new /obj/item/storage/box/utensils(src)
