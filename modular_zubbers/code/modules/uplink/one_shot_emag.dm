/obj/item/card/emag/one_shot
	name = "密码序列器"
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_DETECTIVE, JOB_HEAD_OF_SECURITY)
	special_desc = "只要仔细一看，你就能立刻认出这是一把真正的密码序列器，这种东西在无数黑市上被成批低价交易。它们以不可靠著称，做工粗劣，用一次就会坏掉。"
	/// How many uses does it have left?
	var/charges = 1
	/// Who summoned this?
	var/caller

/obj/item/card/emag/one_shot/examine(mob/user)
	. = ..()
	if(user == caller)
		. += span_notice("它看起来很廉价，他们确实说过这东西只能用一次……")
	else
		. += span_notice("它看起来很单薄，和“咚克公司”的玩具一模一样。")

/obj/item/card/emag/one_shot/can_emag(atom/target, mob/user)
	if(charges <= 0)
		balloon_alert(user, "毫无反应！")
		return FALSE
	use_charge(user)
	return TRUE

/obj/item/card/emag/one_shot/proc/use_charge(mob/user)
	balloon_alert(user, "充能已耗尽！")
	charges --
