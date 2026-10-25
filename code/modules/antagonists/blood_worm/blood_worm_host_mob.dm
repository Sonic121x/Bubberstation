/mob/living/blood_worm_host
	name = "宿主"
	desc = "……你到底是怎么查看这个的？这东西连实体都没有。"

	var/datum/action/changeling_expel_worm/expel_worm_action

/mob/living/blood_worm_host/Login()
	. = ..()
	if (!.)
		return

	if (IS_CHANGELING(src))
		to_chat(src, span_good("你体内的血虫对你的基因能力毫无抵抗之力！"))

		if (!expel_worm_action)
			expel_worm_action = new(src)
			expel_worm_action.Grant(src)
