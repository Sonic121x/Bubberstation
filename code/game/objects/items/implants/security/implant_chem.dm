/obj/item/implant/chem
	name = "化学植入体"
	desc = "可注入各种物质。"
	icon_state = "reagents"
	actions_types = null
	implant_flags = IMPLANT_TYPE_SECURITY
	hud_icon_state = "hud_imp_chem"
	custom_materials = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	/// All possible injection sizes for the implant shown in the prisoner management console.
	var/list/implant_sizes = list(1, 5, 10)
	/// Frequency of radio signal we've been synced to
	var/frequency
	/// Code of radio signal we've been synced to
	var/code


	implant_info = "需在植入体盒内用注射器注入药剂。植入时自动激活。\
		可将药剂远程直接释放至被植入者的血液中。可与远程信号装置同步。"

	implant_lore = "强劲公司 MJ-420 远程化学释放植入体是一种远程控制的微胶囊网络，\
		设计为在仍处于植入体盒内时通过注射器填充。植入后，\
		可通过囚犯管理控制台访问 MJ-420，将可控剂量的药剂直接释放到被植入者的血液中，\
		这对于控制性释放镇静剂、抗精神病药物，\
		或对特别危险的囚犯执行注射死刑都很有用。被植入者死亡时，\
		它会分解并将所有药剂释放进其血液。"

/obj/item/implant/chem/is_shown_on_console(obj/machinery/computer/prisoner/management/console)
	return !frequency && is_valid_z_level(get_turf(console), get_turf(imp_in))

/obj/item/implant/chem/get_management_console_data()
	var/list/info_shown = ..()
	info_shown["容量"] = "[reagents.total_volume]u"
	return info_shown

/obj/item/implant/chem/get_management_console_buttons()
	var/list/buttons = ..()
	for(var/i in implant_sizes)
		UNTYPED_LIST_ADD(buttons, list(
			"name" = "注入 [i]u",
			"color" = "good",
			"action_key" = "inject",
			"action_params" = list("amount" = i),
		))
	return buttons

/obj/item/implant/chem/handle_management_console_action(mob/user, list/params, obj/machinery/computer/prisoner/management/console)
	. = ..()
	if(.)
		return

	if(params["implant_action"] == "inject")
		var/amount = text2num(params["amount"])
		if(!(amount in implant_sizes))
			return TRUE

		var/reagents_inside = reagents.get_reagent_log_string()
		activate(amount)
		log_combat(user, imp_in, "injected [amount] units of [reagents_inside]", src)
		return TRUE

/obj/item/implant/chem/Initialize(mapload)
	. = ..()
	create_reagents(50, OPENCONTAINER)

/obj/item/implant/chem/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(. && !frequency)
		RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/obj/item/implant/chem/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_LIVING_DEATH)

/obj/item/implant/chem/proc/on_death(mob/living/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, TYPE_PROC_REF(/obj/item/implant/chem, activate), reagents.total_volume)

/obj/item/implant/chem/activate(cause)
	. = ..()
	if(!cause || !imp_in)
		return
	var/mob/living/carbon/victim = imp_in
	var/injectamount = null
	if (cause == "action_button")
		injectamount = reagents.total_volume
	else
		injectamount = cause
	reagents.trans_to(victim, injectamount, methods = INJECT)
	to_chat(victim, span_hear("你听到一声微弱的哔声。"))
	if(!reagents.total_volume)
		to_chat(victim, span_hear("你听到胸口传来一声微弱的咔嗒声。"))
		qdel(src)

/obj/item/implant/chem/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/assembly/signaler))
		signaler_sync(tool, user)
		return ITEM_INTERACT_SUCCESS
	return ..()

/obj/item/implant/chem/proc/signaler_sync(obj/item/assembly/signaler/syncing_signaler, mob/living/user)
	to_chat(user, "你将 \the [src] 同步至 \the [syncing_signaler] 的代码与频率[frequency ? "" : "，同时禁用了其他激活方式"]。")
	code = syncing_signaler.code
	SSradio.remove_object(src, frequency)
	frequency = syncing_signaler.frequency
	SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/implant/chem/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return
	activate(reagents.total_volume)

/obj/item/implantcase/chem
	name = "植入体盒 -“远程化学”"
	desc = "一个玻璃盒，内含一个远程化学植入体。"
	imp_type = /obj/item/implant/chem
