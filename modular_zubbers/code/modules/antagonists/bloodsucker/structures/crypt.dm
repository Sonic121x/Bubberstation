/obj/structure/bloodsucker
	///Who owns this structure?
	var/mob/living/owner
	/*
	 *	We use vars to add descriptions to items.
	 *	This way we don't have to make a new /examine for each structure
	 *	And it's easier to edit.
	 */
	var/ghost_desc
	var/vamp_desc
	var/ghoul_desc
	var/hunter_desc

/obj/structure/bloodsucker/examine(mob/user)
	. = ..()
	if(!user.mind && ghost_desc != "")
		. += span_cult(ghost_desc)
	if(IS_BLOODSUCKER(user) && vamp_desc)
		if(!owner)
			. += span_cult("它尚未固定。在避难所内点击[src]将其固定，才能发挥全部作用。")
			return
		. += span_cult(vamp_desc)
	if(IS_GHOUL(user) && ghoul_desc != "")
		. += span_cult(ghoul_desc)
	if(IS_MONSTERHUNTER(user) && hunter_desc != "")
		. += span_cult(hunter_desc)

/// This handles bolting down the structure.
/obj/structure/bloodsucker/proc/bolt(mob/user)
	to_chat(user, span_danger("你将[src]固定在了原地。"))
	to_chat(user, span_announce("* 吸血鬼提示：查看[src]以了解其用途！"))
	owner = user

/// This handles unbolting of the structure.
/obj/structure/bloodsucker/proc/unbolt(mob/user)
	to_chat(user, span_danger("你解除了[src]的固定。"))
	owner = null

/obj/structure/bloodsucker/attackby(obj/item/item, mob/living/user, params)
	/// If a Bloodsucker tries to wrench it in place, yell at them.
	if(item.tool_behaviour == TOOL_WRENCH && !anchored && IS_BLOODSUCKER(user))
		user.playsound_local(null, 'sound/machines/buzz/buzz-sigh.ogg', 40, FALSE, pressure_affected = FALSE)
		to_chat(user, span_announce("* 吸血鬼提示：查看吸血鬼结构以了解其用途！"))
		return
	return ..()

/obj/structure/bloodsucker/attack_hand(mob/user, list/modifiers)
//	. = ..() // Don't call parent, else they will handle unbuckling.
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	/// Claiming the Rack instead of using it?
	if(istype(bloodsuckerdatum) && !owner)
		if(!bloodsuckerdatum.bloodsucker_haven_area)
			to_chat(user, span_danger("你还没有避难所。认领一口棺材，使其所在区域成为避难所。"))
			return FALSE
		if(bloodsuckerdatum.bloodsucker_haven_area != get_area(src))
			to_chat(user, span_danger("你只能在避难所中启用此结构：[chinese_area_display(bloodsuckerdatum.bloodsucker_haven_area.name)]。"))
			return FALSE

		/// Radial menu for securing your Persuasion rack in place.
		to_chat(user, span_notice("要将[src]固定在这里吗？"))
		var/static/list/secure_options = list(
			"是" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"否" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"))
		var/secure_response = show_radial_menu(user, src, secure_options, radius = 36, require_near = TRUE)
		if(!secure_response)
			return FALSE
		switch(secure_response)
			if("是")
				user.playsound_local(null, 'sound/items/tools/ratchet.ogg', 70, FALSE, pressure_affected = FALSE)
				bolt(user)
				return FALSE
		return FALSE
	return TRUE

/obj/structure/bloodsucker/click_alt(mob/user)
	. = ..()
	if(user == owner && user.Adjacent(src))
		balloon_alert(user, "解除[src]的固定？")
		var/static/list/unclaim_options = list(
			"是" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
			"否" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
		)
		var/unclaim_response = show_radial_menu(user, src, unclaim_options, radius = 36, require_near = TRUE)
		switch(unclaim_response)
			if("是")
				unbolt(user)
	return CLICK_ACTION_SUCCESS
/*
/obj/structure/bloodsucker/bloodaltar
	name = "血腥祭坛"
	desc = "由大理石制成，以玄武岩镶边，散发着令人不安的寒意，让你浑身起鸡皮疙瘩。"
/obj/structure/bloodsucker/bloodstatue
	name = "血腥面容"
	desc = "它看起来熟悉得令人不安……"
/obj/structure/bloodsucker/bloodportrait
	name = "油画肖像"
	desc = "一张熟悉得令人不安的面孔正凝视着你。那些红色似乎并非用油彩画成……"
/obj/structure/bloodsucker/bloodbrazier
	name = "燃烧的火盆"
	desc = "它缓缓燃烧，却不散发任何热量。"
/obj/structure/bloodsucker/bloodmirror
	name = "黯淡镜子"
	desc = "你觉得那凝视着你的模糊倒影似乎拥有异样的智慧。"
/obj/item/restraints/legcuffs/beartrap/bloodsucker
*/

/obj/structure/bloodsucker/ghoulrack
	name = "劝化刑架"
	desc = "如果这东西不是用来施刑的，那某人的爱好可真够吓人。"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	icon_state = "ghoulrack"
	anchored = FALSE
	density = TRUE
	can_buckle = TRUE
	buckle_lying = 180
	ghost_desc = "这是血仆刑架，吸血鬼可以用它将船员奴役为忠诚的仆从。"
	vamp_desc = "这是血仆刑架，你可以用它将船员奴役为效忠于你的仆从。\n\
		按住受害者并将其拖到刑架上即可绑住，右键点击刑架可以解绑。\n\
		反复点击劝化刑架可将受害者转化为血仆。所需时间取决于副手中的工具，过程会消耗血液。\n\
		转化后继续拷问，可将血仆提升为特殊血仆。"
	ghoul_desc = "这是血仆刑架，你的主人可以用它将船员奴役为仆从。\n\
		协助主人把受害者带来，并确保他们无法逃脱。\n\
		刑架固定后，将受害者拖到上面即可绑住。"
	hunter_desc = "这是血仆刑架，怪物用它将船员洗脑为忠诚的奴隶。\n\
		他们通常会给受害者戴上手铐，防止逃跑。\n\
		仪式需要时间，我们可以趁机破坏。"
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
	)

	/// Resets on each new character to be added to the chair. Some effects should lower it...
	var/convert_progress = 3
	/// Mindshielded and Antagonists willingly have to accept you as their Master.
	var/disloyalty_confirm = FALSE
	/// Prevents popup spam.
	var/disloyalty_offered = FALSE

/obj/structure/bloodsucker/ghoulrack/examine(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(bloodsuckerdatum)
		. += span_cult("你最多能维系[bloodsuckerdatum.max_ghouls()]名血仆，\
		还剩[bloodsuckerdatum.free_ghoul_slots()]个名额。")

/obj/structure/bloodsucker/ghoulrack/atom_deconstruct(disassembled = TRUE)
	. = ..()
	new /obj/item/stack/sheet/iron(src.loc, 4)
	new /obj/item/stack/rods(loc, 4)
	qdel(src)

/obj/structure/bloodsucker/ghoulrack/bolt()
	. = ..()
	density = FALSE
	anchored = TRUE

/obj/structure/bloodsucker/ghoulrack/unbolt()
	. = ..()
	density = TRUE
	anchored = FALSE

/obj/structure/bloodsucker/ghoulrack/mouse_drop_receive(atom/movable/movable_atom, mob/user, params)
	var/mob/living/living_target = movable_atom
	if(!anchored && IS_BLOODSUCKER(user))
		user.balloon_alert(user, "尚未固定！")
		to_chat(user, span_danger("刑架固定之前无法发挥作用。"))
		to_chat(user, span_announce("* 吸血鬼提示：查看劝化刑架以了解其用途！"))
		return
	// Default checks
	if(!isliving(movable_atom) || !living_target.Adjacent(src) || living_target == user || !isliving(user) || has_buckled_mobs() || user.incapacitated || living_target.buckled)
		return
	// Don't buckle Silicon to it please.
	if(issilicon(living_target))
		to_chat(user, span_danger("你意识到这台机器无法转化为血仆，绑住它毫无意义。"))
		return
	if(do_after(user, 5 SECONDS, living_target))
		attach_victim(living_target, user)

/// Attempt Release (Owner vs Non Owner)
/obj/structure/bloodsucker/ghoulrack/attack_hand_secondary(mob/user, modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!user.can_perform_action(src))
		return
	if(!has_buckled_mobs() || !isliving(user))
		return
	var/mob/living/carbon/buckled_carbons = pick(buckled_mobs)
	if(buckled_carbons)
		if(user == owner)
			unbuckle_mob(buckled_carbons)
		else
			user_unbuckle_mob(buckled_carbons, user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/**
 * Attempts to buckle target into the ghoulrack
 */
/obj/structure/bloodsucker/ghoulrack/proc/attach_victim(mob/living/target, mob/living/user)
	if(!buckle_mob(target))
		return
	user.visible_message(
		span_notice("[user]将[target]绑在刑架上，使其无法动弹。"),
		span_boldnotice("你牢牢绑住了[target]。现在休想逃出你的手掌心。"),
	)

	playsound(loc, 'sound/effects/pop_expl.ogg', 25, 1)
	update_appearance(UPDATE_ICON)
	density = TRUE

	// Set up Torture stuff now
	convert_progress = 3
	disloyalty_confirm = FALSE
	disloyalty_offered = FALSE

/// Attempt Unbuckle
/obj/structure/bloodsucker/ghoulrack/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(IS_BLOODSUCKER(user) || IS_GHOUL(user))
		return ..()

	if(buckled_mob == user)
		buckled_mob.visible_message(
			span_danger("[user]试图挣脱刑架！"),
			span_danger("你试图挣脱刑架！"),
			span_hear("你听到湿黏的挤压声。"))
		if(!do_after(user, 20 SECONDS, buckled_mob))
			return
	else
		buckled_mob.visible_message(
			span_danger("[user]试图把[buckled_mob]从刑架上拉下来！"),
			span_danger("[user]试图把[buckled_mob]从刑架上拉下来！"),
			span_hear("你听到湿黏的挤压声。"))
		if(!do_after(user, 10 SECONDS, buckled_mob))
			return

	return ..()

/obj/structure/bloodsucker/ghoulrack/unbuckle_mob(mob/living/buckled_mob, force = FALSE, can_fall = TRUE)
	. = ..()
	if(!.)
		return
	visible_message(span_danger("[buckled_mob][buckled_mob.stat == DEAD ? "的尸体" : ""]从刑架上滑落。"))
	density = FALSE
	buckled_mob.Paralyze(2 SECONDS)
	update_appearance(UPDATE_ICON)

/obj/structure/bloodsucker/ghoulrack/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(!.)
		return FALSE
	// Is there anyone on the rack & If so, are they being tortured?
	if(!has_buckled_mobs())
		return FALSE

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	var/mob/living/carbon/buckled_carbons = pick(buckled_mobs)
	// If I'm not a Bloodsucker, try to unbuckle them.
	if(!istype(bloodsuckerdatum))
		user_unbuckle_mob(buckled_carbons, user)
		return
	if(!bloodsuckerdatum.my_clan)
		to_chat(user, span_warning("加入氏族后才能转化血仆（通过反派界面按钮加入）。"))
		user.balloon_alert(user, "请先加入氏族！")
		return
	var/datum/antagonist/ghoul/ghouldatum = IS_GHOUL(buckled_carbons)
	// Are they our Ghoul?
	if(ghouldatum && (ghouldatum in bloodsuckerdatum.ghouls))
		SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_INTERACT_WITH_GHOUL, ghouldatum)
		return
	if(bloodsuckerdatum.free_ghoul_slots() < 1)
		to_chat(user, span_warning("需要继续升级才能转化更多血仆！当前可用名额为[bloodsuckerdatum.free_ghoul_slots()]，血仆上限为[bloodsuckerdatum.max_ghouls()]。"))
		user.balloon_alert(user, "血仆名额不足！")
		return


	// Not our Ghoul, but Alive & We're a Bloodsucker, good to torture!
	torture_victim(user, buckled_carbons)

/**
 * Torture steps:
 *
 * * Tick Down Conversion from 3 to 0
 * * Break mindshielding/antag (on approve)
 * * Ghoulize target
 */
/obj/structure/bloodsucker/ghoulrack/proc/torture_victim(mob/living/user, mob/living/target)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(IS_GHOUL(target))
		var/datum/antagonist/ghoul/ghouldatum = IS_GHOUL(target)
		if(!ghouldatum.master.broke_masquerade)
			balloon_alert(user, "是别人的血仆！")
			return FALSE

	var/disloyalty_requires = RequireDisloyalty(user, target)
	if(disloyalty_requires == GHOULING_BANNED)
		if(target.ckey)
			balloon_alert(user, "无法转化为血仆！")
		else
			balloon_alert(user, "目标没有心智！")
		return FALSE

	// Conversion Process
	if(convert_progress)
		balloon_alert(user, "正在放血……")
		bloodsuckerdatum.AdjustBloodVolume(-TORTURE_BLOOD_HALF_COST)
		if(!do_torture(user, target))
			return FALSE
		bloodsuckerdatum.AdjustBloodVolume(-TORTURE_BLOOD_HALF_COST)
		// Prevent them from unbuckling themselves as long as we're torturing.
		target.Paralyze(1 SECONDS)
		convert_progress--

		// We're done? Let's see if they can be Ghoul.
		if(convert_progress)
			balloon_alert(user, "还需要继续劝化……")
			return

		if(disloyalty_requires)
			balloon_alert(user, "另有效忠对象！需要继续劝化！")
		else
			balloon_alert(user, "已准备好血之共融！")
		return

	if(!disloyalty_confirm && disloyalty_requires)
		if(!do_disloyalty(user, target))
			return
		if(!disloyalty_confirm)
			balloon_alert(user, "拒绝了劝化！")
		else
			balloon_alert(user, "已准备好血之共融！")
		return

	user.balloon_alert_to_viewers("正在涂抹鲜血……", "正在绘制血印……")
	if(!do_after(user, 5 SECONDS, target))
		balloon_alert(user, "被打断了！")
		return
	// Convert to Ghoul!
	bloodsuckerdatum.AdjustBloodVolume(-TORTURE_CONVERSION_COST)
	remove_loyalties(target)
	if(bloodsuckerdatum.make_ghoul(target))
		SEND_SIGNAL(bloodsuckerdatum, COMSIG_BLOODSUCKER_MADE_GHOUL, user, target)

/obj/structure/bloodsucker/ghoulrack/proc/do_torture(mob/living/user, mob/living/carbon/target, mult = 1)
	// Fifteen seconds if you aren't using anything. Shorter with weapons and such.
	var/torture_time = 15
	var/torture_dmg_brute = 2
	var/torture_dmg_burn = 0
	var/obj/item/bodypart/selected_bodypart = pick(target.bodyparts)
	// Get Weapon
	var/obj/item/held_item = user.get_inactive_held_item()
	/// Weapon Bonus
	if(held_item)
		torture_time -= held_item.force / 4
		if(!held_item.use_tool(src, user, 0, volume = 5))
			return
		switch(held_item.damtype)
			if(BRUTE)
				torture_dmg_brute = held_item.force / 4
				torture_dmg_burn = 0
			if(BURN)
				torture_dmg_brute = 0
				torture_dmg_burn = held_item.force / 4
		switch(held_item.sharpness)
			if(SHARP_EDGED)
				torture_time -= 2
			if(SHARP_POINTY)
				torture_time -= 3

	// Minimum 5 seconds.
	torture_time = max(5 SECONDS, torture_time * 10)
	// Now run process.
	if(!do_after(user, (torture_time * mult), target))
		return FALSE

	if(held_item)
		held_item.play_tool_sound(target)
	target.visible_message(
		span_danger("[user]举行仪式，让鲜血从[target]的[selected_bodypart.name]流出，使其惶恐不安！"),
		span_userdanger("[user]举行仪式，让鲜血从你的[selected_bodypart.name]流出，使你惶恐不安！"))

	INVOKE_ASYNC(target, TYPE_PROC_REF(/mob, emote), "scream")
	target.set_timed_status_effect(5 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
	target.apply_damages(brute = torture_dmg_brute, burn = torture_dmg_burn, def_zone = selected_bodypart.body_zone)
	return TRUE

/// Offer them the opportunity to join now.
/obj/structure/bloodsucker/ghoulrack/proc/do_disloyalty(mob/living/user, mob/living/target)
	if(disloyalty_offered)
		return FALSE
	// Can't willingly join if you're banned from it. It'll just ghost you anyways.
	if(is_banned_from(target.ckey, ROLE_BLOODSUCKER))
		return TRUE
	disloyalty_offered = TRUE
	to_chat(user, span_notice("[target]获得了臣服的机会。你等待着答复……"))
	var/alert_response = tgui_alert(
		user = target, \
		message = "你正在遭受拷问！要屈服并向[user]宣誓永远效忠吗？\n\
			你不会失去现有目标，但它们的优先级将低于新主人的意志！", \
		title = "这可怕的痛苦！什么时候才能结束？！",
		buttons = list("接受", "拒绝"),
		timeout = 10 SECONDS, \
		autofocus = TRUE, \
	)
	switch(alert_response)
		if("接受")
			disloyalty_confirm = TRUE
			target.visible_message(
				span_notice("[target]屈服了，接受了[user]的奴役！"),
				span_userdanger("你屈服了，接受了[user]的奴役！"))
		else
			target.visible_message(
				span_danger("[target]不屈地瞪着[user]，拒绝臣服！"),
				span_danger("你不屈地瞪着[user]，拒绝臣服！"))
	disloyalty_offered = FALSE
	return TRUE

/obj/structure/bloodsucker/ghoulrack/proc/RequireDisloyalty(mob/living/user, mob/living/target)
#ifdef BLOODSUCKER_TESTING
	if(!target || !target.mind)
#else
	if(!target?.mind || !target?.client)
#endif
		return GHOULING_BANNED

	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		return GHOULING_DISLOYAL
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	return bloodsuckerdatum.AmValidAntag(target)

/obj/structure/bloodsucker/ghoulrack/proc/remove_loyalties(mob/living/target)
	// Find Mind Implant & Destroy
	for(var/obj/item/implant/all_implants as anything in target.implants)
		if(all_implants.type == /obj/item/implant/mindshield)
			all_implants.removed(target, silent = TRUE)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// todo, make this steal blood into a internal reservoir from nearby non-vassals/bloodsuckers
/obj/structure/bloodsucker/candelabrum
	name = "烛台"
	desc = "它缓缓燃烧，却不散发任何热量。"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	icon_state = "candelabrum"
	light_color = "#66FFFF"//LIGHT_COLOR_BLUEGREEN // lighting.dm
	light_power = 3
	light_range = 0 // to 2
	max_integrity = 100
	density = FALSE
	can_buckle = TRUE
	anchored = FALSE
	ghost_desc = "这是一支魔法蜡烛，会侵蚀吸血鬼与血仆之外所有人的理智。\n\
		血仆可以手动点燃，吸血鬼则可远程操作。"
	vamp_desc = "这是一支魔法蜡烛，燃烧时会侵蚀不受你支配的凡人的理智。\n\
		可以在任意距离右键点击，远程启用；也可以站在旁边点击，正常点燃或熄灭。"
	ghoul_desc = "这是一支魔法蜡烛，燃烧时会侵蚀那些尚未臣服于你主人的愚者的理智。\n\
		站在旁边点击，即可点燃或熄灭。\n\
		若主人属于梵卓氏族，还会用它提升宠爱血仆。"
	hunter_desc = "这是一座蓝色烛台，燃烧时会使附近的人陷入疯狂。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5)
	var/lit = FALSE

/obj/structure/bloodsucker/candelabrum/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/bloodsucker/candelabrum/update_icon_state()
	icon_state = "candelabrum[lit ? "_lit" : ""]"
	return ..()

/obj/structure/bloodsucker/candelabrum/bolt()
	. = ..()
	set_anchored(TRUE)
	density = TRUE

/obj/structure/bloodsucker/candelabrum/unbolt()
	. = ..()
	set_anchored(FALSE)
	density = FALSE
	if(lit)
		toggle()

/obj/structure/bloodsucker/candelabrum/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!.)
		return
	if(IS_GHOUL(user) || IS_BLOODSUCKER(user))
		toggle()
	return ..()

/obj/structure/bloodsucker/candelabrum/Click(location, control, params)
	. = ..()
	var/mob/user = usr
	var/list/modifiers = params2list(params)
	if(!LAZYACCESS(modifiers, RIGHT_CLICK) || !IS_BLOODSUCKER(user) || !istype(user))
		return
	if(IS_UNCONSCIOUS_OR_CRIT(user))
		return
	user.balloon_alert_to_viewers("朝[src]挥手示意")
	toggle(user)

/obj/structure/bloodsucker/candelabrum/proc/toggle(mob/user)
	if(!anchored)
		to_chat(user, span_danger("尚未固定，无法启用！"))
		return
	lit = !lit
	if(lit)
		desc = initial(desc)
		set_light(2, 3, "#66FFFF")
		START_PROCESSING(SSobj, src)
	else
		desc = "尽管未被点燃，它仍让你毛骨悚然。"
		set_light(0)
		STOP_PROCESSING(SSobj, src)
	update_icon()


/obj/structure/bloodsucker/candelabrum/process()
	if(!lit)
		return
	for(var/mob/living/carbon/nearly_people in viewers(7, src))
		/// We dont want Bloodsuckers or Ghouls affected by this
		if(IS_GHOUL(nearly_people) || IS_BLOODSUCKER(nearly_people))
			continue
		nearly_people.adjust_hallucinations(5 SECONDS)
		nearly_people.add_mood_event("vampcandle", /datum/mood_event/vampcandle)

/// Blood Throne - Allows Bloodsuckers to remotely speak with their Ghouls. - Code (Mostly) stolen from comfy chairs (armrests) and chairs (layers)
/obj/structure/bloodsucker/bloodthrone
	name = "邪恶王座"
	desc = "扭曲的金属碎片从扶手上刺出，看起来很不舒服。只有受虐狂才会坐在这件满是尖刺的家具上。"
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj_64.dmi'
	icon_state = "throne"
	buckle_lying = 0
	anchored = FALSE
	density = TRUE
	can_buckle = TRUE
	ghost_desc = "这是吸血鬼王座。吸血鬼坐上去后，只需开口说话，就能远程向血仆传话。"
	vamp_desc = "这是鲜血王座，坐上去后，只需开口就能通过心灵感应与血仆交谈。"
	ghoul_desc = "这是鲜血王座，你的主人可以借它通过心灵感应与你及其他血仆交谈。"
	hunter_desc = "这把椅子会伤害试图坐上去的人，但不死者可以安然落座。\n\
		坐在上面的怪物能借此进行心灵感应交流。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/wood = SHEET_MATERIAL_AMOUNT)
	var/mutable_appearance/armrest

// Add rotating and armrest
/obj/structure/bloodsucker/bloodthrone/Initialize(mapload)
	AddElement(/datum/element/simple_rotation)
	armrest = GetArmrest()
	armrest.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/bloodsucker/bloodthrone/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/bloodsucker/bloodthrone/bolt()
	. = ..()
	anchored = TRUE

/obj/structure/bloodsucker/bloodthrone/unbolt()
	. = ..()
	anchored = FALSE

// Armrests
/obj/structure/bloodsucker/bloodthrone/proc/GetArmrest()
	return mutable_appearance('modular_zubbers/icons/obj/structures/vamp_obj_64.dmi', "thronearm")

/obj/structure/bloodsucker/bloodthrone/proc/update_armrest()
	if(has_buckled_mobs())
		add_overlay(armrest)
	else
		cut_overlay(armrest)

// Rotating
/obj/structure/bloodsucker/bloodthrone/setDir(newdir)
	. = ..()
	if(has_buckled_mobs())
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(newdir)

	if(has_buckled_mobs() && dir == NORTH)
		layer = ABOVE_MOB_LAYER
	else
		layer = OBJ_LAYER

// Buckling
/obj/structure/bloodsucker/bloodthrone/buckle_mob(mob/living/user, force = FALSE, check_loc = TRUE)
	if(!anchored)
		to_chat(user, span_announce("[src]尚未固定在地面上！"))
		return
	. = ..()
	user.visible_message(
		span_notice("[user]坐上了[src]。"),
		span_boldnotice("你坐上了[src]。"),
	)
	if(IS_BLOODSUCKER(user))
		RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		unbuckle_mob(user)
		user.Paralyze(10 SECONDS)
		to_chat(user, span_cult("鲜血王座的力量将你淹没！"))

/obj/structure/bloodsucker/bloodthrone/post_buckle_mob(mob/living/target)
	. = ..()
	update_armrest()
	target.pixel_y += 2

// Unbuckling
/obj/structure/bloodsucker/bloodthrone/unbuckle_mob(mob/living/user, force = FALSE, can_fall = TRUE)
	src.visible_message(span_danger("[user]从[src]上解开了束缚。"))
	if(IS_BLOODSUCKER(user))
		UnregisterSignal(user, COMSIG_MOB_SAY)
	. = ..()

/obj/structure/bloodsucker/bloodthrone/post_unbuckle_mob(mob/living/target)
	target.pixel_y -= 2

// The speech itself
/obj/structure/bloodsucker/bloodthrone/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER

	var/forced_type = speech_args[SPEECH_FORCED]
	if(forced_type == CLAN_MALKAVIAN)
		return
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/rendered = span_cult_large("<b>[user.real_name]:</b> [capitalize(message)]")
	user.log_talk(message, LOG_SAY, tag = ROLE_BLOODSUCKER)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	for(var/datum/antagonist/ghoul/receiver as anything in bloodsuckerdatum.ghouls)
		if(!receiver.owner.current)
			continue
		var/mob/receiver_mob = receiver.owner.current
		to_chat(receiver_mob, rendered)
	to_chat(user, rendered) // tell yourself, too.

	for(var/mob/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, user)
		to_chat(dead_mob, "[link] [rendered]")

	speech_args[SPEECH_MESSAGE] = ""
