// Pen basetype where the icon is gotten from
/obj/item/reagent_containers/hypospray/medipen/deforest
	name = "故障的德福雷斯特自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，不过这一支似乎既空了又坏了。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/injectors.dmi'
	icon_state = "default"
	volume = 25
	list_reagents = list()
	custom_price = PAYCHECK_COMMAND
	/// If this pen has a timer for injecting others with, just for safety with some of the drugs in these
	var/inject_others_time = 1.5 SECONDS

/obj/item/reagent_containers/hypospray/medipen/deforest/Initialize(mapload)
	. = ..()
	amount_per_transfer_from_this = volume

/obj/item/reagent_containers/hypospray/medipen/deforest/inject(mob/living/affected_mob, mob/user)
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] 是空的！"))
		return FALSE
	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "试图注射", src, "([contained])")

	if((affected_mob != user) && inject_others_time)
		affected_mob.visible_message(span_danger("[user] 正试图给 [affected_mob] 注射！"), \
				span_userdanger("[user] 正试图往你体内注射什么东西！"))
		if(!do_after(user, CHEM_INTERACT_DELAY(inject_others_time, user), affected_mob))
			return FALSE

	if(reagents.total_volume && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))) // Ignore flag should be checked first or there will be an error message.
		to_chat(affected_mob, span_warning("你感到一阵轻微的刺痛！"))
		to_chat(user, span_notice("你用 [src] 给 [affected_mob] 注射。"))
		if(!stealthy)
			playsound(affected_mob, 'sound/items/hypospray.ogg', 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transferred_by = user, methods = INJECT)
			else
				reagents.expose(affected_mob, INJECT, fraction)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, copy_only = TRUE)
			to_chat(user, span_notice("已注射 [trans] 单位。[src] 中还剩 [reagents.total_volume] 单位。"))
			log_combat(user, affected_mob, "注射", src, "([contained])")
		return TRUE
	return FALSE

// Sensory restoration, heals eyes and ears with a bit of impurity
/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate
	name = "奥库伊萨特感官恢复自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合试剂，可让你的视觉与听觉恢复正常。"
	base_icon_state = "occuisate"
	icon_state = "occuisate"
	list_reagents = list(
		/datum/reagent/medicine/inacusiate = 7,
		/datum/reagent/medicine/oculine = 7,
		/datum/reagent/impurity/inacusiate = 3,
		/datum/reagent/inverse/oculine = 3,
		/datum/reagent/toxin/lipolicide = 5,
	)

// Adrenaline, fills you with determination (and also stimulants)
/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline
	name = "肾上腺素自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合试剂，可让你按需主动进入战斗或逃跑状态。"
	base_icon_state = "adrenaline"
	icon_state = "adrenaline"
	list_reagents = list(
		/datum/reagent/medicine/synaptizine = 5,
		/datum/reagent/medicine/inaprovaline = 5,
		/datum/reagent/determination = 10,
		/datum/reagent/toxin/histamine = 5,
	)

// Morpital, heals a small amount of damage and kills pain for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/morpital
	name = "莫匹塔尔再生兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合试剂，可麻痹疼痛并修复少量物理损伤。"
	base_icon_state = "morpital"
	icon_state = "morpital"
	list_reagents = list(
		/datum/reagent/medicine/morphine = 5,
		/datum/reagent/medicine/omnizine/protozine = 15,
		/datum/reagent/toxin/staminatoxin = 5,
	)

// Lipital, heals more damage than morpital but doesnt work much at higher damages
/obj/item/reagent_containers/hypospray/medipen/deforest/lipital
	name = "利匹塔尔再生兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合试剂，可麻痹疼痛并修复少量物理损伤。 \
		对钝击造成的损伤效果最佳。"
	base_icon_state = "lipital"
	icon_state = "lipital"
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 5,
		/datum/reagent/medicine/omnizine = 5,
		/datum/reagent/medicine/c2/probital = 10,
	)

// Anti-poisoning injector, with a little bit of radiation healing as a treat
/obj/item/reagent_containers/hypospray/medipen/deforest/meridine
	name = "梅里丁解毒剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合试剂，可解除银河系中大多数毒素。 \
		上面贴着的警告标签指出，若患者已有物理损伤则不应使用，因为可能引发并发症。"
	base_icon_state = "meridine"
	icon_state = "meridine"
	list_reagents = list(
		/datum/reagent/medicine/ammoniated_mercury = 9,
		/datum/reagent/medicine/potass_iodide = 10,
		/datum/reagent/nitrous_oxide = 5,
	)

// Epinephrine and helps a little bit against stuns and stamina damage
/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine
	name = "辛弗林应急兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合试剂，可稳定危重状态并恢复精力损耗。"
	base_icon_state = "synephrine"
	icon_state = "synephrine"
	list_reagents = list(
		/datum/reagent/medicine/epinephrine = 10,
		/datum/reagent/medicine/synaptizine = 5,
		/datum/reagent/medicine/synaphydramine = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5

// Critical condition stabilizer
/obj/item/reagent_containers/hypospray/medipen/deforest/calopine
	name = "卡洛平应急稳定剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有可稳定状态的混合试剂，用于修复危重状况。"
	base_icon_state = "calopine"
	icon_state = "calopine"
	list_reagents = list(
		/datum/reagent/medicine/atropine = 10,
		/datum/reagent/medicine/coagulant/fabricated = 5,
		/datum/reagent/medicine/salbutamol = 5,
		/datum/reagent/toxin/staminatoxin = 5,
	)

// Coagulant, really not a whole lot more
/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants
	name = "凝血剂-S 自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合凝血剂，可预防并止住出血。"
	base_icon_state = "coagulant"
	icon_state = "coagulant"
	list_reagents = list(
		/datum/reagent/medicine/coagulant = 5,
		/datum/reagent/medicine/salglu_solution = 15,
		/datum/reagent/impurity = 5,
	)

// Stimulant centered around ondansetron
/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine
	name = "克罗托嗪调控兴奋剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合兴奋剂与弱效治疗剂。"
	base_icon_state = "krotozine"
	icon_state = "krotozine"
	list_reagents = list(
		/datum/reagent/medicine/ondansetron = 5,
		/datum/reagent/drug/kronkaine = 5,
		/datum/reagent/medicine/omnizine/protozine = 10,
		/datum/reagent/drug/maint/tar = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5

// Stuff really good at healing burn stuff and stabilizing temps
/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi
	name = "莱波图里烧伤治疗自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合药物，可迅速治疗烧伤。"
	base_icon_state = "lepoturi"
	icon_state = "lepoturi"
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 5,
		/datum/reagent/medicine/leporazine = 5,
		/datum/reagent/medicine/c2/lenturi = 10,
		/datum/reagent/toxin/staminatoxin = 5,
	)

// Stabilizes a lot of stats like drowsiness, sanity, dizziness, so on
/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil
	name = "普西非尼个人恢复自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合药物，可缓解许多常见的不适，如困倦、疼痛、情绪不稳等等。"
	base_icon_state = "psifinil"
	icon_state = "psifinil"
	list_reagents = list(
		/datum/reagent/medicine/modafinil = 10,
		/datum/reagent/medicine/psicodine = 10,
		/datum/reagent/medicine/leporazine = 5,
	)

// Helps with liver failure and some drugs, also alcohol
/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin
	name = "哈洛比宁醒酒剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有混合药物，可缓解肝衰竭与常见药物的影响。"
	base_icon_state = "halobinin"
	icon_state = "halobinin"
	list_reagents = list(
		/datum/reagent/medicine/haloperidol = 5,
		/datum/reagent/medicine/antihol = 5,
		/datum/reagent/medicine/higadrite = 5,
		/datum/reagent/medicine/silibinin = 5,
	)

// Medpen for robots that fixes toxin damage and purges synth chems but slows them down for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner
	name = "合成体清洁剂自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有为合成体清除体内试剂而配制的系统清洁剂。"
	base_icon_state = "robor"
	icon_state = "robor"
	list_reagents = list(
		/datum/reagent/medicine/system_cleaner = 15,
		/datum/reagent/dinitrogen_plasmide = 5,
	)

// Medpen for robots that fixes brain damage but slows them down for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder
	name = "合成体智能焊锡自动注射器"
	desc = "一款德福雷斯特品牌的自动注射器，装有液态焊锡，用于修复合成体处理器核心的损伤。"
	base_icon_state = "robor_brain"
	icon_state = "robor_brain"
	list_reagents = list(
		/datum/reagent/medicine/liquid_solder = 15,
		/datum/reagent/dinitrogen_plasmide = 5,
	)
