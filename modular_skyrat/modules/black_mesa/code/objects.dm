/obj/item/minespawner/explosive
	name = "未激活的爆炸性地雷"
	desc = "激活后会在 3 秒内展开成一颗高爆地雷，非常适合那些懒得费力加固工事的军人。"

	mine_type = /obj/effect/mine/explosive

/obj/item/minespawner/explosive/nri

	mine_type = /obj/effect/mine/explosive/nri

/// A nerfed down version of a landmine I really should've done a long time ago but only did it now.
/obj/effect/mine/explosive/nri
	name = "爆炸地雷"
	range_devastation = 0
	range_heavy = 0
	range_light = 2
	range_flame = 1
	range_flash = 3
	/// Stun time after an activation.
	var/stun_time = 100

/obj/effect/mine/explosive/nri/mineEffect(mob/living/victim)
	explosion(src, range_devastation, range_heavy, range_light, range_flame, range_flash)
	if(isliving(victim))
		victim.Paralyze(stun_time)
