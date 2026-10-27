/obj/item/organ/heart/gland/access
	abductor_hint = "全身描记电扰器。激活后，使被绑架者获得固有全域通行权限。"
	cooldown_low = 600
	cooldown_high = 1200
	uses = 1
	icon_state = "mindshock"
	mind_control_uses = 3
	mind_control_duration = 900

/obj/item/organ/heart/gland/access/activate()
	to_chat(owner, span_notice("你不知为何感觉自己像位贵宾。"))
	owner.AddComponent(/datum/component/simple_access, SSid_access.get_region_access_list(list(REGION_ALL_GLOBAL)), src)
