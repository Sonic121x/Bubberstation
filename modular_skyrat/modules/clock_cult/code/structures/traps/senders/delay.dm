/obj/item/wallframe/clocktrap/delay
	name = "发条定时器"
	desc = "一个拆下来的小型定时器。"
	icon_state = "delayer"
	result_path = /obj/structure/destructible/clockwork/trap/delay
	clockwork_desc = "一种可安装在墙上的装置。接收到输入信号后，它会在可配置（用多用工具调整）的时间之后发送输出信号。"


/obj/structure/destructible/clockwork/trap/delay
	name = "发条定时器"
	desc = "一个安装在墙上的小型定时器。"
	icon_state = "delayer"
	component_datum = /datum/component/clockwork_trap/delay
	unwrench_path = /obj/item/wallframe/clocktrap/delay
	max_integrity = 15
	clockwork_desc = "接收到输入信号后，它会在可配置（用多用工具调整）的时间之后发送输出信号。"
	/// How much time the signal is delayed
	var/delay_time = 1 SECONDS


/obj/structure/destructible/clockwork/trap/delay/multitool_act(mob/living/user, obj/item/tool)
	delay_time = tgui_input_number(user, "输入延迟时间", "发条定时器", 1 SECONDS, 120 SECONDS, 1 SECONDS)
	return TRUE


/datum/component/clockwork_trap/delay
	takes_input = TRUE
	sends_input = TRUE
	/// If the trap is active or not
	var/active = FALSE


/datum/component/clockwork_trap/delay/trigger()
	if(!..() || active)
		return

	active = TRUE
	flick("delayer_active", parent)

	var/obj/structure/destructible/clockwork/trap/delay/parent_delayer = parent
	addtimer(CALLBACK(src, PROC_REF(finish)), parent_delayer.delay_time)


/// Finish the delay, trigger any traps
/datum/component/clockwork_trap/delay/proc/finish()
	active = FALSE
	trigger_connected()
