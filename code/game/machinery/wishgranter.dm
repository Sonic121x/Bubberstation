/obj/machinery/wish_granter
	name = "许愿机"
	desc = "你已经开始拿不定主意了……"
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "syndbeacon"

	use_power = NO_POWER_USE
	density = TRUE

	var/charges = 1
	var/insisting = 0

/obj/machinery/wish_granter/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(charges <= 0)
		to_chat(user, span_boldnotice("许愿机一片沉寂。"))
		return

	else if(!ishuman(user))
		to_chat(user, span_boldnotice("你感到许愿机内部有某种黑暗在蠢动，那是你绝不想沾染的东西。你的直觉比任何人类都敏锐。"))
		return

	else if(user.is_antag())
		to_chat(user, span_boldnotice("即便你的内心如此阴暗，也知道这不会带来好事。某种本能让你退缩了。"))

	else if (!insisting)
		to_chat(user, span_boldnotice("你的首次触碰使许愿机苏醒，开始倾听你的心声。你真的确定要这么做吗？"))
		insisting++

	else
		to_chat(user, span_boldnotice("你开口说道：[pick("我要空间站消失","人性腐朽，人类必须毁灭","我要变得富有", "我要统治世界","我要永生")]。许愿机回应了。"))
		to_chat(user, span_boldnotice("你的头一阵剧痛，随后视野恢复清晰。你是许愿机的化身，拥有无穷无尽的力量！这一切都属于你。你必须确保没人能将它夺走。首先，不能让任何人知道。"))

		charges--
		insisting = 0

		user.mind.add_antag_datum(/datum/antagonist/wishgranter)

		to_chat(user, span_warning("你对此有种极其不祥的预感。"))

	return
