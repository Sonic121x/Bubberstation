/datum/action/cooldown/spell/pointed/projectile/fireball
	name = "火球术"
	desc = "向目标发射一枚会爆炸的火球。"
	button_icon_state = "fireball0"

	sound = 'sound/effects/magic/fireball.ogg'
	school = SCHOOL_EVOCATION
	cooldown_time = 6 SECONDS
	cooldown_reduction_per_rank = 1 SECONDS // 1 second reduction per rank

	invocation = "ONI SOMA!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	active_msg = "你准备施放火球术！"
	deactive_msg = "你熄灭了火球……暂时而已。"
	cast_range = 8
	projectile_type = /obj/projectile/magic/fireball

/datum/action/cooldown/spell/pointed/projectile/fireball/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	to_fire.range = (6 + 2 * spell_level)
