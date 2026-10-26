#define PULSE_DISTANCE_RANGE 2

/obj/machinery/vending/runic_vendor
	name = "\improper 符文售货机"
	desc = "这台售货机是为战争而设计的！是引诱纳米传讯船员消费欲的完美诱饵。"
	icon_state = "RunicVendor"
	panel_type = "panel10"
	product_slogans = "来领取免费魔法！;今天雷神之锤半价！; 买一支传送哨，再免费送一支！"
	vend_reply = "请站在售货机旁不要动，等待你的特殊包裹！"
	resistance_flags = FIRE_PROOF
	light_mask = "RunicVendor-light-mask"
	obj_flags = parent_type::obj_flags | NO_DEBRIS_AFTER_DECONSTRUCTION
	/// How long the vendor stays up before it decays.
	var/time_to_decay = 30 SECONDS
	/// Area around the vendor that will pushback nearby mobs.
	var/pulse_distance = PULSE_DISTANCE_RANGE
	allow_custom = FALSE

/obj/machinery/vending/runic_vendor/Initialize(mapload)
	if(mapload)
		log_mapping("[type] 不应被放置在地图上，它会在设定时间后消散")
		stack_trace("Someone mapped in the meme vending machine the wizard scepter spawns, please remove it")

	addtimer(CALLBACK(src, PROC_REF(decay)), time_to_decay, TIMER_STOPPABLE)
	INVOKE_ASYNC(src, PROC_REF(runic_pulse))

	switch(pick(1,3))
		if(1)
			products = list(
			/obj/item/clothing/head/wizard = 1,
			/obj/item/clothing/suit/wizrobe = 1,
			/obj/item/clothing/shoes/sandal/magic = 1,
			/obj/item/toy/foam_runic_scepter = 1,
			)
		if(2)
			products = list(
			/obj/item/clothing/head/wizard/red = 1,
			/obj/item/clothing/suit/wizrobe/red = 1,
			/obj/item/clothing/shoes/sandal/magic = 1,
			/obj/item/toy/foam_runic_scepter = 1,
			)
		if(3)
			products = list(
			/obj/item/clothing/head/wizard/yellow = 1,
			/obj/item/clothing/suit/wizrobe/yellow = 1,
			/obj/item/clothing/shoes/sandal/magic = 1,
			/obj/item/toy/foam_runic_scepter = 1,
			)

	return ..()

/obj/machinery/vending/runic_vendor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(held_item)
		if(istype(held_item, /obj/item/runic_vendor_scepter))
			context[SCREENTIP_CONTEXT_LMB] = "引爆"
			context[SCREENTIP_CONTEXT_RMB] = "强力推斥"

		return CONTEXTUAL_SCREENTIP_SET

	return .

/obj/machinery/vending/runic_vendor/handle_deconstruct(disassembled)
	SHOULD_NOT_OVERRIDE(TRUE)

	visible_message(span_warning("[src] 闪烁了一下便消失了！"))
	playsound(src,'sound/items/weapons/resonator_blast.ogg',25,TRUE)
	return ..()

/obj/machinery/vending/runic_vendor/proc/runic_explosion()
	explosion(src, light_impact_range = 2)
	deconstruct(FALSE)

/obj/machinery/vending/runic_vendor/proc/runic_pulse()
	var/pulse_locs = spiral_range_turfs(pulse_distance, get_turf(src))
	var/list/hit_things = list()
	for(var/turf/pulsing_turf in pulse_locs)
		for(var/mob/living/mob_to_be_pulsed_back in pulsing_turf.contents)
			hit_things += mob_to_be_pulsed_back
			var/atom/target = get_edge_target_turf(mob_to_be_pulsed_back, get_dir(src, get_step_away(mob_to_be_pulsed_back, src)))
			to_chat(mob_to_be_pulsed_back, span_userdanger("力场以巨大的力量将你弹开！"))
			playsound(src, 'sound/effects/gravhit.ogg', 50, TRUE)
			mob_to_be_pulsed_back.throw_at(target, 4, 4)

/obj/machinery/vending/runic_vendor/screwdriver_act(mob/living/user, obj/item/I)
	runic_explosion()

/obj/machinery/vending/runic_vendor/proc/decay()
	deconstruct(FALSE)

#undef PULSE_DISTANCE_RANGE
