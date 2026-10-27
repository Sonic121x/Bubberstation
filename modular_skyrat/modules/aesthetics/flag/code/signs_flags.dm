/obj/structure/sign/flag
	name = "空白旗帜"
	desc = "虚空之旗。上面什么都没有。壮丽至极。"
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "flag_coder"
	buildable_sign = FALSE
	custom_materials = null
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
			return
		if(!user.can_perform_action(src, NEED_DEXTERITY))
			return
		user.visible_message(span_notice("[user] 抓住[src.name]并将其折叠起来。"), span_notice("你抓住[src.name]并将其折叠起来。"))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
		qdel(src)

/obj/structure/sign/flag/ssc
	name = "阿库拉民主联盟旗帜"
	desc = "阿库拉民主联盟的旗帜。一面由骄傲民族高举的旗帜，象征他们来自并将最终回归的海洋。"
	icon_state = "flag_agurk"
	item_flag = /obj/item/sign/flag/ssc

/obj/structure/sign/flag/nanotrasen
	name = "纳米传讯旗帜"
	desc = "纳米传讯的官方企业旗帜。多用于仪式场合，或在新边疆宣示土地所有权。"
	icon_state = "flag_nt"
	item_flag = /obj/item/sign/flag/nanotrasen

/obj/structure/sign/flag/tizira
	name = "北莫格斯共和国旗帜"
	desc = "北莫格斯大共和国的旗帜。取决于你问谁，它象征着力量，或是蜂巢中一只蚂蚁的存在。"
	icon_state = "flag_tizira"
	item_flag = /obj/item/sign/flag/tizira

/obj/structure/sign/flag/mothic
	name = "蛾族大游牧舰队旗帜"
	desc = "蛾族大游牧舰队的旗帜。一面经典的海军军旗，其使用已取代旧国旗，旧国旗仍可在旗角看到。"
	icon_state = "flag_mothic"
	item_flag = /obj/item/sign/flag/mothic

/obj/structure/sign/flag/mars
	name = "特沙利自决联盟旗帜"
	desc = "特沙利自决联盟的旗帜。它最初是金羽共和国时期的革命旗帜，后来被采用为该星球的官方旗帜，以纪念特沙利人为代表权与独立而进行的抗争。"
	icon_state = "flag_mars"
	item_flag = /obj/item/sign/flag/mars

/obj/structure/sign/flag/terragov
	name = "地球政府旗帜"
	desc = "地球政府的旗帜。无论人类身在何处，也无论他们多么不愿承认，它都是人类的象征。"
	icon_state = "flag_terragov"
	item_flag = /obj/item/sign/flag/terragov

/obj/structure/sign/flag/nri
	name = "泛斯拉夫联邦旗帜"
	desc = "泛斯拉夫联邦的旗帜。蓝、白、红三色泛斯拉夫色，早在 1848 年就于地球确立。"
	icon_state = "flag_nri"
	item_flag = /obj/item/sign/flag/nri

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/nri, 32)

/obj/structure/sign/flag/azulea
	name = "阿库拉民主联盟横幅"
	desc = "阿库拉人常自豪悬挂的横幅，表达他们对本民族的热爱。常成对悬挂于指挥场所。"
	icon_state = "flag_azulea"
	item_flag = /obj/item/sign/flag/azulea

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/azulea, 32)

/// Please, for the love of God, use this in Black Mesa ONLY. NOWHERE ELSE. It's the only reason it was allowed in the game.
/obj/structure/sign/flag/usa
	name = "美利坚合众国国旗"
	desc = "“星条旗”，美利坚合众国的国旗。红色代表坚韧与英勇；蓝色代表勤勉、警觉与正义；白色代表纯洁。十三道红白条纹代表最初建国的十三个殖民地，五十颗星代表当前的五十个州。"
	icon_state = "flag_usa"
	item_flag = /obj/item/sign/flag/usa

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/syndicate
	name = "辛迪加旗帜"
	desc = "索斯兰辛迪加的旗帜。它曾被索斯兰人用来表达对纳米传讯的反抗，如今已成为跨星系的同一象征，但目的已被大幅扭曲，因为越来越多利益集团为了自身利益加入了叛乱一方。"
	icon_state = "flag_syndi"
	item_flag = /obj/item/sign/flag/syndicate

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/syndicate, 32)

/obj/item/sign/flag
	name = "折叠的空白旗帜"
	desc = "折叠的虚空之旗。上面什么都没有。美极了。"
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "folded_coder"
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE
	custom_materials = null

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/item/sign/flag/nanotrasen
	name = "折叠的纳米传讯旗帜"
	desc = "折叠的纳米传讯旗帜。"
	icon_state = "folded_nt"
	sign_path = /obj/structure/sign/flag/nanotrasen

/obj/item/sign/flag/ssc
	name = "折叠的阿库拉民主联盟旗帜"
	desc = "折叠的阿库拉民主联盟旗帜。"
	icon_state = "folded_agurk"
	sign_path = /obj/structure/sign/flag/ssc

/obj/item/sign/flag/terragov
	name = "折叠的地球政府旗帜"
	desc = "折叠的地球政府旗帜。"
	icon_state = "folded_terragov"
	sign_path = /obj/structure/sign/flag/terragov

/obj/item/sign/flag/tizira
	name = "折叠的北莫格斯共和国旗帜"
	desc = "折叠的北莫格斯共和国旗帜。"
	icon_state = "folded_tizira"
	sign_path = /obj/structure/sign/flag/tizira

/obj/item/sign/flag/mothic
	name = "折叠的蛾族大游牧舰队旗帜"
	desc = "折叠的蛾族大游牧舰队旗帜。"
	icon_state = "folded_mothic"
	sign_path = /obj/structure/sign/flag/mothic

/obj/item/sign/flag/mars
	name = "折叠的特沙利自决联盟旗帜"
	desc = "折叠的特沙利自决联盟旗帜。"
	icon_state = "folded_mars"
	sign_path = /obj/structure/sign/flag/mars

/obj/item/sign/flag/nri
	name = "折叠的泛斯拉夫联邦旗帜"
	desc = "折叠的泛斯拉夫联邦旗帜。"
	icon_state = "folded_nri"
	sign_path = /obj/structure/sign/flag/nri

/obj/item/sign/flag/azulea
	name = "折叠的阿库拉民主联盟横幅"
	desc = "折叠的阿库拉民主联盟横幅。"
	icon_state = "folded_azulea"
	sign_path = /obj/structure/sign/flag/azulea

/// Please, for the love of God, use this in Black Mesa ONLY. NOWHERE ELSE. It's the only reason it was allowed in the game.
/obj/item/sign/flag/usa
	name = "折叠的美利坚合众国国旗"
	desc = "折叠的美利坚合众国国旗。"
	icon_state = "folded_usa"
	sign_path = /obj/structure/sign/flag/usa

/obj/item/sign/flag/syndicate
	name = "折叠的辛迪加旗帜"
	desc = "折叠的索斯兰辛迪加旗帜。"
	icon_state = "folded_syndi"
	sign_path = /obj/structure/sign/flag/syndicate
