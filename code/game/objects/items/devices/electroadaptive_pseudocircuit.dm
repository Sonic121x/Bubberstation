#define MIN_ENERGY_COST (0.01 * STANDARD_CELL_CHARGE)
#define MAX_ENERGY_COST (0.5 * STANDARD_CELL_CHARGE)

//Used by engineering cyborgs in place of generic circuits.
/obj/item/electroadaptive_pseudocircuit
	name = "电适应伪电路"
	desc = "集电路印刷机、设计师、合成器、装备员、创造者和厨师于一身。建造时可替代任何通用电路板。"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "boris"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
	var/recharging = FALSE
	var/circuits = 5 //How many circuits the pseudocircuit has left
	var/static/recycleable_circuits = typecacheof(list(
		/obj/item/electronics/firelock,
		/obj/item/electronics/airalarm,
		/obj/item/electronics/firealarm,
		/obj/item/electronics/apc,
	))//A typecache of circuits consumable for material

/obj/item/electroadaptive_pseudocircuit/Initialize(mapload)
	. = ..()
	maptext = MAPTEXT(circuits)

/obj/item/electroadaptive_pseudocircuit/examine(mob/user)
	. = ..()
	if(iscyborg(user))
		. += "[span_notice("材料足以制造<b>[circuits]</b>块电路板。对现有电路使用伪电路可获取材料。")]\n"+\
		"[span_notice("可替代<b>火灾/空气警报器</b>、<b>防火门</b>和<b>区域电力控制器</b>的电子元件。")]\n"+\
		span_notice("也可以对未安装电池的区域电力控制器使用，以高额能耗<b>制造低容量电池</b>。")

/obj/item/electroadaptive_pseudocircuit/proc/adapt_circuit(mob/living/silicon/robot/R, circuit_cost = 0)
	if(QDELETED(R) || !istype(R))
		return
	if(!R.cell)
		to_chat(R, span_warning("你需要安装电池才能这样做。"))
		return
	if(recharging)
		to_chat(R, span_warning("[src]需要先充能一段时间。"))
		return
	if(!R.cell.use(circuit_cost))
		to_chat(R, span_warning("你的能量不足（需要[display_energy(circuit_cost)]）。"))
		return
	if(!circuits)
		to_chat(R, span_warning("你需要更多材料。对现有的简单电路使用[src]可将其分解。"))
		return
	playsound(R, 'sound/items/tools/rped.ogg', 50, TRUE)
	recharging = TRUE
	circuits--
	maptext = MAPTEXT(circuits)
	icon_state = "[initial(icon_state)]_recharging"
	var/recharge_time = (circuit_cost - MIN_ENERGY_COST) / (MAX_ENERGY_COST - MIN_ENERGY_COST)
	recharge_time = clamp(recharge_time, 0, 1)
	recharge_time = (5 SECONDS) + (55 SECONDS) * recharge_time //anywhere between 5 seconds to 1 minute
	addtimer(CALLBACK(src, PROC_REF(recharge)), ROUND_UP(recharge_time))
	return TRUE //The actual circuit magic itself is done on a per-object basis

/obj/item/electroadaptive_pseudocircuit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!is_type_in_typecache(interacting_with, recycleable_circuits))
		return NONE
	circuits++
	maptext = MAPTEXT(circuits)
	user.visible_message(
		span_notice("[user]用[src]分解了[interacting_with]。"),
		span_notice("你将[interacting_with]回收进[src]，现有材料足以制造<b>[circuits]</b>块电路板。")
	)
	playsound(user, 'sound/items/deconstruct.ogg', 50, TRUE)
	qdel(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/electroadaptive_pseudocircuit/proc/recharge()
	playsound(src, 'sound/machines/chime.ogg', 25, TRUE)
	recharging = FALSE
	icon_state = initial(icon_state)

#undef MIN_ENERGY_COST
#undef MAX_ENERGY_COST
