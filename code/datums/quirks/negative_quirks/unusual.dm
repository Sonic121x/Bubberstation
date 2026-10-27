/datum/quirk/touchy
	name = "Touchy"
	desc = "你十分依赖触觉，只有伸手能够碰到的东西才能仔细查看。"
	icon = FA_ICON_HAND
	value = -2
	gain_text = span_danger("你感觉自己无法从远处查看东西了。")
	lose_text = span_notice("你感觉自己又能从远处查看东西了。")
	medical_record_text = "患者无法从远处辨别物体。"
	hardcore_value = 4

/datum/quirk/touchy/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_CLICK_SHIFT, PROC_REF(examinate_check))

/datum/quirk/touchy/remove()
	UnregisterSignal(quirk_holder, COMSIG_CLICK_SHIFT)

///Checks if the mob is besides the  thing being examined, if they aren't then we cancel their examinate.
/datum/quirk/touchy/proc/examinate_check(mob/examiner, atom/examined)
	SIGNAL_HANDLER

	if(!examined.Adjacent(examiner))
		return COMSIG_MOB_CANCEL_CLICKON
