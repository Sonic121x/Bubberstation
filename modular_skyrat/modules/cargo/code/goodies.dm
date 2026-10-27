/*
*	EMERGENCY RACIAL EQUIPMENT
*/

/datum/supply_pack/goody/airsuppliesnitrogen
	name = "应急空气补给（氮气）"
	desc = "一副 Vox 呼吸面罩和一个氮气罐。"
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/nitrogen/belt,
		/obj/item/clothing/mask/breath/vox,
	)

/datum/supply_pack/goody/airsuppliesoxygen
	name = "应急空气补给（氧气）"
	desc = "一副呼吸面罩和一个应急氧气罐。"
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/clothing/mask/breath,
	)

/datum/supply_pack/goody/airsuppliesplasma
	name = "应急空气补给（等离子）"
	desc = "一副呼吸面罩和一个等离子人等离子罐。"
	cost = PAYCHECK_CREW
	contains = list(
		/obj/item/tank/internals/plasmaman/belt,
		/obj/item/clothing/mask/breath,
	)

/*
*	ENGINEERING STUFF
*/

/datum/supply_pack/goody/improvedrcd
	name = "改进型快速建造装置（RCD）"
	desc = "升级版快速建造装置，拥有更出色的材料储量，还附赠框架与电路升级！"
	cost = PAYCHECK_CREW * 38
	access_view = ACCESS_ENGINE_EQUIP
	contains = list(/obj/item/construction/rcd/improved)

/*
*	MISC
*/

/datum/supply_pack/goody/crayons
	name = "一盒蜡笔"
	desc = "色彩缤纷！"
	cost = PAYCHECK_CREW * 2
	contains = list(/obj/item/storage/crayons)

/datum/supply_pack/goody/diamondring
	name = "钻石戒指"
	desc = "让他们看看你的爱如钻石般坚不可摧、永不磨灭。概不退货。"
	cost = PAYCHECK_CREW * 50
	contains = list(/obj/item/storage/fancy/ringbox/diamond)
	crate_name = "钻石戒指箱"

/datum/supply_pack/goody/paperbin
	name = "纸张盒"
	desc = "有纸可推时，推卸文书工作总是更轻松！"
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/paper_bin)

/datum/supply_pack/goody/xenoarch_intern
	name = "异种考古学实习生技能芯片"
	desc = "一块技能芯片，包含开始涉猎解读异种考古发现这门精妙技艺所需的全部信息。 \
			不含实际的异种考古工具，也无法让别人真的注意到你 \
			装腔作势的智识表演，更不会给你任何真正的策展员工作经验。"
	cost = PAYCHECK_CREW * 35 // 1750 credit goody? do bounties
	contains = list(/obj/item/skillchip/xenoarch_magnifier)

/datum/supply_pack/goody/scratching_stone
	name = "磨爪石"
	desc = "一块由特种合金制成的高级磨石，用于磨利剃刀般的爪子。遗憾的是，这一块显然早已风光不再。"
	cost = CARGO_CRATE_VALUE * 4 //800 credits
	contains = list(/obj/item/scratching_stone)
	order_flags = ORDER_CONTRABAND

/*
*	CARPET PACKS
*/

/datum/supply_pack/goody/classiccarpet
	name = "地毯：经典红黑优惠包"
	desc = "用格调装饰一番，内含 50 块经典红与经典黑地毯。"
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/stack/tile/carpet/fifty,
		/obj/item/stack/tile/carpet/black/fifty,
	)

/datum/supply_pack/goody/royalcarpet
	name = "地毯：皇家黑蓝优惠包"
	desc = "用格调装饰一番，内含 50 块皇家黑与皇家蓝地毯。"
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/stack/tile/carpet/royalblack/fifty,
		/obj/item/stack/tile/carpet/royalblue/fifty,
	)

/datum/supply_pack/goody/rgbcarpet
	name = "地毯：红绿蓝优惠包"
	desc = "用格调装饰一番，内含 50 块红、绿、蓝三色地毯。"
	cost = PAYCHECK_CREW * 8.5
	contains = list(
		/obj/item/stack/tile/carpet/red/fifty,
		/obj/item/stack/tile/carpet/green/fifty,
		/obj/item/stack/tile/carpet/blue/fifty,
	)

/datum/supply_pack/goody/copcarpet
	name = "地毯：青橙紫优惠包"
	desc = "用格调装饰一番，内含 50 块青、橙、紫三色地毯。"
	cost = PAYCHECK_CREW * 8.5
	contains = list(
		/obj/item/stack/tile/carpet/cyan/fifty,
		/obj/item/stack/tile/carpet/orange/fifty,
		/obj/item/stack/tile/carpet/purple/fifty,
	)

/datum/supply_pack/goody/rgbneoncarpet
	name = "霓虹地毯：红绿蓝优惠包"
	desc = "用格调装饰一番，内含 60 块三种款式的地毯：红、绿、蓝。"
	cost = PAYCHECK_CREW * 8.5
	contains = list(
		/obj/item/stack/tile/carpet/neon/simple/red/sixty,
		/obj/item/stack/tile/carpet/neon/simple/green/sixty,
		/obj/item/stack/tile/carpet/neon/simple/blue/sixty,
	)

/datum/supply_pack/goody/bwneoncarpet
	name = "霓虹地毯：黑白优惠包"
	desc = "用格调装饰一番，内含 60 块两种款式的地毯：白与黑。"
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/stack/tile/carpet/neon/simple/white/sixty,
		/obj/item/stack/tile/carpet/neon/simple/black/sixty,
	)

/datum/supply_pack/goody/pvneoncarpet
	name = "霓虹地毯：粉紫优惠包"
	desc = "用格调装饰一番，内含 60 块两种款式的地毯：粉与紫。"
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/stack/tile/carpet/neon/simple/pink/sixty,
		/obj/item/stack/tile/carpet/neon/simple/violet/sixty,
	)

/datum/supply_pack/goody/copneoncarpet
	name = "霓虹地毯：青橙紫优惠包"
	desc = "用格调装饰一番，内含 60 块三种款式的地毯：青、橙、紫。"
	cost = PAYCHECK_CREW * 8.5
	contains = list(
		/obj/item/stack/tile/carpet/neon/simple/cyan/sixty,
		/obj/item/stack/tile/carpet/neon/simple/orange/sixty,
		/obj/item/stack/tile/carpet/neon/simple/purple/sixty,
	)

/datum/supply_pack/goody/yltneoncarpet
	name = "霓虹地毯：黄绿青优惠包"
	desc = "用格调装饰一番，内含 60 块三种款式的地毯：黄、柠檬绿与青绿。"
	cost = PAYCHECK_CREW * 8.5
	contains = list(
		/obj/item/stack/tile/carpet/neon/simple/yellow/sixty,
		/obj/item/stack/tile/carpet/neon/simple/lime/sixty,
		/obj/item/stack/tile/carpet/neon/simple/teal/sixty,
	)

/*
* NIF STUFF
*/
/datum/supply_pack/goody/standard_nif
	name = "标准型 NIF"
	desc = "内含一枚标准型 NIF，需要手术植入。"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(
		/obj/item/organ/cyberimp/brain/nif/standard,
	)

/datum/supply_pack/goody/cheap_nif
	name = "经济型 NIF"
	desc = "内含一枚经济型 NIF，需要手术植入。"
	cost = CARGO_CRATE_VALUE * 7.5
	contains = list(
		/obj/item/organ/cyberimp/brain/nif/roleplay_model,
	)

/datum/supply_pack/goody/nif_repair_kit
	name = "蔚蓝 NIF 修复器"
	desc = "内含一罐 NIF 修复液，最多可使用 5 次。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/nif_repair_kit,
	)

/datum/supply_pack/goody/money_sense_nifsoft
	name = "自动估价 NIFSoft"
	desc = "内含一张自动估价 NIFSoft 上传磁盘。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/money_sense,
	)

/datum/supply_pack/goody/shapeshifter_nifsoft
	name = "变形 NIFSoft"
	desc = "内含一张变形 NIFSoft 上传磁盘。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/shapeshifter,
	)

/datum/supply_pack/goody/hivemind_nifsoft
	name = "蜂巢意识 NIFSoft"
	desc = "内含一张蜂巢意识 NIFSoft 上传磁盘。"
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/hivemind,
	)

/datum/supply_pack/goody/summoner_nifsoft
	name = "蔚蓝魔典 NIFSoft"
	desc = "内含一张蔚蓝魔典 NIFSoft 上传磁盘。"
	cost = CARGO_CRATE_VALUE * 0.75
	contains = list(
		/obj/item/disk/nifsoft_uploader/summoner,
	)

/datum/supply_pack/goody/firstaid_pouch
	name = "迷你医疗包急救袋"
	desc = "内含一个带口袋夹的剩余急救袋。内装已按空间站标准医疗物资重新打包， \
	不过也没人拦着你自己重新装填。"
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/storage/pouch/medical/firstaid/loaded,
	)

/datum/supply_pack/goody/stabilizer_pouch
	name = "稳定剂急救袋"
	desc = "内含一个带口袋夹的剩余急救袋。内装已按以稳定伤口为主的配置重新打包， \
	不过也没人拦着你自己重新装填。"
	cost = PAYCHECK_CREW * 6
	contains = list(
		/obj/item/storage/pouch/medical/firstaid/stabilizer,
	)
