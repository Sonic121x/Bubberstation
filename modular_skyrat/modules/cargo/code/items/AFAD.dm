#define PHYSICAL_DAMAGE_HEALING -0.2
#define EXOTIC_DAMAGE_HEALING -0.1

/obj/item/gun/medbeam/afad
	name = "自动急救装置"
	desc = "AFAD 通常随医疗包配发，是一款用于处理擦伤与瘀伤的革命性装置，绝对不是什么传奇医疗光束枪的仿制品。底面贴着标签，提醒你不要让光束交叉。"
	icon = 'icons/obj/chronos.dmi'
	icon_state = "chronogun"
	inhand_icon_state = "chronogun"
	w_class = WEIGHT_CLASS_NORMAL



/obj/item/gun/medbeam/afad/on_beam_tick(mob/living/target)
	if(target.health != target.maxHealth)
		new /obj/effect/temp_visual/heal(get_turf(target), "#80F5FF")
	target.adjust_brute_loss(PHYSICAL_DAMAGE_HEALING)
	target.adjust_fire_loss(PHYSICAL_DAMAGE_HEALING)
	target.adjust_tox_loss(EXOTIC_DAMAGE_HEALING)
	target.adjust_oxy_loss(EXOTIC_DAMAGE_HEALING)
	return

#undef PHYSICAL_DAMAGE_HEALING
#undef EXOTIC_DAMAGE_HEALING
