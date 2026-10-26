/datum/scripture/integration_cog
	name = "整合齿轮"
	desc = "制造一枚整合齿轮，可插入 APC 中汲取电力并解锁经文。"
	tip = "将整合齿轮装入 APC，以增加你的能量储备并解锁新的经文。"
	button_icon_state = "Integration Cog"
	invocation_time = 1 SECONDS
	invocation_text = list("Tick tock Eng'Ine...")
	category = SPELLTYPE_SERVITUDE

/datum/scripture/integration_cog/invoke_success()
	if(invoker.put_in_hands(new /obj/item/clockwork/integration_cog))
		to_chat(invoker, span_brass("你召唤了一枚整合齿轮到手中。"))
		playsound(src, 'sound/machines/click.ogg', 50)
		return TRUE

	else
		to_chat(invoker, span_brass("你将一枚整合齿轮召唤到了地上。"))
		playsound(src, 'sound/machines/click.ogg', 50)
		return FALSE
