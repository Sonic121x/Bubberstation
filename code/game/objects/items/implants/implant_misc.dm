/obj/item/implant/weapons_auth
	name = "枪械认证植入体"
	desc = "让你能开枪。"
	icon_state = "auth"
	actions_types = null

	implant_info = "植入后自动激活。为具备相应安全系统的武器提供认证， \
		通常作用于击针。"

	implant_lore = "赛博太阳装备认证植入体是一种皮下 RFID 认证模块及配套发射器， \
		旨在与具备相应安全系统的设备对接，例如受相关秘密行动人员和非国家行为者青睐的植入体锁定击针。 \
		此类认证系统因让试图从倒下敌人手中窃取装备的人难以得手而值得注意， \
		它能防止这些装备被轻易使用。 \
		不过应当注意，数字认证方案中最薄弱的一环， \
		往往就是物理层。"

/obj/item/implant/emp
	name = "\improper EMP 植入体"
	desc = "触发一次 EMP。"
	icon_state = "emp"
	uses = 3

	implant_info = "手动激活。触发时产生一次范围中等、不加区分的电磁脉冲。"

	implant_lore = "赛博太阳皮下电磁脉冲发生器，正如其名， \
		是一种皮下植入体，触发时会产生不加区分的电磁脉冲， \
		干扰使用者半径内的电子设备（如能量武器）， \
		以及生命体（如站内硅基单位）。 \
		提醒潜在使用者：S-EPG 并不能保护宿主免受自身电磁脉冲的影响。"

/obj/item/implant/emp/activate()
	. = ..()
	uses--
	empulse(imp_in, 3, 5, emp_source = src)
	if(!uses)
		qdel(src)

/obj/item/implanter/emp
	name = "植入器" // Skyrat edit, was implanter (EMP)
	imp_type = /obj/item/implant/emp
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // Skyrat edit
	special_desc = "用于 EMP 植入体的辛迪加植入器" // Skyrat edit

/obj/item/implant/smoke
	name = "烟雾植入体"
	desc = "释放一团烟雾。"
	icon_state = "smoke"
	uses = 3

/obj/item/implant/smoke/activate()
	. = ..()
	uses--
	do_smoke(6, imp_in, imp_in.loc, smoke_type = /datum/effect_system/fluid_spread/smoke/bad)
	if(!uses)
		qdel(src)

/obj/item/implanter/smoke
	name = "植入器（烟雾）"
	imp_type = /obj/item/implant/smoke

/obj/item/implant/smoke
	name = "烟雾植入体"
	desc = "释放一团烟雾。"
	icon_state = "smoke"
	uses = 3

	implant_info = "手动激活。触发时产生一团范围中等、不加区分的烟雾。"

	implant_lore = "赛博太阳皮下视觉阻碍发生器，正如其名， \
		是一种皮下植入体，触发时能产生烟雾形式的视觉阻碍， \
		阻断指向使用者的视线。 \
		提醒潜在使用者：S-VOG 并不能很好地保护宿主免受热成像侦测， \
		也无法阻止盲目向烟雾中射击，更不能阻止移动。"

/obj/item/implant/smoke/activate()
	. = ..()
	uses--
	do_smoke(6, imp_in, imp_in.loc, smoke_type = /datum/effect_system/fluid_spread/smoke/bad)
	if(!uses)
		qdel(src)

/obj/item/implanter/smoke
	name = "植入器（烟雾）"
	imp_type = /obj/item/implant/smoke

/obj/item/implant/radio
	name = "内置无线电植入体"
	var/obj/item/radio/radio
	var/radio_key
	var/subspace_transmission = FALSE
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "walkietalkie"

	implant_info = "植入后自动激活。提供无线电收发能力。"

	implant_lore = "内置无线电植入体是一种长期开源的皮下双向无线电系统， \
		从纳米传讯到赛博太阳，几乎人人都在生产，旨在与电信网络对接。 \
		它对那些预料会丢失装备， \
		或不习惯使用独立无线电设备的人尤其有用。"

/obj/item/implant/radio/activate()
	. = ..()
	// needs to be GLOB.deep_inventory_state otherwise it won't open
	radio.ui_interact(usr, state = GLOB.deep_inventory_state)

/obj/item/implant/radio/Initialize(mapload)
	. = ..()

	radio = new(src)
	// almost like an internal headset, but without the
	// "must be in ears to hear" restriction.
	radio.name = "内置无线电"
	radio.subspace_transmission = subspace_transmission
	radio.canhear_range = 0
	if(radio_key)
		radio.keyslot = new radio_key
	radio.recalculateChannels()

/obj/item/implant/radio/Destroy()
	QDEL_NULL(radio)
	return ..()

/obj/item/implant/radio/mining
	radio_key = /obj/item/encryptionkey/headset_cargo

/obj/item/implant/radio/syndicate
	desc = "上帝，你在吗？是我，辛迪加通信特工。"
	radio_key = /obj/item/encryptionkey/syndicate
	subspace_transmission = TRUE

/obj/item/implant/radio/slime
	name = "史莱姆无线电"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "adamantine_resonator"
	radio_key = /obj/item/encryptionkey/headset_sci
	subspace_transmission = TRUE

/obj/item/implanter/radio
	name = "植入器（内置无线电）"
	imp_type = /obj/item/implant/radio

/obj/item/implanter/radio/syndicate
	name = "植入器" // Skyrat edit , was originally implanter (internal syndicate radio)
	imp_type = /obj/item/implant/radio/syndicate
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // Skyrat edit
	special_desc = "用于内置无线电植入体的辛迪加植入器" // Skyrat edit

