/obj/item/ammo_box/speedloader
	name = "快速装弹器（基础类型）"
	desc = "这东西不该出现在这里。请向程序员报告，谢谢！"
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_box_multiload = (AMMO_BOX_MULTILOAD_IN | AMMO_BOX_MULTILOAD_OUT_LOADED)
	// You can feed ammo in from a box (assuming someone ever codes a relevant ammo box),
	// you can feed ammo out to a revolver's cylinder,
	// but you can't use it to teleport six bullets into a detached rifle magazine.

/obj/item/ammo_box/speedloader/c357
	name = "快速装弹器（.357）"
	desc = "用于快速为七膛 .357 左轮手枪装弹。"
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/c357
	max_ammo = 7
	caliber = CALIBER_357
	item_flags = NO_MAT_REDEMPTION
	ammo_band_icon = "+357_ammo_band"
	ammo_band_color = null

/obj/item/ammo_box/speedloader/c357/match
	name = "快速装弹器（.357 竞赛弹）"
	desc = parent_type::desc + " 竞赛弹在极严格的公差内制造，很容易用它们炫出花式射击。"
	ammo_type = /obj/item/ammo_casing/c357/match
	ammo_band_color = "#77828a"

/obj/item/ammo_box/speedloader/c357/phasic
	name = "快速装弹器（.357 相位弹）"
	desc = parent_type::desc + " 相位弹又称“幽灵铅”，经过特殊制造，可以径直穿过非有机材质。天知道是怎么办到的。"
	ammo_type = /obj/item/ammo_casing/c357/phasic
	ammo_band_color = "#693a6a"

/obj/item/ammo_box/speedloader/c357/heartseeker
	name = "快速装弹器（.357 寻心弹）"
	desc = parent_type::desc + " 寻心弹会以不明方法极其精准地转向扑向目标。 \
		据说它能利用大脑中的神经脉冲预测目标动向，不过这卖点不太好宣传。 \
		详见 NTFlik 大热太空恐怖西部片《勿忘我》，由罗塞乌斯银河影业出品！"
	ammo_type = /obj/item/ammo_casing/c357/heartseeker
	ammo_band_color = "#a91e1e"

/obj/item/ammo_box/speedloader/c38
	name = "快速装弹器（.38）"
	desc = "用于快速为六膛 .38 特种左轮手枪装弹。"
	icon_state = "38"
	base_icon_state = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	caliber = CALIBER_38
	ammo_band_icon = "+38_ammo_band"
	ammo_band_color = null
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)

/obj/item/ammo_box/speedloader/c38/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-base"

/obj/item/ammo_box/speedloader/c38/update_overlays()
	. = ..()
	if(!LAZYLEN(stored_ammo))
		return
	for(var/inserted_ammo in 1 to stored_ammo.len)
		var/obj/item/ammo_casing/c38/boolet = stored_ammo[inserted_ammo]
		. += "38-[boolet::lead_or_laser]-[inserted_ammo]"

/obj/item/ammo_box/speedloader/c38/trac
	name = "快速装弹器（.38 追踪弹）"
	desc = parent_type::desc + " 追踪弹会在目标体内植入一枚追踪植入体。"
	ammo_type = /obj/item/ammo_casing/c38/trac
	ammo_band_color = COLOR_AMMO_TRACK
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ammo_box/speedloader/c38/match
	name = "快速装弹器（.38 竞赛弹）"
	desc = parent_type::desc + " 竞赛弹在极严格的公差内制造，很容易用它们炫出花式射击。"
	ammo_type = /obj/item/ammo_casing/c38/match
	ammo_band_color = COLOR_AMMO_MATCH

/obj/item/ammo_box/speedloader/c38/match/bouncy
	name = "快速装弹器（.38 橡胶弹）"
	desc = parent_type::desc + " 橡胶弹弹性极强，且大体上属于低致命弹药，非常适合用来炫技。"
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy
	ammo_band_color = COLOR_AMMO_RUBBER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/ammo_box/speedloader/c38/true
	name = "快速装弹器（.38 必中弹）"
	desc = parent_type::desc + " 必中弹在跳弹之后会以惊人的精度弹向新的目标。"
	ammo_type = /obj/item/ammo_casing/c38/match/true
	ammo_band_color = COLOR_AMMO_TRUESTRIKE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ammo_box/speedloader/c38/dumdum
	name = "快速装弹器（.38 达姆弹）"
	desc = parent_type::desc + " 达姆弹命中后会扩张，牺牲了直接的停止作用， \
		却能在近距离撕碎目标并造成大量出血， \
		代价是对付护甲和远距离目标时极为乏力。"
	ammo_type = /obj/item/ammo_casing/c38/dumdum
	ammo_band_color = COLOR_AMMO_DUMDUM

/obj/item/ammo_box/speedloader/c38/hotshot
	name = "快速装弹器（.38 炽热弹）"
	desc = parent_type::desc + " 炽热弹内装有燃烧装药，可点燃被命中的目标。"
	ammo_type = /obj/item/ammo_casing/c38/hotshot
	ammo_band_color = COLOR_AMMO_HOTSHOT
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ammo_box/speedloader/c38/iceblox
	name = "快速装弹器（.38 冰封弹）"
	desc = parent_type::desc + " 冰封弹内装有低温装药，可降低被命中目标的体温。"
	ammo_type = /obj/item/ammo_casing/c38/iceblox
	ammo_band_color = COLOR_AMMO_ICEBLOX
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 0.75)

/obj/item/ammo_box/speedloader/c38/flare
	name = "快速装弹器（.38 照明弹）"
	desc = parent_type::desc + " 照明弹弹壳会朝目标发射一束集中的粒子束，把目标照亮给所有人看。"
	ammo_type = /obj/item/ammo_casing/c38/flare
	ammo_band_color = COLOR_AMMO_HELLFIRE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/ammo_box/speedloader/strilka310
	name = "弹夹（.310 斯特里尔卡）"
	desc = "一个用于 .310 斯特里尔卡步枪的五发弹夹。"
	icon_state = "310_strip"
	ammo_type = /obj/item/ammo_casing/strilka310
	max_ammo = 5
	ammo_box_multiload = AMMO_BOX_MULTILOAD_ALL
	caliber = CALIBER_STRILKA310

/obj/item/ammo_box/speedloader/strilka310/surplus
	name = "弹夹（.310 军剩弹）"
	desc = parent_type::desc + " 这一件在枪油没糊住的地方有那么几处锈斑。"
	ammo_type = /obj/item/ammo_casing/strilka310/surplus

/obj/item/ammo_box/speedloader/strilka310/phasic
	name = "弹夹（.310 相位弹）"
	desc = parent_type::desc + " 这里面应该装着相位弹， \
		它们是在一次走火毁掉阿特拉科·银鳞的无价维戈星法贝热彩蛋之后匆忙研发出来的。 \
		这些花哨的子弹会径直穿过贵重物品，直到最后钻进某个远没那么值钱的人类头骨里。"
	ammo_type = /obj/item/ammo_casing/strilka310/phasic
