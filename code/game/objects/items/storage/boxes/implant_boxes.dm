/obj/item/storage/box/trackimp
	name = "盒装追踪植入体套件"
	desc = "装满追踪败类用工具的盒子。"
	icon_state = "secbox"
	illustration = "implant"

/obj/item/storage/box/trackimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/tracking = 4,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
		/obj/item/locator = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/minertracker
	name = "盒装追踪植入体套件"
	desc = "用于寻找那些死在受诅咒的熔岩世界的人。"
	illustration = "implant"

/obj/item/storage/box/minertracker/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/tracking = 2,
		/obj/item/implantcase/beacon = 2,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
		/obj/item/locator = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/minerdeathrattle
	name = "盒装远征临终遗言植入体套件"
	desc = "用于确认你的同事已经死亡，而不是刻意无视通讯。需要手动设置。\
		仅在原始的熔岩世界或冰月荒原中的死亡才有效。"
	illustration = "implant"

/obj/item/storage/box/minerdeathrattle/PopulateContents()
	var/static/items_inside = list(
		/obj/item/implantcase/deathrattle/lavaland = 5, // 3 miners 1 QM/paramed/etc, 1 for saving config, presumably
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/chemimp
	name = "盒装化学植入体套件"
	desc = "一盒用于植入化学物质的器具。"
	illustration = "implant"

/obj/item/storage/box/chemimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/chem = 5,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/exileimp
	name = "盒装流放植入体套件"
	desc = "一盒流放植入体。盒面上画着一名正被踹出传送门的马戏小丑。"
	illustration = "implant"

/obj/item/storage/box/exileimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/exile = 5,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/beaconimp
	name = "盒装信标植入体套件"
	desc = "内含一整套信标植入体。侧面贴有警告标签，提醒务必先确认传送目的地的安全，\
		旁边还配着一幅欢快的插图：一名安保官说着“三思而后跃！”"
	illustration = "implant"

/obj/item/storage/box/beaconimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/beacon = 3,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/teleport_blocker
	name = "盒装蓝空间接地植入体套件"
	desc = "一盒蓝空间接地植入体。侧面有一幅画——一个身披令人生畏长袍的身影，皱着眉，流下一滴泪。"
	illustration = "implant"

/obj/item/storage/box/teleport_blocker/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/teleport_blocker = 2,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

//BOX O' IMPLANTS
/obj/item/storage/box/cyber_implants
	name = "盒装赛博植入体"
	desc = "一个光滑而坚固的盒子。"
	icon_state = "cyber_implants"

/obj/item/storage/box/cyber_implants/PopulateContents()
	new /obj/item/autosurgeon/syndicate/xray_eyes(src)
	new /obj/item/autosurgeon/syndicate/anti_stun(src)
	new /obj/item/autosurgeon/syndicate/reviver(src)
