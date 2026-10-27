
/obj/item/security_voucher
	name = "安保凭证"
	desc = "用于兑换一件装备的凭证。"
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "security_voucher_primary"
	w_class = WEIGHT_CLASS_TINY

/obj/item/security_voucher/examine(mob/user)
	. = ..()

	. += span_notice("你可以在[EXAMINE_HINT("安保装备售货机")]或[EXAMINE_HINT("任意车床")]兑换它。")

/obj/item/security_voucher/primary
	name = "安保主武器凭证"
	icon_state = "security_voucher_primary"

/obj/item/security_voucher/utility
	name = "安保实用装备凭证"
	icon_state = "security_voucher_utility"

#define HOS_PRIMARY_MARKINGS " 这件的标记表明它是配发给安保主管的。"

/proc/retarget_hos_primary_objectives(obj/item/weapon_path, objective_name)
	for(var/datum/objective/objective as anything in GLOB.objectives)
		if(!istype(objective, /datum/objective/steal))
			continue
		var/datum/objective/steal/steal_objective = objective
		if(!istype(steal_objective.targetinfo, /datum/objective_item/steal/hoslaser))
			continue

		steal_objective.steal_target = weapon_path
		steal_objective.explanation_text = "偷取[objective_name]，即安保主管的勤务武器。"

		for(var/datum/mind/owner as anything in steal_objective.get_owners())
			if(!owner.current)
				continue
			to_chat(owner.current, span_notice("你的目标已更新：[steal_objective.explanation_text]"))
			for(var/datum/antagonist/antag as anything in owner.antag_datums)
				antag.update_static_data(owner.current)

/obj/item/gun/energy/e_gun/hos/hos_primary
	desc = parent_type::desc + HOS_PRIMARY_MARKINGS

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/hos_primary
	desc = parent_type::desc + HOS_PRIMARY_MARKINGS
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/projectile/bullet/security/smart
	name = "智能 9x19 毫米墨菲子弹"

/obj/projectile/bullet/security/smart/prehit_pierce(atom/target)
	if(isliving(target) && HAS_TRAIT(target, TRAIT_MINDSHIELD))
		return PROJECTILE_PIERCE_PHASE
	return ..()

/obj/item/ammo_casing/security/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from)
	if(istype(fired_from, /obj/item/gun/ballistic/automatic/pistol/sec_glock/smart))
		QDEL_NULL(loaded_projectile)
		loaded_projectile = new /obj/projectile/bullet/security/smart(src)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart
	name = "\improper 智能手枪"
	desc = parent_type::desc + " 此型号是新型原型，采用紧凑型敌我识别组件引导子弹绕过植入了心智护盾的目标。" + HOS_PRIMARY_MARKINGS
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "firefly"
	base_icon_state = "firefly"
	projectile_damage_multiplier = 0.9
	show_bolt_icon = FALSE
	mag_display = FALSE
	var/firefly_slide_animating = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE)

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/update_overlays()
	. = ..()
	if(magazine && !internal_magazine)
		. += "firefly_mag"
	var/datum/component/seclite_attachable/seclite = GetComponent(/datum/component/seclite_attachable)
	if(seclite?.light)
		var/light_state = seclite.light.light_on ? "on" : "off"
		. += "firefly-light_[light_state]"
	if(!firefly_slide_animating)
		. += bolt_locked ? "firefly_bolt_locked" : "firefly_bolt"

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/pbtarget = null, message = TRUE)
	. = ..()
	recoil_firefly_slide()

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/proc/recoil_firefly_slide()
	firefly_slide_animating = TRUE
	update_appearance(UPDATE_OVERLAYS)
	var/atom/movable/flick_visual/slide = flick_overlay_view(mutable_appearance(icon, "firefly_bolt", layer + 0.1), 0.75)
	if(slide)
		animate(slide, pixel_w = -3, time = 0.375)
		animate(pixel_w = 0, time = 0.375)
	addtimer(CALLBACK(src, PROC_REF(reset_firefly_slide_recoil)), 0.75)

/obj/item/gun/ballistic/automatic/pistol/sec_glock/smart/proc/reset_firefly_slide_recoil()
	firefly_slide_animating = FALSE
	update_appearance(UPDATE_OVERLAYS)

/obj/item/gun/ballistic/revolver/c38/the_law
	name = "\improper “法律”"
	desc = "一把经过定制改装的 .38 特种左轮手枪，看起来比标准型号重得多。" + HOS_PRIMARY_MARKINGS
	icon = 'modular_zubbers/icons/obj/weapons/hos_revolver.dmi'
	icon_state = "the_law"
	base_icon_state = "the_law"
	projectile_damage_multiplier = 1.1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/storage/belt/holster/detective/full/ert/the_law
	desc = parent_type::desc + HOS_PRIMARY_MARKINGS

/obj/item/storage/belt/holster/detective/full/ert/the_law/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/speedloader/c38 = 3,
		/obj/item/gun/ballistic/revolver/c38/the_law = 1,
	), src)

/obj/item/hos_primary_case
	name = "安保主管勤务武器箱"
	desc = "一个安全的枪箱，内含安保主管的其中一件勤务武器。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "guncase"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/worn/cases.dmi'
	worn_icon_state = "darkcase"
	material_flags = NONE
	w_class = WEIGHT_CLASS_NORMAL
	/// Prevents double redemption if two interactions race each other.
	var/redeemed = FALSE

/obj/item/hos_primary_case/click_alt(mob/user)
	try_redeem(user)
	return CLICK_ACTION_SUCCESS

/obj/item/hos_primary_case/attack_self(mob/user)
	try_redeem(user)

/obj/item/hos_primary_case/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/energy/e_gun/hos)

/obj/item/hos_primary_case/proc/try_redeem(mob/user)
	if(redeemed || QDELETED(src))
		return
	if(!isliving(user))
		return
	var/mob/living/redeemer = user
	if(redeemer.incapacitated)
		return

	var/static/list/primary_options
	if(!primary_options)
		var/datum/radial_menu_choice/x01_option = new
		x01_option.image = image(icon = 'icons/obj/weapons/guns/energy.dmi', icon_state = "hoslaser")
		x01_option.info = span_boldnotice("安保主管独有的三模式能量枪。")

		var/datum/radial_menu_choice/shotgun_option = new
		shotgun_option.image = image(icon = 'icons/obj/weapons/guns/ballistic.dmi', icon_state = "cshotgunc")
		shotgun_option.info = span_boldnotice("一把微型化战斗霰弹枪。")

		var/datum/radial_menu_choice/smart_pistol_option = new
		smart_pistol_option.image = image(icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi', icon_state = "firefly")
		smart_pistol_option.info = span_boldnotice("一把墨菲式手枪，射击时可绕过植入了心智护盾的目标。")

		var/datum/radial_menu_choice/the_law_option = new
		the_law_option.image = image(icon = 'modular_zubbers/icons/obj/weapons/hos_revolver.dmi', icon_state = "the_law")
		the_law_option.info = span_boldnotice("“法律”，一把改装过的侦探特种型左轮，威力比标准型号更强。")

		primary_options = list(
			"X-01 多相能量枪" = x01_option,
			"紧凑型霰弹枪" = shotgun_option,
			"智能手枪" = smart_pistol_option,
			"“法律”" = the_law_option,
		)

	var/selection = show_radial_menu(redeemer, src, primary_options, custom_check = CALLBACK(src, PROC_REF(check_redeem_menu), redeemer), radius = 38, require_near = TRUE, tooltips = TRUE)
	if(!selection || redeemed || QDELETED(src))
		return

	var/spawn_path
	var/objective_path
	var/objective_name
	switch(selection)
		if("X-01 多相能量枪")
			spawn_path = /obj/item/gun/energy/e_gun/hos/hos_primary
			objective_name = "X-01 多相能量枪"
		if("紧凑型霰弹枪")
			spawn_path = /obj/item/gun/ballistic/shotgun/automatic/combat/compact/hos_primary
			objective_name = "紧凑型霰弹枪"
		if("智能手枪")
			spawn_path = /obj/item/gun/ballistic/automatic/pistol/sec_glock/smart
			objective_name = "智能手枪"
		if("“法律”")
			spawn_path = /obj/item/storage/belt/holster/detective/full/ert/the_law
			objective_path = /obj/item/gun/ballistic/revolver/c38/the_law
			objective_name = "“法律”"
		else
			return

	objective_path ||= spawn_path
	redeemed = TRUE
	var/obj/item/chosen_item = new spawn_path(drop_location())
	redeemer.put_in_hands(chosen_item)
	retarget_hos_primary_objectives(objective_path, objective_name)
	balloon_alert(redeemer, "已选择 [LOWER_TEXT(selection)]")
	qdel(src)

/obj/item/hos_primary_case/proc/check_redeem_menu(mob/living/redeemer)
	if(!istype(redeemer))
		return FALSE
	if(redeemer.incapacitated)
		return FALSE
	if(QDELETED(src) || redeemed)
		return FALSE
	if(!redeemer.Adjacent(src))
		return FALSE
	return TRUE

#undef HOS_PRIMARY_MARKINGS

/obj/machinery/vending/security/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/obj/machinery/rnd/production/techfab/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/obj/machinery/rnd/production/protolathe/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/datum/voucher_set/security
	blackbox_key = "security_voucher_redeemed"

/datum/voucher_set/security/primary

/datum/voucher_set/security/utility

/datum/voucher_set/security/primary/disabler
	name = "缴械枪"
	description = "纳米传讯安保部队的标准配发能量枪。自带枪套。"
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "disabler"
	set_items = list(
		/obj/item/storage/belt/holster/energy/disabler,
		)

/datum/voucher_set/security/primary/advanced_taser
	name = "混合电击枪"
	description = "一种双模式电击枪，既可发射短程大功率电极，也可发射远程缴械光束。"
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "advtaser"
	set_items = list(
		/obj/item/gun/energy/e_gun/advtaser,
		)

/datum/voucher_set/security/primary/disabler_smg
	name = "胡椒球 AGH"
	description = "一种射速较慢的手枪，发射“胡椒球”，能轻易把目标打倒在地。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "peppergun"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/pepperball,
		/obj/item/ammo_box/magazine/pepperball
		)

/datum/voucher_set/security/primary/strobe_shield
	name = "频闪盾牌"
	description = "一面内置高强度灯光的盾牌，能使嫌疑人致盲并失去方向感。使用普通手持闪光器作为灯泡。"
	icon = 'icons/obj/weapons/shields.dmi'
	icon_state = "flashshield"
	set_items = list(
		/obj/item/shield/riot/flash,
		)

/datum/voucher_set/security/primary/archery
	name = "射箭套装"
	description = "一把强弓、一本训练手册，以及一个装着非致命或低致命箭矢的箭袋。若想制作致命箭矢，你仍需要从货运部订购制箭手册。"
	icon = 'icons/obj/weapons/bows/bows.dmi'
	icon_state = "hardlightbow"
	set_items = list(
		/obj/item/gun/ballistic/bow/security,
		/obj/item/storage/bag/quiver/lesser/security,
		/obj/item/book/granter/crafting_recipe/fletching/nonlethal,
		/obj/item/hatchet,
	)

/obj/item/storage/bag/quiver/lesser/security
	name = "安保箭袋"
	desc = "一个轻便、容量很低的箭袋，可以折起来塞进口袋，除此之外什么也做不了。"
	slot_flags = ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET|ITEM_SLOT_BELT

/obj/item/storage/bag/quiver/lesser/security/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_casing/arrow/blunt = 7,
		/obj/item/ammo_casing/arrow/taser = 3
	)

	generate_items_inside(items_inside, src)

/obj/item/book/granter/crafting_recipe/fletching/nonlethal
	name = "瞄准膝盖，别瞄眼睛！"
	desc = "一本讲解如何制作低致命弓与箭、如何最好地使用它们……以及如何制作小提琴的手册？"
	crafting_recipe_types = list(
		/datum/crafting_recipe/shortbow,
		/datum/crafting_recipe/blunted_arrow,
		/datum/crafting_recipe/taser_arrow,
		/datum/crafting_recipe/violin,
	)
	uses = 1

/datum/voucher_set/security/primary/nt_usp
	name = "NT22-HCS“执法者”手枪"
	description = "一把利用硬光技术合成子弹的小型手枪。由于威力较低，除了让罪犯疲惫之外没什么用处。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp_full"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/ntusp,
		/obj/item/ammo_box/magazine/recharge/ntusp,
		)

/datum/voucher_set/security/utility/sec_projector
	name = "安保全息屏障投射器"
	description = "一种全息投射器，可生成全息安保屏障以及全息手铐。"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker_sec"
	set_items = list(
		/obj/item/holosign_creator/security,
		)

/datum/voucher_set/security/utility/lawbook
	name = "加重版太空法书籍"
	description = "纳米传讯《太空法》的特别版。装饰性金属封面增加了相当多的分量……挥动时请小心。"
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	set_items = list(
		/obj/item/book/manual/wiki/security_space_law/weighted,
		)

/datum/voucher_set/security/utility/donut_box
	name = "一盒甜甜圈"
	description = "诱人……"
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox"
	set_items = list(
		/obj/item/storage/fancy/donut_box,
		/obj/item/reagent_containers/cup/glass/coffee,
		)

/datum/voucher_set/security/utility/barrier
	name = "屏障手榴弹"
	description = "两枚屏障手榴弹。"
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "wallbang"
	set_items = list(
		/obj/item/grenade/barrier,
		/obj/item/grenade/barrier,
		)

/datum/voucher_set/security/utility/stingbang
	name = "震爆手榴弹"
	description = "两枚震爆手榴弹。"
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "timeg_locked"
	set_items = list(
		/obj/item/grenade/stingbang,
		/obj/item/grenade/stingbang,
		)

/datum/voucher_set/security/utility/justice_helmet
	name = "正义头盔"
	description = "罪犯惧怕正义头盔。"
	icon = 'icons/obj/clothing/head/helmet.dmi'
	icon_state = "justice"
	set_items = list(
		/obj/item/clothing/mask/gas/sechailer/swat,
		/obj/item/clothing/head/helmet/toggleable/justice,
		)

/datum/voucher_set/security/utility/pinpointer_pairs
	name = "成对定位器"
	description = "一对便携追踪装置，会锁定配对的另一半。"
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "pinpointer"
	set_items = list(
		/obj/item/storage/box/pinpointer_pairs,
		)

/datum/voucher_set/security/utility/laptop
	name = "安保笔记本电脑"
	description = "一台预装安保软件的笔记本电脑。"
	icon = 'icons/obj/devices/modular_laptop.dmi'
	icon_state = "laptop-closed"
	set_items = list(
		/obj/item/modular_computer/laptop/preset/security,
	)

/obj/item/modular_computer/laptop/preset/security
	starting_programs = list(
		/datum/computer_file/program/chatclient,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/secureye,
	)
