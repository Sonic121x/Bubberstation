/datum/religion_rites
	/// name of the religious rite
	var/name = "宗教仪式"
	/// Description of the religious rite
	var/desc = "我我我要念咒了"
	/// length it takes to complete the ritual
	var/ritual_length = (10 SECONDS) //total length it'll take
	/// list of invocations said (strings) throughout the rite
	var/list/ritual_invocations //strings that are by default said evenly throughout the rite
	/// message when you invoke
	var/invoke_msg
	var/favor_cost = 0

	///Rite flags we use mostly to know when it should be deleted.
	// RITE_AUTO_DELETE | RITE_ALLOW_MULTIPLE_PERFORMS | RITE_ONE_TIME_USE
	var/rite_flags = RITE_AUTO_DELETE

/datum/religion_rites/New()
	. = ..()
	if(!GLOB?.religious_sect)
		return
	LAZYADD(GLOB.religious_sect.active_rites, src)

/datum/religion_rites/Destroy()
	if(GLOB?.religious_sect)
		LAZYREMOVE(GLOB.religious_sect.active_rites, src)
	return ..()

/datum/religion_rites/proc/can_afford(mob/living/user)
	if(GLOB.religious_sect?.favor < favor_cost)
		to_chat(user, span_warning("此仪式需要更多恩宠！"))
		return FALSE
	return TRUE

///Called to perform the invocation of the rite, with args being the performer and the altar where it's being performed. Maybe you want it to check for something else?
/datum/religion_rites/proc/perform_rite(mob/living/user, atom/religious_tool)
	if(!can_afford(user))
		return FALSE
	to_chat(user, span_notice("你开始举行 [name] 仪式……"))
	if(!ritual_invocations)
		if(do_after(user, ritual_length))
			return TRUE
		return FALSE
	var/first_invoke = TRUE
	for(var/i in ritual_invocations)
		if(first_invoke) //instant invoke
			user.say(i)
			first_invoke = FALSE
			continue
		if(!length(ritual_invocations)) //we divide so we gotta protect
			return FALSE
		if(!do_after(user, ritual_length/length(ritual_invocations)))
			return FALSE
		user.say(i)
	if(!do_after(user, ritual_length/length(ritual_invocations))) //because we start at 0 and not the first fraction in invocations, we still have another fraction of ritual_length to complete
		return FALSE
	if(invoke_msg)
		user.say(invoke_msg)
	return TRUE


///Does the thing if the rite was successfully performed. return value denotes that the effect successfully (IE a harm rite does harm)
/datum/religion_rites/proc/invoke_effect(mob/living/user, atom/religious_tool)
	SHOULD_CALL_PARENT(TRUE)
	GLOB.religious_sect.on_riteuse(user, religious_tool)
	return TRUE

///Called if invoke effect returns TRUE, for effects meant to occur only if the rite passes.
/datum/religion_rites/proc/post_invoke_effects(mob/living/user, atom/religious_tool)
	SHOULD_CALL_PARENT(TRUE)
	if(!(rite_flags & RITE_ONE_TIME_USE))
		return
	GLOB.religious_sect.rites_list.Remove(src.type)

/datum/religion_rites/proc/refund(percent = 1.0)
	GLOB.religious_sect.adjust_favor(favor_cost * percent)

/**** Mechanical God ****/

/datum/religion_rites/synthconversion
	name = "合成转化"
	desc = "将某个人形个体转化为（更高级的）仿生人。将人类绑上以转化对方，否则此仪式会转化你自己。"
	ritual_length = 30 SECONDS
	ritual_invocations = list("借我神的内在机关……",
						"……我们在逆境中向你呼唤……",
						"……请你补全我们，除去那些不想要的部分……")
	invoke_msg = "……起身吧，我们的冠军！成为你灵魂渴望之物，以真正的形态活在世间！！"
	favor_cost = 1000

/datum/religion_rites/synthconversion/perform_rite(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		to_chat(user, span_warning("此仪式需要一件可将人绑缚其上的宗教器具。"))
		return FALSE
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool)
		return FALSE
	if(LAZYLEN(movable_reltool.buckled_mobs))
		to_chat(user, span_warning("你将要转化绑在 [movable_reltool] 上的那个人。"))
	else
		if(!movable_reltool.can_buckle) //yes, if you have somehow managed to have someone buckled to something that now cannot buckle, we will still let you perform the rite!
			to_chat(user, span_warning("此仪式需要一件可将人绑缚其上的宗教器具。"))
			return FALSE
		if(isandroid(user))
			to_chat(user, span_warning("你已经转化了自己。若要转化他人，必须将其绑在 [movable_reltool] 上。"))
			return FALSE
		to_chat(user, span_warning("你将要通过此仪式转化自己。"))
	return ..()

/datum/religion_rites/synthconversion/invoke_effect(mob/living/user, atom/religious_tool)
	..()
	if(!ismovable(religious_tool))
		CRASH("[name]'s perform_rite had a movable atom that has somehow turned into a non-movable!")
	var/atom/movable/movable_reltool = religious_tool
	var/mob/living/carbon/human/rite_target
	if(!movable_reltool?.buckled_mobs?.len)
		rite_target = user
	else
		for(var/buckled in movable_reltool.buckled_mobs)
			if(ishuman(buckled))
				rite_target = buckled
				break
	if(!rite_target)
		return FALSE
	rite_target.set_species(/datum/species/android)
	rite_target.visible_message(span_notice("[rite_target] 已被 [name] 仪式转化！"))
	return TRUE


/datum/religion_rites/machine_blessing
	name = "接受祝福"
	desc = "接受机械之神的祝福，以推进你的升华。"
	ritual_length = 5 SECONDS
	ritual_invocations = list(
		"让你的意志驱动我们的熔炉。",
		"……在我们伟大的征服中帮助我们！",
	)
	invoke_msg = "血肉的终末已近！"
	favor_cost = 2000

/datum/religion_rites/machine_blessing/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	var/blessing = pick_weight_recursive(
		list(
			// Arms
			list(
				/obj/item/organ/cyberimp/arm/toolkit/combat = 1,
				/obj/item/organ/cyberimp/arm/toolkit/surgery = 1000000,
				/obj/item/organ/cyberimp/arm/toolkit/toolset = 1500000,
			) = 15,
			// Eyes
			list(
				/obj/item/organ/cyberimp/eyes/hud/diagnostic = 1,
				/obj/item/organ/cyberimp/eyes/hud/medical = 1,
				/obj/item/organ/eyes/robotic/glow = 1,
				/obj/item/organ/eyes/robotic/shield = 2,
			) = 15,
			// Chest
			list(
				/obj/item/organ/cyberimp/chest/reviver = 1,
				/obj/item/organ/cyberimp/chest/thrusters = 2,
			) = 9,
			// Brain / Head
			list(
				/obj/item/organ/cyberimp/brain/anti_drop = 50,
				/obj/item/organ/cyberimp/brain/connector = 50,
				/obj/item/organ/cyberimp/brain/anti_stun = 10,
			) = 10,
			// Misc
			list(
				/obj/item/organ/cyberimp/mouth/breathing_tube = 1,
			) = 5,
		)
	)
	new blessing(altar_turf)
	return TRUE

/*********Greedy God**********/

///all greed rites cost money instead
/datum/religion_rites/greed
	ritual_length = 5 SECONDS
	invoke_msg = "抱歉我迟到了，刚才在忙着赚一大笔钱。"
	var/money_cost = 0

/datum/religion_rites/greed/can_afford(mob/living/user)
	var/datum/bank_account/account = user.get_bank_account()
	if(!account)
		to_chat(user, span_warning("你必须有支付仪式费用的方式！"))
		return FALSE
	if(account.account_balance < money_cost)
		to_chat(user, span_warning("此仪式需要更多钱！"))
		return FALSE
	return TRUE

/datum/religion_rites/greed/invoke_effect(mob/living/user, atom/movable/religious_tool)
	var/datum/bank_account/account = user.get_bank_account()
	if(!account || account.account_balance < money_cost)
		to_chat(user, span_warning("此仪式需要更多钱！"))
		return FALSE
	account.adjust_money(-money_cost, "教会捐赠：仪式")
	. = ..()

/datum/religion_rites/greed/vendatray
	name = "购买售卖托盘"
	desc = "召唤一个售卖托盘。你可以用它出售物品！"
	invoke_msg = "我需要一个售卖托盘来赚更多钱！"
	money_cost = 300

/datum/religion_rites/greed/vendatray/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	new /obj/structure/displaycase/forsale(altar_turf)
	playsound(get_turf(religious_tool), 'sound/effects/cashregister.ogg', 60, TRUE)
	return TRUE

/datum/religion_rites/greed/custom_vending
	name = "购买私人自动售货机"
	desc = "召唤一台自定义自动售货机。你可以用它出售大量物品！"
	invoke_msg = "如果我有一台自定义自动售货机来卖我的产品，我就能发财！"
	money_cost = 1000 //quite a step up from vendatray

/datum/religion_rites/greed/custom_vending/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	new /obj/machinery/vending/custom/greed(altar_turf)
	playsound(get_turf(religious_tool), 'sound/effects/cashregister.ogg', 60, TRUE)
	return TRUE

/*********Maintenance God**********/

/datum/religion_rites/maint_adaptation
	name = "维护区适应"
	desc = "开始蜕变为更适合维护区的存在。"
	ritual_length = 10 SECONDS
	ritual_invocations = list("我舍弃这个世界……",
	"……与深处融为一体……",
	"……我的形态将变得扭曲……")
	invoke_msg = "……但我会保留我的微笑！"
	favor_cost = 150 //150u of organic slurry

/datum/religion_rites/maint_adaptation/perform_rite(mob/living/carbon/human/user, atom/religious_tool)
	if(!ishuman(user))
		return FALSE
	//uses HAS_TRAIT_FROM because junkies are also hopelessly addicted
	if(HAS_TRAIT_FROM(user, TRAIT_HOPELESSLY_ADDICTED, "maint_adaptation"))
		to_chat(user, span_warning("你已经适应过了。"))
		return FALSE
	return ..()

/datum/religion_rites/maint_adaptation/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	to_chat(user, span_warning("你感到基因被搅动、重塑。<b>你正在变成某种新东西。</b>"))
	user.emote("laugh")
	ADD_TRAIT(user, TRAIT_HOPELESSLY_ADDICTED, "maint_adaptation")
	//addiction sends some nasty mood effects but we want the maint adaption to be enjoyed like a fine wine
	user.add_mood_event("maint_adaptation", /datum/mood_event/maintenance_adaptation)
	if(iscarbon(user))
		var/mob/living/carbon/vomitorium = user
		vomitorium.vomit(VOMIT_CATEGORY_DEFAULT)
		var/datum/dna/dna = vomitorium.has_dna()
		dna?.add_mutation(/datum/mutation/stimmed, MUTATION_SOURCE_MAINT_ADAPT) //some fluff mutations
		dna?.add_mutation(/datum/mutation/strong, MUTATION_SOURCE_MAINT_ADAPT)
	user.mind.add_addiction_points(/datum/addiction/maintenance_drugs, 1000)//ensure addiction

/datum/religion_rites/adapted_eyes
	name = "适应之眼"
	desc = "仅在维护区适应后可用。你的双眼也会适应，在光线下变得无用。"
	ritual_length = 10 SECONDS
	invoke_msg = "我不再想看见光了。"
	favor_cost = 300 //300u of organic slurry, i'd consider this a reward of the sect

/datum/religion_rites/adapted_eyes/perform_rite(mob/living/carbon/human/user, atom/religious_tool)
	if(!ishuman(user))
		return FALSE
	if(!HAS_TRAIT_FROM(user, TRAIT_HOPELESSLY_ADDICTED, "maint_adaptation"))
		to_chat(user, span_warning("你需要先适应维护区。"))
		return FALSE
	var/obj/item/organ/eyes/night_vision/maintenance_adapted/adapted = user.get_organ_slot(ORGAN_SLOT_EYES)
	if(adapted && istype(adapted))
		to_chat(user, span_warning("你的眼睛已经适应了！"))
		return FALSE
	return ..()

/datum/religion_rites/adapted_eyes/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	..()
	var/obj/item/organ/eyes/oldeyes = user.get_organ_slot(ORGAN_SLOT_EYES)
	to_chat(user, span_warning("你感到双眼适应了黑暗！"))
	if(oldeyes)
		oldeyes.Remove(user, special = TRUE)
		qdel(oldeyes)//eh
	var/obj/item/organ/eyes/night_vision/maintenance_adapted/neweyes = new
	neweyes.Insert(user, special = TRUE)

/datum/religion_rites/adapted_food
	name = "霉化"
	desc = "适应维护区后，你将无法食用普通食物。这应该能帮上忙。"
	ritual_length = 5 SECONDS
	invoke_msg = "霉化！"
	favor_cost = 5 //5u of organic slurry
	///the food that will be molded, only one per rite
	var/obj/item/food/mold_target

/datum/religion_rites/adapted_food/perform_rite(mob/living/user, atom/religious_tool)
	for(var/obj/item/food/could_mold in get_turf(religious_tool))
		if(istype(could_mold, /obj/item/food/badrecipe/moldy))
			continue
		mold_target = could_mold //moldify this o great one
		return ..()
	to_chat(user, span_warning("你需要把食物放在 [religious_tool] 上才能这么做！"))
	return FALSE

/datum/religion_rites/adapted_food/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/obj/item/food/moldify = mold_target
	mold_target = null
	if(QDELETED(moldify) || !(get_turf(religious_tool) == moldify.loc)) //check if the same food is still there
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	to_chat(user, span_warning("[moldify] 变得腐臭了！"))
	user.emote("laugh")
	new /obj/item/food/badrecipe/moldy(get_turf(religious_tool))
	qdel(moldify)
	return TRUE

/datum/religion_rites/ritual_totem
	name = "制作仪式图腾"
	desc = "制作一个仪式图腾，一种可随身携带的仪式工具。需要木材。只有神圣者才能拾起。"
	favor_cost = 100
	invoke_msg = "帕达拉！！"
	///the food that will be molded, only one per rite
	var/obj/item/stack/sheet/mineral/wood/converted

/datum/religion_rites/ritual_totem/perform_rite(mob/living/user, atom/religious_tool)
	for(var/obj/item/stack/sheet/mineral/wood/could_totem in get_turf(religious_tool))
		converted = could_totem //totemify this o great one
		return ..()
	to_chat(user, span_warning("你需要一块木头才能这么做！"))
	return FALSE

/datum/religion_rites/ritual_totem/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	var/obj/item/stack/sheet/mineral/wood/padala = converted
	converted = null
	if(QDELETED(padala) || !(get_turf(religious_tool) == padala.loc)) //check if the same food is still there
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	to_chat(user, span_warning("[padala] 重塑成了一根图腾！"))
	if(!padala.use(1))//use one wood
		return
	user.emote("laugh")
	new /obj/item/ritual_totem(altar_turf)
	return TRUE

///sparring god rites

/datum/religion_rites/sparring_contract
	name = "召唤切磋契约"
	desc = "将一些纸张变成一份切磋契约。"
	invoke_msg = "我将以我神之名训练。"
	///paper to turn into a sparring contract
	var/obj/item/paper/contract_target

/datum/religion_rites/sparring_contract/perform_rite(mob/living/user, atom/religious_tool)
	for(var/obj/item/paper/could_contract in get_turf(religious_tool))
		if(could_contract.get_total_length()) //blank paper pls
			continue
		contract_target = could_contract
		return ..()
	to_chat(user, span_warning("你需要把空白纸张放在 [religious_tool] 上才能这么做！"))
	return FALSE

/datum/religion_rites/sparring_contract/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/obj/item/paper/blank_paper = contract_target
	var/turf/tool_turf = get_turf(religious_tool)
	contract_target = null
	if(QDELETED(blank_paper) || !(tool_turf == blank_paper.loc)) //check if the same paper is still there
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	blank_paper.visible_message(span_notice("文字神奇地在 [blank_paper] 上浮现！"))
	playsound(tool_turf, 'sound/effects/pray.ogg', 50, TRUE)
	var/datum/religion_sect/spar/sect = GLOB.religious_sect
	if(sect.existing_contract)
		sect.existing_contract.visible_message(span_warning("[src] 嘶的一声化为乌有！"))
		qdel(sect.existing_contract)
	sect.existing_contract = new /obj/item/sparring_contract(tool_turf)
	qdel(blank_paper)
	return TRUE

/datum/religion_rites/declare_arena
	name = "宣告竞技场"
	desc = "宣告一片新区域适合切磋。你可以在契约中选择它。"
	ritual_length = 6 SECONDS
	ritual_invocations = list("我寻求新的地平线……")
	invoke_msg = "……愿我的攀登陡峭艰难。"
	favor_cost = 1 //only costs one holy battle for a new area
	var/area/area_instance

/datum/religion_rites/declare_arena/perform_rite(mob/living/user, atom/religious_tool)
	var/list/filtered = list()
	for(var/area/unfiltered_area as anything in get_sorted_areas())
		if(istype(unfiltered_area, /area/centcom)) //youuu dont need thaaat
			continue
		if(!(unfiltered_area.area_flags & HIDDEN_AREA))
			filtered += unfiltered_area
	area_instance = tgui_input_list(user, "选择一片区域标记为竞技场！", "竞技场宣告", filtered)
	if(isnull(area_instance))
		return FALSE
	. = ..()

/datum/religion_rites/declare_arena/invoke_effect(mob/living/user, atom/movable/religious_tool)
	. = ..()
	var/datum/religion_sect/spar/sect = GLOB.religious_sect
	sect.arenas[area_instance.name] = area_instance.type
	to_chat(user, span_warning("[area_instance] 现在已成为切磋契约中的可选项。"))

/datum/religion_rites/ceremonial_weapon
	name = "锻造仪式装备"
	desc = "将一些材料变成仪式装备。仪式刀刃在切磋之外很弱，而且携带起来相当沉重。"
	ritual_length = 10 SECONDS
	invoke_msg = "以你之名的武器！以你之血的战斗！"
	favor_cost = 0
	///the material that will be attempted to be forged into a weapon
	var/obj/item/stack/sheet/converted

/datum/religion_rites/ceremonial_weapon/perform_rite(mob/living/user, atom/religious_tool)
	var/not_rigid = null
	var/datum/material_requirement/requirement = SSmaterials.requirements[/datum/material_requirement/rigid_material]
	for(var/obj/item/stack/sheet/could_blade in get_turf(religious_tool))
		var/datum/material/blade_mat = SSmaterials.get_material(could_blade.material_type)
		if(!blade_mat)
			continue
		if(!requirement.valid_material(blade_mat))
			not_rigid = blade_mat
			continue
		if(could_blade.amount < 5)
			continue
		converted = could_blade
		return ..()
	// We've found a material but it wasn't solid enough.
	if(not_rigid)
		to_chat(user, span_warning("[not_rigid] 不适合用来制作装备！"))
	else
		to_chat(user, span_warning("你至少需要五张刚性材料才能制作装备！"))
	return FALSE

/datum/religion_rites/ceremonial_weapon/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	var/obj/item/stack/sheet/used_for_blade = converted
	converted = null
	if(QDELETED(used_for_blade) || !(get_turf(religious_tool) == used_for_blade.loc) || used_for_blade.amount < 5) //check if the same food is still there
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	var/material_used = used_for_blade.material_type
	to_chat(user, span_warning("[used_for_blade] 重塑成了一把仪式刀刃！"))
	if(!used_for_blade.use(5))//use 5 of the material
		return
	var/obj/item/ceremonial_blade/blade = new(altar_turf)
	blade.set_custom_materials(list(SSmaterials.get_material(material_used) = SHEET_MATERIAL_AMOUNT * 5))
	return TRUE

/datum/religion_rites/unbreakable
	name = "变得坚不可摧"
	desc = "你的训练使你坚不可摧。在危急时刻，你会试图继续战斗。"
	ritual_length = 10 SECONDS
	invoke_msg = "我的意志必须坚不可摧。请赐予我这份恩惠！"
	favor_cost = 4 //4 duels won

/datum/religion_rites/unbreakable/perform_rite(mob/living/carbon/human/user, atom/religious_tool)
	if(!ishuman(user))
		return FALSE
	if(HAS_TRAIT_FROM(user, TRAIT_UNBREAKABLE, INNATE_TRAIT))
		to_chat(user, span_warning("你的精神已经坚不可摧了！"))
		return FALSE
	return ..()

/datum/religion_rites/unbreakable/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	..()
	to_chat(user, span_nicegreen("你感到 [GLOB.deity] 坚持战斗的意志涌入体内！"))
	user.AddComponent(/datum/component/unbreakable)

/datum/religion_rites/tenacious
	name = "变得坚韧"
	desc = "你的训练使你坚韧不拔。在危急时刻，你能爬得更快。"
	ritual_length = 10 SECONDS
	invoke_msg = "赐予我你的坚韧！我已经证明了自己！"
	favor_cost = 3 //3 duels won

/datum/religion_rites/tenacious/perform_rite(mob/living/carbon/human/user, atom/religious_tool)
	if(!ishuman(user))
		return FALSE
	if(HAS_TRAIT_FROM(user, TRAIT_TENACIOUS, INNATE_TRAIT))
		to_chat(user, span_warning("你的精神已经坚韧不拔了！"))
		return FALSE
	return ..()

/datum/religion_rites/tenacious/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	..()
	to_chat(user, span_nicegreen("你感到 [GLOB.deity] 的坚韧涌入体内！"))
	user.AddElement(/datum/element/tenacious)
