/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator // modified on request of nikotheguydude, the person who donated for this upstream
	name = "精致礼服大衣"
	special_desc = "仔细一看，内衬似乎用防护材料做了改装，还带有 \
	常见于医疗实验服的挂载点。"

//@EspeciallyStrange @Wolf751  for the sprite if reaching out to us is needed
// Sprites are donated from either project kepler or hand done by me for this occasion, They can be used for anything else
//Will also be available for usage in Foundation 19
// Placed in these file so that You and others may remove them if I am not playing here anymore, or if it were to be used for anything else!

/obj/item/clothing/head/helmet/sec/sol/idma_helmet
	name = "铁月勤务头盔。"
	desc = "罗穆卢斯远征军佩戴的头盔。"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	icon_state = "romulushelmet"

/obj/item/clothing/head/idma_beret
	name = "铁月勤务贝雷帽。"
	desc = "一种在仪式或和平时期由罗穆卢斯国民警卫队佩戴的贝雷帽，因为它完全不具备任何防护能力。"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	icon_state = "romulusberet"
	resistance_flags = FIRE_PROOF
//provide no armor because it's a ceremonial piece. meant to be available across all role. I would not like to get it burnt off however

/obj/item/clothing/under/rank/security/idma_fatigue
	name = "铁月勤务作战服"
	desc = "一套旧式雪地图案制服，罗穆卢斯远征军在开普勒紧急事件期间穿着。"
	icon_state = "romulusmarine"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn_digi.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/rank/idma_utility
	name = "铁月通用作战服"
	desc = "一套旧式雪地图案制服，IDMA 员工常穿。"
	icon_state = "romulusutility"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn_teshari.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/rank/security/idma_fatigue/alt
	name = "阿格诺斯坦勤务作战服"
	desc = "一套旧式沙漠制服，罗穆卢斯远征军一直穿到 2181 年 3 月 21 日。上面还附着一枚银质奖章"
	icon_state = "argnostanuniform"

/obj/item/clothing/suit/jacket/vera_jacket
	name = "硅基管理员背心"
	desc = "一件带金色饰边的紫色背心，正适合势利眼的科研主管。"
	icon_state = "verajacket"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	armor_type = /datum/armor/skyrat_rd // It's a really advanced labcoat at the end of the day
	allowed = list (
		/obj/item/biopsy_tool,
		/obj/item/dnainjector,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/gun/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/assembly/flash/handheld,
		/obj/item/cigarette,
		/obj/item/disk,
		/obj/item/lighter,
		/obj/item/melee,
		/obj/item/reagent_containers/cup/glass/flask,
		/obj/item/stamp,
		/obj/item/storage/box/matches,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/lockbox/medal,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)

/obj/item/clothing/suit/jacket/idma_jacket
	name = "铁月勤务外套"
	desc = "一件轻便夹克，上面带有“罗穆卢斯远征军”徽记，这件是作为勤务外套穿着的。"
	icon_state = "romulusofficer"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


/obj/item/clothing/suit/armor/vest/idma_vest
	name = "IDMA 作战背心"
	desc = "一件轻型防弹背心，上面带有“罗穆卢斯远征军”徽记，内含 IIA 级防弹插板，可保护穿着者免受伤害。"
	icon_state = "romfed_armor"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/idma_vest/idma_jacket
	name = "铁月重型勤务外套"
	desc = "一件厚重的夹克，上面带有“罗穆卢斯远征军”徽记，这一件带有装甲。"
	icon_state = "romulusarmoured"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


/obj/item/clothing/accessory/armband/idmaarmband
	name = "铁月警察臂章"
	desc = "一枚精致的红色臂章，通常为罗穆卢斯联邦警察所使用"
	icon_state = "romuluspolice"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	resistance_flags = FIRE_PROOF

/obj/item/toy/plush/especiallystrange
	name = "铁月塔亚拉毛绒玩偶"
	desc = "一个以千名塔亚拉志愿兵为原型的小毛绒玩偶，这一只似乎是枪械维护员。"
	icon_state = "travian"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	attack_verb_continuous = list ("依偎", "喵叫", "嘶叫")
	attack_verb_simple = list ("依偎", "喵叫", "嘶叫")
	squeak_override = list ('modular_zubbers/sound/voice/merowr.ogg' = 1)
	resistance_flags = FIRE_PROOF

