/*!
 * Tier 4 knowledge: Combat related knowledge
 */

/datum/heretic_knowledge/spell/space_phase
	name = "空间相位"
	desc = "赋予你空间相位，一种让你能在太空中自由移动的法术。<br>\
		只有当你身处太空或杂项地砖上时，才能进入或退出相位。"
	gain_text = "你感觉自己的身体能像尘埃一样穿过太空。"

	action_to_add = /datum/action/cooldown/spell/jaunt/space_crawl
	cost = 2
	research_tree_icon_frame = 6
	drafting_tier = 4
	max_charges = 2
	path_recharge_amount = 0.0
	holywater_drain_amount = 0.5
	transmute_text = "充能方法：站在符文上捏碎一块蓝空间水晶。"
	/// Tracks tim ein EVA
	var/seconds_in_eva = 0

/datum/heretic_knowledge/spell/space_phase/has_charges(mob/living/user)
	return HAS_TRAIT(user, TRAIT_MAGICALLY_PHASED) || ..()

/datum/heretic_knowledge/spell/space_phase/should_deduct_charge(mob/living/user)
	return !HAS_TRAIT(user, TRAIT_MAGICALLY_PHASED)

/datum/heretic_knowledge/spell/space_phase/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_CRUSHED_BLUESPACE_CRYSTAL, PROC_REF(on_crystal_crushed))

/datum/heretic_knowledge/spell/space_phase/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_CRUSHED_BLUESPACE_CRYSTAL)

/datum/heretic_knowledge/spell/space_phase/proc/on_crystal_crushed(mob/living/source, obj/item/crystal)
	SIGNAL_HANDLER

	var/obj/effect/heretic_rune/rune = locate() in view(1, source)
	if(isnull(rune))
		return

	rune.ritual_animation()
	add_charges(1)

/datum/heretic_knowledge/unfathomable_curio
	name = "深不可测的古玩"
	desc = "制作一件深不可测的古玩—— \
		一条可以存放刀刃和仪式物品的腰带。<br>佩戴时它会为你覆上一层帷幕， \
		以消耗帷幕为代价挡下一次伤害。离开战斗后，帷幕会自行恢复。"
	transmute_text = "转化 3 根金属杆、肺和任意腰带。"
	gain_text = "漫宿藏有无数古玩，其中一些并非凡人肉眼该见之物。"

	required_atoms = list(
		/obj/item/organ/lungs = 1,
		/obj/item/stack/rods = 3,
		/obj/item/storage/belt = 1,
	)
	result_atoms = list(/obj/item/storage/belt/unfathomable_curio)
	cost = 2
	research_tree_icon_path = 'icons/obj/clothing/belts.dmi'
	research_tree_icon_state = "unfathomable_curio"
	drafting_tier = 4

/datum/heretic_knowledge/rust_sower
	name = "锈蚀播种者手榴弹"
	desc = "召唤一枚装满诡异锈蚀的手榴弹。<br>引爆时，它会释放出巨大的云雾， \
		使有机体失明、锈蚀受影响的地砖，并彻底摧毁硅基单位与机甲。"
	transmute_text = "转化一个化学手榴弹外壳和一些发霉的食物。"
	gain_text = "锈蚀群丘上枯槁的藤蔓结满了这样熟透的果实。它能抹去进步的痕迹，留下一片干净的白纸，好让人重新塑造新的形态。"
	required_atoms = list(
		list(
			/obj/item/food/breadslice/moldy,
			/obj/item/food/badrecipe/moldy,
			/obj/item/food/deadmouse/moldy,
			/obj/item/food/pizzaslice/moldy,
			/obj/item/food/boiledegg/rotten,
			/obj/item/food/egg/rotten
		) = 1,
		/obj/item/grenade/chem_grenade = 1
	)
	result_atoms = list(/obj/item/grenade/chem_grenade/rust_sower)
	cost = 2
	research_tree_icon_path = 'icons/obj/weapons/grenade.dmi'
	research_tree_icon_state = "rustgrenade"
	drafting_tier = 4

/datum/heretic_knowledge/crimson_cleave
	name = "绯红屠刀"
	desc = "让你能够锻造绯红屠刀，一把渴求鲜血的恐怖武器。<br>\
		它的攻击会根据造成的伤害治疗你，且能一次劈中多个敌人。\
		它也是一件颇为有效的投掷武器，投出后会返回持有者手中。"
	gain_text = "起初我并不懂这些战争器具，但祭司 \
		让我尽管使用。他说，很快我就会熟悉它们。"
	transmute_text = "转化一把屠刀和一些血液——\
		可以是血泊或血滴、染血的抹布或绷带、装有血液的烧杯或小瓶，甚至是屠刀自身沾染的血液。"
	required_atoms = list(
		/obj/item/knife/butcher = 1,
	)
	result_atoms = list(/obj/item/knife/butcher/heretic)
	banned_atom_types = list(/obj/item/knife/butcher/heretic)
	cost = 2
	drafting_tier = 4
	research_tree_icon_path = /obj/item/knife/butcher/heretic::icon
	research_tree_icon_state = /obj/item/knife/butcher/heretic::icon_state

/datum/heretic_knowledge/crimson_cleave/prepare_atom_for_ritual_test(atom/what)
	. = ..()
	what.add_blood_DNA(list("Test DNA" = get_blood_type(/datum/blood_type/human/o_minus)))

/datum/heretic_knowledge/crimson_cleave/get_extra_requirements()
	return "一些血液——可以是血泊或血滴、染血的抹布或绷带、装有血液的烧杯或小瓶，甚至是屠刀自身沾染的血液"

/datum/heretic_knowledge/crimson_cleave/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	for(var/obj/item/knife/butcher/cleaver in atoms)
		selected_atoms += cleaver
		if(GET_ATOM_BLOOD_DNA_LENGTH(cleaver))
			return TRUE // two for one deal
		break

	for(var/obj/effect/decal/cleanable/blood/blood in atoms)
		selected_atoms += blood // blood is blood
		return TRUE

	for(var/obj/item/rag/rag in atoms)
		if(GET_ATOM_BLOOD_DNA_LENGTH(rag))
			selected_atoms += rag
			return TRUE

	for(var/obj/item/stack/medical/wrap/gauze/medwrap in atoms)
		if(GET_ATOM_BLOOD_DNA_LENGTH(medwrap))
			selected_atoms += medwrap
			return TRUE

	for(var/obj/item/reagent_containers/container in atoms)
		for(var/datum/reagent/reagent_content as anything in container.reagents.reagent_list)
			if(LAZYACCESS(reagent_content.data, BLOOD_DATA_DNA))
				selected_atoms += container
				return TRUE

	loc.balloon_alert(user, "仪式失败，缺少血液！")
	to_chat(user, span_mansus("你缺少完成仪式“[name]”所需的血液。"))
	return FALSE

/datum/heretic_knowledge/crimson_cleave/cleanup_atoms(list/selected_atoms)
	for(var/obj/item/reagent_containers/container in selected_atoms)
		for(var/datum/reagent/reagent_content as anything in container.reagents.reagent_list)
			if(LAZYACCESS(reagent_content.data, BLOOD_DATA_DNA))
				container.reagents.del_reagent(reagent_content.type)
		selected_atoms -= container

	for(var/obj/item/stack/medical/wrap/gauze/medwrap in selected_atoms)
		medwrap.use(1)
		selected_atoms -= medwrap

	return ..()

/datum/heretic_knowledge/rifle
	name = "猎狮者步枪"
	desc = "释放猎狮者步枪。<br>\
		猎狮者步枪是一种可发射三发子弹的远距离实弹武器。 \
		从近距离或对无生命物体射击时，这些子弹表现为普通但威力偏弱的大口径弹药。 \
		你可以瞄准远处的敌人， \
		让子弹用你的抓握标记目标，并将你直接传送到对方身边。"
	transmute_text = "转化一块木头、任意动物的兽皮和一台相机。"
	gain_text = "我在一家古董店里遇到一位老人，他拿着一件非常奇特的武器。 \
		当时我没能买下它，但他向我演示了多年前他们是如何制造它的。"
	required_atoms = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/stack/sheet/animalhide = 1,
		/obj/item/camera = 1,
	)
	result_atoms = list(/obj/item/gun/ballistic/rifle/lionhunter)
	cost = 2
	research_tree_icon_path = 'icons/obj/weapons/guns/ballistic.dmi'
	research_tree_icon_state = "goldrevolver"
	drafting_tier = 2

/datum/heretic_knowledge/rifle_ammo
	name = "猎狮者步枪弹药"
	desc = "为猎狮者步枪制造一个额外的弹药夹。"
	transmute_text = "转化 3 枚任意口径的实弹弹壳（用过的或未用的均可），包括霰弹枪弹壳。"
	gain_text = "那把武器附带了三颗粗糙的铁球，原本打算用作弹药。 \
		以普通铁器而言它们非常有效，但消耗得很快，我很快就用完了。 \
		没有任何替代弹药能生效。它想要什么，实在古怪。"
	required_atoms = list(
		/obj/item/ammo_casing = 3,
	)
	result_atoms = list(/obj/item/ammo_box/speedloader/strilka310/lionhunter)
	cost = 0
	research_tree_icon_path = 'icons/obj/weapons/guns/ammo.dmi'
	research_tree_icon_state = "310_strip"

	/// A list of calibers that the ritual will deny. Only ballistic calibers are allowed.
	var/static/list/caliber_blacklist = list(
		CALIBER_LASER,
		CALIBER_ENERGY,
		CALIBER_FOAM,
		CALIBER_ARROW,
		CALIBER_HARPOON,
		CALIBER_HOOK,
	)

/datum/heretic_knowledge/rifle_ammo/pre_research(mob/user, datum/antagonist/heretic/our_heretic)
	if(!our_heretic.get_knowledge(/datum/heretic_knowledge/rifle))
		tgui_alert(user, "你必须先研究猎狮者步枪的知识，才能研究它的弹药。")
		return FALSE

	return TRUE

/datum/heretic_knowledge/rifle_ammo/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	for(var/obj/item/ammo_casing/casing in atoms)
		if(!(casing.caliber in caliber_blacklist))
			continue

		// Remove any casings in the caliber_blacklist list from atoms
		atoms -= casing
	// We removed any invalid casings from the atoms list,
	// return to allow the ritual to fill out selected atoms with the new list
	return TRUE
