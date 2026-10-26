/datum/action/cooldown/spell/conjure/bee
	name = "次级召唤蜜蜂"
	desc = "这个法术以魔法之力踢了一脚跨维度蜂巢， \
		瞬间在你所在处召唤出一群蜜蜂。 \
		这些蜜蜂对任何人都绝不友好。"
	button_icon_state = "bee"
	sound = 'sound/mobs/humanoids/moth/scream_moth.ogg'

	school = SCHOOL_CONJURATION
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 10 SECONDS

	invocation = "别是蜜蜂！"
	invocation_type = INVOCATION_SHOUT

	summon_radius = 3
	summon_type = list(/mob/living/basic/bee/toxin)
	summon_amount = 9
