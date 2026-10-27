/obj/item/reagent_containers/hypospray
	name = "无针注射器"
	desc = "德福雷斯特医疗公司的无针注射器是一款无菌的气动针头自动注射器，可快速为患者给药。"
	icon = 'icons/obj/medical/syringe.dmi'
	inhand_icon_state = "hypo"
	worn_icon_state = "hypo"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = list(5)
	resistance_flags = ACID_PROOF
	initial_reagent_flags = OPENCONTAINER | NO_SPLASH
	slot_flags = ITEM_SLOT_BELT
	var/ignore_flags = NONE
	var/infinite = FALSE
	/// If TRUE, won't play a noise when injecting.
	var/stealthy = FALSE
	/// If TRUE, the hypospray will be permanently unusable.
	var/used_up = FALSE
	// BUBBER EDIT CHANGE: for pen_medipens, allows for medipens without the warning label
	var/no_sticker = FALSE

/obj/item/reagent_containers/hypospray/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/reagent_containers/hypospray/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	return inject(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/item/reagent_containers/hypospray/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	if (!target.reagents)
		return NONE

	if(isliving(target))
		to_chat(user, span_warning("[src] 不能用来抽血！"))
		return ITEM_INTERACT_BLOCKING

	if(reagents.holder_full())
		to_chat(user, span_notice("[src] 是满的。"))
		return ITEM_INTERACT_BLOCKING

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target] 是空的！"))
		return ITEM_INTERACT_BLOCKING

	if(!target.is_drawable(user))
		to_chat(user, span_warning("你无法直接从 [target] 中取出试剂！"))
		return ITEM_INTERACT_BLOCKING

	var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user)
	if(trans)
		to_chat(user, span_notice("你往 [src] 里装了 [trans] 单位溶液。现在它含有 [reagents.total_volume] 单位。"))
	return ITEM_INTERACT_SUCCESS

///Handles all injection checks, injection and logging.
/obj/item/reagent_containers/hypospray/proc/inject(mob/living/affected_mob, mob/user)
	if(used_up)
		to_chat(user, span_warning("[src] 的针头已损坏，无法再使用！"))
		return FALSE
	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "尝试注射", src, "([contained])")
	user.changeNext_move(CLICK_CD_MELEE)

	if(!used_up && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))) // Ignore flag should be checked first or there will be an error message.
		to_chat(affected_mob, span_warning("你感到一阵轻微的刺痛！"))
		to_chat(user, span_notice("你用 [src] 为 [affected_mob] 注射。"))
		if(!stealthy)
			playsound(affected_mob, 'sound/items/hypospray.ogg', 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)


		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transferred_by = user, methods = INJECT)
			else
				reagents.expose(affected_mob, INJECT, fraction)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, methods = INJECT, copy_only = TRUE)
			to_chat(user, span_notice("已注射 [trans] 单位。[src] 中还剩 [reagents.total_volume] 单位。"))
			log_combat(user, affected_mob, "注射", src, "([contained])")
		return TRUE
	return FALSE


/obj/item/reagent_containers/hypospray/cmo
	volume = 60
	possible_transfer_amounts = list(1,3,5)
	list_reagents = list(/datum/reagent/medicine/omnizine = 30)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//combat

/obj/item/reagent_containers/hypospray/combat
	name = "战斗兴奋剂注射器"
	desc = "一款改装过的气动针头自动注射器，供支援特工在战斗中快速处理伤势。"
	amount_per_transfer_from_this = 10
	inhand_icon_state = "combat_hypo"
	icon_state = "combat_hypo"
	volume = 90
	possible_transfer_amounts = list(5,10)
	ignore_flags = 1 // So they can heal their comrades.
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30, /datum/reagent/medicine/omnizine = 30, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/hypospray/combat/empty
	list_reagents = null

/obj/item/reagent_containers/hypospray/combat/nanites
	name = "实验性战斗兴奋剂注射器"
	desc = "一款改装过的气动针头自动注射器，用于战斗场合。预装了实验性医疗纳米机器人和兴奋剂，可快速治疗并提供战斗加成。"
	inhand_icon_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 100
	list_reagents = list(/datum/reagent/medicine/adminordrazine/quantum_heal = 80, /datum/reagent/medicine/synaptizine = 20)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/combat/heresypurge
	name = "圣水穿刺注射器"
	desc = "一款改装过的气动针头自动注射器，用于战斗场合。预装了 5 剂圣水与镇静剂混合物。请勿对队友使用。"
	inhand_icon_state = "holy_hypo"
	icon_state = "holy_hypo"
	volume = 250
	possible_transfer_amounts = list(25,50)
	list_reagents = list(/datum/reagent/water/holywater = 150, /datum/reagent/peaceborg/tire = 50, /datum/reagent/peaceborg/confuse = 50)
	amount_per_transfer_from_this = 50

//MediPens

/obj/item/reagent_containers/hypospray/medipen
	name = "肾上腺素注射笔"
	desc = "一种快速而安全的方式，可供不具备高级医学知识的人员稳定情况危急的患者。含有强效防腐剂，用于尸体时可延缓腐烂，并能在过敏反应期间阻止组胺产生。"
	icon_state = "medipen"
	inhand_icon_state = "medipen"
	worn_icon_state = "medipen"
	base_icon_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount_per_transfer_from_this = 15
	has_variable_transfer_amount = FALSE
	volume = 15
	ignore_flags = 1 //so you can medipen through spacesuits
	initial_reagent_flags = NONE
	flags_1 = null
	list_reagents = list(/datum/reagent/medicine/epinephrine = 10, /datum/reagent/toxin/formaldehyde = 3, /datum/reagent/medicine/coagulant = 2)
	custom_price = PAYCHECK_CREW
	custom_premium_price = PAYCHECK_COMMAND
	var/label_examine = TRUE
	var/label_text

/obj/item/reagent_containers/hypospray/medipen/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 开始被 [src] 呛住！看来是想自杀！"))
	return OXYLOSS//ironic. he could save others from oxyloss, but not himself.

/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(. && !reagents.total_volume)
		used_up = TRUE //Makes them useless afterwards
		reagents.flags = NONE
		update_appearance()

/obj/item/reagent_containers/hypospray/medipen/attack_self(mob/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH|ALLOW_RESTING))
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/medipen/Initialize(mapload)
	. = ..()
	if(!no_sticker) // BUBBER EDIT CHANGE: for pen_medipens, allows for medipens without the warning label
		label_text = span_notice("侧面贴着一张标签，上面写着：“警告：本注射笔含有 [pretty_string_from_reagent_list(reagents.reagent_list, names_only = TRUE, join_text = ", ", final_and = TRUE, capitalize_names = TRUE)]，如果对所列任何化学物质过敏，请勿使用。”")

/obj/item/reagent_containers/hypospray/medipen/examine()
	. = ..()
	if (label_examine)
		. += label_text
	if(length(reagents?.reagent_list))
		. += span_notice("它已装填。")
	else
		. += span_notice("它已用尽。")

/obj/item/reagent_containers/hypospray/medipen/stimpack //goliath kiting
	name = "兴奋针注射笔"
	desc = "一种快速激发身体肾上腺素的方法，让你在笨重的护甲里也能更灵活地行动。"
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/medicine/ephedrine = 10, /datum/reagent/consumable/coffee = 10)

/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor
	desc = "一款改装过的兴奋剂自动注射器，用于战斗场合。具有轻微的治疗效果。"
	list_reagents = list(/datum/reagent/medicine/stimulants = 10, /datum/reagent/medicine/omnizine = 10)
	volume = 20

/obj/item/reagent_containers/hypospray/medipen/stimulants
	name = "兴奋剂注射笔"
	desc = "含有大量极其强效的兴奋剂，可在约五分钟内大幅提升移动速度并极大减少眩晕时间。孕期请勿服用。"
	icon_state = "syndipen"
	inhand_icon_state = "tbpen"
	base_icon_state = "syndipen"
	volume = 50
	amount_per_transfer_from_this = 50
	list_reagents = list(/datum/reagent/medicine/stimulants = 50)

/obj/item/reagent_containers/hypospray/medipen/methamphetamine
	name = "甲基安非他命注射笔"
	volume = 24
	amount_per_transfer_from_this = 24
	desc = "含有相对安全剂量的甲基安非他命，并加入甘露醇，以尽量减少脑损伤。"
	list_reagents = list(/datum/reagent/drug/methamphetamine = 10, /datum/reagent/medicine/mannitol = 14)

/obj/item/reagent_containers/hypospray/medipen/morphine
	name = "吗啡注射笔"
	desc = "一种让你迅速脱离困境的快捷手段！不过你会感到相当困倦。"
	icon_state = "morphen"
	inhand_icon_state = "morphen"
	base_icon_state = "morphen"
	list_reagents = list(/datum/reagent/medicine/morphine = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/oxandrolone
	name = "氧雄龙注射笔"
	desc = "一支含氧雄龙的自动注射器，用于治疗严重烧伤。"
	icon_state = "oxapen"
	inhand_icon_state = "oxapen"
	base_icon_state = "oxapen"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/penacid
	name = "喷替酸注射笔"
	desc = "一支含喷替酸的自动注射器，用于降低高剂量辐射与中等程度的毒素。"
	icon_state = "penacid"
	inhand_icon_state = "penacid"
	base_icon_state = "penacid"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/salacid
	name = "水杨酸注射笔"
	desc = "一支含水杨酸的自动注射器，用于治疗严重的钝击伤害。"
	icon_state = "salacid"
	inhand_icon_state = "salacid"
	base_icon_state = "salacid"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/salbutamol
	name = "沙丁胺醇注射笔"
	desc = "一支含沙丁胺醇的自动注射器，用于快速治疗缺氧伤害。"
	icon_state = "salpen"
	inhand_icon_state = "salpen"
	base_icon_state = "salpen"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure
	name = "BVAK 自动注射器"
	desc = "生物病毒解毒套装自动注射器。具备两次使用量，可供自己和他人使用。感染时注射。"
	icon_state = "tbpen"
	inhand_icon_state = "tbpen"
	base_icon_state = "tbpen"
	volume = 20
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 20)

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"

/obj/item/reagent_containers/hypospray/medipen/survival
	name = "生存急救注射笔"
	desc = "用于在恶劣环境中生存的注射笔，可治疗大多数常见伤害来源。警告：可能造成器官损伤。"
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list( /datum/reagent/medicine/epinephrine = 8, /datum/reagent/medicine/c2/aiuri = 8, /datum/reagent/medicine/c2/libital = 8, /datum/reagent/medicine/leporazine = 6)

/obj/item/reagent_containers/hypospray/medipen/survival/inject(mob/living/affected_mob, mob/user)
	if(lavaland_equipment_pressure_check(get_turf(user)))
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
		return ..()

	if(DOING_INTERACTION(user, DOAFTER_SOURCE_SURVIVALPEN))
		to_chat(user,span_notice("你太忙了，没法使用 \the [src]！"))
		return

	to_chat(user,span_notice("你开始手动释放低压阀门……"))
	if(!do_after(user, 10 SECONDS, affected_mob, interaction_key = DOAFTER_SOURCE_SURVIVALPEN))
		return

	amount_per_transfer_from_this = initial(amount_per_transfer_from_this) * 0.5
	return ..()


/obj/item/reagent_containers/hypospray/medipen/survival/luxury
	name = "豪华注射笔"
	desc = "尖端的蓝空间技术让纳米传讯得以把 60u 容量压缩进一支注射笔。其中含有用于协助探索极端环境的稀有强效化学品。警告：请勿与肾上腺素或阿托品混用。"
	icon_state = "luxpen"
	inhand_icon_state = "atropen"
	base_icon_state = "luxpen"
	volume = 60
	amount_per_transfer_from_this = 60
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/c2/penthrite = 10, /datum/reagent/medicine/oxandrolone = 10, /datum/reagent/medicine/sal_acid = 10 ,/datum/reagent/medicine/omnizine = 10 ,/datum/reagent/medicine/leporazine = 10)

/obj/item/reagent_containers/hypospray/medipen/atropine
	name = "阿托品自动注射器"
	desc = "一种快速把人从危重伤势中救回来的手段！另外还含有强效凝血剂，以防止失血。"
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/atropine = 10, /datum/reagent/medicine/coagulant = 2)
	volume = 12

/obj/item/reagent_containers/hypospray/medipen/snail
	name = "蜗牛针剂"
	desc = "万能蜗牛药！请勿用于非蜗牛生物！"
	icon_state = "snail"
	inhand_icon_state = "snail"
	base_icon_state = "snail"
	list_reagents = list(/datum/reagent/snail = 10)
	label_examine = FALSE
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/magillitis
	name = "实验性自动注射器"
	desc = "一种定制框架的针头注射器，带有一个小型一次性储液腔，内含实验性血清。与更常见的注射笔框架不同，它无法刺穿防护装甲或太空服，里面的化学物质也无法被抽出。"
	icon_state = "gorillapen"
	inhand_icon_state = "gorillapen"
	base_icon_state = "gorillapen"
	volume = 5
	ignore_flags = 0
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/hypospray/medipen/pumpup
	name = "维护区振奋剂"
	desc = "一支看起来很廉价的自制自动注射器，里面灌着便宜肾上腺素……非常适合用来扛住电击棍的效果。"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/drug/pumpup = 15)
	icon_state = "maintenance"
	base_icon_state = "maintenance"
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/ekit
	name = "急救自动注射笔"
	desc = "一支肾上腺素注射笔，额外添加了凝血剂和抗生素，用于帮助稳定严重的割伤和烧伤。"
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 12, /datum/reagent/medicine/coagulant = 2.5, /datum/reagent/medicine/spaceacillin = 0.5)

/obj/item/reagent_containers/hypospray/medipen/blood_loss
	name = "低血容量应急自动注射器"
	desc = "一款旨在稳定并迅速逆转严重失血的注射笔。"
	icon_state = "hypovolemic"
	base_icon_state = "hypovolemic"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 5, /datum/reagent/medicine/coagulant = 2.5, /datum/reagent/iron = 3.5, /datum/reagent/medicine/salglu_solution = 4)

/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "去突变药自动注射器"
	desc = "一支去突变药注射笔，仅需一支即可协助治愈基因错误。"
	icon_state = "penacid"
	inhand_icon_state = "penacid"
	base_icon_state = "penacid"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/mutadone = 15)

/obj/item/reagent_containers/hypospray/medipen/penthrite
	name = "彭斯莱特自动注射器"
	desc = "实验性心脏药物。"
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/c2/penthrite = 10)
	volume = 10
