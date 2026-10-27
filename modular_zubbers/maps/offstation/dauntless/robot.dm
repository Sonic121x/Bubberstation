/obj/item/borg/upgrade/syndicate_access
	name = "辛迪加半机械人权限覆写模块"
	desc = "让任何型号的半机械人在辛迪加瞄准系统中都显示为辛迪加半机械人，并额外授予其进入辛迪加气闸的权限。 \
	\n\n致特工：请格外小心处理，以免你指定的飞船/空间站上出现失控的半机械人"

	// It is not module specific
	one_use = TRUE

/obj/item/borg/upgrade/syndicate_access/action(mob/living/silicon/robot/R, user)
	. = ..()
	// Turns out this is all you need for access to the doors. See code\game\machinery\_machinery.dm
	R.add_faction(ROLE_SYNDICATE)
	to_chat(R, span_alert("检测到附加权限！远程摄像接口已损毁。"))
	to_chat(user, span_warning("随着附加权限等级被写入，半机械人发出轻微嗡鸣，远程摄像模块烧断了一根保险丝。"))
	// Remove the camera, much like how the camera is removed for ghost cafe cyborgs
	if(!QDELETED(R.builtInCamera))
		QDEL_NULL(R.builtInCamera)


/obj/item/borg/upgrade/syndicate_access/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	R.set_faction(initial(faction))

/obj/item/borg/upgrade/syndicate_access/dauntless/examine_more(mob/user)
	. = ..()
	. += span_notice("这个似乎还附带了一块英特戴恩通讯芯片。挺别致！")

/obj/item/borg/upgrade/syndicate_access/dauntless/action(mob/living/silicon/robot/R, user)
	. = ..()

	// Yes, this forces out and removes any other keys. Which it should, in this case.
	R.radio.keyslot = new /obj/item/encryptionkey/headset_syndicate/cybersun(src)
	R.radio.recalculateChannels()
