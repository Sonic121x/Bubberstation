/obj/item/storage/backpack/satchel/flat/PopulateContents()
	var/contraband_list = list(
		/obj/item/storage/belt/utility/syndicate = 1,
		/obj/item/storage/toolbox/syndicate = 7,
		/obj/item/card/id/advanced/chameleon = 6,
		/obj/item/stack/spacecash/c5000 = 3,
		/obj/item/stack/telecrystal = 2,
		/obj/item/storage/belt/military = 12,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 8,
		/obj/item/storage/box/fireworks/dangerous = 11,
		/obj/item/clothing/mask/gas/syndicate = 10,
		/obj/item/vending_refill/donksoft = 13,
		/obj/item/ammo_box/foambox/riot = 11,
		/obj/item/soap/syndie = 7,
		/obj/item/reagent_containers/crackbrick = 5,
		/obj/item/reagent_containers/crack = 10,
		/obj/item/reagent_containers/cocaine = 9,
		/obj/item/reagent_containers/cocainebrick = 4,
		/obj/item/reagent_containers/hashbrick = 13, //not contraband, but it'll be good padding, and there'll still be a black market for bulk goods
		/obj/item/reagent_containers/heroin = 8,
		/obj/item/reagent_containers/heroinbrick = 3,
		/obj/item/reagent_containers/blacktar = 12,
		/obj/item/storage/pill_bottle/stimulant = 9, //ephedrine and coffee. Can actually change whether someone gets out of a runaway situation
		/obj/item/cigarette/pipe/crackpipe = 15,
		/obj/item/toy/cards/deck/syndicate = 10, //1tc, not balance breaking, small but premium commodity
		/obj/item/reagent_containers/cup/bottle/morphine = 8,
		/obj/item/reagent_containers/syringe/contraband/methamphetamine = 12,
		/obj/item/clothing/glasses/sunglasses = 5, //can already be achieved in an arguably better form with just some hacking
	)

	for(var/i in 1 to 3)
		var/contraband_type = pick_weight(contraband_list)
		contraband_list -= contraband_type
		new contraband_type(src)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/iron/base(src)
	new /obj/item/crowbar(src)

/*
 * Messenger Bag Types
 */

/obj/item/storage/backpack/messenger
	name = "邮差包"
	desc = "一款外观时髦的邮差包；有时也被称为快递包。时尚又便携。"
	icon_state = "messenger"
	inhand_icon_state = "messenger"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'

/obj/item/storage/backpack/messenger/eng
	name = "工业邮差包"
	desc = "一款坚固的邮差包，采用经过高级处理的防火皮革制成。它的口袋也比普通款式更多。"
	icon_state = "messenger_engineering"
	inhand_icon_state = "messenger_engineering"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/med
	name = "医疗邮差包"
	desc = "一款无菌邮差包，因其便携与流线外形而深受医疗人员喜爱。"
	icon_state = "messenger_medical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/vir
	name = "病毒学家邮差包"
	desc = "一款采用病毒学家配色的无菌邮差包，便于以创纪录的速度投放生物危害物。"
	icon_state = "messenger_virology"
	inhand_icon_state = "messenger_virology"

/obj/item/storage/backpack/messenger/chem
	name = "化学家邮差包"
	desc = "一款采用化学家配色的无菌邮差包，适合准时赶赴你的小巷交易。"
	icon_state = "messenger_chemistry"
	inhand_icon_state = "messenger_chemistry"

/obj/item/storage/backpack/messenger/coroner
	name = "验尸官邮差包"
	desc = "一款用于从墓地悄悄溜出、还能保持不错速度的邮差包。"
	icon_state = "messenger_coroner"
	inhand_icon_state = "messenger_coroner"

/obj/item/storage/backpack/messenger/gen
	name = "基因学家邮差包"
	desc = "一款采用基因学家配色的无菌邮差包，对绿巨人来说是个格外可爱的配饰。"
	icon_state = "messenger_genetics"
	inhand_icon_state = "messenger_genetics"

/obj/item/storage/backpack/messenger/science
	name = "科学家邮差包"
	desc = "适合存放研究材料，也能让你更快赶往各个扫描目标。"
	icon_state = "messenger_science"
	inhand_icon_state = "messenger_science"

/obj/item/storage/backpack/messenger/hyd
	name = "植物学家邮差包"
	desc = "一款由全天然纤维制成的邮差包，很适合准时赶上聚会。"
	icon_state = "messenger_hydroponics"
	inhand_icon_state = "messenger_hydroponics"

/obj/item/storage/backpack/messenger/sec
	name = "安保邮差包"
	desc = "一款坚固的邮差包，满足安保相关需求。"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	icon_state = "messenger_security"
	inhand_icon_state = "messenger_security"

/obj/item/storage/backpack/messenger/explorer
	name = "探险家邮差包"
	desc = "一款坚固的邮差包，可用来藏匿战利品，也能为你那身龙骨护甲增添一份格外可爱的点缀。"
	icon_state = "messenger_explorer"
	inhand_icon_state = "messenger_explorer"

/obj/item/storage/backpack/messenger/cap
	name = "舰长的邮差包"
	desc = "一款专供纳米传讯军官的专属邮差包，由真正的鲸皮制成。"
	icon_state = "messenger_captain"
	inhand_icon_state = "messenger_captain"

/obj/item/storage/backpack/messenger/head_of_personnel
	name = "人事主管的邮差包"
	desc = "一款配发给纳米传讯最优秀二把手的专属邮差包，拥有充足空间容纳你计划处理的所有文书。"
	icon_state = "messenger_hop"
	inhand_icon_state = "messenger_hop"

/obj/item/storage/backpack/messenger/blueshield
	name = "蓝盾的邮差包"
	desc = "一款配发给纳米传讯最优秀看门狗的坚固邮差包，还带有额外的战术口袋。管它那是什么意思。"
	icon_state = "messenger_blueshield"
	inhand_icon_state = "messenger_blueshield"

/obj/item/storage/backpack/messenger/science/robo
	name = "机器人学邮差包"
	desc = "一款配发给机器人学人员的流线型工业级邮差包。隐约散发着机油味；对时髦地久坐不动的机械师而言，是个时髦又便于携带的选择。"
	icon_state = "messenger_robo"
	inhand_icon_state = "messenger_robo"

/obj/item/storage/backpack/messenger/clown
	name = "小咯咯·冯·洪克顿"
	desc = "洪克公司最新的储物“技术”。嘿，这么小的外形怎么能装下这么多东西？穿戴者绝对不会告诉你。"
	icon_state = "messenger_clown"
	inhand_icon_state = "messenger_clown"
