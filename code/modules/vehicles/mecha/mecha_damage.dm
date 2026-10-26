/*!
 * # Mecha defence explanation
 * Mechs focus is on a more heavy-but-slower damage approach
 * For this they have the following mechanics
 *
 * ## Backstab
 * Basically the tldr is that mechs are less flexible so we encourage good positioning, pretty simple
 * ## Armor modules
 * Pretty simple, adds armor, you can choose against what
 * ## Internal damage
 * When taking damage will force you to take some time to repair, encourages improvising in a fight
 * Targeting different def zones will damage them to encurage a more strategic approach to fights
 * where they target the "dangerous" modules
 */

/// returns a number for the damage multiplier for this relative angle/dir
/obj/vehicle/sealed/mecha/proc/get_armour_facing(relative_dir)
	switch(relative_dir)
		if(180) // BACKSTAB!
			return facing_modifiers[MECHA_BACK_ARMOUR]
		if(0, 45) // direct or 45 degrees off
			return facing_modifiers[MECHA_FRONT_ARMOUR]
	return facing_modifiers[MECHA_SIDE_ARMOUR] //if its not a front hit or back hit then assume its from the side

///tries to deal internal damaget depending on the damage amount
/obj/vehicle/sealed/mecha/proc/try_deal_internal_damage(damage)
	var/internal_damage_threshold = (max_integrity/10) /// Mech internal damage can only occur if the resulting hit exceeds a tenth of the mecha's maximum integrity in a single blow.
	if(damage < internal_damage_threshold)
		return
	if(!prob(internal_damage_probability))
		return
	var/internal_damage_to_deal = possible_int_damage
	internal_damage_to_deal &= ~internal_damage
	if(internal_damage_to_deal)
		set_internal_damage(pick(bitfield_to_list(internal_damage_to_deal)))

/// tries to repair any internal damage and plays fluff for it
/obj/vehicle/sealed/mecha/proc/try_repair_int_damage(mob/user, flag_to_heal)
	balloon_alert(user, get_int_repair_fluff_start(flag_to_heal))
	log_message("[key_name(user)] 开始修复内部损伤，标志位 [flag_to_heal]", LOG_MECHA)
	if(!do_after(user, 10 SECONDS, src))
		balloon_alert(user, get_int_repair_fluff_fail(flag_to_heal))
		log_message("标志位 [flag_to_heal] 的内部损伤修复失败。", LOG_MECHA, color="red")
		return
	clear_internal_damage(flag_to_heal)
	balloon_alert(user, get_int_repair_fluff_end(flag_to_heal))
	log_message("标志位 [flag_to_heal] 的内部损伤修复完成。", LOG_MECHA)

///gets the starting balloon alert flufftext
/obj/vehicle/sealed/mecha/proc/get_int_repair_fluff_start(flag)
	switch(flag)
		if(MECHA_INT_FIRE)
			return "正在启动内部灭火……"
		if(MECHA_INT_TEMP_CONTROL)
			return "正在重置温度模块……"
		if(MECHA_CABIN_AIR_BREACH)
			return "正在启动座舱破口密封剂……"
		if(MECHA_INT_CONTROL_LOST)
			return "正在重新校准协调系统……"
		if(MECHA_INT_SHORT_CIRCUIT)
			return "正在冲洗内部电容……"

///gets the successful finish balloon alert flufftext
/obj/vehicle/sealed/mecha/proc/get_int_repair_fluff_end(flag)
	switch(flag)
		if(MECHA_INT_FIRE)
			return "内部火焰已扑灭"
		if(MECHA_INT_TEMP_CONTROL)
			return "温度芯片已重新激活"
		if(MECHA_CABIN_AIR_BREACH)
			return "座舱破口已密封"
		if(MECHA_INT_CONTROL_LOST)
			return "协调系统已恢复"
		if(MECHA_INT_SHORT_CIRCUIT)
			return "内部电容已重置"

///gets the on-fail balloon alert flufftext
/obj/vehicle/sealed/mecha/proc/get_int_repair_fluff_fail(flag)
	switch(flag)
		if(MECHA_INT_FIRE)
			return "灭火已取消"
		if(MECHA_INT_TEMP_CONTROL)
			return "重置已中止"
		if(MECHA_CABIN_AIR_BREACH)
			return "密封剂已停用"
		if(MECHA_INT_CONTROL_LOST)
			return "重新校准失败"
		if(MECHA_INT_SHORT_CIRCUIT)
			return "电容冲洗失败"

/obj/vehicle/sealed/mecha/proc/set_internal_damage(int_dam_flag)
	internal_damage |= int_dam_flag
	log_message("内部损伤类型 [int_dam_flag]。", LOG_MECHA)
	SEND_SOUND(occupants, sound('sound/machines/warning-buzzer.ogg',wait=0))
	diag_hud_set_mechstat()

/obj/vehicle/sealed/mecha/proc/clear_internal_damage(int_dam_flag)
	if(internal_damage & int_dam_flag)
		switch(int_dam_flag)
			if(MECHA_INT_TEMP_CONTROL)
				to_chat(occupants, "[icon2html(src, occupants)][span_boldnotice("生命维持系统已重新激活。")]")
			if(MECHA_INT_FIRE)
				to_chat(occupants, "[icon2html(src, occupants)][span_boldnotice("内部火焰已扑灭。")]")
			if(MECHA_CABIN_AIR_BREACH)
				to_chat(occupants, "[icon2html(src, occupants)][span_boldnotice("座舱破口已密封。")]")
			if(MECHA_INT_CONTROL_LOST)
				to_chat(occupants, "[icon2html(src, occupants)][span_boldnotice("控制模块已重新激活。")]")
			if(MECHA_INT_SHORT_CIRCUIT)
				to_chat(occupants, "[icon2html(src, occupants)][span_boldnotice("内部电容已成功重置。")]")
	internal_damage &= ~int_dam_flag
	diag_hud_set_mechstat()
