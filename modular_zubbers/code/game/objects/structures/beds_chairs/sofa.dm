/// Looking through pillows on sofas when rightclicked
/obj/structure/chair/sofa/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!ishuman(user) || !user.ckey)
		return
	balloon_alert(user, "正在翻找靠垫下面……")
	to_chat(user, span_alert("你开始仔细翻找沙发的靠垫……"))
	if(do_after(user, 10 SECONDS, src))
		if(prob(10))
			balloon_alert(user, "找到了东西")
			if(prob(1))
				do_sparks(5, TRUE, loc, spark_type = /datum/effect_system/basic/spark_spread/quantum)
				new /obj/item/disk/nuclear/fake(loc)
			else
				// New epic way of making money. Totally
				new /obj/item/coin/iron(loc)
		else
			balloon_alert(user, "什么也没有")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
