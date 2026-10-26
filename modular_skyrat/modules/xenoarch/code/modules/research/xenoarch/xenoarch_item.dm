//useless relics
/obj/item/xenoarch/useless_relic
	name = "无用遗物"
	desc = "可兑换货运点数或研究点数的无用遗物。"
	///Used to spawn the same relic
	var/magnified_number

/obj/item/xenoarch/useless_relic/Initialize(mapload)
	. = ..()
	magnified_number = rand(1,8)
	icon_state = "useless[magnified_number]"

/obj/item/xenoarch/useless_relic/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/glassblowing/magnifying_glass))
		if(istype(src, /obj/item/xenoarch/useless_relic/magnified))
			balloon_alert(user, "已经仔细鉴定过了！")
			return

		if(!HAS_TRAIT(user, TRAIT_XENOARCH_QUALIFIED))
			balloon_alert(user, "需要专业训练！") // it was very tempting to replace this with "skill issue"
			return

		balloon_alert(user, "开始分析！")
		if(!do_after(user, 5 SECONDS, target = src))
			balloon_alert(user, "别动！")
			return

		loc.balloon_alert(user, "鉴定完成！")
		user.mind?.adjust_experience(/datum/skill/research, 5)
		spawn_magnified(magnified_number)
		return

	return ..()

#define ANCIENT_URN 1
#define ANCIENT_BOWL 2
#define ANCIENT_CROWN 3
#define ANCIENT_COIL 4
#define ANCIENT_LIGHT 5
#define ANCIENT_CUP 6
#define ANCIENT_UTENSILS 7
#define ANCIENT_R_BOWL 8

/obj/item/xenoarch/useless_relic/proc/spawn_magnified(type_number)
	var/obj/item/xenoarch/useless_relic/magnified/new_item = new(get_turf(src))
	new_item.icon_state = "useless[type_number]"
	switch(type_number)
		if(ANCIENT_URN)
			new_item.name = "古代骨灰瓮"
			new_item.desc = "这件无用遗物是一个约有 [rand(400,600)] 年历史的古代骨灰瓮。\
			它由陶瓷类材料制成，边缘已有明显的碎裂。里面或许盛着\
			某位古人的骨灰。"

		if(ANCIENT_BOWL)
			new_item.name = "古代碗"
			new_item.desc = "这件无用遗物是一个约有 [rand(400,600)] 年历史的古代碗。\
			它由青铜合金制成，表面凹陷，内侧有一些刮痕。或许曾经\
			留有某位古人的 DNA。"

		if(ANCIENT_CROWN)
			new_item.name = "古代王冠"
			new_item.desc = "这件无用遗物是一顶约有 [rand(900,1100)] 年历史的古代王冠。\
			它由未知合金制成，上面的小凹槽应该曾镶嵌着宝石。也许我们\
			在附近找找，还能发现那些古老的宝石。"

		if(ANCIENT_COIL)
			new_item.name = "古代线圈"
			new_item.desc = "这件无用遗物是一个约有 [rand(400,600)] 年历史的古代线圈。\
			它由铁和铜制成，铁棒周围有一些焦痕。也许以后\
			我们还能把它用在某些机器上。"

		if(ANCIENT_LIGHT)
			new_item.name = "古代灯具"
			new_item.desc = "这件无用遗物是一盏约有 [rand(400,600)] 年历史的古代灯具。\
			它由铁制成，周围散着玻璃碎片。铁壳上有凹痕和明显的使用不当造成的损坏。\
			也许以后可以研究它，看看古人是如何制作灯具的。"

		if(ANCIENT_CUP)
			new_item.name = "古代杯子"
			new_item.desc = "这件无用遗物是一个约有 [rand(900,1100)] 年历史的古代杯子。\
			它由坚硬的石头制成，表面布满细小裂纹和凿痕。\
			也许它能帮助我们了解古人的饮食习惯。"

		if(ANCIENT_UTENSILS)
			new_item.name = "古代餐具"
			new_item.desc = "这些无用遗物是约有 [rand(900,1100)] 年历史的古代餐具。\
			它们由坚硬的石头制成，表面布满细小裂纹和凿痕。\
			也许它们能帮助我们了解古人的饮食习惯。"

		if(ANCIENT_R_BOWL)
			new_item.name = "古代石碗"
			new_item.desc = "这件无用遗物是一个约有 [rand(900,1100)] 年历史的古代石碗。\
			它由坚硬的石头制成，表面布满细小裂纹和凿痕。\
			也许它能帮助我们了解古人的饮食习惯。"

	new_item.desc += "无论它过去有何用途，如今只能当作博物馆藏品，或通过货运穿梭机卖给收藏家。"
	qdel(src)

#undef ANCIENT_URN
#undef ANCIENT_BOWL
#undef ANCIENT_CROWN
#undef ANCIENT_COIL
#undef ANCIENT_LIGHT
#undef ANCIENT_CUP
#undef ANCIENT_UTENSILS
#undef ANCIENT_R_BOWL

/obj/item/xenoarch/useless_relic/magnified
	name = "已鉴定的无用遗物"
	desc = "一件经过仔细鉴定的无用遗物，可以通过货运出售。"

/datum/export/xenoarch
	abstract_type = /datum/export/xenoarch

/datum/export/xenoarch/useless_relic
	cost = CARGO_CRATE_VALUE * 3 //600
	unit_name = "无用遗物"
	export_types = list(/obj/item/xenoarch/useless_relic)
	include_subtypes = FALSE
	k_elasticity = 0

/datum/export/xenoarch/broken_item
	cost = CARGO_CRATE_VALUE*5
	unit_name = "损坏物品"
	export_types = list(/obj/item/xenoarch/broken_item)
	include_subtypes = TRUE
	k_elasticity = 0

/datum/export/xenoarch/useless_relic/magnified
	cost = CARGO_CRATE_VALUE * 6 //1200
	unit_name = "已鉴定的无用遗物"
	export_types = list(/obj/item/xenoarch/useless_relic/magnified)
	include_subtypes = FALSE

//broken items
/obj/item/xenoarch/broken_item
	name = "损坏物品"
	desc = "已经损坏许久的物品，仍有可能修复。"

/obj/item/xenoarch/broken_item/tech
	name = "损坏的科技产品"
	icon_state = "recover_tech"

/obj/item/xenoarch/broken_item/weapon
	name = "损坏的武器"
	icon_state = "recover_weapon"

/obj/item/xenoarch/broken_item/illegal
	name = "损坏的不明物体"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/alien
	name = "损坏的不明物体"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/plant
	name = "枯萎植物"
	desc = "早已枯败的植物，仍有可能恢复生机。"
	icon_state = "recover_plant"

/obj/item/xenoarch/broken_item/animal
	name = "保存完好的动物尸体"
	desc = "死去很久的动物，仍有可能复原。可以用拭子采集其残留的原始 DNA。"
	icon_state = "recover_animal"

/obj/item/xenoarch/broken_item/animal/Initialize(mapload)
	. = ..()
	var/pick_celltype = pick(CELL_LINE_TABLE_BEAR,
							CELL_LINE_TABLE_BLOBBERNAUT,
							CELL_LINE_TABLE_BLOBSPORE,
							CELL_LINE_TABLE_CARP,
							CELL_LINE_TABLE_CAT,
							CELL_LINE_TABLE_CHICKEN,
							CELL_LINE_TABLE_COCKROACH,
							CELL_LINE_TABLE_CORGI,
							CELL_LINE_TABLE_COW,
							CELL_LINE_TABLE_MOONICORN,
							CELL_LINE_TABLE_GELATINOUS,
							CELL_LINE_TABLE_GRAPE,
							CELL_LINE_TABLE_MEGACARP,
							CELL_LINE_TABLE_MOUSE,
							CELL_LINE_TABLE_PINE,
							CELL_LINE_TABLE_PUG,
							CELL_LINE_TABLE_SLIME,
							CELL_LINE_TABLE_SNAKE,
							CELL_LINE_TABLE_VATBEAST,
							CELL_LINE_TABLE_NETHER,
							CELL_LINE_TABLE_GLUTTON,
							CELL_LINE_TABLE_FROG,
							CELL_LINE_TABLE_WALKING_MUSHROOM,
							CELL_LINE_TABLE_QUEEN_BEE,
							CELL_LINE_TABLE_MEGA_ARACHNID)
	AddElement(/datum/element/swabable, pick_celltype, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/xenoarch/broken_item/clothing
	name = "石化衣物"
	desc = "一件早已失去昔日风采的衣物。"
	icon_state = "recover_clothing"


//circuit boards
/obj/item/circuitboard/machine/xenoarch_machine
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2,
	)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	name = "异星考古研究仪（机器电路板）"
	build_path = /obj/machinery/xenoarch/researcher

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner
	name = "异星考古扫描仪（机器电路板）"
	build_path = /obj/machinery/xenoarch/scanner

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer
	name = "异星考古修复器（机器电路板）"
	build_path = /obj/machinery/xenoarch/recoverer

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger
	name = "异星考古挖掘机（机器电路板）"
	build_path = /obj/machinery/xenoarch/digger

/obj/item/paper/fluff/xenoarch_guide
	name = "异星考古指南——必读"
	default_raw_text = {"<b><center>异星考古指南</center></b><br> \
			先从基础开始：什么是异星考古学？<br> \
			问得好！异星考古学研究的是封存在奇异岩石中的古代异物。<br> \
			作为异星考古学家，你的目标就是找到这些奇异岩石，发掘其中的秘密。<br> \
			我们通常环绕运行的天体上遍布这种岩石。<br> \
			<br> \
			<b>专业工具</b><br> \
			<br> \
			所需工具不少，还有一些只是为了让考古工作更方便。<br> \
			包括锤子、刷子、卷尺、腰带、袋子、手持设备和固定机器。<br> \
			这项工作最基础的工具是刷子和锤子。<br> \
			它们能帮你挖出奇异岩石中的异物。<br> \
			锤子有不同的挖掘深度，能比刷子更快地挖到目标深度。<br> \
			刷子可以在恰当深度将物品清理出来，而不损坏它。<br> \
			卷尺可为奇异岩石标注当前深度，随时检查岩石即可查看更新。<br> \
			腰带用来收纳便携和手持工具，方便随时取用。<br> \
			袋子可以储存并自动拾取地面上的奇异岩石和遗物。<br> \
			手持设备让你无需一直守在机器旁，目前只有扫描仪和修复器有手持型号。<br> \
			扫描仪能为奇异岩石标注最大深度与安全深度。<br> \
			研究仪能将遗物与物品整合凝聚成更大的奇异文物。<br> \
			修复器能从破损物品中复原那些失落已久的物件。<br> \
			<br> \
			<b>操作流程</b><br> \
			<br> \
			1）在野外找到一块奇异岩石。<br> \
			2）返回（或留在）异星考古实验室。<br> \
			3）用扫描仪处理岩石，或使用手持扫描仪。<br> \
			4）用卷尺测量岩石。<br> \
			5）用最大深度（MD）减去安全深度（SD）。<br> \
				5a）提问：最大深度为 50、安全深度为 16 时，应挖<i>到</i>多深？<br> \
					答案：34。注意不是再挖 34，因为还要考虑原先已有的深度。<br> \
			6）用第 5 步的结果减去当前深度（CD）。<br> \
			7）用锤子挖掘第 6 步算出的深度。<br> \
			8）到达第 5 步算出的总深度后，持续用刷子清理，直到物品显露。<br> \
			9）享用你发掘出来的秘密吧！<br> \
				9a）若是无用遗物，可以出售，或投入研究仪换取惊喜。<br> \
				9b）若是破损物品，可以出售，或投入修复器换取惊喜。<br> \
			<br> \
			希望本指南对你有帮助，祝你大获成功！<br> \
			<br> \
			<i>- KB</i><br> \
			异星考古研究主管"}
