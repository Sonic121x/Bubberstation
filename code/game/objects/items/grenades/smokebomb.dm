/**
 *This is smoke bomb, mezum koman. It is a grenade subtype. All craftmanship is of the highest quality.
 *It menaces with spikes of iron. On it is a depiction of an assistant.
 *The assistant is bleeding. The assistant has a painful expression. The assistant is dead.
 */
/obj/item/grenade/smokebomb
	name = "烟雾弹"
	desc = "如果你看到了这段说明，那可真让人无语。最好去告诉某个程序员。"
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "smokewhite"
	inhand_icon_state = "smoke"
	slot_flags = ITEM_SLOT_BELT
	///List of words we take randomly every time we're examined. It's extremely important to keep this list up to date,
	///It helps to generate the insightful description of the smokebomb
	var/static/list/bruh_moment = list(
		"带劲",
		"潮流",
		"燃爆",
		"有种",
		"强悍",
		"无语",
		"游戏高手",
		"孤狼强者",
		"老兄",
		"饭税",
		"翘臀",
		"颜值修炼",
		"舌顶塑脸",
		"气场",
		"破防",
	)

///Here we generate the extremely insightful description.
/obj/item/grenade/smokebomb/Initialize(mapload)
	. = ..()
	desc = "上面用蜡笔潦草地写着“[pick(bruh_moment)]”。"

///Here we generate some smoke and also damage blobs??? for some reason. Honestly not sure why we do that.
/obj/item/grenade/smokebomb/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	update_mob()
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	do_smoke(4, src, loc, smoke_type = /datum/effect_system/fluid_spread/smoke/bad)
	for(var/obj/structure/blob/blob in view(8, src))
		var/damage = round(30/(get_dist(blob, src) + 1))
		blob.take_damage(damage, BURN, MELEE, 0)
	qdel(src)
