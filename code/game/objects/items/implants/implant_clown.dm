/// A passive implant that plays a funny noise (defaults to sound/misc/sadtrombone.ogg) when you deathgasp for any reason
/obj/item/implant/sad_trombone
	name = "悲伤长号植入体"
	actions_types = null
	custom_materials = list(/datum/material/bananium = HALF_SHEET_MATERIAL_AMOUNT)

	/// What do we play when the implantee deathgasps?
	var/death_noise = 'sound/misc/sadtrombone.ogg'

	implant_info = "死亡时激活，播放悲伤长号音效。"

	implant_lore = "洪克公司的悲伤长号植入体是一种皮下生命体征分析仪兼\
		音效合成器，仅预载了一种音效：悲伤长号。\
		死亡时（或通过足够逼真的死亡喘息假装死亡时），会播放悲伤长号音效。"

/obj/item/implant/sad_trombone/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(.)
		RegisterSignal(target, COMSIG_MOB_EMOTED("deathgasp"), PROC_REF(on_deathgasp))

/obj/item/implant/sad_trombone/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_MOB_EMOTED("deathgasp"))

/obj/item/implant/sad_trombone/proc/on_deathgasp(mob/source)
	SIGNAL_HANDLER
	playsound(loc, death_noise, 50, FALSE)

///Implanter that spawns with a sad trombone implant, as well as an appropriate name
/obj/item/implanter/sad_trombone
	name = "植入器（悲伤长号）"
	imp_type = /obj/item/implant/sad_trombone

///Implant case that spawns with a sad trombone implant, as well as an appropriate name and description
/obj/item/implantcase/sad_trombone
	name = "植入体盒 - “悲伤长号”"
	desc = "一个装有悲伤长号植入体的玻璃盒。"
	imp_type = /obj/item/implant/sad_trombone
