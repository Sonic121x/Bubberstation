/obj/item/key
	name = "钥匙"
	desc = "一把小号的灰色钥匙。"
	icon = 'icons/mob/rideables/vehicles.dmi'
	icon_state = "key"
	w_class = WEIGHT_CLASS_TINY

/obj/item/key/atv
	name = "全地形车钥匙"
	desc = "一把小号的灰色钥匙，用于启动和驾驶全地形车。"

/obj/item/key/security
	desc = "一个钥匙圈，挂着一把小钢钥匙，还有一个橡胶电棍挂饰。"
	icon_state = "keysec"

/obj/item/key/security/suicide_act(mob/living/user)
	if(!user.emote("spin")) //In the off chance that someone attempts this suicide while under the effects of mime's bane they deserve the silliness.
		user.visible_message(span_suicide("[user] 把 \the [src] 塞进耳朵里，发动了马达！看样子是想自杀……但它只是突突几声就熄火了！ "))
		playsound(src, 'sound/misc/sadtrombone.ogg', 50, TRUE, -1)
		return SHAME
	user.visible_message(span_suicide("[user] 把 \the [src] 塞进耳朵里，发动了马达！看样子是想自杀！"))
	user.say("轰轰！！", forced="secway key suicide") //Not doing a shamestate here, because even if they fail to speak they're spinning.
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/, gib)), 2 SECONDS)
	return MANUAL_SUICIDE

/obj/item/key/janitor
	desc = "一个钥匙圈，挂着一把小钢钥匙和一块粉色吊牌，上面写着“猫咪快车”。"
	icon_state = "keyjanitor"
	icon_angle = 90
	force = 2
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 9
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("捅", "戳")
	attack_verb_simple = list("捅", "戳")
	sharpness = SHARP_EDGED
	embed_type = /datum/embedding/janicart_key
	wound_bonus = -1
	exposed_wound_bonus = 2

/datum/embedding/janicart_key
	pain_mult = 1
	embed_chance = 30
	fall_chance = 70

/obj/item/key/janitor/suicide_act(mob/living/user)
	switch(user.mind?.get_skill_level(/datum/skill/cleaning))
		if(SKILL_LEVEL_APPRENTICE to SKILL_LEVEL_JOURNEYMAN) //At least they tried
			user.visible_message(span_suicide("[user] 把 \the [src] 塞进嘴里，笨拙地与清洁车融为了一体！看样子是想自杀！"))
			user.AddElement(/datum/element/cleaning)
			addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 5.1 SECONDS)
			return MANUAL_SUICIDE
		if(SKILL_LEVEL_EXPERT to SKILL_LEVEL_MASTER) //They are worthy enough, but can it go even further beyond?
			user.visible_message(span_suicide("[user] 把 \the [src] 塞进嘴里，娴熟地与清洁车融为了一体！看样子是想自杀！"))
			user.AddElement(/datum/element/cleaning)
			for(var/i in 1 to 100)
				addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, add_atom_colour), (i % 2)? "#a245bb" : "#7a7d82", ADMIN_COLOUR_PRIORITY), i)
			addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 101)
			return MANUAL_SUICIDE
		if(SKILL_LEVEL_LEGENDARY to INFINITY) //Holy shit, look at that janny go!
			user.visible_message(span_suicide("[user] 把 \the [src] 塞进嘴里，史诗般地与清洁车融为了一体，甚至还进入了超速模式！看样子是想自杀！"))
			user.AddElement(/datum/element/cleaning)
			playsound(src, 'sound/effects/magic/lightning_chargeup.ogg', 50, TRUE, -1)
			user.reagents.add_reagent(/datum/reagent/drug/methamphetamine, 10) //Gotta go fast!
			for(var/i in 1 to 150)
				addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, add_atom_colour), (i % 2)? "#a245bb" : "#7a7d82", ADMIN_COLOUR_PRIORITY), i)
			addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 151)
			return MANUAL_SUICIDE

	//Their mind is too weak to ascend as a janny
	user.visible_message(span_suicide("[user] 把 \the [src] 塞进嘴里，试图与清洁车融为一体，却完全不知道从何下手！看样子是想自杀！"))
	user.gib(DROP_ALL_REMAINS)
	return MANUAL_SUICIDE

/obj/item/key/proc/manual_suicide(mob/living/user)
	if(user)
		user.remove_atom_colour(ADMIN_COLOUR_PRIORITY)
		user.visible_message(span_suicide("[user] 忘了自己其实并不是清洁车！这下要吃板子了！"))
		if(user.mind?.get_skill_level(/datum/skill/cleaning) >= SKILL_LEVEL_LEGENDARY) //Janny janny janny janny janny
			playsound(src, 'sound/effects/adminhelp.ogg', 50, TRUE, -1)
		user.adjust_oxy_loss(200)
		user.death(FALSE)

/obj/item/key/lasso
	name = "骨制套索"
	desc = "用来驱赶歌利亚的完美工具！要是能让它们走得再快一点就好了……"
	force = 12
	icon_state = "lasso"
	inhand_icon_state = "chain"
	worn_icon_state = "whip"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb_continuous = list("抽打", "鞭打", "猛抽", "惩戒")
	attack_verb_simple = list("抽打", "鞭打", "猛抽", "惩戒")
	hitsound = 'sound/items/weapons/whip.ogg'
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
