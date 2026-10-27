/obj/item/advanced_choice_beacon
	name = "高级自选信标"
	desc = "只要纳米传讯批准，这个信标就能送来你想要的东西。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "designator_syndicate"
	inhand_icon_state = "nukietalkie"

	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	var/list/possible_choices = list()

	var/pod_style = /datum/pod_style/centcom

/obj/item/advanced_choice_beacon/attack_self(mob/user, modifiers)
	if(can_use_beacon(user))
		display_options(user)

/obj/item/advanced_choice_beacon/proc/can_use_beacon(mob/living/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 40, TRUE)
		return FALSE


/obj/item/advanced_choice_beacon/proc/display_options(mob/user)
	var/list/radial_build = get_available_options()

	if(!radial_build)
		return

	var/chosen_option = show_radial_menu(user, src, radial_build, radius = 40, tooltips = TRUE)

	if(!chosen_option)
		return

	podspawn(list(
		"target" = get_turf(src),
		"style" = pod_style,
		"spawn" = chosen_option,
	))

	qdel(src)

/obj/item/advanced_choice_beacon/proc/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/our_object = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_object.icon), icon_state = initial(our_object.icon_state))
		option.info = span_boldnotice("[initial(our_object.desc)]")

		options[our_object] = option

	sort_list(options)

	return options


/obj/item/advanced_choice_beacon/nri
	name = "\improper 泛斯拉夫联邦国防委员会补给信标"
	desc = "用于申请职责所需的补给，拿在手中使用即可！"

/obj/item/advanced_choice_beacon/nri/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/structure/closet/crate/secure/weapon/nri/our_crate = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_crate.icon), icon_state = initial(our_crate.icon_state))
		option.info = span_boldnotice("[initial(our_crate.loadout_desc)]")

		options[our_crate] = option

	sort_list(options)

	return options

/obj/item/advanced_choice_beacon/nri/engineer
	name = "\improper 泛斯拉夫联邦国防委员会工程补给信标"
	desc = "用于申请职责所需的补给，拿在手中使用即可！"

	possible_choices = list(/obj/structure/closet/crate/secure/weapon/nri/engineer/defense, /obj/structure/closet/crate/secure/weapon/nri/engineer/offense)

/obj/item/advanced_choice_beacon/nri/heavy
	name = "\improper 泛斯拉夫联邦国防委员会重武器补给信标"
	desc = "用于申请职责所需的补给，拿在手中使用即可！"

	possible_choices = list(/obj/structure/closet/crate/secure/weapon/nri/heavy/defense,/obj/structure/closet/crate/secure/weapon/nri/heavy/offense)

/obj/item/stack/sheet/mineral/sandbags/fifty
	amount = 50

/obj/item/storage/toolbox/emergency/turret/nri
	name = "泛斯拉夫联邦固定防御部署系统"
	desc = "你莫名地想拿扳手敲它一下。"
	icon = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	icon_state = "inventory"
	inhand_icon_state = "held"
	lefthand_file = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	righthand_file = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	w_class = WEIGHT_CLASS_BULKY
	has_latches = FALSE

/obj/item/storage/toolbox/emergency/turret/nri/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/obj/item/storage/toolbox/emergency/turret/nri/PopulateContents()
	return null

/obj/item/storage/toolbox/emergency/turret/nri/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WRENCH && user.combat_mode)
		user.visible_message(span_danger("[user]用[I]敲击[src]！"), \
			span_danger("你用[I]敲击[src]！"), null, COMBAT_MESSAGE_RANGE)
		playsound(src, "sound/items/tools/drill_use.ogg", 80, TRUE, -1)
		var/obj/machinery/porta_turret/syndicate/pod/toolbox/nri/turret = new(get_turf(loc))
		turret.add_faction(FACTION_NEUTRAL, FACTION_ERT)
		qdel(src)

	..()

/obj/machinery/porta_turret/syndicate/pod/toolbox/nri
	icon = 'modular_skyrat/modules/novaya_ert/icons/turret_deployable.dmi'
	icon_state = "living"
	base_icon_state = "living"
	stun_projectile = /obj/projectile/bullet/c27_54cesarzowa
	lethal_projectile = /obj/projectile/bullet/c27_54cesarzowa
	max_integrity = 150
	req_access = list(ACCESS_CENT_GENERAL)
	faction = list(FACTION_NEUTRAL, FACTION_ERT)
	shot_delay = 0.25

/obj/machinery/porta_turret/syndicate/pod/toolbox/nri/assess_perp(mob/living/carbon/human/perp)
	return 0

/mob/living/basic/viscerator/nri
	faction = list(FACTION_NEUTRAL, FACTION_ERT)

/obj/item/grenade/spawnergrenade/manhacks/nri
	name = "帝国剖脏机投送手榴弹"
	spawner_type = /mob/living/basic/viscerator/nri
	deliveryamt = 10

/obj/structure/closet/crate/secure/weapon/nri
	name = "军用补给箱"
	desc = "一个安全的军用级箱子。根据标记及其中混杂的西里尔字母，它由泛斯拉夫国防委员会提供并运送。"
	req_access = list(ACCESS_CENT_GENERAL)
	var/loadout_desc = "选择这个的人大概正忙着调试这段复制粘贴的代码。"

//base, don't use this, but leaving it for admin spawns is probably a good call? (no because it's literally freaking empty lmfao)
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	return null

//defensive engineering loadout
/obj/structure/closet/crate/secure/weapon/nri/engineer/defense
	name = "防御工程补给"
	loadout_desc = "一套专为快速构筑防御工事准备的工程补给。\
		包含路障、建筑材料、超大燃料罐和5.6毫米防御自动炮塔。"

/obj/structure/closet/crate/secure/weapon/nri/engineer/defense/PopulateContents()
	new /obj/item/storage/barricade(src)
	new /obj/item/storage/barricade(src)
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/stack/sheet/iron/fifty(src)
	new /obj/item/stack/sheet/plasteel/fifty(src)
	new /obj/item/stack/sheet/glass/fifty(src)
	new /obj/item/stack/sheet/mineral/sandbags/fifty(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/structure/reagent_dispensers/fueltank/large(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/storage/toolbox/emergency/turret/nri(src)
	new /obj/item/rcd_ammo/large(src)

//offensive engineering loadout
/obj/structure/closet/crate/secure/weapon/nri/engineer/offense
	name = "进攻工程补给"
	loadout_desc = "一套专为快速推进、拆除工事和区域压制准备的工程补给。\
		路障和建材远少于防御型补给，但包含泛斯拉夫配发的剖脏机手榴弹与战斗型快速建造装置。"

/obj/structure/closet/crate/secure/weapon/nri/engineer/offense/PopulateContents()
	new /obj/item/storage/barricade(src)
	new /obj/item/stack/sheet/mineral/sandbags/fifty(src)
	new /obj/item/grenade/barrier(src)
	new /obj/item/grenade/barrier(src)
	new /obj/structure/reagent_dispensers/fueltank(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/grenade/spawnergrenade/manhacks/nri(src)
	new /obj/item/construction/rcd/combat(src)
	new /obj/item/rcd_ammo/large(src)

//defensive heavy loadout
/obj/structure/closet/crate/secure/weapon/nri/heavy/defense
	name = "防御重装补给"
	loadout_desc = "一套专为固定阵地火力压制和爆炸物防御工事准备的重装士兵补给。\
		包含一挺.50口径重机枪及大量备用弹药，还有一批爆炸地雷。\
		另赠几枚破片手榴弹。"

/obj/structure/closet/crate/secure/weapon/nri/heavy/defense/PopulateContents()
	new /obj/item/mounted_machine_gun_folded(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/ammo_box/magazine/mmg_box(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/minespawner/explosive(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/frag(src)

//offensive heavy loadout
/obj/structure/closet/crate/secure/weapon/nri/heavy/offense
	name = "进攻重装补给"
	loadout_desc = "一套专为快速推进和弹药支援准备的重装士兵补给。\
		包含斯卡伯勒制式轻机枪与备用弹药箱，以及克林科夫和PP-542的弹药。"

/obj/structure/closet/crate/secure/weapon/nri/heavy/offense/PopulateContents()
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted(src)
	new /obj/item/storage/toolbox/ammobox/full/l6_saw(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/krinkov(src)
	new /obj/item/storage/toolbox/ammobox/full/nri_smg(src)
	new /obj/item/storage/toolbox/ammobox/full/nri_smg(src)
	new /obj/item/storage/toolbox/ammobox/full/aps(src)
