/obj/item/gun/energy/pulse
	name = "脉冲步枪"
	desc = "一把重型多面能量步枪，拥有三种模式。前线作战人员的最爱。"
	icon_state = "pulse"
	inhand_icon_state = null
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	modifystate = TRUE
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	light_color = COLOR_BLUE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	cell_type = /obj/item/stock_parts/power_store/cell/pulse

/obj/item/gun/energy/pulse/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/pulse/prize
	pin = /obj/item/firing_pin

/obj/item/gun/energy/pulse/prize/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)
	var/turf/T = get_turf(src)

	message_admins("一把脉冲步枪奖品已在 [ADMIN_VERBOSEJMP(T)] 生成")
	log_game("一把脉冲步枪奖品已在 [AREACOORD(T)] 生成")

	notify_ghosts(
		"有人赢得了一把脉冲步枪作为奖品！",
		source = src,
		header = "脉冲步枪奖品",
	)

/obj/item/gun/energy/pulse/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/carbine
	name = "脉冲卡宾枪"
	desc = "脉冲步枪的紧凑型号，火力较弱但更易收纳。"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "pulse_carbine"
	worn_icon_state = "gun"
	inhand_icon_state = null
	cell_type = /obj/item/stock_parts/power_store/cell/pulse/carbine

/obj/item/gun/energy/pulse/carbine/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 18, \
		overlay_y = 12)

/obj/item/gun/energy/pulse/carbine/lethal
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/electrode)

/obj/item/gun/energy/pulse/carbine/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/carbine/taserless
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/pulse/destroyer
	name = "脉冲毁灭者"
	desc = "一把专为纯粹毁灭而生的重型能量步枪。"
	worn_icon_state = "pulse"
	cell_type = /obj/item/stock_parts/power_store/cell/infinite
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)

/obj/item/gun/energy/pulse/destroyer/attack_self(mob/living/user)
	to_chat(user, span_danger("[src.name] 有三种模式，而它们全都是“毁灭”。"))

/obj/item/gun/energy/pulse/pistol
	name = "脉冲手枪"
	desc = "手枪外形、便于隐藏、容量较低的脉冲步枪。"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	icon_state = "pulse_pistol"
	worn_icon_state = "gun"
	inhand_icon_state = "gun"
	cell_type = /obj/item/stock_parts/power_store/cell/pulse/pistol

/obj/item/gun/energy/pulse/pistol/taserless
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/pulse/pistol/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/pistol/m1911
	name = "\improper M1911-P"
	desc = "经典手枪框架中装入紧凑脉冲核心，专为纳米传讯军官打造。重要的不是枪的尺寸，而是它在人身上打出的洞有多大。"
	icon_state = "m1911"
	inhand_icon_state = "gun"
	cell_type = /obj/item/stock_parts/power_store/cell/infinite
