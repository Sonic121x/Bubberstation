/obj/item/wallframe/clocktrap/lever
	name = "开关"
	desc = "一个安装在墙上的小开关。"
	icon_state = "lever"
	result_path = /obj/structure/destructible/clockwork/trap/lever
	clockwork_desc = "一种可安装在墙上的装置，让你能向已连接的陷阱发送信号。"


/obj/structure/destructible/clockwork/trap/lever
	name = "开关"
	desc = "一个安装在墙上的小开关。"
	icon_state = "lever"
	unwrench_path = /obj/item/wallframe/clocktrap/lever
	component_datum = /datum/component/clockwork_trap/lever
	max_integrity = 75
	clockwork_desc = "一种让你能向已连接的陷阱发送信号的装置。"


/datum/component/clockwork_trap/lever
	sends_input = TRUE


/datum/component/clockwork_trap/lever/attack_hand(mob/user)
	trigger_connected()
	to_chat(user, span_notice("你按下了开关。"))
	playsound(user, 'sound/machines/click.ogg', 50)
