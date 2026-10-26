/obj/effect/mob_spawn/ghost_role/human/black_mesa
	name = "研究设施科学小组"
	prompt_name = "一名研究设施科学家"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/science_team
	you_are_text = "你是一名绝密政府设施中的科学家。你失去了意识。现在，你醒来时面对着其内潜藏的恐怖。"
	flavour_text = "你是一名绝密政府设施爆心附近的科学家。你失去了意识。现在，你醒来时面对着其内潜藏的恐怖。"
	important_text = "除非已有远征队在场且离你很近，否则不要尝试探索这一关卡；即便有，也要在自己的区域里至少等上 20 分钟再离开。"
	restricted_species = list(/datum/species/human)
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/black_mesa/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)

/datum/outfit/science_team
	name = "Scientist"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/radio,
							/obj/item/reagent_containers/cup/beaker,
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/science_team

/datum/outfit/science_team/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.add_faction(FACTION_BLACKMESA)

/datum/id_trim/science_team
	assignment = "科学小组科学家"
	trim_state = "trim_scientist"
	access = list(ACCESS_SCIENCE)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/guard
	name = "研究设施安保警卫"
	prompt_name = "一名研究设施警卫"
	outfit = /datum/outfit/security_guard
	you_are_text = "你是一名绝密政府设施中的安保警卫。你失去了意识。现在，你醒来时面对着其内潜藏的恐怖。"
	flavour_text = "你是一名绝密政府设施爆心附近的安保警卫。你失去了意识。现在，你醒来时面对着其内潜藏的恐怖。"

/obj/effect/mob_spawn/ghost_role/human/black_mesa/guard/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)

/datum/outfit/security_guard
	name = "Security Guard"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	head = /obj/item/clothing/head/helmet/blueshirt
	gloves = /obj/item/clothing/gloves/color/black
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/security/full
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/radio,
							/obj/item/gun/ballistic/automatic/pistol/sol,
							/obj/item/ammo_box/magazine/c35sol_pistol,
							/obj/item/ammo_box/magazine/c35sol_pistol,
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/security_guard

/datum/outfit/security_guard/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.add_faction(FACTION_BLACKMESA)

/datum/id_trim/security_guard
	assignment = "安保警卫"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_AWAY_SEC)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu
	name = "HECU"
	prompt_name = "一名战术小队成员"
	outfit = /datum/outfit/hecu
	you_are_text = "你是一支被派入研究设施、遏制感染扩散的精锐战术小队成员。"
	flavour_text = "你和其他四名陆战队员被选中在黑山基地的一处入口附近担任警戒。 \
	除了枪声和他们的无线电归于沉寂之外，你们对西北哨所的情况一无所知。 \
	更糟的是，你们的撤离直升机在飞行途中被击落，下一架不会那么快赶到； \
	而你的机枪手被某个东西——或者某个人——一枪爆头击倒。至少在目前，你们很可能只能靠自己了。"
	important_text = "除非远征队已经死亡或愿意合作，否则不要尝试探索这一关卡。待在你的区域附近。"
	restricted_species = list(/datum/species/human)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)

/obj/item/clothing/under/rank/security/officer/hecu //Subtype of security for armor (and because I dont want to repath it)
	name = "城市迷彩作战服"
	desc = "一件宽松的军用迷彩制服，采用 ERDL 迷彩图案。其白灰配色在城市环境中十分实用。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi' //Camo goes into the syndicate.dmi
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "urban_camo"
	inhand_icon_state = "w_suit"

/obj/item/clothing/under/rank/security/officer/hecu/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/storage/backpack/ert/odst/hecu
	name = "HECU 背包"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'
	icon_state = "hecu_pack"
	worn_icon_state = "hecu_pack"

/obj/item/storage/backpack/ert/odst/hecu/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hecu_backpack)

/datum/atom_skin/hecu_backpack
	abstract_type = /datum/atom_skin/hecu_backpack

/datum/atom_skin/hecu_backpack/olive
	preview_name = "橄榄绿"
	new_icon_state = "hecu_pack"

/datum/atom_skin/hecu_backpack/black
	preview_name = "黑色"
	new_icon_state = "hecu_pack_black"

/obj/item/storage/belt/military/assault/hecu
	name = "HECU 战术腰带"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'
	icon_state = "hecu_belt"
	worn_icon_state = "hecu_belt"

/obj/item/storage/belt/military/assault/hecu/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hecu_warbelt)

/datum/atom_skin/hecu_warbelt
	abstract_type = /datum/atom_skin/hecu_warbelt

/datum/atom_skin/hecu_warbelt/olive
	preview_name = "橄榄绿"
	new_icon_state = "hecu_belt"

/datum/atom_skin/hecu_warbelt/black
	preview_name = "黑色"
	new_icon_state = "hecu_belt_black"

/datum/outfit/hecu
	name = "HECU Grunt"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/assault/hecu
	ears = /obj/item/radio/headset/headset_faction
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/storage/belt/bowie_sheath
	r_pocket = /obj/item/flashlight/flare
	back = /obj/item/storage/backpack/ert/odst/hecu
	backpack_contents = list(
							/obj/item/storage/box/survival/radio,
							/obj/item/storage/medkit/emergency,
							/obj/item/armament_points_card/hecu,
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/hecu
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/hecu/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.add_faction(FACTION_HECU)

/datum/id_trim/hecu
	assignment = "HECU 陆战队员"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_AWAY_SEC)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu/leader
	name = "HECU 小队队长"
	prompt_name = "一名战术小队队长"
	outfit = /datum/outfit/hecu/leader
	you_are_text = "你是一支被派入研究设施、遏制感染扩散的精锐战术小队队长。"
	flavour_text = "你和其他四名陆战队员被选中在黑山基地的一处入口附近担任警戒。 \
	由于根本没有像样的简报，而负责简报的军官又在登陆时阵亡，你完全不清楚自己的目标是什么， \
	于是你和你的小队就在这里扎了营。除了枪声和他们的无线电归于沉寂之外，你们对西北哨所的情况一无所知。 \
	更糟的是，你们的撤离直升机在飞行途中被击落，下一架不会那么快赶到； \
	而你的机枪手被某个东西——或者某个人——一枪爆头击倒。至少在目前，你们很可能只能靠自己了。"
	important_text = "维持并鼓舞陆战队员的士气与纪律。尽你所能分派职责。 \
	除非远征队已经死亡或愿意合作，否则不要尝试探索这一关卡。待在你的区域附近。"
	restricted_species = list(/datum/species/human)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu/leader/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/spinwarder, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/yangyu, source = LANGUAGE_SPAWNER)

/datum/outfit/hecu/leader
	name = "HECU Captain"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = /obj/item/clothing/head/beret/sec
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	belt = /obj/item/storage/belt/military/assault/hecu
	ears = /obj/item/radio/headset/headset_faction/bowman/captain
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/storage/belt/bowie_sheath
	r_pocket = /obj/item/binoculars
	back = /obj/item/storage/backpack/ert/odst/hecu
	backpack_contents = list(
							/obj/item/storage/box/survival/radio,
							/obj/item/storage/medkit/emergency,
							/obj/item/armament_points_card/hecu,
							/obj/item/book/granter/martial/cqc,
							/obj/item/grenade/smokebomb,
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/hecu_leader
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/hecu/leader/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.add_faction(FACTION_HECU)

/datum/id_trim/hecu_leader
	assignment = "HECU 上尉"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_AWAY_SEC)
