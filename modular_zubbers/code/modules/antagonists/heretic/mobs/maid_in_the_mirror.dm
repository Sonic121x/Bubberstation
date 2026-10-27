/mob/living/basic/heretic_summon/maid_in_the_mirror/examine(mob/user)
	. = ..()

	. += span_notice("免疫激光，但易受近战和实弹伤害。被观察时会受到伤害。")
	. += span_notice("攻击会施加虚空寒冷——一种可叠加的降温减益，但也能被利用来治疗。")
	. += span_notice("拥有透视视觉。")
	. += span_notice("靠近玻璃时可以相位穿行。")
