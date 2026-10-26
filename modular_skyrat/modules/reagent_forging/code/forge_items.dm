//incomplete pre-complete items
/obj/item/forging/incomplete
	name = "未完成的锻件"
	desc = "你不应该看到这个！"
	abstract_type = /obj/item/forging/incomplete

	///the quality points required for it to be considered usable for crafting
	var/completion_quality_points = 40
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///the bad hits required for it to break; exceeding this will break the item
	var/bad_hit_maximum = 5
	///maximum number of perfect hits before perfect hits no longer improve the quality
	var/max_perfect_hits = 20

	///the path of the item that will be spawned upon completion
	var/spawn_item
	///does this item break if it's not finished hammering when it's quenched?
	//this is mostly for working on stuff that has no effect based on completion amount, preventing cheesing
	var/break_on_early_quench = FALSE
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/forging/incomplete/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/forge_smithable, completion_quality_points, TRUE, max_perfect_hits, bad_hit_maximum, average_wait, CALLBACK(src, TYPE_PROC_REF(/obj/item/forging/incomplete, quench_item)), color = "")// TYPE_PROC_REF(/obj/item/forging/incomplete/, quench_item))

/obj/item/forging/incomplete/proc/quench_item(datum/reagents/dunk_reagents, dunk_object, mob/living/quencher)
	SIGNAL_HANDLER

	var/datum/component/forge_smithable/forge_component = GetComponent(/datum/component/forge_smithable)
	if(forge_component.is_finished_smithing())
		to_chat(quencher, span_notice("你冷却了 [src]。"))
		quencher.mind?.adjust_experience(/datum/skill/smithing, 5)
	else
		if(break_on_early_quench)
			to_chat(quencher, span_warning("[src] 因热冲击而碎裂！这类物品必须先锤打成形才能完成加工。"))
			qdel(src)
			return
		else
			to_chat(quencher, span_warning("你冷却了 [src]，但不确定它是否已准备妥当……"))

	var/obj/spawned_obj = new spawn_item(get_turf(dunk_object))
	if(custom_materials)
		spawned_obj.set_custom_materials(custom_materials, 1) //lets set its material

	if(istype(spawned_obj, /obj/item/forging/complete))
		var/obj/item/forging/complete/complete_spawned = spawned_obj
		complete_spawned.perfect_ratio = forge_component.get_perfect_ratio()
		complete_spawned.hammer_completion_amount = forge_component.get_completion_ratio()

	var/datum/component/reagent_imbued/new_reagent_component = spawned_obj.GetComponent(/datum/component/reagent_imbued)
	if(!isnull(new_reagent_component) && USER_CAN_REAGENT_IMBUE(quencher))
		new_reagent_component.set_reagent_imbue(dunk_reagents, FALSE, TRUE)
		to_chat(quencher, span_notice("[spawned_obj] 已注入试剂。"))

	qdel(src)
	return spawned_obj

/obj/item/forging/incomplete/tong_act(mob/living/user, obj/item/tool)
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "钳子已经夹着东西了！")
		return
	forceMove(tool)

/obj/item/forging/incomplete/pickup(mob/living/user)
	var/hand_protected = FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user) || HAS_TRAIT(human_user, TRAIT_RESISTHEAT) || HAS_TRAIT(human_user, TRAIT_RESISTHEATHANDS))
		hand_protected = TRUE
	else if(!istype(human_user.gloves, /obj/item/clothing/gloves))
		hand_protected = FALSE
	else
		var/obj/item/clothing/gloves/gloves = human_user.gloves
		if(gloves.max_heat_protection_temperature)
			hand_protected = (gloves.max_heat_protection_temperature > 360)

	..()
	if(!hand_protected)
		var/hitzone = user.held_index_to_dir(user.active_hand_index) == "r" ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND
		user.apply_damage(5, BURN, hitzone)
		to_chat(user, span_danger("你试图拿起 [src]，却烫伤了手！"))
		user.add_mood_event("burnt_thumb", /datum/mood_event/burnt_thumb)
		user.dropItemToGround(src)

/obj/item/forging/incomplete/can_be_pulled(user, force) // no drag memes
	return FALSE

/obj/item/forging/incomplete/chain
	name = "未完成的链条"
	icon_state = "hot_chain"
	completion_quality_points = 40
	max_perfect_hits = 15
	spawn_item = /obj/item/forging/complete/chain
	break_on_early_quench = TRUE
	desc = "一段链条，用于制作台上的各种配方。"

/obj/item/forging/incomplete/plate
	name = "未完成的金属板"
	icon_state = "hot_plate"
	completion_quality_points = 40
	max_perfect_hits = 15
	spawn_item = /obj/item/forging/complete/plate
	desc = "一块坚固的板材，可用于制作台上的多种配方，尤其是护甲。"

/obj/item/forging/incomplete/sword
	name = "未完成的剑刃"
	icon_state = "hot_blade"
	spawn_item = /obj/item/forging/complete/sword
	desc = "一把长剑，基本需要双手持握才能有效使用，但非常擅长格挡攻击。"

/obj/item/forging/incomplete/katana
	name = "未完成的武士刀刃"
	icon_state = "hot_katanablade"
	spawn_item = /obj/item/forging/complete/katana
	desc = "一片武士刀刃。单手持用不太灵便，但精心锻造可提高其破甲能力。"

/obj/item/forging/incomplete/rapier
	name = "未完成的刺剑刃"
	icon_state = "hot_rapierblade"
	spawn_item = /obj/item/forging/complete/rapier
	desc = "一片刺剑刃。经典的防身武器，只需单手即可使用。"

/obj/item/forging/incomplete/dagger
	name = "未完成的匕首刃"
	icon_state = "hot_daggerblade"
	completion_quality_points = 22
	max_perfect_hits = 10
	spawn_item = /obj/item/forging/complete/dagger
	desc = "一把小巧纤细的匕首，易于隐藏，能对破绽毕露的对手造成致命一击。"

/obj/item/forging/incomplete/staff
	name = "未完成的杖头"
	icon_state = "hot_staffhead"
	spawn_item = /obj/item/forging/complete/staff
	desc = "一根可注入试剂的法杖，不太适合直接战斗。"

/obj/item/forging/incomplete/spear
	name = "未完成的矛头"
	completion_quality_points = 18 ///crazy low completion required (spears are historically an easy weapon to make that are used for widespread arming)
	max_perfect_hits = 8
	icon_state = "hot_spearhead"
	spawn_item = /obj/item/forging/complete/spear
	desc = "一个短矛头。作为平民的武器，它攻击距离较远，制作速度也比其他武器快得多。"

/obj/item/forging/incomplete/axe
	name = "未完成的斧头"
	icon_state = "hot_axehead"
	completion_quality_points = 22
	max_perfect_hits = 14
	spawn_item = /obj/item/forging/complete/axe
	desc = "一个沉重的斧头，有机会绕过盾牌及其他防护造成打击。"

/obj/item/forging/incomplete/hammer
	name = "未完成的锤头"
	icon_state = "hot_hammerhead"
	spawn_item = /obj/item/forging/complete/hammer
	desc = "一个沉重的锤头，可当作锻造锤使用——双手持握时还能砸开门。"

/obj/item/forging/incomplete/pickaxe
	name = "未完成的镐头"
	icon_state = "hot_pickaxehead"
	spawn_item = /obj/item/forging/complete/pickaxe
	desc = "一把用于挖掘的镐。"

/obj/item/forging/incomplete/shovel
	name = "未完成的铲头"
	icon_state = "hot_shovelhead"
	spawn_item = /obj/item/forging/complete/shovel
	desc = "一把用于挖掘的铲子。"

/obj/item/forging/incomplete/arrowhead
	name = "未完成的箭头"
	icon_state = "hot_arrowhead"
	completion_quality_points = 12
	spawn_item = /obj/item/forging/complete/arrowhead
	desc = "一些用于制作箭矢的小箭头。"

/obj/item/forging/incomplete/revolver_cylinder
	name = "未完成的左轮弹巢"
	icon_state = "hot_revolver_cylinder"
	completion_quality_points = 60
	max_perfect_hits = 70
	spawn_item = /obj/item/forging/complete/revolver_cylinder
	desc = "经典单动式左轮手枪的弹巢。"

/obj/item/forging/incomplete/revolver_frame
	name = "未完成的左轮枪架"
	icon_state = "hot_revolver_frame"
	completion_quality_points = 90
	max_perfect_hits = 110
	spawn_item = /obj/item/forging/complete/revolver_frame
	desc = "经典单动式左轮手枪的枪架。"

/obj/item/forging/incomplete/baseball_bat
	name = "未完成的棒球棒"
	icon_state = "hot_baseball_bat"
	spawn_item = /obj/item/forging/complete/baseball_bat
	desc = "一根正在制作的棒球棒。"

/obj/item/forging/incomplete/rail_nail
	name = "未完成的道钉"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_nail"
	completion_quality_points = 10
	spawn_item = /obj/item/forging/complete/rail_nail
	break_on_early_quench = TRUE
	desc = "用于铺设轨道的道钉。"

/obj/item/forging/incomplete/rail_cart
	name = "未完成的矿车"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_cart"
	spawn_item = /obj/vehicle/ridden/rail_cart
	break_on_early_quench = TRUE
	desc = "一辆可乘坐并沿轨道行驶的矿车。"

//"complete" pre-complete items
/obj/item/forging/complete
	abstract_type = /obj/item/forging/complete
	///the path of the item that will be created
	var/spawning_item
	///how many perfect hits did we get, out of the max?
	var/perfect_ratio = 0
	///when this was worked at an anvil, how many hits were actually applied of the max?
	var/hammer_completion_amount = 0
	///the crafting recipe datum that contains additional requirements to finish this item
	var/recipe_requirements = list(/obj/item/stack/sheet/mineral/wood = 1)
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

	///does it cut the user's hand when used as a weapon?
	var/double_edged_damage = 0
	var/has_reagent_component = TRUE

/obj/item/forging/complete/Initialize(mapload)
	. = ..()
	if(has_reagent_component)
		AddComponent(/datum/component/reagent_imbued)

/obj/item/forging/complete/examine(mob/user)
	. = ..()
	if(spawning_item)
		. += span_notice("<br>需要工作台才能完成这件物品！")

/obj/item/forging/complete/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(double_edged_damage <= 0)
		return

	if(!iscarbon(user) || !user.is_holding(src))
		return

	var/mob/living/carbon/jab = user
	if(jab.get_all_covered_flags() & HANDS)
		return

	to_chat(user, span_warning("[src] 割伤了你的手！"))
	jab.apply_damage(double_edged_damage * hammer_completion_amount, BRUTE, user.get_active_hand(), attacking_item = src)

/obj/item/forging/complete/tong_act(mob/living/user, obj/item/tool)
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "钳子已经夹着东西了！")
		return
	forceMove(tool)

/obj/item/forging/complete/chain
	name = "链条"
	desc = "一段链条，最好与其他链条组合使用。"
	icon_state = "chain"

/obj/item/forging/complete/plate
	name = "金属板"
	desc = "一块金属板，最好与其他金属板组合使用。"
	icon_state = "plate"

/obj/item/forging/complete/sword
	name = "剑刃"
	desc = "一片剑刃，加些木材就能组装完成。"
	icon_state = "blade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/sword
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/katana
	name = "武士刀刃"
	desc = "一片武士刀刃，加些木材就能组装完成。"
	icon_state = "katanablade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/katana
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/rapier
	name = "刺剑刃"
	desc = "一片刺剑刃，加些木材就能组装完成。"
	icon_state = "rapierblade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/rapier
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/dagger
	name = "匕首刃"
	desc = "一片匕首刃，加些木材就能组装完成。"
	icon_state = "daggerblade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/dagger
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/staff
	name = "杖头"
	desc = "一个杖头，加些木材就能组装完成。"
	icon_state = "staffhead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/staff
	recipe_requirements = list(/obj/item/stack/sheet/mineral/wood = 2)

/obj/item/forging/complete/spear
	name = "矛头"
	desc = "一个矛头，加些木材就能组装完成。"
	icon_state = "spearhead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/spear
	recipe_requirements = list(/obj/item/stack/sheet/mineral/wood = 2)
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/axe
	name = "斧头"
	desc = "一个斧头，加些木材就能组装完成。"
	icon_state = "axehead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/axe
	force = 5

/obj/item/forging/complete/hammer
	name = "锤头"
	desc = "一个锤头，加些木材就能组装完成。"
	icon_state = "hammerhead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/hammer
	recipe_requirements = list(/obj/item/stack/sheet/mineral/wood = 2)
	force = 5

/obj/item/forging/complete/pickaxe
	name = "镐头"
	desc = "一个镐头，加些木材就能组装完成。"
	icon_state = "pickaxehead"
	spawning_item = /obj/item/pickaxe/reagent_weapon
	force = 5

/obj/item/forging/complete/shovel
	name = "铲头"
	desc = "一个铲头，加些木材就能组装完成。"
	icon_state = "shovelhead"
	spawning_item = /obj/item/shovel/reagent_weapon

/obj/item/forging/complete/arrowhead
	name = "箭头"
	desc = "一个箭头，加些木材就能组装完成。"
	icon_state = "arrowhead"
	spawning_item = /obj/item/arrow_spawner
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/revolver_cylinder
	name = "单动式左轮弹巢"
	icon_state = "revolver_cylinder"

/obj/item/forging/complete/revolver_frame
	name = "单动式左轮枪架"
	icon_state = "revolver_frame"

/obj/item/forging/complete/rail_nail
	name = "道钉"
	desc = "一根可与木材一同用于铺设轨道的钉子。"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "nail"
	spawning_item = /obj/item/stack/rail_track/ten
	force = 3

/obj/item/forging/complete/baseball_bat
	name = "棒球棒"
	desc = "棒球棒的主体。要在握柄上缠好皮革，才能真正打出全垒打……"
	icon_state = "baseball_bat_incomplete"
	recipe_requirements = list(/obj/item/stack/sheet/leather = 3)
	spawning_item = /obj/item/melee/baseball_bat/reagent_forged
	force = 12

/obj/item/forging/coil
	name = "线圈"
	desc = "由铁杆盘绕而成的简单线圈。"
	icon_state = "coil"

/obj/item/forging/incomplete_bow
	name = "未完成的长弓"
	desc = "一把尚未装弦的木弓。"
	icon_state = "nostring_bow"

/obj/item/forging/incomplete_bow/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/weaponcrafting/silkstring))
		new /obj/item/gun/ballistic/bow/longbow(get_turf(src))
		qdel(attacking_item)
		qdel(src)
		return
	return ..()

/obj/item/arrow_spawner
	name = "箭矢"
	desc = "你不应该看到这个。"
	/// the amount of arrows that are spawned from the spawner
	var/spawning_amount = 4

/obj/item/arrow_spawner/Initialize(mapload)
	. = ..()
	var/turf/src_turf = get_turf(src)
	for(var/i in 1 to spawning_amount)
		new /obj/item/ammo_casing/arrow/(src_turf)
	qdel(src)

/obj/item/stock_parts/power_store/cell/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/forging/coil))
		var/obj/item/stock_parts/power_store/cell/crank/new_crank = new(get_turf(src))
		new_crank.maxcharge = maxcharge
		new_crank.charge = charge
		qdel(attacking_item)
		qdel(src)
		return
	return ..()

/obj/item/stack/tong_act(mob/living/user, obj/item/tool)
	if(amount < 1)
		user.balloon_alert(user, "这叠材料的数量不足！")
		return FALSE
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "钳子已经夹着东西了！")
		return FALSE
	if(!material_type && !custom_materials)
		user.balloon_alert(user, "材料无效！")
		return

	var/obj/item/stack/stack_to_move
	if(amount == 1)
		stack_to_move = src
	else
		stack_to_move = split_stack(1)

	if(!isnull(stack_to_move))
		stack_to_move.forceMove(tool)
		user.balloon_alert(user, "已取出一个")
	else
		stack_trace("[src] was grabbed by [tool] and couldn't pull one sheet!")

/obj/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents))
		user.balloon_alert(user, "钳子已经夹着东西了！")
		return FALSE
	if(!isnull(GetComponent(/datum/component/forge_smithable/)) || !isnull(GetComponent(/datum/component/reagent_imbued)))
		forceMove(tool)
		user.balloon_alert(user, "已取走 [src]")

/obj/item/empty_circuit
	name = "空白电路"
	desc = "一块即将完成的电路，只需要些构思和黄金。"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "circuit"
	var/static/recycleable_circuits = typecacheof(list(
		/obj/item/electronics/airalarm,
		/obj/item/electronics/firealarm,
		/obj/item/electronics/apc,
	))//A typecache of circuits consumable for material

/obj/item/empty_circuit/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/gold))
		var/obj/item/stack/attacking_stack = attacking_item

		if(user.mind.get_skill_level(/datum/skill/research) < SKILL_LEVEL_JOURNEYMAN)
			to_chat(user, span_warning("你的科研技能不足，无法制作电路！"))
			return

		var/choice = tgui_input_list(user, "你想制作哪种电路？", "制作电路", recycleable_circuits)
		if(!choice)
			to_chat(user, span_notice("你决定放弃制作电路……"))
			return

		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("你的移动毁掉了电路！"))
			qdel(src)
			return

		if(!attacking_stack.use(1))
			to_chat(user, span_warning("你没能使用黄金，电路因此损坏了！"))
			qdel(src)
			return

		new choice(get_turf(src))
		qdel(src)
		return

	return ..()
