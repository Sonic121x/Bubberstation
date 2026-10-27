//Suits for the pink and grey skeletons! //EVA version no longer used in favor of the Jumpsuit version

/obj/item/clothing/suit/space/eva/plasmaman
	name = "EVA 等离子防护服"
	desc = "一套专为太空环境设计的特殊等离子收容服，也可套在其他衣物外穿着。和它的较小版本一样，它能在危急时刻自动扑灭穿戴者身上的火，且蓄能次数是后者的两倍。"
	allowed = list(/obj/item/gun, /obj/item/ammo_casing, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/restraints/handcuffs, /obj/item/tank)
	armor_type = /datum/armor/eva_plasmaman
	resistance_flags = FIRE_PROOF
	icon_state = "plasmaman_suit"
	inhand_icon_state = "plasmaman_suit"
	fishing_modifier = 0
	COOLDOWN_DECLARE(extinguish_timer)
	var/extinguish_cooldown = 100
	var/extinguishes_left = 10

/datum/armor/eva_plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/suit/space/eva/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("这套防护服内还剩 [extinguishes_left] 次灭火剂充能。")

/obj/item/clothing/suit/space/eva/plasmaman/equipped(mob/living/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_OCLOTHING)
		RegisterSignals(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)), PROC_REF(check_fire_state))
		check_fire_state()

/obj/item/clothing/suit/space/eva/plasmaman/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)))

/obj/item/clothing/suit/space/eva/plasmaman/proc/check_fire_state(datum/source)
	SIGNAL_HANDLER

	if (!ishuman(loc))
		return

	// This is weird but basically we're calling this proc once the cooldown ends in case our wearer gets set on fire again during said cooldown
	// This is why we're ignoring source and instead checking by loc
	var/mob/living/carbon/human/owner = loc
	if (!owner.on_fire || !owner.is_atmos_sealed(additional_flags = PLASMAMAN_PREVENT_IGNITION, check_hands = TRUE))
		return

	if (!extinguishes_left || !COOLDOWN_FINISHED(src, extinguish_timer))
		return

	extinguishes_left -= 1
	COOLDOWN_START(src, extinguish_timer, extinguish_cooldown)
	// Check if our (possibly other) wearer is on fire once the cooldown ends
	addtimer(CALLBACK(src, PROC_REF(check_fire_state)), extinguish_cooldown)
	owner.visible_message(span_warning("[owner] 的防护服自动扑灭了其身上的火！"), span_warning("你的防护服自动扑灭了你身上的火。"))
	owner.extinguish_mob()
	new /obj/effect/particle_effect/water(get_turf(owner))

/obj/item/clothing/suit/space/eva/plasmaman/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (!istype(tool, /obj/item/extinguisher_refill))
		return

	if (extinguishes_left == initial(extinguishes_left))
		to_chat(user, span_notice("内置灭火器是满的。"))
		return ITEM_INTERACT_BLOCKING

	extinguishes_left = initial(extinguishes_left)
	to_chat(user, span_notice("你给防护服的内置灭火器补充了灭火剂，用掉了整个罐体。"))
	check_fire_state()
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

//I just want the light feature of helmets
/obj/item/clothing/head/helmet/space/plasmaman
	name = "等离子防护头盔"
	desc = "一顶特殊的收容头盔，可让等离子体生命在含氧环境中安全存活。它适合太空环境，可与其他 EVA 装备一同佩戴。"
	icon = 'icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'icons/mob/clothing/head/plasmaman_head.dmi'
	clothing_flags = parent_type::clothing_flags | PLASMAMAN_PREVENT_IGNITION
	icon_state = "plasmaman-helm"
	inhand_icon_state = "plasmaman-helm"
	strip_delay = 8 SECONDS
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	armor_type = /datum/armor/space_plasmaman
	resistance_flags = FIRE_PROOF
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 0.8
	light_color = "#ffcc99"
	light_on = FALSE
	fishing_modifier = 0
	actions_types = list(/datum/action/item_action/toggle_helmet_light, /datum/action/item_action/toggle_welding_screen)
	visor_flags = NONE
	visor_flags_inv = HIDEEYES|HIDEFACE|HIDESNOUT
	visor_flags_cover = NONE
	visor_dirt = null
	var/helmet_on = FALSE
	var/smile = FALSE
	var/smile_color = COLOR_RED
	var/visor_icon = "envisor"
	var/smile_state = "envirohelm_smile"

/datum/armor/space_plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/Initialize(mapload)
	. = ..()
	visor_toggling()
	update_appearance()
	register_context()

/obj/item/clothing/head/helmet/space/plasmaman/add_stabilizer(loose_hat = FALSE)
	..()

/obj/item/clothing/head/helmet/space/plasmaman/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	context[SCREENTIP_CONTEXT_ALT_LMB] = "切换焊接面罩"
	if(istype(held_item, /obj/item/toy/crayon))
		context[SCREENTIP_CONTEXT_LMB] = "涂鸦"

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/head/helmet/space/plasmaman/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/helmet/space/plasmaman/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_welding_screen))
		adjust_visor(user)
		return

	return ..()

/obj/item/clothing/head/helmet/space/plasmaman/adjust_visor(mob/living/user)
	. = ..()
	if(!.)
		return
	if(helmet_on)
		to_chat(user, span_notice("头盔的灯无法透过焊接面罩照出！"))
		set_light_on(FALSE)
		helmet_on = FALSE
	update_appearance()

/obj/item/clothing/head/helmet/space/plasmaman/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][helmet_on ? "-light":""]"
	inhand_icon_state = icon_state

/obj/item/clothing/head/helmet/space/plasmaman/update_overlays()
	. = ..()
	if(!up)
		. += visor_icon
	if(smile)
		var/mutable_appearance/smiley = mutable_appearance(icon, smile_state)
		smiley.color = smile_color
		. += smiley

/obj/item/clothing/head/helmet/space/plasmaman/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/crayon))
		return NONE

	if(smile)
		to_chat(user, span_warning("似乎已经有人在 [src] 的面罩上画了东西！"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/toy/crayon/crayon = tool
	to_chat(user, span_notice("你开始在 [src] 的面罩上画一个笑脸……"))
	if(!do_after(user, 2.5 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	smile = TRUE
	smile_color = crayon.paint_color
	to_chat(user, "你在 [src] 的面罩上画了一个笑脸。")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

///By the by, helmets have the update_icon_updates_onmob element, so we don't have to call mob.update_worn_head()
/obj/item/clothing/head/helmet/space/plasmaman/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands && !up)
		// BUBBER EDIT START
		. += mutable_appearance(worn_icon, visor_icon)
		// BUBBER EDIT END

/obj/item/clothing/head/helmet/space/plasmaman/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands = FALSE, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands && smile)
		// BUBBER EDIT START
		var/mutable_appearance/smiley = mutable_appearance(worn_icon, smile_state)
		// BUBBER EDIT END
		smiley.color = smile_color
		. += smiley

/obj/item/clothing/head/helmet/space/plasmaman/wash(clean_types)
	. = NONE
	if(smile && (clean_types & CLEAN_TYPE_HARD_DECAL))
		smile = FALSE
		update_appearance(UPDATE_OVERLAYS)
		. |= COMPONENT_CLEANED|COMPONENT_CLEANED_GAIN_XP
	. |= ..()

/obj/item/clothing/head/helmet/space/plasmaman/attack_self(mob/user)
	helmet_on = !helmet_on
	update_appearance()

	if(helmet_on)
		if(!up)
			to_chat(user, span_notice("头盔的灯无法透过焊接面罩照出！"))
			set_light_on(FALSE)
			// BUBBER EDIT ADDITION START
			helmet_on = FALSE
			update_appearance()
			// BUBBER EDIT ADDITION END
		else
			set_light_on(TRUE)
	else
		set_light_on(FALSE)

	update_item_action_buttons()

/obj/item/clothing/head/helmet/space/plasmaman/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(!helmet_on)
		return FALSE
	helmet_on = FALSE
	update_appearance()
	return TRUE

/obj/item/clothing/head/helmet/space/plasmaman/security
	name = "安保等离子防护头盔"
	desc = "专为安保官设计的等离子防护头盔，保护他们免于被活活烧死，也防其他不受欢迎的东西。"
	icon_state = "security_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/head_helmet/plasmaman

/datum/armor/head_helmet/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/security/detective
	name = "侦探的等离子防护头盔"
	desc = "专为侦探设计的特殊收容头盔，保护他们免于被活活烧死，也防其他不受欢迎的东西。"
	icon_state = "white_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/fedora_det_hat/plasmaman

/datum/armor/fedora_det_hat/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/security/warden
	name = "典狱长的等离子防护头盔"
	desc = "专为典狱长设计的等离子防护头盔。加了两道白色条纹，以便与安保部门的其他成员区分。"
	icon_state = "warden_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_warden/plasmaman

/datum/armor/hats_warden/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/security/head_of_security
	name = "安保主管的等离子防护头盔"
	desc = "专为安保主管设计的特殊收容头盔。加了两道金色条纹，以便与安保部门的其他成员区分。"
	icon_state = "hos_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_hos/plasmaman

/datum/armor/hats_hos/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/prisoner
	name = "囚犯的等离子防护头盔"
	desc = "为囚犯准备的等离子防护头盔。"
	icon_state = "prisoner_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/medical
	name = "医生的等离子防护头盔"
	desc = "专为等离子体医生设计的防护头盔，沿长度方向有两道条纹以示身份。"
	icon_state = "doctor_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/coroner
	name = "验尸官的等离子防护头盔"
	desc = "专为等离子体验尸官设计的防护头盔，比常规型号更有棱角。"
	icon_state = "coroner_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/paramedic
	name = "急救员的等离子防护头盔"
	desc = "专为等离子体急救员设计的防护头盔，条纹比医疗型号的蓝色更深。"
	icon_state = "paramedic_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/viro
	name = "病毒学的等离子防护头盔"
	desc = "由空间站上最安全的人佩戴的头盔——就是那些对自己创造的怪物完全免疫的人。"
	icon_state = "virologist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/chemist
	name = "化学的等离子防护头盔"
	desc = "专为化学家设计的等离子体防护服，面部有两道橙色条纹。"
	icon_state = "chemist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/chief_medical_officer
	name = "首席医疗官的等离子防护头盔"
	desc = "专为首席医疗官设计的特殊收容头盔。施加一道金色条纹以示与其他医疗人员的区别。"
	icon_state = "cmo_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/science
	name = "科研的等离子防护头盔"
	desc = "专为科学家设计的等离子体防护头盔。"
	icon_state = "scientist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/robotics
	name = "机器人学的等离子防护头盔"
	desc = "专为机器人学家设计的等离子体防护头盔。"
	icon_state = "roboticist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/genetics
	name = "基因学家的等离子防护头盔"
	desc = "专为基因学家设计的等离子体防护头盔。"
	icon_state = "geneticist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/research_director
	name = "研究主管的等离子防护头盔"
	desc = "专为研究主管设计的特殊收容头盔。采用浅棕色设计以示与其他科学家的区别。"
	icon_state = "rd_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/engineering
	name = "工程的等离子防护头盔"
	desc = "专为等离子体工程师设计的太空头盔，常见的紫色条纹被工程的橙色取代。"
	icon_state = "engineer_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/space_plasmaman/engineering_atmos

/datum/armor/space_plasmaman/engineering_atmos
	acid = 95

/obj/item/clothing/head/helmet/space/plasmaman/atmospherics
	name = "大气的等离子防护头盔"
	desc = "专为等离子体大气技师设计的太空头盔，常见的紫色条纹被大气的蓝色取代。隔热性更佳。"
	icon_state = "atmos_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/space_plasmaman/engineering_atmos
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT // Same protection as the Atmospherics Hardhat

/obj/item/clothing/head/helmet/space/plasmaman/chief_engineer
	name = "总工程师的等离子防护头盔"
	desc = "专为总工程师设计的特殊收容头盔，常见的紫色条纹被总工程师的绿色取代。隔热性更佳。"
	icon_state = "ce_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/space_plasmaman/engineering_atmos
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT // Same protection as the Atmospherics Hardhat

/obj/item/clothing/head/helmet/space/plasmaman/cargo
	name = "货运的等离子防护头盔"
	desc = "专为货运技师和军需官设计的等离子体防护头盔。"
	icon_state = "cargo_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/mining
	name = "采矿的等离子防护头盔"
	desc = "发给在熔岩地作业的等离子体矿工的一顶卡其色头盔。"
	icon_state = "explorer_envirohelm"
	inhand_icon_state = null
	visor_icon = "explorer_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/chaplain
	name = "牧师的等离子防护头盔"
	desc = "专为最虔诚的等离子体信徒设计的防护头盔。"
	icon_state = "chap_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/white
	name = "白色等离子防护头盔"
	desc = "一顶通用白色防护头盔。"
	icon_state = "white_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/curator
	name = "管理员的等离子防护头盔"
	desc = "这顶头盔是对传统太空服头盔的小幅改装，是纳米传讯针对*雇佣等离子体人带来的后勤问题*给出的首个方案。尽管有种种局限，这些头盔仍被历史学家和老派等离子体人使用。"
	icon_state = "prototype_envirohelm"
	inhand_icon_state = "void_helmet"
	actions_types = list(/datum/action/item_action/toggle_welding_screen)
	smile_state = "prototype_smile"
	visor_icon = "prototype_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/botany
	name = "植物学的等离子防护头盔"
	desc = "一顶绿蓝相间的防护头盔，表明佩戴者是植物学家。虽然并非为此专门设计，但它能防护轻微的植物相关伤害。"
	icon_state = "botany_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/janitor
	name = "清洁工的等离子防护头盔"
	desc = "一顶灰色头盔，带有一对紫色条纹，表明佩戴者是清洁工。"
	icon_state = "janitor_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/mime
	name = "默剧演员防护头盔"
	desc = "妆是画上去的，居然没掉漆，真是奇迹。颜色不怎么鲜艳。"
	icon_state = "mime_envirohelm"
	inhand_icon_state = null
	visor_icon = "mime_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/clown
	name = "小丑防护头盔"
	desc = "妆是画上去的，居然没掉漆，真是奇迹。<i>“HONK！”</i>"
	icon_state = "clown_envirohelm"
	inhand_icon_state = null
	visor_icon = "clown_envisor"
	smile_state = "clown_smile"

/obj/item/clothing/head/helmet/space/plasmaman/clown/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/head/helmet/space/plasmaman/head_of_personnel
	name = "人事主管的防护头盔"
	desc = "专为人事主管设计的特殊收容头盔。尴尬的是，除了红色条纹外，它看起来实在太像舰长的款式了。"
	icon_state = "hop_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_hopcap/plasmaman

/datum/armor/hats_hopcap/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/captain
	name = "舰长的等离子防护头盔"
	desc = "专为舰长设计的特殊收容头盔。尴尬的是，除了金色条纹外，它看起来实在太像人事主管的款式了。我是说，拜托。金色条纹能解决一切。"
	icon_state = "captain_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_caphat/plasmaman

/datum/armor/hats_caphat/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/centcom_commander
	name = "中央指挥部指挥官的等离子防护头盔"
	desc = "专为中央指挥部高层人员设计的特殊收容头盔。这种头盔数量不多，因为中央指挥部通常不会因各种麻烦而聘用等离子体人担任高层职位。"
	icon_state = "commander_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_centhat/plasmaman

/datum/armor/hats_centhat/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/centcom_official
	name = "中央指挥部官员的等离子防护头盔"
	desc = "专为中央指挥部人员设计的特殊收容头盔。他们确实很爱自己的绿色。"
	icon_state = "official_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/centcom_intern
	name = "中央指挥部实习生的等离子防护头盔"
	desc = "专为中央指挥部人员设计的特殊收容头盔。你知道的，这样洒出的咖啡就不会弄死那可怜的家伙。"
	icon_state = "intern_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/syndie
	name = "战术潮流防护头盔"
	desc = "毫无疑问，这顶头盔让你凌驾于所有其他等离子体人之上。如果你看到另一个等离子体人戴着这样的头盔，那要么是因为他也是个狠角色，\
		要么是因为他谋杀了一个你的狠角色同伴，并把它当作战利品夺走。不管怎样，戴这顶头盔的人都至少值得你点头致意。"
	icon_state = "syndie_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/bitrunner
	name = "比特潜行者的等离子防护头盔"
	desc = "一顶带有扩展蓝色滤光片的防护头盔，供比特跑的等离子体人使用。"
	icon_state = "bitrunner_envirohelm"
