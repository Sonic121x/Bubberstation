/datum/action/cooldown/spell/conjure/presents
	name = "变出礼物！"
	desc = "此法术让你能把手伸进 S 空间取出礼物！好耶！"

	school = SCHOOL_CONJURATION
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 13.75 SECONDS

	invocation = "呵呵呵！"
	invocation_type = INVOCATION_SHOUT

	summon_radius = 3
	summon_type = list(/obj/item/gift)
	summon_amount = 5
