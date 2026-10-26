/obj/item/smelling_salts
	name = "嗅盐"
	desc = "一小堆类似盐的物质，气味恶心得令人难以忍受。据说味道刺鼻到连死人都会活过来，只为逃离它。"
	icon_state = "smelling_salts"
	icon = 'modular_skyrat/modules/primitive_catgirls/icons/salts.dmi'
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	item_flags = NOBLUDGEON

/obj/item/smelling_salts/attack(mob/living/mob_attacked, mob/user)
	. = ..()
	if(!iscarbon(mob_attacked))
		to_chat(user, span_warning("仔细想想，[src]或许对[mob_attacked]不起作用。"))
		return

	if(mob_attacked == user)
		to_chat(user, span_warning("你实在无法让[src]靠近自己的脸。"))
		return

	if(mob_attacked.stat != DEAD)
		to_chat(user, span_warning("仔细想想，如果[mob_attacked]还没<b>死</b>，也许不该用这个。"))
		return

	try_revive(mob_attacked, user)

/// If the right conditions are present (basically could this person be defibrilated), revives the target
/obj/item/smelling_salts/proc/try_revive(mob/living/carbon/carbon_target, mob/user)
	carbon_target.grab_ghost()

	if(!do_after(user, 3 SECONDS, carbon_target))
		user.balloon_alert(user, "已停止复苏[carbon_target]")
		return

	if(carbon_target.stat != DEAD)
		to_chat(user, span_warning("等等，[carbon_target]其实还没<b>死</b>！"))
		return
	carbon_target.notify_revival("有人正在尝试让你复活！")

	user.balloon_alert_to_viewers("正在尝试复苏[carbon_target]")

	var/defib_result = carbon_target.can_defib()
	var/fail_reason

	switch (defib_result)
		if (DEFIB_FAIL_SUICIDE, DEFIB_FAIL_BLACKLISTED, DEFIB_FAIL_NO_INTELLIGENCE)
			fail_reason = "[carbon_target]毫无反应……你觉得对方不会回来了。"
		if (DEFIB_FAIL_NO_HEART, DEFIB_FAIL_FAILING_HEART, DEFIB_FAIL_FAILING_BRAIN)
			fail_reason = "[carbon_target]似乎有一点反应，但身体里一定有你看不到的问题……"
		if (DEFIB_FAIL_TISSUE_DAMAGE, DEFIB_FAIL_HUSK)
			fail_reason = "[carbon_target]的身体损坏得太严重，这恐怕没用了……"
		if (DEFIB_FAIL_NO_BRAIN)
			fail_reason = "[carbon_target]的头部似乎缺少什么重要的东西。"

	if(carbon_target.get_organic_health() <= HEALTH_THRESHOLD_CRIT)
		fail_reason = "[carbon_target]的身体损伤程度还是超出了复苏条件……"

	if(fail_reason)
		to_chat(user, span_boldwarning("[fail_reason]"))
		return

	carbon_target.adjust_oxy_loss(amount = HEALTH_THRESHOLD_CRIT, updating_health = TRUE, forced = TRUE)
	playsound(src, 'modular_skyrat/modules/emotes/sound/emotes/female/female_sniff.ogg', 50, FALSE)

	if(defib_result == DEFIB_POSSIBLE)
		carbon_target.grab_ghost()

	carbon_target.revive()
	to_chat(carbon_target, span_userdanger("[CONFIG_GET(string/blackoutpolicy)]"))
	log_combat(user, carbon_target, "revived", src)
