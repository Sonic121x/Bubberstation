/datum/orderable_item/mining/survival_bodybag
	purchase_path = /obj/item/bodybag/environmental
	cost_per_order = 500

/datum/orderable_item/mining/suit_voucher
	purchase_path = /obj/item/suit_voucher
	cost_per_order = 2000

/obj/item/kinetic_crusher/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/obj/item/kinetic_crusher/proc/on_reskin(mob/our_mob)
	SIGNAL_HANDLER
	if(icon_state == "crusher_glaive")
		name = "原型动能长刃"
		desc = "一柄改装过的原型动能粉碎器，本质上仍不过是把各种采矿工具拼凑起来\
			而成的高科技长刀，装有护手与歌利亚皮革握柄。它虽与未经改装的同型产品同样有效，\
		但除了最娴熟——或最想不开——的人之外，依旧帮不上什么忙。"
		attack_verb_continuous = list("切割着", "劈砍着", "剁开着", "砍剁着", "刺着")
		attack_verb_simple = list("切", "劈", "剁", "砍", "刺")
		inhand_x_dimension = 64
		inhand_y_dimension = 64
		our_mob.update_held_items()
