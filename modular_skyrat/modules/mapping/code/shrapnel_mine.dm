/obj/effect/mine/shrapnel/human_only
	name = "精密破片地雷"
	desc = "一枚致命的地雷，这一枚似乎被改装成只对人类触发的了？"

/obj/effect/mine/shrapnel/human_only/on_entered(datum/source, atom/movable/AM)
	if(!ishuman(AM))
		return
	. = ..()
