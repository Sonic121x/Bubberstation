/datum/action/changeling/digitalcamo
	name = "数字伪装"
	desc = "通过进化出扭曲我们形态与比例的能力，我们得以击败摄像头上用于探测生命体的常见算法。"
	helptext = "使用此技能时，我们无法被摄像头追踪，也无法被 AI 单位看见。不过，看到我们的人类会觉得我们……有些诡异。"
	button_icon_state = "digital_camouflage"
	category = "stealth"
	dna_cost = 1
	active = FALSE

//Prevents AIs tracking you but makes you easily detectable to the human-eye.
/datum/action/changeling/digitalcamo/sting_action(mob/user)
	..()
	if(active)
		to_chat(user, span_notice("我们恢复正常。"))
		user.RemoveElement(/datum/element/digitalcamo)
	else
		to_chat(user, span_notice("我们扭曲自己的形态，以躲避 AI 的视线。"))
		user.AddElement(/datum/element/digitalcamo)
	active = !active
	return TRUE

/datum/action/changeling/digitalcamo/Remove(mob/user)
	user.RemoveElement(/datum/element/digitalcamo)
	..()
