/obj/item/organ/brain
	name = "大脑"
	desc = "一块从人脑袋里找到的多汁肉块。"
	icon_state = "brain"
	visual = TRUE
	throw_speed = 3
	throw_range = 5
	layer = ABOVE_MOB_LAYER
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_BRAIN
	organ_flags = ORGAN_ORGANIC | ORGAN_VITAL | ORGAN_PROMINENT
	attack_verb_continuous = list("攻击", "扇打", "猛击")
	attack_verb_simple = list("攻击", "扇打", "猛击")

	///The brain's organ variables are significantly more different than the other organs, with half the decay rate for balance reasons, and twice the maxHealth
	decay_factor = STANDARD_ORGAN_DECAY * 0.5 //30 minutes of decaying to result in a fully damaged brain, since a fast decay rate would be unfun gameplay-wise

	maxHealth = BRAIN_DAMAGE_DEATH
	low_threshold = 45
	high_threshold = 120

	organ_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LITERATE, TRAIT_CAN_STRIP)

	var/suicided = FALSE
	var/mob/living/brain/brainmob = null
	/// If it's a fake brain with no brainmob assigned. Feedback messages will be faked as if it does have a brainmob. See changelings & dullahans.
	var/decoy_override = FALSE


	var/list/datum/brain_trauma/traumas = list()

	/// List of skillchip items, their location should be this brain.
	var/list/obj/item/skillchip/skillchips
	/// Maximum skillchip complexity we can support before they stop working. Do not reference this var directly and instead call get_max_skillchip_complexity()
	var/max_skillchip_complexity = 3
	/// Maximum skillchip slots available. Do not reference this var directly and instead call get_max_skillchip_slots()
	var/max_skillchip_slots = 5

	/// Size modifier for the sprite
	var/brain_size = 1
	/// Can this brain become smooth after it gets washed
	var/can_smoothen_out = TRUE
	/// We got smooth from being washed
	var/smooth_brain = FALSE
	/// Variance in brain traits added by subtypes
	var/variant_traits_added
	/// Variance in brain traits removed by subtypes
	var/variant_traits_removed
	/// The color of this brain. Fluff, only used when repairing (shade of...).
	var/shade_color = "粉色"

/obj/item/organ/brain/Initialize(mapload)
	. = ..()
	// Brain size logic
	transform = transform.Scale(brain_size)
	organ_traits.Remove(variant_traits_removed)
	organ_traits |= variant_traits_added

/obj/item/organ/brain/on_mob_insert(mob/living/carbon/brain_owner, special = FALSE, movement_flags)
	. = ..()

	name = initial(name)

	// Special check for if you're trapped in a body you can't control because it's owned by a ling.
	if(IS_CHANGELING(brain_owner) && !(movement_flags & NO_ID_TRANSFER))
		if(brainmob && !IS_DEAD_OR_FAKING(brain_owner))
			to_chat(brainmob, span_danger("你感觉不到自己的身体！你现在只是一颗大脑！"))
		forceMove(brain_owner)
		brain_owner.update_body_parts()
		return

	if(brainmob)
		// If it's a ling decoy brain, nothing to transfer, just throw it out
		if(decoy_override)
			if(brainmob?.key)
				stack_trace("Decoy override brain with a key assigned - This should never happen.")

		// Not a ling - assume direct control
		else
			if(brain_owner.key)
				brain_owner.ghostize()

			if(brainmob.mind)
				brainmob.mind.transfer_to(brain_owner)
			else
				brain_owner.PossessByPlayer(brainmob.key)

			brain_owner.set_suicide(HAS_TRAIT(brainmob, TRAIT_SUICIDED))

		QDEL_NULL(brainmob)
	else
		brain_owner.set_suicide(suicided)

	for(var/datum/brain_trauma/trauma as anything in traumas)
		if(trauma.owner)
			if(trauma.owner == brain_owner)
				// if we're being special replaced, the trauma is already applied, so this is expected
				// but if we're not... this is likely a bug, and should be reported
				if(!special)
					stack_trace("A brain trauma ([trauma]) is being re-applied to its owning mob ([brain_owner])!")
				continue

			stack_trace("A brain trauma ([trauma]) is being applied to a new mob ([brain_owner]) when it's owned by someone else ([trauma.owner])!")
			continue

		trauma.owner = brain_owner
		if(!trauma.on_gain())
			qdel(trauma)

	//Update the body's icon so it doesnt appear debrained anymore
	if(!special && !(brain_owner.living_flags & STOP_OVERLAY_UPDATE_BODY_PARTS))
		brain_owner.update_body_parts()

/obj/item/organ/brain/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	// Delete skillchips first as parent proc sets owner to null, and skillchips need to know the brain's owner.
	if(!QDELETED(organ_owner) && length(skillchips))
		if(!special)
			to_chat(organ_owner, span_notice("你感到技能芯片启动了紧急省电模式，随着大脑离开你的身体而停用……"))
			for(var/chip in skillchips)
				var/obj/item/skillchip/skillchip = chip
				// Run the try_ proc with force = TRUE.
				skillchip.try_deactivate_skillchip(silent = special, force = TRUE, brain_owner = organ_owner)

	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		BT.on_lose(TRUE)
		BT.owner = null

	if((!QDELETED(src) || !QDELETED(owner)) && !(movement_flags & NO_ID_TRANSFER))
		transfer_identity(organ_owner)
	if(!special)
		organ_owner.clear_mood_event("brain_damage")
		organ_owner.med_hud_set_status()

/obj/item/organ/brain/update_icon_state()
	icon_state = "[initial(icon_state)][smooth_brain ? "-smooth" : ""]"
	return ..()

/obj/item/organ/brain/proc/transfer_identity(mob/living/L)
	name = "[L.name]的[initial(name)]"
	if(brainmob)
		if(!decoy_override)
			return

		// it's just a dummy, throw it out
		QDEL_NULL(brainmob)

	if(!L.mind)
		return
	brainmob = new(src)
	brainmob.name = L.real_name
	brainmob.real_name = L.real_name
	brainmob.timeofdeath = L.timeofdeath

	if(suicided)
		ADD_TRAIT(brainmob, TRAIT_SUICIDED, REF(src))

	if(L.has_dna())
		var/mob/living/carbon/C = L
		if(!brainmob.stored_dna)
			brainmob.stored_dna = new /datum/dna/stored(brainmob)
		C.dna.copy_dna(brainmob.stored_dna)
		// Hack, fucked dna needs to follow the brain to prevent memes, so we need to copy over the trait sources and shit
		for(var/source in GET_TRAIT_SOURCES(L, TRAIT_BADDNA))
			ADD_TRAIT(brainmob, TRAIT_BADDNA, source)

	if(L.mind && L.mind.current && !decoy_override)
		L.mind.transfer_to(brainmob)
		to_chat(brainmob, span_notice("你感到有些失去方向感。当你只是一颗大脑时，这是正常的。"))

/obj/item/organ/brain/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/borg/apparatus/organ_storage))
		return NONE//Borg organ bags shouldn't be killing brains

	if (check_for_repair(tool, user))
		return ITEM_INTERACT_SUCCESS

	// Cutting out skill chips.
	if(!length(skillchips) || tool.get_sharpness() != SHARP_EDGED)
		return NONE

	to_chat(user,span_notice("你开始从 [src] 中挖出技能芯片。"))
	if(!do_after(user, 15 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	for(var/obj/item/skillchip/skillchip as anything in skillchips)
		if(!istype(skillchip, /obj/item/skillchip))
			stack_trace("Item of type [skillchip.type] qdel'd from [src] skillchip list.")
			qdel(skillchip)
			continue

		remove_skillchip(skillchip)

		if(skillchip.removable)
			skillchip.forceMove(drop_location())
			continue

		qdel(skillchip)

	skillchips = null
	return ITEM_INTERACT_SUCCESS

/obj/item/organ/brain/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)
	user.changeNext_move(CLICK_CD_MELEE)

	if(brainmob) //if we aren't trying to heal the brain, pass the attack onto the brainmob.
		item.attack(brainmob, user) //Oh noooeeeee

	if(item.force != 0 && !(item.item_flags & NOBLUDGEON))
		user.do_attack_animation(src)
		playsound(loc, 'sound/effects/meatslap.ogg', 50)
		set_organ_damage(maxHealth) //fails the brain as the brain was attacked, they're pretty fragile.
		visible_message(span_danger("[user] 用 [item] 砸向 [src]！"))
		to_chat(user, span_danger("你用 [item] 砸向 [src]！"))

/obj/item/organ/brain/proc/check_for_repair(obj/item/item, mob/user)
	if(damage && item.is_drainable() && item.reagents.has_reagent(/datum/reagent/medicine/mannitol) && (organ_flags & ORGAN_ORGANIC)) //attempt to heal the brain
		if(brainmob?.health <= brainmob?.dead_threshold) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] 受损太严重了，我们已经无能为力了！"))
			return TRUE

		user.visible_message(span_notice("[user] 开始慢慢把 [item] 里的东西倒在 [src] 上。"), span_notice("你开始慢慢把 [item] 里的东西倒在 [src] 上。"))
		if(!do_after(user, 3 SECONDS, src))
			to_chat(user, span_warning("你没能把 [item] 里的东西倒在 [src] 上！"))
			return TRUE
		var/and_bright_shade = !shade_color ? "" : "，并泛出更明亮的[shade_color]色调"
		user.visible_message(span_notice("[user] 把 [item] 里的东西倒在 [src] 上，使它恢复原本的形状[and_bright_shade]。"), span_notice("你把 [item] 里的东西倒在 [src] 上，使它恢复原本的形状[and_bright_shade]。"))
		var/amount = item.reagents.get_reagent_amount(/datum/reagent/medicine/mannitol)
		var/healto = max(0, damage - amount * 2)
		item.reagents.remove_all(ROUND_UP(item.reagents.total_volume / amount * (damage - healto) * 0.5)) //only removes however much solution is needed while also taking into account how much of the solution is mannitol
		set_organ_damage(healto) //heals 2 damage per unit of mannitol, and by using "set_organ_damage", we clear the failing variable if that was up
		return TRUE
	return FALSE

/obj/item/organ/brain/examine(mob/user)
	. = ..()
	if(length(skillchips))
		. += span_info("里面嵌着一枚技能芯片。")
	. += brain_damage_examine()
	if (smooth_brain)
		. += span_notice("那些烦人的褶皱全都不见了。现在只需要好好晾干……")
	if(brain_size < 1)
		. += span_notice("它偏小了一点……")
	if(brain_size > 1)
		. += span_notice("它比普通的大一些……")

/// Needed so subtypes can override examine text while still calling parent
/obj/item/organ/brain/proc/brain_damage_examine()
	if(suicided)
		return span_info("它开始微微发灰。他们一定是承受不住这一切的压力。")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("它内部似乎还残留着一点能量，但受损相当严重……你也许可以用一些<b>甘露醇</b>让它恢复。")
		else if(damage >= maxHealth*0.5)
			return span_info("你能感觉到这一颗里还残留着一丝生命火花，不过它有些淤伤。你也许可以用一些<b>甘露醇</b>让它恢复。")
		else
			return span_info("你能感觉到这一颗里还残留着一丝生命火花。")
	else
		return span_info("这一颗已经完全没有任何生命迹象。")

/obj/item/organ/brain/get_status_appendix(scanpower, add_tooltips)
	var/list/trauma_text
	for(var/datum/brain_trauma/trauma as anything in traumas)
		var/trauma_desc = ""
		switch(trauma.resilience)
			if(TRAUMA_RESILIENCE_BASIC)
				trauma_desc = conditional_tooltip("轻度 ", "可通过脑外科手术或 [/datum/reagent/medicine/neurine::name] 等药物治疗。", add_tooltips)
			if(TRAUMA_RESILIENCE_SURGERY)
				trauma_desc = conditional_tooltip("重度 ", "可通过脑外科手术治疗。", add_tooltips)
			if(TRAUMA_RESILIENCE_LOBOTOMY)
				trauma_desc = conditional_tooltip("根深蒂固 ", "可通过高级脑外科手术治疗。", add_tooltips) // BUBBER EDIT CHANGE - Original: Repair via Lobotomy
			if(TRAUMA_RESILIENCE_WOUND)
				trauma_desc = conditional_tooltip("骨折性 ", "可通过治疗头部创伤来治疗。", add_tooltips)
			if(TRAUMA_RESILIENCE_MAGIC)
				// BUBBER EDIT CHANGE BEGIN - Blessed neurectomy
				trauma_desc = conditional_tooltip("灵魂绑定 ", "可通过受祝福的脑外科手术治疗。", add_tooltips)
				// BUBBER EDIT CHANGE END - Blessed neurectomy
			if(TRAUMA_RESILIENCE_ABSOLUTE)
				trauma_desc = conditional_tooltip("永久性 ", "正常情况下无法修复。", add_tooltips)
		trauma_desc += capitalize(trauma.scan_desc)
		LAZYADD(trauma_text, trauma_desc)
	if(LAZYLEN(trauma_text))
		return "精神创伤：[english_list(trauma_text, and_text = "以及")]。"

/obj/item/organ/brain/feel_for_damage(self_aware)
	if(damage < low_threshold)
		return ""
	if(self_aware)
		if(damage < high_threshold)
			return span_warning("你的大脑有点疼。")
		return span_warning("你的大脑疼得厉害。")
	if(damage < high_threshold)
		return span_warning("感觉有点模糊。")
	return span_warning("它一直在隐隐作痛。")

/obj/item/organ/brain/attack(mob/living/carbon/C, mob/user)
	if(!istype(C))
		return ..()

	add_fingerprint(user)

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/target_has_brain = C.get_organ_by_type(/obj/item/organ/brain)

	if(!target_has_brain && C.is_eyes_covered())
		to_chat(user, span_warning("你得先摘掉 [C] 的头部护具！"))
		return

	//since these people will be dead M != usr

	if(!target_has_brain)
		if(!C.get_bodypart(BODY_ZONE_HEAD) || !user.temporarilyRemoveItemFromInventory(src))
			return
		var/msg = "[C] 的头部被 [user] 植入了 [src]。"
		if(C == user)
			msg = "[user] 把 [src] 植入了自己的头部！"

		C.visible_message(span_danger("[msg]"),
						span_userdanger("[msg]"))

		if(C != user)
			to_chat(C, span_notice("[user] 把 [src] 植入了你的头部。"))
			to_chat(user, span_notice("你把 [src] 植入了 [C] 的头部。"))
		else
			to_chat(user, span_notice("你把 [src] 植入了自己的头部。") )

		Insert(C)
	else
		..()

/obj/item/organ/brain/Destroy() //copypasted from MMIs.
	QDEL_NULL(brainmob)
	QDEL_LIST(traumas)

	destroy_all_skillchips()
	owner?.mind?.set_current(null) //You aren't allowed to return to brains that don't exist
	return ..()

/obj/item/organ/brain/on_life(seconds_per_tick)
	. = ..()

	if(HAS_TRAIT(src, TRAIT_BRAIN_DAMAGE_NODEATH))
		return
	if(damage >= maxHealth) //rip
		to_chat(owner, span_userdanger("你大脑中最后一丝生命火花熄灭了……"))
		owner.investigate_log("因脑损伤而死。", INVESTIGATE_DEATHS)
		owner.death()

/obj/item/organ/brain/on_bodypart_insert(obj/item/bodypart/limb)
	. = ..()
	if(ishuman(limb.owner))
		limb.owner.update_hair()
	else
		limb.update_icon_dropped()

/obj/item/organ/brain/on_bodypart_remove(obj/item/bodypart/limb, movement_flags)
	. = ..()
	if(ishuman(limb.owner))
		limb.owner.update_hair()
	else
		limb.update_icon_dropped()
	// once it's out in the world we need to make sure it's the right color
	update_brain_color(animate = FALSE)

/obj/item/organ/brain/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE)
	. = ..()
	var/delta_dam = . //for the sake of clarity
	if(isnull(bodypart_owner)) // no need to color it if it's in someone's noggin
		update_brain_color()
	if(delta_dam < 0 && damage > BRAIN_DAMAGE_MILD)
		roll_for_brain_trauma(-delta_dam) // parent call returns negative numbers if take damage and positive if we heal

/// Rolls a random chance to gain a brain trauma based on damage taken and current damage level
/obj/item/organ/brain/proc/roll_for_brain_trauma(delta_dam)
	if(prob(delta_dam * (1 + max(0, (damage - BRAIN_DAMAGE_MILD)/100)))) //Base chance is the hit damage; for every point of damage past the threshold the chance is increased by 1% //learn how to do your bloody math properly goddamnit
		gain_trauma_type(BRAIN_TRAUMA_MILD, natural_gain = TRUE)

	var/is_boosted = (owner && HAS_TRAIT(src, TRAIT_SPECIAL_TRAUMA_BOOST))
	if(damage < BRAIN_DAMAGE_SEVERE)
		return
	if(prob(delta_dam * (1 + max(0, (damage - BRAIN_DAMAGE_SEVERE)/100)))) //Base chance is the hit damage; for every point of damage past the threshold the chance is increased by 1%
		if(prob(20 + (is_boosted * 30)))
			gain_trauma_type(BRAIN_TRAUMA_SPECIAL, is_boosted ? TRAUMA_RESILIENCE_SURGERY : null, natural_gain = TRUE)
		else
			gain_trauma_type(BRAIN_TRAUMA_SEVERE, natural_gain = TRUE)

#define BRAIN_DAMAGE_FILTER "brain_damage_color_filter"

/// Updates the brain's color based on damage level - the more damaged, the darker and grayer it gets
/obj/item/organ/brain/proc/update_brain_color(animate = TRUE)
	if(damage <= 0)
		if(get_filter(BRAIN_DAMAGE_FILTER))
			if(animate)
				transition_filter(BRAIN_DAMAGE_FILTER, color_matrix_filter("#ffffff"), time = 1 SECONDS)
				addtimer(CALLBACK(src, TYPE_PROC_REF(/datum, remove_filter), "brain_damage_color_filter"), 1.2 SECONDS, TIMER_UNIQUE)
			else
				remove_filter(BRAIN_DAMAGE_FILTER)
		return

	var/gradient = rgb_gradient(round(damage / maxHealth, 0.01), 0, "#ffffff", 1, "#7f7f7f")
	if(animate)
		if(!get_filter(BRAIN_DAMAGE_FILTER))
			add_filter(BRAIN_DAMAGE_FILTER, 1, color_matrix_filter("#ffffff"))
		transition_filter(BRAIN_DAMAGE_FILTER, color_matrix_filter(gradient), time = 1 SECONDS)
	else if(get_filter(BRAIN_DAMAGE_FILTER))
		modify_filter(BRAIN_DAMAGE_FILTER, color_matrix_filter(gradient))
	else
		add_filter(BRAIN_DAMAGE_FILTER, 1, color_matrix_filter(gradient))

#undef BRAIN_DAMAGE_FILTER

/obj/item/organ/brain/check_damage_thresholds()
	. = ..()
	if(!owner)
		return
	// If we crossed blinking brain damage thresholds either way, update our blinking
	if((prev_damage >= BRAIN_DAMAGE_ASYNC_BLINKING && damage < BRAIN_DAMAGE_ASYNC_BLINKING) || (prev_damage < BRAIN_DAMAGE_ASYNC_BLINKING && damage >= BRAIN_DAMAGE_ASYNC_BLINKING))
		var/obj/item/organ/eyes/eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes?.blink_animation)
			eyes.animate_eyelids(owner)
	if(damage >= 60 && prev_damage < 60)
		owner.add_mood_event("brain_damage", /datum/mood_event/brain_damage)
	else if(prev_damage >= 60 && damage < 60)
		owner.clear_mood_event("brain_damage")

	// If we're not more injured than before, return without gambling for a trauma
	if(damage <= prev_damage)
		return

	// Conscious or soft-crit
	var/brain_message
	if(prev_damage < BRAIN_DAMAGE_MILD && damage >= BRAIN_DAMAGE_MILD)
		brain_message = span_warning("你感到头晕目眩。")
	else if(prev_damage < BRAIN_DAMAGE_SEVERE && damage >= BRAIN_DAMAGE_SEVERE)
		brain_message = span_warning("你感到自己的想法越来越不受控制。")
	else if(prev_damage < (maxHealth - 20) && damage >= (maxHealth - 20))
		brain_message = span_warning("你能感到自己的意识忽明忽暗……")

	if(.)
		. += "\n[brain_message]"
	else
		return brain_message

/obj/item/organ/brain/before_organ_replacement(obj/item/organ/replacement)
	. = ..()
	var/obj/item/organ/brain/replacement_brain = replacement
	if(!istype(replacement_brain))
		return

	// Transfer over skillcips to the new brain

	// If we have some sort of brain type or subtype change and have skillchips, engage the failsafe procedure!
	if(owner && length(skillchips) && (replacement_brain.type != type))
		activate_skillchip_failsafe()

	// Check through all our skillchips, remove them from this brain, add them to the replacement brain.
	for(var/chip in skillchips)
		var/obj/item/skillchip/skillchip = chip

		// We're technically doing a little hackery here by bypassing the procs, but I'm the one who wrote them
		// and when you know the rules, you can break the rules.

		// Technically the owning mob is the same. We don't need to activate or deactivate the skillchips.
		// All the skillchips themselves care about is what brain they're in.
		// Because the new brain will ultimately be owned by the same body, we can safely leave skillchip logic alone.

		// Directly change the new holding_brain.
		skillchip.holding_brain = replacement_brain
		//And move the actual obj into the new brain (contents)
		skillchip.forceMove(replacement_brain)

		// Directly add them to the skillchip list in the new brain.
		LAZYADD(replacement_brain.skillchips, skillchip)

	// Any skillchips has been transferred over, time to empty the list.
	LAZYCLEARLIST(skillchips)

	// Transfer over traumas as well
	for(var/datum/brain_trauma/trauma as anything in traumas)
		remove_trauma_from_traumas(trauma)
		replacement_brain.add_trauma_to_traumas(trauma)

/obj/item/organ/brain/machine_wash(obj/machinery/washing_machine/brainwasher)
	. = ..()
	if (can_smoothen_out && !smooth_brain)
		smooth_brain = TRUE
		update_appearance()

	if(HAS_TRAIT(brainwasher, TRAIT_BRAINWASHING))
		set_organ_damage(0)
		cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	else
		set_organ_damage(maxHealth)

/obj/item/organ/brain/alien
	name = "异形大脑"
	desc = "我们连地球动物的大脑都几乎搞不懂。谁知道在如此高级的物种脑中会发现什么？"
	icon_state = "brain-x"
	variant_traits_removed = list(TRAIT_LITERATE, TRAIT_ADVANCEDTOOLUSER)
	shade_color = "绿色"

/obj/item/organ/brain/primitive //No like books and stompy metal men
	name = "原始大脑"
	desc = "这块多汁的肉块明显额叶发育不全。"
	variant_traits_removed = list(TRAIT_LITERATE)
	variant_traits_added = list(
		TRAIT_PRIMITIVE, // No literacy
		TRAIT_FORBID_MINING_SHUTTLE_CONSOLE_OUTSIDE_STATION,
		TRAIT_EXPERT_FISHER, // live off land, fish from river
		TRAIT_ROUGHRIDER, // ride beast, chase down prey, flee from danger
		TRAIT_BEAST_EMPATHY, // know the way of beast, calm with food
		TRAIT_NECROPOLIS_WORSHIP,
		TRAIT_TACKLING_TAILED_DEFENDER,
	)

/obj/item/organ/brain/golem
	name = "晶体矩阵"
	desc = "这簇闪光的宝石不知怎么让魔像得以思考。"
	icon_state = "adamantine_resonator"
	can_smoothen_out = FALSE
	color = COLOR_GOLEM_GRAY
	shade_color = "青色"
	organ_flags = ORGAN_MINERAL
	variant_traits_added = list(TRAIT_ROCK_METAMORPHIC)

/obj/item/organ/brain/lustrous
	name = "流光大脑"
	desc = "这就是吸了蓝空间粉尘后的你的大脑。一次都别试。"
	icon_state = "random_fly_4"
	can_smoothen_out = FALSE
	shade_color = null

// This fixes an edge case from species/regenerate_organs that would transfer the brain trauma before organ/on_mob_remove can remove it
// Prevents wizards from using the magic mirror to gain bluespace_prophet trauma and then switching to another race
/obj/item/organ/brain/lustrous/before_organ_replacement(obj/item/organ/replacement)
	if(owner)
		owner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
		owner.RemoveElement(/datum/element/tenacious)
	. = ..()

/obj/item/organ/brain/lustrous/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	organ_owner.RemoveElement(/datum/element/tenacious)

/obj/item/organ/brain/lustrous/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet, TRAUMA_RESILIENCE_ABSOLUTE)
	organ_owner.AddElement(/datum/element/tenacious)

/obj/item/organ/brain/felinid //A bit smaller than average
	brain_size = 0.8
	variant_traits_added = list(
		TRAIT_CATLIKE_INSTINCT,
		TRAIT_WATER_HATER,
	)

// Sometimes, felinids go a bit haywire and bite people. Based entirely on mania and hunger.
/obj/item/organ/brain/felinid/get_attacking_limb(mob/living/carbon/human/target)
	var/starving_cat_bonus = owner.nutrition <= NUTRITION_LEVEL_HUNGRY ? 1 : 10
	var/crazy_feral_cat = clamp((starving_cat_bonus * owner.mob_mood?.sanity_level), 0, 100)
	if(prob(crazy_feral_cat) || HAS_TRAIT(owner, TRAIT_FERAL_BITER))
		return owner.get_bodypart(BODY_ZONE_HEAD) || ..()
	return ..()

/obj/item/organ/brain/lizard
	name = "蜥蜴大脑"
	desc = "这块多汁的肉块有着过大的脑干和小脑，几乎谈不上有什么边缘系统。你会觉得它的主人相当冷血。"
	variant_traits_added = list(TRAIT_TACKLING_TAILED_DEFENDER)

/obj/item/organ/brain/ghost
	name = "幽灵大脑"
	desc = "你到底是怎么拿住它的？"
	icon_state = "brain-ghost"
	movement_type = PHASING
	organ_flags = parent_type::organ_flags | ORGAN_GHOST
	shade_color = "灵质白"

/obj/item/organ/brain/abductor
	name = "小灰人大脑"
	desc = "一块从小灰人脑袋里找到的多汁肉块。"
	icon_state = "brain-x"
	brain_size = 1.3
	variant_traits_added = list(TRAIT_REMOTE_TASTING, TRAIT_ABDUCTOR_KNOWLEDGE)
	shade_color = "灰色"

/obj/item/organ/brain/abductor/on_mob_insert(mob/living/carbon/brain_owner, special = FALSE, movement_flags)
	. = ..()
	RegisterSignal(brain_owner, COMSIG_MOB_REAGENT_TICK, PROC_REF(handle_peanut_butter))

/obj/item/organ/brain/abductor/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_MOB_REAGENT_TICK)

/obj/item/organ/brain/abductor/proc/handle_peanut_butter(mob/living/carbon/organ_owner, datum/reagent/reagent, seconds_per_tick, metabolization_ratio)
	SIGNAL_HANDLER
	if(!istype(reagent, /datum/reagent/consumable/peanut_butter))
		return
	organ_owner.add_mood_event("ET_pieces", /datum/mood_event/et_pieces, reagent.name)
	organ_owner.set_drugginess_if_lower(15 SECONDS * metabolization_ratio * seconds_per_tick)


////////////////////////////////////TRAUMAS////////////////////////////////////////

/obj/item/organ/brain/proc/has_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_ABSOLUTE)
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		if(istype(BT, brain_trauma_type) && (BT.resilience <= resilience))
			return BT

/obj/item/organ/brain/proc/get_traumas_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_ABSOLUTE)
	. = list()
	for(var/X in traumas)
		var/datum/brain_trauma/BT = X
		if(istype(BT, brain_trauma_type) && (BT.resilience <= resilience))
			. += BT

/obj/item/organ/brain/proc/can_gain_trauma(datum/brain_trauma/trauma, resilience, natural_gain = FALSE)
	if(HAS_TRAIT(src, TRAIT_BRAIN_TRAUMA_IMMUNITY))
		return FALSE

	if(!ispath(trauma))
		trauma = trauma.type
	if(!initial(trauma.can_gain))
		return FALSE
	if(!resilience)
		resilience = initial(trauma.resilience)

	var/resilience_tier_count = 0
	for(var/X in traumas)
		if(istype(X, trauma))
			return FALSE
		var/datum/brain_trauma/T = X
		if(resilience == T.resilience)
			resilience_tier_count++

	var/max_traumas
	switch(resilience)
		if(TRAUMA_RESILIENCE_BASIC)
			max_traumas = TRAUMA_LIMIT_BASIC
		if(TRAUMA_RESILIENCE_SURGERY)
			max_traumas = TRAUMA_LIMIT_SURGERY
		if(TRAUMA_RESILIENCE_WOUND)
			max_traumas = TRAUMA_LIMIT_WOUND
		if(TRAUMA_RESILIENCE_LOBOTOMY)
			max_traumas = TRAUMA_LIMIT_LOBOTOMY
		if(TRAUMA_RESILIENCE_MAGIC)
			max_traumas = TRAUMA_LIMIT_MAGIC
		if(TRAUMA_RESILIENCE_ABSOLUTE)
			max_traumas = TRAUMA_LIMIT_ABSOLUTE

	if(natural_gain && resilience_tier_count >= max_traumas)
		return FALSE
	return TRUE

//Proc to use when directly adding a trauma to the brain, so extra args can be given
/obj/item/organ/brain/proc/gain_trauma(datum/brain_trauma/trauma, resilience, ...)
	var/list/arguments = list()
	if(args.len > 2)
		arguments = args.Copy(3)
	. = brain_gain_trauma(trauma, resilience, arguments)

/obj/item/organ/brain/vv_edit_var(var_name, var_value)
	. = ..()
	if(var_name == NAMEOF(src, smooth_brain))
		update_appearance()

//Direct trauma gaining proc. Necessary to assign a trauma to its brain. Avoid using directly.
/obj/item/organ/brain/proc/brain_gain_trauma(datum/brain_trauma/trauma, resilience, list/arguments)
	if(!can_gain_trauma(trauma, resilience))
		return null

	var/datum/brain_trauma/actual_trauma
	if(ispath(trauma))
		if(!LAZYLEN(arguments))
			actual_trauma = new trauma() //arglist with an empty list runtimes for some reason
		else
			actual_trauma = new trauma(arglist(arguments))
	else
		actual_trauma = trauma

	if(actual_trauma.brain) //we don't accept used traumas here
		WARNING("gain_trauma was given an already active trauma.")
		return null

	add_trauma_to_traumas(actual_trauma)
	if(owner)
		actual_trauma.owner = owner
		if(SEND_SIGNAL(owner, COMSIG_CARBON_GAIN_TRAUMA, trauma, resilience) & COMSIG_CARBON_BLOCK_TRAUMA)
			qdel(actual_trauma)
			return null
		if(!actual_trauma.on_gain())
			qdel(actual_trauma)
			return null
		log_game("[key_name_and_tag(owner)] 获得了以下脑创伤：[trauma.type]")
	if(resilience)
		actual_trauma.resilience = resilience
	SSblackbox.record_feedback("tally", "traumas", 1, actual_trauma.type)
	return actual_trauma

/// Adds the passed trauma instance to our list of traumas and links it to our brain.
/// DOES NOT handle setting up the trauma, that's done by [proc/brain_gain_trauma]!
/obj/item/organ/brain/proc/add_trauma_to_traumas(datum/brain_trauma/trauma)
	trauma.brain = src
	traumas += trauma

/// Removes the passed trauma instance to our list of traumas and links it to our brain
/// DOES NOT handle removing the trauma's effects, that's done by [/datum/brain_trauma/Destroy()]!
/obj/item/organ/brain/proc/remove_trauma_from_traumas(datum/brain_trauma/trauma)
	trauma.brain = null
	traumas -= trauma

//Add a random trauma of a certain subtype
/obj/item/organ/brain/proc/gain_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience, natural_gain = FALSE)
	var/list/datum/brain_trauma/possible_traumas = list()
	for(var/T in subtypesof(brain_trauma_type))
		var/datum/brain_trauma/BT = T
		if(can_gain_trauma(BT, resilience, natural_gain) && initial(BT.random_gain))
			possible_traumas += BT

	if(!LAZYLEN(possible_traumas))
		return

	var/trauma_type = pick(possible_traumas)
	return gain_trauma(trauma_type, resilience)

//Cure a random trauma of a certain resilience level
/obj/item/organ/brain/proc/cure_trauma_type(brain_trauma_type = /datum/brain_trauma, resilience = TRAUMA_RESILIENCE_BASIC)
	var/list/traumas = get_traumas_type(brain_trauma_type, resilience)
	if(LAZYLEN(traumas))
		qdel(pick(traumas))

/obj/item/organ/brain/proc/cure_all_traumas(resilience = TRAUMA_RESILIENCE_BASIC)
	var/amount_cured = 0
	var/list/traumas = get_traumas_type(resilience = resilience)
	for(var/X in traumas)
		qdel(X)
		amount_cured++
	return amount_cured

/// This proc lets the mob's brain decide what bodypart to attack with in an unarmed strike.
/obj/item/organ/brain/proc/get_attacking_limb(mob/living/carbon/human/target)
	var/obj/item/bodypart/arm/active_hand = owner.get_active_hand()
	if(HAS_TRAIT(owner, TRAIT_FERAL_BITER) || (HAS_TRAIT(owner, TRAIT_REFINED_BITER) && prob(50))) //Feral biters will always prefer biting. Refined biters pick a bite 50% of the time.
		var/obj/item/bodypart/head/found_head = owner.get_bodypart(BODY_ZONE_HEAD)
		return found_head || active_hand // If we are a biter, return a usable head.
	if(target.pulledby == owner) // if we're grabbing our target we're beating them to death with our bare hands
		return active_hand
	if(target.body_position == LYING_DOWN && owner.usable_legs)
		var/obj/item/bodypart/found_bodypart = owner.get_bodypart(IS_LEFT_INDEX(active_hand.held_index) ? BODY_ZONE_L_LEG : BODY_ZONE_R_LEG)
		return found_bodypart || active_hand
	return active_hand

/// Brains REALLY like ghosting people. we need special tricks to avoid that, namely removing the old brain with no_id_transfer
/obj/item/organ/brain/replace_into(mob/living/carbon/new_owner)
	var/obj/item/organ/brain/old_brain = new_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	old_brain.Remove(new_owner, special = TRUE, movement_flags = NO_ID_TRANSFER)
	qdel(old_brain)
	return Insert(new_owner, special = TRUE, movement_flags = NO_ID_TRANSFER | DELETE_IF_REPLACED)

/obj/item/organ/brain/pod
	name = "荚人核"
	desc = "荚人的大脑，比人类大脑更接近植物。"
	foodtype_flags = PODPERSON_ORGAN_FOODTYPES
	color = COLOR_LIME
	shade_color = "青柠色"
