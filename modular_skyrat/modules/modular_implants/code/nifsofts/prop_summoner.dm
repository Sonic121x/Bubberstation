#define SUMMONED_ITEM_ALPHA 180
#define SUMMONED_ITEM_LIGHT 2

/obj/item/disk/nifsoft_uploader/summoner
	name = "蔚蓝魔典"
	loaded_nifsoft = /datum/nifsoft/summoner
	custom_price = PAYCHECK_CREW * 3

/obj/item/disk/nifsoft_uploader/summoner/ghost
	custom_price = 0

/datum/nifsoft/summoner
	name = "蔚蓝魔典"
	program_desc = "蔚蓝魔典是一份开源、虚拟、去中心化的可召唤物品目录，最初由交错空间巫团开发——那是一群后异教时代的女巫，于 2544 年首次被数字化为印痕。这些可召唤的构装体被称为“图标”，由精细的纳米机器图案构成，作为硬光的框架与投影器；“Caeruleam”之名源自图标在召唤者手中投下的蓝光。尽管魔典至今已服务过数千人，但企业势力封锁了所有能够损害其资产的图标。"
	cooldown = TRUE
	activation_cost = 100 // Around 1/10th the energy of a standard NIF
	buying_category = NIFSOFT_CATEGORY_FUN
	ui_icon = "book-open"
	able_to_keep = TRUE // These NIFSofts are mostly for comsetic/fun reasons anyways.

	/// Does the resulting object have a holographic like filter appiled to it?
	var/holographic_filter = TRUE
	/// Is there any special tag added at the begining of the resulting object name?
	var/name_tag = "蔚蓝"
	purchase_price = 175

	///The list of items that can be summoned from the NIFSoft.
	var/list/summonable_items = list(
		/obj/item/toy/katana/nanite,
		/obj/item/cane/nanite,
		/obj/item/storage/dice/nanite,
		/obj/item/toy/cards/deck/nanite,
		/obj/item/toy/cards/deck/tarot/nanite, //The arcana is the means by which all is revealed
		/obj/item/toy/cards/deck/kotahi/nanite,
		/obj/item/toy/foamblade/nanite,
		/obj/item/cane/white/nanite,
		/obj/item/lighter/nanite,
		/obj/item/holocigarette/nanite,
	)

	///The objects currently summoned by the NIFSoft
	var/list/summoned_items = list()
	///What is the maximum amount of items that can be suummoned?
	var/max_summoned_items = 5

/datum/nifsoft/summoner/activate()
	. = ..()
	if(!.)
		return FALSE

	if(tgui_alert(linked_mob, "你想召唤一件新物品，还是取消已存在的物品？", program_name, list("召唤", "取消召唤")) == "取消召唤")
		refund_activation_cost()
		if(!length(summoned_items))
			linked_mob.balloon_alert(linked_mob, "你没有已召唤的物品！")
			return FALSE

		var/obj/item/choice = tgui_input_list(linked_mob, "选择要取消召唤的物品。", program_name, summoned_items)

		if(!choice)
			linked_mob.balloon_alert(linked_mob, "你没有选择任何物品！")
			return FALSE

		summoned_items -= choice
		qdel(choice)
		return TRUE

	if(length(summoned_items) >= max_summoned_items)
		linked_mob.balloon_alert(linked_mob, "你已召唤到物品数量上限！")
		refund_activation_cost()
		return FALSE

	var/list/summon_choices = list()
	for(var/obj/item/summon_item as anything in summonable_items)
		var/image/obj_icon = image(icon = initial(summon_item.icon), icon_state = initial(summon_item.icon_state))

		summon_choices[summon_item] = obj_icon

	var/obj/item/choice = show_radial_menu(linked_mob, linked_mob, summon_choices, radius = 42, custom_check = CALLBACK(src, PROC_REF(check_menu), linked_mob))
	if(!choice)
		refund_activation_cost()
		return FALSE

	var/obj/item/new_item = new choice
	new_item.name = name_tag + new_item.name

	if(!linked_mob.put_in_hands(new_item))
		linked_mob.balloon_alert(linked_mob, "[new_item] 未能在你手中成形！")
		qdel(new_item)
		refund_activation_cost()
		return FALSE

	apply_custom_properties(new_item)
	summoned_items += new_item
	new_item.AddComponent(/datum/component/summoned_item, holographic_filter)

/// This proc is called while an item is being summoned, use this to modifiy aspects of the item that aren't modified by the component.
/datum/nifsoft/summoner/proc/apply_custom_properties(obj/item/target_item)
	if(!target_item)
		return FALSE

	return TRUE

/datum/nifsoft/summoner/Destroy()
	QDEL_LIST(summoned_items)
	return ..()

///Can the person using the NIFSoft summon an item?
/datum/nifsoft/summoner/proc/check_menu(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE

	return TRUE

/datum/component/summoned_item
	///What items were contained, if any, inside of the summoned item? These are deleted when the item is desummoned.
	var/list/sub_items = list()

/datum/component/summoned_item/Initialize(holographic_filter = TRUE)
	. = ..()
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/summoned_item = parent
	if(holographic_filter)
		summoned_item.alpha = SUMMONED_ITEM_ALPHA
		summoned_item.set_light(SUMMONED_ITEM_LIGHT)
		summoned_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)

		if(istype(summoned_item, /obj/item/storage))
			for(var/obj/item/stored_item as anything in summoned_item)
				stored_item.alpha = SUMMONED_ITEM_ALPHA
				stored_item.set_light(SUMMONED_ITEM_LIGHT)
				stored_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)
				sub_items += stored_item

		if(istype(summoned_item, /obj/item/toy/cards/deck))
			var/obj/item/toy/cards/deck/summoned_deck = summoned_item
			var/list/cardlist = summoned_deck.fetch_card_atoms()
			if(!cardlist)
				return FALSE

			for(var/obj/item/toy/single_card in cardlist)
				single_card.alpha = SUMMONED_ITEM_ALPHA
				single_card.set_light(SUMMONED_ITEM_LIGHT)
				single_card.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)
				sub_items += single_card

/datum/component/summoned_item/Destroy(force, silent)
	for(var/obj/item in sub_items)
		sub_items -= item
		qdel(item)

	return ..()

//Summonable Items
///A somehow wekaer version of the toy katana
/obj/item/toy/katana/nanite
	name = "咒刃"
	special_desc = "最早向蔚蓝魔典代码库贡献内容的群体之一，是马拉泰斯塔决斗者——一群雇佣兵兼哲学家，追求成为“切割”这门首要技艺无可争议的大师。这些图标最初意在生成完美锋利、完美不可折断，且完美胜任“获准行动”——即切割——的刀刃。然而，这些“钝化”的道具图标只不过是决斗者最初开发成果的一道影子，也是星际法律允许平民持有的唯一版本；通常出现在展会现场，或握在那些想无风险切磋的人手中。"
	force = 0
	throwforce = 0

/obj/item/storage/dice/nanite
	name = "骰子套装"
	special_desc = "一套精美骰子的华丽复制品。其原型是一套两百多年前用稀有月晶雕成的骰子，原为塞勒涅战棋学会所有。虽然除首席游戏主持人外，任何人都不被允许掷出原套骰子中的哪怕一枚，但该学会仍慷慨地将虚拟复制品捐赠给交错空间巫团的代码库，以感谢其在更多真人角色扮演形式中提供的帮助。"

/obj/item/toy/cards/deck/nanite
	name = "主牌组"
	special_desc = "又一件由塞勒涅战棋学会慷慨捐赠的游戏装备。这些卡牌使用了近乎隐形的纳米机器局部场，并配备先进的眼动追踪软件，以确保卡牌显示无法被偷看。此外，标准五十二张牌组支持超过五十万种变化，涵盖所有已知文字。"

/obj/item/toy/cards/deck/tarot/nanite
	name = "塔罗牌组"
	special_desc = "这副七十八张的牌组历来为神秘学家与秘术师所用，例如交错空间巫团的女巫们。它既包含大阿卡纳的宏大奥秘，也包含小阿卡纳的细微奥秘，整副牌组是纸牌占卜的关键工具；据说这些牌能洞察过去、现在与未来。用它占卜的人会询问各式各样的话题，从健康到经济问题无所不包，但巫团则用它作为指引自身灵性道路的工具，并声称这些可由数字召唤的卡牌所具有的非物质特性，能让占卜者对命运本身更为敏感。"

/obj/item/toy/cards/deck/kotahi/nanite
	name = "科塔希牌组"
	special_desc = "长途货船上玩科塔希！低轨道上玩科塔希！地板上玩科塔希！前所未有的科塔希！近六百年来，科塔希作为银河第一的接龙类卡牌游戏，始终统治着卡牌游戏品类！但如何才能让这个深受数千智慧生命喜爱的品牌更上一层楼？在塞勒涅战棋学会的合作下，我们把科塔希带上了全新的赛场：可数字召唤的科塔希卡牌，只需低至 200cr——现在你知道我们为什么称它为第一了。"

/obj/item/cane/nanite
	name = "手杖"
	special_desc = "该程序由互助团体“智慧生命权利恢复协会”贡献，该协会分布于地球东部大陆的许多地区。蔚蓝手杖使用的纳米机器多于全息影像，因此拥有坚固的核心与稳定的杖尖，供残障人士使用。通过大量音效提示帮助召唤者浏览菜单，也为因意外、先天或生理原因失明的人士开发了一套方案。"

	force = 0
	throwforce = 0

/obj/item/cane/white/nanite
	name = "白色手杖"
	special_desc = "该程序由互助团体“智慧生命权利恢复协会”贡献，该协会分布于地球东部大陆的许多地区。蔚蓝手杖使用的纳米机器多于全息影像，因此拥有坚固的核心与稳定的杖尖，供残障人士使用。通过大量音效提示帮助召唤者浏览菜单，也为因意外、先天或生理原因失明的人士开发了一套方案。"

	force = 0
	throwforce = 0

/obj/item/toy/foamblade/nanite
	name = "臂刃"
	special_desc = "这个图标是有点非法地泄露到魔典上的。它最初由一名即将离开的猛虎合作社成员上传，下载说明告知召唤者，该图标最初被该教派用于“为他们的生物飞升”做准备，使其转变为变形实体。数小时内，针对各种智慧生命肢体构型的多个变体便被分叉并上传，而这一版是完全非致命的。"

/obj/item/lighter/nanite
	name = "捕焰"
	special_desc = "以普通图标的标准来看，这是一件艺术品：它由一位召唤者连续五年打磨而成；在少数拥有实体的交错空间巫团成员采用该图标后，此人如今被称为“逆位新人”。这件印痕作品利用纳米机器点燃大气中的氢分子，图标散发的蓝光源自完美而充分的燃烧。这让打火机的功能与普通 Zippo 完全一致，其描述写道：“……可用于点燃壁炉、蜡烛与熏香；如果能在网上订购，试试白鼠尾草，只求它别把印痕驱散了，哈哈。”"

/obj/item/holocigarette/nanite
	name = "云棒"
	special_desc = "这是人类终结“大烟草”遗产的众多尝试之一。它由一位完全匿名的印痕贡献，随后被分叉无数次，复制出无数品牌与口味，因此“云棒”更像一个品类而非单一图标。大多数可下载版本甚至允许召唤者调整烟雾的像素化程度，以获得与真烟更为“疏离”的体验。不少召唤者反馈这些有助于戒烟，另一些人则只是评论说：“这就是我最初下载捕焰的原因。”"


#undef SUMMONED_ITEM_ALPHA
#undef SUMMONED_ITEM_LIGHT
