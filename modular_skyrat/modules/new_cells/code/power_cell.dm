/obj/item/stock_parts/power_store/cell/crank
	name = "手摇电池"
	desc = "来吧，摇动手柄为它充电。"
	icon = 'modular_skyrat/modules/new_cells/icons/power.dmi'
	icon_state = "crankcell"
	/// how much each crank will give the cell charge
	var/crank_amount = STANDARD_CELL_CHARGE * 0.1
	/// how fast it takes to crank to get the crank_amount
	var/crank_speed = 1 SECONDS
	/// how much gets discharged every process
	var/discharge_amount = STANDARD_CELL_CHARGE * 0.01

/obj/item/stock_parts/power_store/cell/crank/examine(mob/user)
	. = ..()
	. += span_notice("单击即可开始手摇充电。")

/obj/item/stock_parts/power_store/cell/crank/Initialize(mapload, override_maxcharge)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/stock_parts/power_store/cell/crank/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stock_parts/power_store/cell/crank/process(seconds_per_tick)
	use(discharge_amount)

/obj/item/stock_parts/power_store/cell/crank/attack_self(mob/user)
	while(charge < maxcharge)
		if(!do_after(user, crank_speed, src))
			return
		give(crank_amount)
		playsound(src, 'modular_skyrat/modules/new_cells/sound/crank.ogg', 25, FALSE)

/obj/item/stock_parts/power_store/cell/self_charge
	name = "自充电池"
	desc = "一种会随时间自行充电的特殊电池。"
	icon = 'modular_skyrat/modules/new_cells/icons/power.dmi'
	icon_state = "chargecell"
	maxcharge = STANDARD_CELL_CHARGE * 2.5
	/// how much is recharged every process
	var/recharge_amount = STANDARD_CELL_CHARGE * 0.2

/obj/item/stock_parts/power_store/cell/self_charge/Initialize(mapload, override_maxcharge)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/stock_parts/power_store/cell/self_charge/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stock_parts/power_store/cell/self_charge/process(seconds_per_tick)
	give(recharge_amount)
