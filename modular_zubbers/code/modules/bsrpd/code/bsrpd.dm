#define BSRPD_CAPACITY_MAX 500
#define BSRPD_CAPACITY_USE 10
#define BSRPD_CAPACITY_NEW 250

/obj/item/pipe_dispenser/bluespace
	name = "蓝空间快速管道分配器"
	desc = "纳米传讯科学家正在测试的最先进技术；这是他们唯一能用的原型机。"
	icon = 'modular_zubbers/icons/obj/bsrpd.dmi'
	icon_state = "bsrpd"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/bsrpd_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/bsrpd_righthand.dmi'
	inhand_icon_state = "bsrpd"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	custom_materials = null
	var/current_capacity = BSRPD_CAPACITY_MAX
	var/ranged_use_cost = BSRPD_CAPACITY_USE
	var/in_use = FALSE
	/// Flag to check if we should use remote piping
	var/remote_piping_toggle = FALSE

/obj/item/pipe_dispenser/bluespace/attackby(obj/item/item, mob/user, param)
	if(istype(item, /obj/item/stack/sheet/bluespace_crystal))
		if(BSRPD_CAPACITY_NEW > (BSRPD_CAPACITY_MAX - current_capacity) || ranged_use_cost == 0)
			to_chat(user, span_warning("你无法再为 [src] 充能了！"))
			return
		item.use(1)
		to_chat(user, span_notice("你为 [src] 内部的蓝空间电容充了能。"))
		current_capacity += BSRPD_CAPACITY_NEW
		return
	if(istype(item, /obj/item/assembly/signaler/anomaly/bluespace))
		if(ranged_use_cost)
			to_chat(user, span_notice("你把 [item] 装入 [src]，让蓝空间电容超载强化！"))
			ranged_use_cost = 0
			qdel(item)
		else
			to_chat(user, span_warning("你无法进一步强化 [src] 了。"))
		return
	return ..()

/obj/item/pipe_dispenser/bluespace/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += "当前剩余 [ranged_use_cost == 0 ? "无限" : current_capacity / ranged_use_cost] 次充能。"
		if(ranged_use_cost != 0)
			. += "蓝空间异常核心插槽是空的。"
	else
		. += "你看不到充能容量。"

	. += span_notice("<b>按住 Alt 左键</b>可切换远程铺管。")

/obj/item/pipe_dispenser/bluespace/click_alt(mob/user)
	remote_piping_toggle = !remote_piping_toggle
	balloon_alert(user, "远程铺管[remote_piping_toggle ? "已开启" : "已关闭"]")
	playsound(get_turf(src), 'sound/machines/click.ogg', 50, TRUE)
	return CLICK_ACTION_SUCCESS

/obj/item/pipe_dispenser/bluespace/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!remote_piping_toggle) // If we are in proximity to the target or have our safety on, don't use charge and don't call this shitcode.
		return NONE
	if(current_capacity < ranged_use_cost)
		to_chat(user, span_warning("[src] 的充能不足以这么做。"))
		return ITEM_INTERACT_BLOCKING
	if(!in_use)
		user.Beam(interacting_with, icon_state = "rped_upgrade", time = 1 SECONDS)
		in_use = TRUE // So people can't just spam click and get more uses
		addtimer(VARSET_CALLBACK(src, in_use, FALSE),  1 SECONDS, TIMER_UNIQUE)
		if(interact_with_atom(interacting_with, user, modifiers))
			current_capacity -= ranged_use_cost
			return ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_BLOCKING

#undef BSRPD_CAPACITY_MAX
#undef BSRPD_CAPACITY_USE
#undef BSRPD_CAPACITY_NEW
