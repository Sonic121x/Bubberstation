/obj/item/choice_beacon/ancient_milsim
	name = "抢先体验装备信标"
	desc = "因你为抢先体验测试做出的贡献而召唤一个装备储物柜。它会与当前游戏版本同步，为你提供最新的职业装备。"
	company_source = "《英勇时刻 2》开发团队"
	company_message = span_bold("谢谢，玩得开心！")

/obj/item/choice_beacon/ancient_milsim/generate_display_names()
	var/static/list/gear_options
	if(!gear_options)
		gear_options = list()
		for(var/obj/structure/closet/crate/secure/weapon/milsim/crate as anything in subtypesof(/obj/structure/closet/crate/secure/weapon/milsim))
			gear_options[initial(crate.name)] = crate
	return gear_options

/obj/structure/closet/crate/secure/weapon/milsim
	desc = "（ToV 2 试玩者奖励）UNIF 反叛乱支队套装：包含提供给中强度交火中一线作战人员的装备。<br>\
	“VCIM（虚空作战识别措施）迷彩”外观（替代款 1/无频闪、不透明玻璃）。"

/obj/structure/closet/crate/secure/weapon/milsim/PopulateContents()
	. = ..()
	new /obj/item/knife/combat(src)
	new /obj/item/gun/energy/modular_laser_rifle/carbine(src)
	new /obj/item/radio/headset/headset_faction(src)

/obj/structure/closet/crate/secure/weapon/milsim/after_open()
	qdel(src)

/obj/structure/closet/crate/secure/weapon/milsim/mechanic
	name = "机械师（绑架者工具腰带/电缆卷分发器/医疗 HUD）"

/obj/structure/closet/crate/secure/weapon/milsim/mechanic/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/mechanic(src)

/obj/structure/closet/crate/secure/weapon/milsim/marksman
	name = "射手（路障箱/飞刀分发器/夜视仪—声呐）"

/obj/structure/closet/crate/secure/weapon/milsim/marksman/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/marksman(src)

/obj/structure/closet/crate/secure/weapon/milsim/medic
	name = "医疗兵（战斗注射器/战斗药瓶分发器/医疗 HUD）"

/obj/structure/closet/crate/secure/weapon/milsim/medic/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/medic(src)

/obj/structure/closet/crate/secure/weapon/milsim/trapper
	name = "陷阱手（变色龙投影仪/潜行地雷分发器/热成像）"

/obj/structure/closet/crate/secure/weapon/milsim/trapper/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/trapper(src)

/obj/structure/closet/crate/secure/weapon/milsim/saboteur
	name = "破坏者（Binyat 植入器/EMP 手雷分发器/材料扫描仪—介子）"

/obj/structure/closet/crate/secure/weapon/milsim/sentinel
	name = "哨兵（重机枪/汉堡分发器/夜视仪—声呐）"

/obj/structure/closet/crate/secure/weapon/milsim/sentinel/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/sentinel(src)

/obj/structure/closet/crate/secure/weapon/milsim/trooper
	name = "步兵（太阳步枪/太阳步枪弹匣分发器/夜视仪—声呐）"

/obj/structure/closet/crate/secure/weapon/milsim/trooper/PopulateContents()
	. = ..()
	new /obj/item/mod/control/pre_equipped/responsory/milsim/trooper(src)
