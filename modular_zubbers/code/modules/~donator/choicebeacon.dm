/obj/item/sbeacondrop/carrot
	name = "胡萝卜手机"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "suspiciousphone"
	desc = "一部手机，来电者只标注为‘贾布女士’。背面的小贴纸注明，拨打给法国霸主的电话须收取5信用点服务费。"
	w_class = WEIGHT_CLASS_SMALL
	droptype = /obj/item/storage/backpack/satchel/bunnysatchel

/obj/item/sbeacondrop/carrot/attack_self(mob/user)
	if(user)
		to_chat(user, span_notice("感谢您选择贾布™购买服装！"))
		new droptype( user.loc )
		playsound(src, 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg', 100, TRUE, TRUE)
		qdel(src)
	return
