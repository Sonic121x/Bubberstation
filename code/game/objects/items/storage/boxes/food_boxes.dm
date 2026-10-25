// This contains all boxes with edible stuffs or stuff related to edible stuffs.

/obj/item/storage/box/donkpockets
	name = "咚克口袋饼盒"
	desc = "使用说明：用微波炉加热。得益于咚克公司的尖端技术，本品将永久保持温热。"
	icon_state = "donkpocketbox"
	illustration = null
	/// What type of donk pocket are we gonna cram into this box?
	var/donktype = /obj/item/food/donkpocket
	storage_type = /datum/storage/box/donk_pockets

/obj/item/storage/box/donkpockets/PopulateContents()
	for(var/i in 1 to 6)
		new donktype(src)

/obj/item/storage/box/donkpockets/donkpocketspicy
	name = "辣味咚克口袋饼盒"
	icon_state = "donkpocketboxspicy"
	donktype = /obj/item/food/donkpocket/spicy

/obj/item/storage/box/donkpockets/donkpocketteriyaki
	name = "照烧味咚克口袋饼盒"
	icon_state = "donkpocketboxteriyaki"
	donktype = /obj/item/food/donkpocket/teriyaki

/obj/item/storage/box/donkpockets/donkpocketpizza
	name = "披萨味咚克口袋饼盒"
	icon_state = "donkpocketboxpizza"
	donktype = /obj/item/food/donkpocket/pizza

/obj/item/storage/box/donkpockets/donkpocketgondola
	name = "贡多拉味咚克口袋饼盒"
	icon_state = "donkpocketboxgondola"
	donktype = /obj/item/food/donkpocket/gondola

/obj/item/storage/box/donkpockets/donkpocketberry
	name = "浆果味咚克口袋饼盒"
	icon_state = "donkpocketboxberry"
	donktype = /obj/item/food/donkpocket/berry

/obj/item/storage/box/donkpockets/donkpockethonk
	name = "香蕉味咚克口袋饼盒"
	icon_state = "donkpocketboxbanana"
	donktype = /obj/item/food/donkpocket/honk

/obj/item/storage/box/donkpockets/donkpocketshell
	name = "咚克公司“咚克尖刺”飞镖弹盒"
	desc = "使用说明：切勿用微波炉加热。得益于咚克公司的尖端技术，本品将清除一切敌对威胁。"
	icon_state = "donkpocketboxshell"
	donktype = /obj/item/ammo_casing/shotgun/flechette/donk
	storage_type = /datum/storage/box/donk_bullets

/obj/item/storage/box/papersack
	name = "纸袋"
	desc = "用纸精心制作的袋子。"
	icon = 'icons/obj/storage/paperbag.dmi'
	icon_state = "paperbag_None"
	inhand_icon_state = null
	illustration = null
	resistance_flags = FLAMMABLE
	foldable_result = null
	custom_materials = list(/datum/material/paper = SHEET_MATERIAL_AMOUNT * 1.25)
	/// A list of all available papersack reskins
	var/list/papersack_designs = list()
	///What design from papersack_designs we are currently using.
	var/design_choice = "None"

/obj/item/storage/box/papersack/Initialize(mapload)
	. = ..()
	papersack_designs = sort_list(list(
		"None" = image(icon = src.icon, icon_state = "paperbag_None"),
		"NanotrasenStandard" = image(icon = src.icon, icon_state = "paperbag_NanotrasenStandard"),
		"SyndiSnacks" = image(icon = src.icon, icon_state = "paperbag_SyndiSnacks"),
		"Heart" = image(icon = src.icon, icon_state = "paperbag_Heart"),
		"SmileyFace" = image(icon = src.icon, icon_state = "paperbag_SmileyFace")
		))
	update_appearance()

/obj/item/storage/box/papersack/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, design_choice))
		update_appearance()

/obj/item/storage/box/papersack/update_icon_state()
	icon_state = "paperbag_[design_choice][(contents.len == 0) ? null : "_closed"]"
	return ..()

/obj/item/storage/box/papersack/update_desc(updates)
	switch(design_choice)
		if("None")
			desc = "用纸精心制作的袋子。"
		if("NanotrasenStandard")
			desc = "一款标准的纳米传讯纸质午餐袋，适合奔波中的忠诚员工。"
		if("SyndiSnacks")
			desc = "这个纸袋上的图案是臭名昭著的“辛迪加零食”计划留下的遗迹。"
		if("Heart")
			desc = "侧面蚀刻着一颗爱心的纸袋。"
		if("SmileyFace")
			desc = "侧面蚀刻着一个粗糙笑脸的纸袋。"
	return ..()

/obj/item/storage/box/papersack/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	if(IS_WRITING_UTENSIL(tool))
		var/choice = show_radial_menu(user, src , papersack_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user, tool), radius = 36, require_near = TRUE)
		if(!choice || choice == design_choice)
			return ITEM_INTERACT_BLOCKING
		design_choice = choice
		balloon_alert(user, "已修改")
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	if(tool.get_sharpness() && !contents.len)
		if(design_choice == "None")
			user.show_message(span_notice("你在[src]上剪出了眼孔。"), MSG_VISUAL)
			new /obj/item/clothing/head/costume/papersack(drop_location())
			qdel(src)
			return ITEM_INTERACT_SUCCESS
		else if(design_choice == "SmileyFace")
			user.show_message(span_notice("你在[src]上剪出眼孔，并修改了图案。"), MSG_VISUAL)
			new /obj/item/clothing/head/costume/papersack/smiley(drop_location())
			qdel(src)
			return ITEM_INTERACT_SUCCESS
	return ..()

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 * * P The pen used to interact with a menu
 */
/obj/item/storage/box/papersack/proc/check_menu(mob/user, obj/item/pen/P)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	if(contents.len)
		balloon_alert(user, "里面有东西！")
		return FALSE
	if(!P || !user.is_holding(P))
		balloon_alert(user, "需要笔！")
		return FALSE
	return TRUE

/obj/item/storage/box/papersack/meat
	desc = "它微微潮湿，散发着屠宰场的气味。"

/obj/item/storage/box/papersack/meat/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/meat/slab(src)

/obj/item/storage/box/papersack/wheat
	desc = "它有些积灰，散发着谷仓的气味。"

/obj/item/storage/box/papersack/wheat/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/food/grown/wheat(src)

/obj/item/storage/box/ingredients //This box is for the randomly chosen version the chef used to spawn with, it shouldn't actually exist.
	name = "食材盒"
	illustration = "fruit"
	var/theme_name

/obj/item/storage/box/ingredients/Initialize(mapload)
	. = ..()
	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "一盒为有志成为厨师的人准备的辅助食材。这盒的主题是“[theme_name]”。"
		inhand_icon_state = "syringe_kit"

/obj/item/storage/box/ingredients/wildcard
	theme_name = "什锦"

/obj/item/storage/box/ingredients/wildcard/PopulateContents()
	for(var/i in 1 to 7)
		var/random_food = pick(
			/obj/item/food/chocolatebar,
			/obj/item/food/grown/apple,
			/obj/item/food/grown/banana,
			/obj/item/food/grown/cabbage,
			/obj/item/food/grown/carrotlike/carrot,
			/obj/item/food/grown/cherries,
			/obj/item/food/grown/chili,
			/obj/item/food/grown/corn,
			/obj/item/food/grown/cucumber,
			/obj/item/food/grown/mushroom/chanterelle,
			/obj/item/food/grown/mushroom/plumphelmet,
			/obj/item/food/grown/potato,
			/obj/item/food/grown/potato/sweet,
			/obj/item/food/grown/soybeans,
			/obj/item/food/grown/tomato,
		)
		new random_food(src)

/obj/item/storage/box/ingredients/fiesta
	theme_name = "节庆"

/obj/item/storage/box/ingredients/fiesta/PopulateContents()
	new /obj/item/food/tortilla(src)
	for(var/i in 1 to 2)
		new /obj/item/food/grown/chili(src)
		new /obj/item/food/grown/corn(src)
		new /obj/item/food/grown/soybeans(src)

/obj/item/storage/box/ingredients/italian
	theme_name = "意式"

/obj/item/storage/box/ingredients/italian/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/grown/tomato(src)
		new /obj/item/food/meatball(src)
	new /obj/item/reagent_containers/cup/glass/bottle/wine(src)

/obj/item/storage/box/ingredients/vegetarian
	theme_name = "素食"

/obj/item/storage/box/ingredients/vegetarian/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/carrotlike/carrot(src)
	new /obj/item/food/grown/apple(src)
	new /obj/item/food/grown/corn(src)
	new /obj/item/food/grown/eggplant(src)
	new /obj/item/food/grown/potato(src)
	new /obj/item/food/grown/tomato(src)

/obj/item/storage/box/ingredients/american
	theme_name = "美式"

/obj/item/storage/box/ingredients/american/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/corn(src)
		new /obj/item/food/grown/potato(src)
		new /obj/item/food/grown/tomato(src)
	new /obj/item/food/meatball(src)

/obj/item/storage/box/ingredients/fruity
	theme_name = "水果"

/obj/item/storage/box/ingredients/fruity/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/apple(src)
		new /obj/item/food/grown/citrus/orange(src)
	new /obj/item/food/grown/citrus/lemon(src)
	new /obj/item/food/grown/citrus/lime(src)
	new /obj/item/food/grown/melonlike/watermelon(src)

/obj/item/storage/box/ingredients/sweets
	theme_name = "甜点"

/obj/item/storage/box/ingredients/sweets/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/cherries(src)
		new /obj/item/food/grown/banana(src)
	new /obj/item/food/chocolatebar(src)
	new /obj/item/food/grown/apple(src)
	new /obj/item/food/grown/cocoapod(src)

/obj/item/storage/box/ingredients/delights
	theme_name = "美味"

/obj/item/storage/box/ingredients/delights/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/grown/bluecherries(src)
		new /obj/item/food/grown/potato/sweet(src)
	new /obj/item/food/grown/berries(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/food/grown/vanillapod(src)

/obj/item/storage/box/ingredients/grains
	theme_name = "谷物"

/obj/item/storage/box/ingredients/grains/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/grown/oat(src)
	new /obj/item/food/grown/cocoapod(src)
	new /obj/item/food/grown/wheat(src)
	new /obj/item/food/honeycomb(src)
	new /obj/item/seeds/poppy(src)

/obj/item/storage/box/ingredients/carnivore
	theme_name = "肉食"

/obj/item/storage/box/ingredients/carnivore/PopulateContents()
	new /obj/item/food/meat/slab/bear(src)
	new /obj/item/food/meat/slab/corgi(src)
	new /obj/item/food/meat/slab/penguin(src)
	new /obj/item/food/meat/slab/spider(src)
	new /obj/item/food/meat/slab/xeno(src)
	new /obj/item/food/meatball(src)
	new /obj/item/food/spidereggs(src)

/obj/item/storage/box/ingredients/exotic
	theme_name = "异域"

/obj/item/storage/box/ingredients/exotic/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/fishmeat/carp(src)
		new /obj/item/food/grown/cabbage(src)
		new /obj/item/food/grown/soybeans(src)
	new /obj/item/food/grown/chili(src)

/obj/item/storage/box/ingredients/seafood
	theme_name = "海鲜"

/obj/item/storage/box/ingredients/seafood/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/food/fishmeat/armorfish(src)
		new /obj/item/food/fishmeat/carp(src)
		new /obj/item/food/fishmeat/moonfish(src)
	new /obj/item/food/fishmeat/gunner_jellyfish/supply(src)

/obj/item/storage/box/ingredients/salads
	theme_name = "沙拉"

/obj/item/storage/box/ingredients/salads/PopulateContents()
	new /obj/item/food/grown/cabbage(src)
	new /obj/item/food/grown/carrotlike/carrot(src)
	new /obj/item/food/grown/olive(src)
	new /obj/item/food/grown/onion/red(src)
	new /obj/item/food/grown/onion/red(src)
	new /obj/item/food/grown/tomato(src)
	new /obj/item/reagent_containers/condiment/olive_oil(src)

/obj/item/storage/box/ingredients/random
	theme_name = "随机"
	desc = "这个盒子不应该存在，请联系相关部门。"

/obj/item/storage/box/ingredients/random/Initialize(mapload)
	. = ..()
	var/chosen_box = pick(subtypesof(/obj/item/storage/box/ingredients) - /obj/item/storage/box/ingredients/random)
	new chosen_box(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/storage/box/gum
	name = "泡泡糖袋"
	desc = "包装上似乎全是日文，你一个字也看不懂。"
	icon = 'icons/obj/storage/gum.dmi'
	icon_state = "bubblegum_generic"
	w_class = WEIGHT_CLASS_TINY
	illustration = null
	foldable_result = null
	custom_price = PAYCHECK_CREW
	storage_type = /datum/storage/box/gum

	///Typepath of the type of gum that spawns with this box, this is passed to the wrapper for spawning in.
	var/spawning_gum_type = /obj/item/food/bubblegum

/obj/item/storage/box/gum/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/storage/bubblegum_wrapper(src, spawning_gum_type)

/obj/item/storage/box/gum/wake_up
	name = "\improper 活力 12 小时药用口香糖袋"
	desc = "用活力牌，在维修隧道的漫长轮班中保持清醒！包装上印着蛾族游牧舰队的认证印章，\
		还有一大串用蛾族语和银河通用语写成的健康与安全免责声明。"
	icon_state = "bubblegum_wake_up"
	custom_premium_price = PAYCHECK_CREW * 1.5

/obj/item/storage/box/gum/wake_up/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你读了一些健康与安全信息……</i>")
	. += "\t[span_info("用于缓解工作时的疲劳与困倦。")]"
	. += "\t[span_info("每 12 小时不得咀嚼超过一片。不得完全替代睡眠。")]"
	. += "\t[span_info("不得给予 16 岁以下儿童。不得超过最大剂量。请勿吞服。不得连续服用超过 3 天。不得与其他药物同时服用。心脏病患者可能产生不良反应。")]"
	. += "\t[span_info("服用活力可能出现的副作用包括触角抽动、翅膀过度活跃、角质失去光泽、刚毛脱落、心律失常、视物模糊以及欣快感。若出现副作用请停止服用。")]"
	. += "\t[span_info("重复使用可能导致成瘾。")]"
	. += "\t[span_info("若超过最大剂量，请立即告知所属舰船的医疗人员。请勿催吐。")]"
	. += "\t[span_info("成分：每片含 500 毫克活力（右旋甲基苯丙胺）。其他成分包括绿色染料 450（翠绿草甸）和人工草本香精。")]"
	. += "\t[span_info("储存：请置于阴凉干燥处。保质期后请勿使用：32/4/350。")]"
	return .

/obj/item/storage/box/gum/wake_up/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/food/bubblegum/wake_up(src)

/obj/item/storage/bubblegum_wrapper
	name = "泡泡糖纸"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "bubblegum_wrapper"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	item_flags = NOBLUDGEON|SKIP_FANTASY_ON_SPAWN

	///The typepath of the type of gum that will spawn in our PopulateContents,
	///this is set in Initialize by the gum box if there is one.
	var/gum_to_spawn = /obj/item/food/bubblegum

/obj/item/storage/bubblegum_wrapper/Initialize(mapload, spawning_gum_type)
	if(!isnull(spawning_gum_type))
		gum_to_spawn = spawning_gum_type
	. = ..()
	atom_storage.set_holdable(/obj/item/food/bubblegum)
	atom_storage.max_slots = 1
	atom_storage.display_contents = FALSE
	update_appearance(UPDATE_OVERLAYS)

/obj/item/storage/bubblegum_wrapper/grind_results()
	return list(/datum/reagent/aluminium = 1)

/obj/item/storage/bubblegum_wrapper/PopulateContents()
	new gum_to_spawn(src)

/obj/item/storage/bubblegum_wrapper/update_overlays()
	. = ..()
	var/obj/item/food/bubblegum/gum_inside = locate() in contents
	if(isnull(gum_inside))
		return .
	var/mutable_appearance/gum_overlay = mutable_appearance(gum_inside.icon, gum_inside.icon_state, layer = src.layer - 0.01)
	gum_overlay.color = gum_inside.color
	. += gum_overlay

//These procs are copied over from cigarette packets
/obj/item/storage/bubblegum_wrapper/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(istype(interacting_with, /obj/item/food/bubblegum))
		atom_storage.item_interact_insert(user, interacting_with)
		return ITEM_INTERACT_SUCCESS
	if(interacting_with != user)
		return ..()
	quick_remove_item(/obj/item/food/bubblegum, user, equip_to_mouth = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/bubblegum_wrapper/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	quick_remove_item(/obj/item/food/bubblegum, user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/storage/bubblegum_wrapper/click_alt(mob/user)
	quick_remove_item(/obj/item/food/bubblegum, user)
	return CLICK_ACTION_SUCCESS

/obj/item/storage/box/gum/nicotine
	name = "尼古丁口香糖袋"
	desc = "旨在同时帮助戒除尼古丁成瘾和口腔依赖，又不会在这个过程中毁掉你的肺。薄荷味！"
	icon_state = "bubblegum_nicotine"
	custom_premium_price = PAYCHECK_CREW * 1.5
	spawning_gum_type = /obj/item/food/bubblegum/nicotine

/obj/item/storage/box/gum/happiness
	name = "HP+ 口香糖袋"
	desc = "看起来像是自制的包装，气味古怪。上面画着一个吐着舌头的笑脸，画风很诡异。"
	icon_state = "bubblegum_happiness"
	custom_price = PAYCHECK_COMMAND * 3
	custom_premium_price = PAYCHECK_COMMAND * 3
	spawning_gum_type = /obj/item/food/bubblegum/happiness

/obj/item/storage/box/gum/happiness/Initialize(mapload)
	. = ..()
	if (prob(25))
		desc += " 你能隐约辨认出上面曾经潦草写着的“血帕普利”这个词。"

/obj/item/storage/box/gum/bubblegum
	name = "泡泡糖味口香糖袋"
	desc = "包装上似乎全是恶魔语。你觉得光是打开它都像是一种罪过。"
	icon_state = "bubblegum_bubblegum"
	spawning_gum_type = /obj/item/food/bubblegum/bubblegum

/obj/item/storage/box/mothic_rations
	name = "蛾族口粮包"
	desc = "一盒装有少量口粮和一些活力口香糖的盒子，能让饥肠辘辘的蛾子继续撑下去。"
	icon_state = "moth_package"
	illustration = null

/obj/item/storage/box/mothic_rations/PopulateContents()
	for(var/i in 1 to 3)
		var/random_food = pick_weight(list(
			/obj/item/food/sustenance_bar = 10,
			/obj/item/food/sustenance_bar/cheese = 5,
			/obj/item/food/sustenance_bar/mint = 5,
			/obj/item/food/sustenance_bar/neapolitan = 5,
			/obj/item/food/sustenance_bar/wonka = 1,
			))
		new random_food(src)
	new /obj/item/storage/box/gum/wake_up(src)

/obj/item/storage/box/tiziran_goods
	name = "提兹拉农场鲜货包"
	desc = "一盒装有各式提兹拉新鲜货物的盒子——非常适合制作蜥蜴帝国的美食。"
	icon_state = "lizard_package"
	illustration = null

/obj/item/storage/box/tiziran_goods/PopulateContents()
	for(var/i in 1 to 12)
		var/random_food = pick_weight(list(
			/obj/item/food/bread/root = 2,
			/obj/item/food/grown/ash_flora/seraka = 2,
			/obj/item/food/grown/korta_nut = 10,
			/obj/item/food/grown/korta_nut/sweet = 2,
			/obj/item/food/liver_pate = 5,
			/obj/item/food/lizard_dumplings = 5,
			/obj/item/food/moonfish_caviar = 5,
			/obj/item/food/root_flatbread = 5,
			/obj/item/food/rootroll = 5,
			/obj/item/food/spaghetti/nizaya = 5,
			))
		new random_food(src)

/obj/item/storage/box/tiziran_cans
	name = "提兹拉罐头食品包"
	desc = "一盒装有各式提兹拉罐装货物的盒子——可直接食用，也可用于烹饪。"
	icon_state = "lizard_package"
	illustration = null

/obj/item/storage/box/tiziran_cans/PopulateContents()
	for(var/i in 1 to 8)
		var/random_food = pick_weight(list(
			/obj/item/food/canned/jellyfish = 5,
			/obj/item/food/canned/desert_snails = 5,
			/obj/item/food/canned/larvae = 5,
			))
		new random_food(src)

/obj/item/storage/box/tiziran_meats
	name = "提兹拉肉市包"
	desc = "一盒装有各式冷冻提兹拉肉类和鱼类的盒子——蜥蜴料理的关键。"
	icon_state = "lizard_package"
	illustration = null

/obj/item/storage/box/tiziran_meats/PopulateContents()
	for(var/i in 1 to 10)
		var/random_food = pick_weight(list(
			/obj/item/food/fishmeat/armorfish = 5,
			/obj/item/food/fishmeat/gunner_jellyfish = 5,
			/obj/item/food/fishmeat/moonfish = 5,
			/obj/item/food/meat/slab = 5,
			))
		new random_food(src)

/obj/item/storage/box/mothic_goods
	name = "蛾族农场鲜货包"
	desc = "一盒装有各式蛾族烹饪原料的盒子。"
	icon_state = "moth_package"
	illustration = null

/obj/item/storage/box/mothic_goods/PopulateContents()
	for(var/i in 1 to 12)
		var/random_food = pick_weight(list(
			/obj/item/food/cheese/cheese_curds = 5,
			/obj/item/food/cheese/curd_cheese = 5,
			/obj/item/food/cheese/firm_cheese = 5,
			/obj/item/food/cheese/mozzarella = 5,
			/obj/item/food/cheese/wheel = 5,
			/obj/item/food/grown/toechtauese = 10,
			/obj/item/reagent_containers/condiment/cornmeal = 5,
			/obj/item/reagent_containers/condiment/olive_oil = 5,
			/obj/item/reagent_containers/condiment/yoghurt = 5,
			))
		new random_food(src)

/obj/item/storage/box/mothic_cans_sauces
	name = "蛾族食品储藏包"
	desc = "一盒装有各式蛾族罐装食品和成品酱料的盒子。"
	icon_state = "moth_package"
	illustration = null

/obj/item/storage/box/mothic_cans_sauces/PopulateContents()
	for(var/i in 1 to 8)
		var/random_food = pick_weight(list(
			/obj/item/food/bechamel_sauce = 5,
			/obj/item/food/canned/pine_nuts = 5,
			/obj/item/food/canned/tomatoes = 5,
			/obj/item/food/pesto = 5,
			/obj/item/food/tomato_sauce = 5,
			))
		new random_food(src)

/obj/item/storage/box/condimentbottles
	name = "调味瓶盒"
	desc = "上面有一大块番茄酱污渍。"
	illustration = "condiment"

/obj/item/storage/box/condimentbottles/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/condiment(src)


/obj/item/storage/box/coffeepack
	icon_state = "arabica_beans"
	name = "阿拉比卡咖啡豆"
	desc = "一袋新鲜的干燥阿拉比卡咖啡豆。由华夫公司以合乎道德的方式采购并包装。"
	illustration = null
	icon = 'icons/obj/food/containers.dmi'
	storage_type = /datum/storage/box/coffee
	var/beantype = /obj/item/food/grown/coffee

/obj/item/storage/box/coffeepack/PopulateContents()
	for(var/i in 1 to 5)
		var/obj/item/food/grown/coffee/bean = new beantype(src)
		ADD_TRAIT(bean, TRAIT_DRIED, ELEMENT_TRAIT(type))
		bean.add_atom_colour(COLOR_DRIED_TAN, FIXED_COLOUR_PRIORITY) //give them the tan just like from the drying rack

/obj/item/storage/box/coffeepack/robusta
	icon_state = "robusta_beans"
	name = "罗布斯塔咖啡豆"
	desc = "一袋新鲜的干燥罗布斯塔咖啡豆。由华夫公司以合乎道德的方式采购并包装。"
	beantype = /obj/item/food/grown/coffee/robusta

/obj/item/storage/box/ramen_beef
	name = "牛肉太空拉面"
	desc = "一盒装有一块脱水拉面和一小包牛肉味调料。"
	icon_state = "ramen_box"
	illustration = null
	storage_type = /datum/storage/box/ramen_beef
	w_class = WEIGHT_CLASS_SMALL //it's meant to come in packs of five and the box can only hold two items, beef flavour or dry ramen

/obj/item/storage/box/ramen_beef/PopulateContents()
	new /obj/item/reagent_containers/condiment/pack/beef_flavour(src)
	new /obj/item/food/spaghetti/ramen_dry(src)
