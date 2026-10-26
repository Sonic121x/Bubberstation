/datum/objective_item/steal/hoslaser
	name = "安保主管的制式武器"
	targetitem = /obj/item/gun/energy/e_gun/hos
	altitems = list(/obj/item/hos_primary_case)
	steal_hint = "安保主管储物柜中的枪盒。"

/datum/objective_item/steal/compactshotty
	name = "典狱长的卡扎鲁克手套"
	targetitem = /obj/item/gun/ballistic/shotgun/automatic/combat/compact
	altitems = list(/obj/item/clothing/gloves/kaza_ruk/sec/warden)
	steal_hint = "典狱长储物柜中的一副强化卡扎鲁克手套。"

/datum/objective_item/steal/compactshotty/check_special_completion(obj/item/thing)
	return istype(thing, /obj/item/clothing/gloves/kaza_ruk/sec/warden)

/datum/objective_item/steal/executive_hudsunglasses
	name = "舰长的高级 HUD 太阳镜"
	targetitem = /obj/item/clothing/glasses/hud/security/sunglasses/guard/command
	excludefromjob = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "舰长佩戴的镀金太阳镜。拥有十一套传感器，其中两套负责寻找酒和钱。"
