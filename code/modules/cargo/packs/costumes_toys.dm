/datum/supply_pack/costumes_toys
	group = "Costumes & Toys"

/datum/supply_pack/costumes_toys/randomised
	name = "收藏帽板条箱"
	desc = "用三顶独特、极具收藏价值的帽子来炫耀你的地位吧！"
	cost = CARGO_CRATE_VALUE * 40
	var/num_contained = 3 //number of items picked to be contained in a randomised crate
	contains = list(/obj/item/clothing/head/collectable/chef,
					/obj/item/clothing/head/collectable/paper,
					/obj/item/clothing/head/collectable/tophat,
					/obj/item/clothing/head/collectable/captain,
					/obj/item/clothing/head/collectable/beret,
					/obj/item/clothing/head/collectable/welding,
					/obj/item/clothing/head/collectable/flatcap,
					/obj/item/clothing/head/collectable/pirate,
					/obj/item/clothing/head/collectable/kitty,
					/obj/item/clothing/head/collectable/rabbitears,
					/obj/item/clothing/head/collectable/wizard,
					/obj/item/clothing/head/collectable/hardhat,
					/obj/item/clothing/head/collectable/hos,
					/obj/item/clothing/head/collectable/hop,
					/obj/item/clothing/head/collectable/thunderdome,
					/obj/item/clothing/head/collectable/swat,
					/obj/item/clothing/head/collectable/slime,
					/obj/item/clothing/head/collectable/police,
					/obj/item/clothing/head/collectable/slime,
					/obj/item/clothing/head/collectable/xenom,
					/obj/item/clothing/head/collectable/petehat,
				)
	crate_name = "收藏帽板条箱"
	crate_type = /obj/structure/closet/crate/wooden
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE
	test_ignored = TRUE

/datum/supply_pack/costumes_toys/randomised/fill(obj/container)
	var/list/L = contains.Copy()
	for(var/i in 1 to num_contained)
		var/item = pick_n_take(L)
		new item(container)

/datum/supply_pack/costumes_toys/formalwear
	name = "正装板条箱"
	desc = "你会喜欢自己这副模样的，我保证。内含一大堆花哨衣物。"
	cost = CARGO_CRATE_VALUE * 4 //Lots of very expensive items. You gotta pay up to look good!
	contains = list(/obj/item/clothing/under/dress/tango,
					/obj/item/clothing/under/misc/assistantformal = 2,
					/obj/item/clothing/under/rank/civilian/lawyer/bluesuit,
					/obj/item/clothing/suit/toggle/lawyer,
					/obj/item/clothing/under/rank/civilian/lawyer/purpsuit,
					/obj/item/clothing/suit/toggle/lawyer/purple,
					/obj/item/clothing/suit/toggle/lawyer/black,
					/obj/item/clothing/accessory/waistcoat,
					/obj/item/clothing/neck/tie/blue,
					/obj/item/clothing/neck/tie/red,
					/obj/item/clothing/neck/tie/black,
					/obj/item/clothing/head/hats/bowler,
					/obj/item/clothing/head/fedora,
					/obj/item/clothing/head/flatcap,
					/obj/item/clothing/head/beret,
					/obj/item/clothing/head/hats/tophat,
					/obj/item/clothing/shoes/laceup = 3,
					/obj/item/clothing/under/suit/charcoal,
					/obj/item/clothing/under/suit/navy,
					/obj/item/clothing/under/suit/burgundy,
					/obj/item/clothing/under/suit/checkered,
					/obj/item/clothing/under/suit/tan,
					/obj/item/lipstick/random,
				)
	crate_name = "正装板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/clownpin
	name = "搞笑撞针板条箱"
	desc = "我呃……我也不太确定这是干什么的。要买吗？"
	cost = CARGO_CRATE_VALUE * 10
	order_flags = ORDER_CONTRABAND
	contains = list(/obj/item/firing_pin/clown)
	crate_name = "玩具板条箱" // It's /technically/ a toy. For the clown, at least.
	crate_type = /obj/structure/closet/crate/wooden
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/costumes_toys/lasertag
	name = "激光对战板条箱"
	desc = "泡沫枪是男孩玩的。激光对战是男人玩的。内含三套红色队服、蓝色队服、\
		配套头盔以及配套激光对战枪。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/gun/energy/laser/redtag = 3,
					/obj/item/gun/energy/laser/bluetag = 3,
					/obj/item/clothing/suit/redtag = 3,
					/obj/item/clothing/suit/bluetag = 3,
					/obj/item/clothing/head/helmet/taghelm/blue = 3,
					/obj/item/clothing/head/helmet/taghelm/red = 3,
				)
	crate_name = "激光对战板条箱"

/datum/supply_pack/costumes_toys/knucklebones
	name = "羊拐骨游戏板条箱"
	desc = "一款有趣的骰子游戏，绝对不是一个邪教发明的。关于获准的宗教活动，\
		请咨询你当地的牧师。内含十八颗 d6 骰子、一根粉笔以及游戏玩法说明。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/dice/d6 = 18,
					/obj/item/paper/guides/knucklebone,
					/obj/item/toy/crayon/white,
				)
	crate_name = "羊拐骨游戏板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/lasertag/pins
	name = "激光对战撞针板条箱"
	desc = "三枚用于激光对战装备的激光对战撞针，可确保使用者穿着对战背心。"
	cost = CARGO_CRATE_VALUE * 3.5
	order_flags = ORDER_CONTRABAND
	contains = list(/obj/item/storage/box/lasertagpins)
	crate_name = "激光对战板条箱"

/datum/supply_pack/costumes_toys/mech_suits
	name = "机甲驾驶员服装板条箱"
	desc = "用于驾驶大型机器人的服装。内含四件！"
	cost = CARGO_CRATE_VALUE * 3 //state-of-the-art technology doesn't come cheap
	contains = list(/obj/item/clothing/under/costume/mech_suit = 4)
	crate_name = "机甲驾驶员服装板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/costume_original
	name = "经典服装板条箱"
	desc = "用这一批服装重演莎士比亚戏剧。内含八种不同的服装！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/clothing/head/costume/snowman,
					/obj/item/clothing/suit/costume/snowman,
					/obj/item/clothing/head/costume/chicken,
					/obj/item/clothing/suit/costume/chickensuit,
					/obj/item/clothing/mask/gas/monkeymask,
					/obj/item/clothing/suit/costume/monkeysuit,
					/obj/item/clothing/head/costume/cardborg,
					/obj/item/clothing/suit/costume/cardborg,
					/obj/item/clothing/head/costume/xenos,
					/obj/item/clothing/suit/costume/xenos,
					/obj/item/clothing/suit/hooded/ian_costume,
					/obj/item/clothing/suit/hooded/carp_costume,
					/obj/item/clothing/suit/hooded/bee_costume,
				)
	crate_name = "经典服装板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/costume
	name = "标准服装板条箱"
	desc = "用这些经纳米传讯认可的服装，为站内表演者提供他们这行所需的\
		装备！内含一整套小丑与哑剧演员服装，外加一个\
		自行车喇叭和一瓶虚无。"
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_THEATRE
	contains = list(/obj/item/storage/backpack/clown,
					/obj/item/clothing/shoes/clown_shoes,
					/obj/item/clothing/mask/gas/clown_hat,
					/obj/item/clothing/under/rank/civilian/clown,
					/obj/item/bikehorn,
					/obj/item/clothing/under/rank/civilian/mime,
					/obj/item/clothing/shoes/sneakers/black,
					/obj/item/clothing/gloves/color/white,
					/obj/item/clothing/mask/gas/mime,
					/obj/item/clothing/head/beret/frenchberet,
					/obj/item/clothing/suit/toggle/suspenders,
					/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing,
					/obj/item/storage/backpack/mime,
				)
	crate_name = "标准服装板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/costume/fill(obj/container)
	..()
	var/funny_gas_internals
	funny_gas_internals = pick(subtypesof(/obj/item/tank/internals/emergency_oxygen/engi/clown) - /obj/item/tank/internals/emergency_oxygen/engi/clown)
	new funny_gas_internals(container)

/datum/supply_pack/costumes_toys/randomised/toys
	name = "玩具板条箱"
	desc = "谁在乎自豪感与成就感？跳过游玩过程，直接享受这产品带来的\
		甜蜜奖励吧！内含五个随机玩具。若用于恶作剧\
		科研主管，保修失效。"
	cost = CARGO_CRATE_VALUE * 8 // or play the arcade machines ya lazy bum
	num_contained = 5
	contains = list()
	crate_name = "玩具板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/randomised/toys/fill(obj/container)
	var/the_toy
	for(var/i in 1 to num_contained)
		if(prob(50))
			the_toy = pick_weight_recursive(GLOB.arcade_prize_pool) //BUBBERSTATION CHANGE: USES PICK_WEIGHT_RECURSIVE
		else
			the_toy = /obj/effect/spawner/random/entertainment/plushie_delux
		new the_toy(container)

/datum/supply_pack/costumes_toys/wizard
	name = "巫师服装板条箱"
	desc = "用这套完整的巫师装束假装加入了巫师联邦！纳米传讯希望提醒\
		其员工：真正加入巫师联邦会导致职务及生命被终止。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/staff,
					/obj/item/clothing/suit/wizrobe/fake,
					/obj/item/clothing/shoes/sandal,
					/obj/item/clothing/head/wizard/fake,
				)
	crate_name = "巫师服装板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/trekkie
	name = "星际迷服装板条箱"
	desc = "穿上纳米传讯十二款连体工作服的废弃设计，其灵感源自二十世纪末\
		地球的流行媒体！虽然这些设计因版权侵权无法用于官方连体工作服，\
		但已有人保证，它们仍可合法地以“失败设计”的名义\
		出售。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/clothing/under/trek/command,
		/obj/item/clothing/under/trek/command/next,
		/obj/item/clothing/under/trek/command/voy,
		/obj/item/clothing/under/trek/command/ent,
		/obj/item/clothing/under/trek/engsec,
		/obj/item/clothing/under/trek/engsec/next,
		/obj/item/clothing/under/trek/engsec/voy,
		/obj/item/clothing/under/trek/engsec/ent,
		/obj/item/clothing/under/trek/medsci,
		/obj/item/clothing/under/trek/medsci/next,
		/obj/item/clothing/under/trek/medsci/voy,
		/obj/item/clothing/under/trek/medsci/ent,
	)
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/costumes_toys/randomised/tcg
	name = "超大补充包礼包"
	desc = "满满一大堆纳米传讯集换式卡牌补充包，涵盖多个系列。把它们全收集齐吧！"
	cost = 1000
	contains = list()
	crate_name = "补充包礼包"
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/costumes_toys/randomised/tcg/fill(obj/container)
	var/cardpacktype
	for(var/i in 1 to 10)
		cardpacktype = pick(subtypesof(/obj/item/cardpack))
		new cardpacktype(container)

/datum/supply_pack/costumes_toys/stickers
	name = "贴纸包板条箱"
	desc = "这个板条箱内装有随机搭配的贴纸。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list()
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/costumes_toys/stickers/fill(obj/structure/closet/crate/crate)
	for(var/i in 1 to rand(1, 2))
		new /obj/item/storage/box/stickers(crate)

	if(prob(30)) // a pair of googly eyes because funny
		new /obj/item/storage/box/stickers/googly(crate)

/datum/supply_pack/costumes_toys/pinata
	name = "柯基皮纳塔套装"
	desc = "这个板条箱内装有一个装满糖果的皮纳塔、一条蒙眼布和一根用来砸开它的球棒。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/pinata,
		/obj/item/melee/baseball_bat,
		/obj/item/clothing/glasses/blindfold,
	)
	crate_name = "柯基皮纳塔套装"
	crate_type = /obj/structure/closet/crate/wooden
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/costumes_toys/balloons
	name = "长条气球套装"
	desc = "这个板条箱内装有一盒长条气球，外加一枚让非小丑也能加入欢乐的技能芯片！多一层安全保障，中央指挥部的小丑可拿不到它们。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/storage/box/balloons,
		/obj/item/skillchip/job/clown,
	)
	crate_name = "长条气球套装"
	crate_type = /obj/structure/closet/crate/wooden
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/costumes_toys/christmas
	name = "剩余圣诞礼物"
	desc = "这个板条箱内装有预先包装好、寄给站内员工的礼物，作为提升士气计划的一部分从纳米传讯的剩余物资中随机抽取。"
	cost = CARGO_CRATE_VALUE * 30
	contains = list()
	order_flags = ORDER_SPECIAL
	crate_type = /obj/structure/closet/crate/mail
	discountable = SUPPLY_PACK_NOT_DISCOUNTABLE

/datum/supply_pack/costumes_toys/christmas/fill(obj/structure/closet/crate/crate)
	var/list/mail_recipients = list()
	for(var/mob/living/carbon/human/human in GLOB.player_list)
		if(human.stat == DEAD || !human.mind)
			continue
		// Skip wizards, nuke ops, cyborgs; They're not written down as employees
		if(!(human.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
			continue
		mail_recipients += human.mind

	for (var/i in 1 to rand(4, 6))
		var/obj/item/gift/anything/gift = new(crate)
		var/datum/mind/recipient = pick_n_take(mail_recipients)
		if(recipient)
			gift.assign_recipient(recipient)
		else
			qdel(gift)
			break

	var/obj/item/delivery/big/parcel = new(crate.loc)
	parcel.base_icon_state = crate.delivery_icon
	parcel.giftwrapped = TRUE
	parcel.update_icon()
	parcel.drag_slowdown = crate.drag_slowdown
	crate.forceMove(parcel)
	parcel.name = "圣诞礼物"
