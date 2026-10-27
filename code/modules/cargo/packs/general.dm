/datum/supply_pack/misc
	group = "Miscellaneous Supplies"

/datum/supply_pack/misc/artsupply
	name = "美术用品"
	desc = "用快速管道清洁器、三罐喷漆和一大堆蜡笔， \
		弄出一些快乐的小意外吧！"
	cost = CARGO_CRATE_VALUE * 1.8
	contains = list(/obj/item/rcl,
					/obj/item/storage/toolbox/artistic,
					/obj/item/storage/toolbox/crafter,
					/obj/item/toy/crayon/spraycan = 3,
					/obj/item/storage/crayons,
					/obj/item/toy/crayon/white,
					/obj/item/toy/crayon/rainbow,
				)
	crate_name = "美术用品板条箱"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/tattoo_kit
	name = "纹身套件"
	desc = "一套附带额外初始墨水的纹身套件。"
	cost = CARGO_CRATE_VALUE * 1.8
	contains = list(
		/obj/item/tattoo_kit,
		/obj/item/toner = 2)
	crate_name = "纹身板条箱"
	crate_type = /obj/structure/closet/crate/wooden
	discountable = SUPPLY_PACK_STD_DISCOUNTABLE

/datum/supply_pack/misc/bicycle
	name = "自行车"
	desc = "纳米传讯提醒所有员工：切勿玩弄自己无法掌控的力量。"
	cost = 1000000 //Special case, we don't want to make this in terms of crates because having bikes be a million credits is the whole meme.
	contains = list(/obj/vehicle/ridden/bicycle)
	crate_name = "自行车板条箱"
	crate_type = /obj/structure/closet/crate/large
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/misc/bigband
	name = "大乐队乐器合集"
	desc = "用这套精美的收藏，让你那死气沉沉的空间站动起来、摇摆起来！ \
		内含九种不同的乐器！"
	cost = CARGO_CRATE_VALUE * 10
	crate_name = "大乐队乐器合集"
	contains = list(/obj/item/instrument/violin,
					/obj/item/instrument/guitar,
					/obj/item/instrument/glockenspiel,
					/obj/item/instrument/accordion,
					/obj/item/instrument/saxophone,
					/obj/item/instrument/trombone,
					/obj/item/instrument/recorder,
					/obj/item/instrument/harmonica,
					/obj/structure/musician/piano/unanchored,
				)
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/book_crate
	name = "书籍板条箱"
	desc = "来自纳米传讯档案馆的库存，这七本书一定值得一读。"
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_LIBRARY
	contains = list(/obj/item/book/codex_gigas,
					/obj/item/book/manual/random = 3,
					/obj/item/book/random = 3,
				)
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/misc/commandkeys
	name = "指挥加密钥匙板条箱"
	desc = "一包加密钥匙，可用于访问指挥无线电网络。 \
		纳米传讯提醒未经授权的员工不要窃听安全通讯频道， \
		至少要把对指挥人员的嘲讽控制在最低限度。"
	access_view = ACCESS_COMMAND
	access = ACCESS_COMMAND
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/encryptionkey/headset_com = 3)
	crate_type = /obj/structure/closet/crate/secure/centcom
	crate_name = "指挥加密钥匙板条箱"

/datum/supply_pack/misc/exploration_drone
	name = "探索无人机"
	desc = "一台用于替换的远程探索无人机。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/exodrone)
	crate_name = "探索无人机板条箱"

/datum/supply_pack/misc/exploration_fuel
	name = "无人机燃料块"
	desc = "一罐全新的探索无人机燃料。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/fuel_pellet)
	crate_name = "探索无人机燃料板条箱"

/datum/supply_pack/misc/paper
	name = "文书工作板条箱"
	desc = "桌上堆得高高的文件是个大问题——用这些文书用品把它变成豆子那么大！ \
		内含六支笔、一些相机胶卷、手持贴标机耗材、 \
		一个纸张盒、一个复写纸盒、三个文件夹、一支激光笔、两个写字板和两枚印章。"
	cost = CARGO_CRATE_VALUE * 3.2
	contains = list(/obj/structure/filingcabinet/chestdrawer/wheeled,
					/obj/item/camera_film,
					/obj/item/hand_labeler,
					/obj/item/hand_labeler_refill = 2,
					/obj/item/paper_bin,
					/obj/item/paper_bin/carbon,
					/obj/item/pen/fourcolor = 2,
					/obj/item/pen,
					/obj/item/pen/fountain,
					/obj/item/pen/blue,
					/obj/item/pen/red,
					/obj/item/folder/blue,
					/obj/item/folder/red,
					/obj/item/folder/yellow,
					/obj/item/clipboard = 2,
					/obj/item/storage/box/stamps,
					/obj/item/laser_pointer/purple,
				)
	crate_name = "文书工作板条箱"

/datum/supply_pack/misc/fountainpens
	name = "书法板条箱"
	desc = "用这七支高管钢笔，优雅地签署死刑令。"
	cost = CARGO_CRATE_VALUE * 1.45
	contains = list(/obj/item/storage/box/fountainpens)
	crate_type = /obj/structure/closet/crate/wooden
	crate_name = "书法板条箱"

/datum/supply_pack/misc/wrapping_paper
	name = "节日包装纸板条箱"
	desc = "想给你爱的人寄包装好的巧克力、毛绒玩具，或者小丑的断头？ \
		有了这一箱包装纸，这些全都能办到。"
	cost = CARGO_CRATE_VALUE * 1.8
	contains = list(/obj/item/stack/wrapping_paper)
	crate_type = /obj/structure/closet/crate/wooden
	crate_name = "节日包装纸板条箱"


/datum/supply_pack/misc/funeral
	name = "葬礼用品板条箱"
	desc = "说到底，总有人希望某个人死掉。用这些 \
		葬礼用品给他们一场体面的送别！内含一口装有寿衣和鲜花的棺材。"
	cost = CARGO_CRATE_VALUE * 1.6
	access_view = ACCESS_CHAPEL_OFFICE
	contains = list(/obj/item/clothing/under/misc/burial,
					/obj/item/food/grown/flower/harebell,
					/obj/item/food/grown/flower/poppy/geranium,
				)
	crate_name = "棺材"
	crate_type = /obj/structure/closet/crate/coffin

/datum/supply_pack/misc/empty
	name = "空补给舱"
	desc = "隆重推出全新纳米传讯牌蓝空间补给舱！运送货物，优雅轻松！ \
		今天就致电，我们只要 300 信用点就给你射来一台体验样机！"
	cost = CARGO_CRATE_VALUE * 0.6 //Empty pod, so no crate refund
	contains = list()
	order_flags = ORDER_POD_ONLY
	crate_type = null
	special_pod = /obj/structure/closet/supplypod/bluespacepod

/datum/supply_pack/misc/empty/generate(atom/A, datum/bank_account/paying_account, crate_override)
	return

/datum/supply_pack/misc/religious_supplies
	name = "宗教用品板条箱"
	desc = "让你本地的牧师开心且物资充足，免得他们降下审判砸到你的 \
		货运舱。内含两瓶圣水、《圣经》、牧师长袍和寿衣。"
	cost = CARGO_CRATE_VALUE * 6 // it costs so much because the Space Church needs funding to build a cathedral
	access_view = ACCESS_CHAPEL_OFFICE
	contains = list(/obj/item/reagent_containers/cup/glass/bottle/holywater = 2,
					/obj/item/book/bible/booze = 2,
					/obj/item/clothing/suit/hooded/chaplain_hoodie = 2,
					/obj/item/clothing/under/misc/burial = 2,
				)
	crate_name = "宗教用品板条箱"

/datum/supply_pack/misc/candles_bulk
	name = "蜡烛盒板条箱"
	desc = "用三盒蜡烛让你本地的教堂保持明亮！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/fancy/candle_box = 3)
	crate_name = "蜡烛盒板条箱"

/datum/supply_pack/misc/toner
	name = "碳粉盒板条箱"
	desc = "打印屁股图片把墨水用光了？别担心，有了这六个碳粉补充装， \
		你就能一直打印屁股到奶牛回家！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/toner = 6)
	crate_name = "碳粉盒板条箱"

/datum/supply_pack/misc/toner_large
	name = "碳粉盒板条箱（大）"
	desc = "厌倦了更换碳粉盒？这六个加强型补充装所含的 \
		碳粉大约是基础型号的五倍！"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/toner/large = 6)
	crate_name = "大型碳粉盒板条箱"

/datum/supply_pack/misc/training_toolbox
	name = "训练工具箱板条箱"
	desc = "用两个奥鲁米尔牌训练工具箱磨练你的战斗能力！ \
		保证能统计对活体目标造成的打击！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/training_toolbox = 2)
	crate_name = "训练工具箱板条箱"

///Special supply crate that generates random syndicate gear up to a determined TC value
/datum/supply_pack/misc/syndicate
	name = "辛迪加杂项装备"
	desc = "内含随机搭配的辛迪加装备。"
	order_flags = ORDER_SPECIAL //Cannot be ordered via cargo
	contains = list()
	crate_name = "辛迪加装备板条箱"
	crate_type = /obj/structure/closet/crate
	test_ignored = TRUE
	///Total TC worth of contained uplink items
	var/crate_value = 30
	///What uplink the contents are pulled from
	var/contents_uplink_type = UPLINK_TRAITORS

///Generate assorted uplink items, taking into account the same surplus modifiers used for surplus crates
/datum/supply_pack/misc/syndicate/fill(obj/container)
	var/list/uplink_items = list()
	for(var/datum/uplink_item/item as anything in SStraitor.uplink_items)
		if(item.purchasable_from & contents_uplink_type && item.item)
			uplink_items += item

	while(crate_value)
		var/datum/uplink_item/uplink_item = pick(uplink_items)
		if(!uplink_item.surplus || prob(100 - uplink_item.surplus))
			continue
		if(length(uplink_item.restricted_roles) || length(uplink_item.restricted_species))
			continue
		if(crate_value < uplink_item.cost)
			continue
		crate_value -= uplink_item.cost
		new uplink_item.item(container)

///Syndicate supply crate that can have its contents value changed by admins, uses a seperate datum to avoid having admins touch the original one.
/datum/supply_pack/misc/syndicate/custom_value

/datum/supply_pack/misc/syndicate/custom_value/proc/setup_contents(value, uplink)
	crate_value = value
	contents_uplink_type = uplink

/datum/supply_pack/misc/papercutter
	name = "切纸刀板条箱"
	desc = "内含 3 把办公级切纸刀，配备锋利刀片，可把任何纸张切成两条薄片。\
		附一片替换刀片。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(
		/obj/item/papercutter = 3,
		/obj/item/hatchet/cutterblade = 1,
	)
	crate_name = "切纸刀板条箱"

/datum/supply_pack/misc/water_cooler
	name = "液体冷饮机 - 水"
	desc = "一台液体冷饮机，装满了整个边区最新鲜的水。最适合在办公室里消磨时间！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/structure/reagent_dispensers/water_cooler/jugless = 1, /obj/item/reagent_containers/cooler_jug/water = 1)
	crate_name = "冷饮机板条箱"

/datum/supply_pack/misc/punch_cooler
	name = "液体冷饮机 - 水果宾治"
	desc = "一台液体冷饮机，装满了能治疗伤势的异域水果宾治！为了你自己的健康与安全，喝的时候一定要待在冷饮机旁边。说真的，千万不要离开冷饮机喝这玩意儿。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/structure/reagent_dispensers/water_cooler/jugless = 1, /obj/item/reagent_containers/cooler_jug/punch = 1)
	crate_name = "宾治冷饮机板条箱"
