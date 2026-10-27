/obj/item/gun/ballistic/revolver
	name = "\improper .357 左轮手枪"
	desc = "一把可疑的左轮手枪。使用 .357 弹药。"
	icon_state = "revolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder
	fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 90
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0
	var/last_fire = 0

/obj/item/gun/ballistic/revolver/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	. = ..()
	if(.)
		last_fire = world.time

/obj/item/gun/ballistic/revolver/chamber_round(spin_cylinder = TRUE, replace_new_round)
	if(!magazine) //if it mag was qdel'd somehow.
		CRASH("revolver tried to chamber a round without a magazine!")
	if(chambered)
		UnregisterSignal(chambered, COMSIG_MOVABLE_MOVED)
	if (spin_cylinder)
		chambered = magazine.get_round()
	else
		chambered = magazine.stored_ammo[1]
		if (ispath(chambered))
			chambered = new chambered(src)
			magazine.stored_ammo[1] = chambered
	if(chambered)
		RegisterSignal(chambered, COMSIG_MOVABLE_MOVED, PROC_REF(clear_chambered))

/obj/item/gun/ballistic/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	..()
	chamber_round()

/obj/item/gun/ballistic/revolver/click_alt(mob/user)
	spin_chamber(user)
	return CLICK_ACTION_SUCCESS

/obj/item/gun/ballistic/revolver/fire_sounds()
	var/frequency_to_use = sin((90/magazine?.max_ammo) * get_ammo(TRUE, FALSE)) // fucking REVOLVERS
	var/click_frequency_to_use = 1 - frequency_to_use * 0.75
	var/play_click = sqrt(magazine?.max_ammo) > get_ammo(TRUE, FALSE)
	if(suppressed)
		playsound(src, suppressed_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
		if(play_click)
			playsound(src, 'sound/items/weapons/gun/general/ballistic_click.ogg', suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0, frequency = click_frequency_to_use)
	else
		playsound(src, fire_sound, fire_sound_volume, vary_fire_sound)
		if(play_click)
			playsound(src, 'sound/items/weapons/gun/general/ballistic_click.ogg', fire_sound_volume, vary_fire_sound, frequency = click_frequency_to_use)

GAME_VERB(/obj/item/gun/ballistic/revolver, spin, "转动弹巢", null)
	spin_chamber(usr)

/obj/item/gun/ballistic/revolver/verb/spin_chamber(mob/living/user)
	if(!istype(user) || IS_UNCONSCIOUS_OR_CRIT(user) || !in_range(user, src))
		return

	if (recent_spin > world.time)
		return

	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
		visible_message(span_notice("[user] 转动了 [src] 的弹巢。"), span_notice("你转动了 [src] 的弹巢。"))
		balloon_alert(user, "弹巢已转动")
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(spin_cylinder = FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "其中有 [live_ammo ? live_ammo : "0"] 发是实弹。"
	. += span_notice("可以用[EXAMINE_HINT("Alt+点击")]转动弹巢。")

/obj/item/gun/ballistic/revolver/ignition_effect(atom/A, mob/user)
	if(last_fire && last_fire + 15 SECONDS > world.time)
		return span_rose("[user] 把 [src] 的枪口凑到 \the [A] 上，用余热点燃了它，冒出一缕青烟。真是帅呆了。")

/obj/item/gun/ballistic/revolver/c38
	name = "\improper .38 左轮手枪"
	desc = "一款经典（也许已经过时）的致命火器。使用 .38 特种弹。"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	icon_state = "c38"
	base_icon_state = "c38"
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'

// 38 special skins
/datum/atom_skin/det_revolver
	abstract_type = /datum/atom_skin/det_revolver
	change_base_icon_state = TRUE

/datum/atom_skin/det_revolver/default
	preview_name = "默认"
	new_icon_state = "c38"

/datum/atom_skin/det_revolver/fitz_special
	preview_name = "菲茨特制型"
	new_icon_state = "c38_fitz"

/datum/atom_skin/det_revolver/police_positive_special
	preview_name = "警用积极特制型"
	new_icon_state = "c38_police"

/datum/atom_skin/det_revolver/blued_steel
	preview_name = "烤蓝钢"
	new_icon_state = "c38_blued"

/datum/atom_skin/det_revolver/stainless_steel
	preview_name = "不锈钢"
	new_icon_state = "c38_stainless"

/datum/atom_skin/det_revolver/gold_trim
	preview_name = "金饰边"
	new_icon_state = "c38_trim"

/datum/atom_skin/det_revolver/golden
	preview_name = "金色"
	new_icon_state = "c38_gold"

/datum/atom_skin/det_revolver/peacemaker
	preview_name = "和平缔造者"
	new_icon_state = "c38_peacemaker"

/datum/atom_skin/det_revolver/black_panther
	preview_name = "黑豹"
	new_icon_state = "c38_panther"

/obj/item/gun/ballistic/revolver/c38/detective
	name = "\improper 柯尔特侦探特制型"
	desc = "一款经典（也许已经过时）的执法用火器。使用 .38 特种弹。 \n有传言说，只要用扳手把枪管拧松，就能“改良”它。"

	can_modify_ammo = TRUE
	initial_caliber = CALIBER_38
	initial_fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	alternative_caliber = CALIBER_357
	alternative_fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	alternative_ammo_misfires = TRUE
	misfire_probability = 0
	misfire_percentage_increment = 25 //about 1 in 4 rounds, which increases rapidly every shot

	obj_flags = UNIQUE_RENAME

/obj/item/gun/ballistic/revolver/c38/detective/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/det_revolver)

/obj/item/gun/ballistic/revolver/badass
	name = "\improper 猛人左轮手枪"
	desc = "华夫公司为了让自家特工感觉自己很猛而制造的七膛左轮手枪。没有任何战术优势。使用 .357 弹药。"
	icon_state = "revolversyndie"

/obj/item/gun/ballistic/revolver/badass/nuclear
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/revolver/cowboy
	desc = "一把经典左轮手枪，经过翻新以供现代使用。使用 .357 弹药。"
	//There's already a cowboy sprite in there!
	icon_state = "lucky"

/obj/item/gun/ballistic/revolver/cowboy/nuclear
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/revolver/mateba
	name = "\improper Unica 6 自动左轮手枪"
	desc = "一款复古的大威力自动左轮，通常配发给新俄罗斯军队的军官。使用 .357 弹药。"
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/golden
	name = "\improper 黄金左轮手枪"
	desc = "这可不是闹着玩，也从来不是什么表演，我很乐意把你认识的最老的老太太打成筛子。使用 .357 弹药。"
	icon_state = "goldrevolver"
	fire_sound = 'sound/items/weapons/resonator_blast.ogg'
	recoil = 8
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/nagant
	name = "\improper 纳甘左轮手枪"
	desc = "一款源自俄罗斯的老式左轮手枪。可安装消音器。使用 7.62x38mmR 弹药。"
	icon_state = "nagant"
	can_suppress = TRUE

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev762


// A gun to play Russian Roulette!
// You can spin the chamber to randomize the position of the bullet.

/obj/item/gun/ballistic/revolver/russian
	name = "\improper 俄罗斯左轮手枪"
	desc = "一把俄制左轮手枪，专供饮酒游戏使用。使用 .357 弹药，其机构要求你每次扣动扳机前都得先转动弹巢。"
	icon_state = "russianrevolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	hidden_chambered = TRUE //Cheater.
	gun_flags = NOT_A_REAL_GUN
	can_hold_up = FALSE // for obvious reasons
	doafter_self_shoot = FALSE // snowflake
	/// If we've been spun before firing
	var/spun = FALSE
	/// Do after for trying to fire the gun
	var/aim_time = 4 SECONDS

/obj/item/gun/ballistic/revolver/russian/examine(mob/user)
	. = ..()
	. += span_notice("你可以用[EXAMINE_HINT("Alt+右键")]调整扣动扳机前停顿的时长。")

/obj/item/gun/ballistic/revolver/russian/click_alt_secondary(mob/user)
	if(loc != user)
		to_chat(user, span_warning("你得先把枪拿在手里，才能决定要停顿多久！"))
		return CLICK_ACTION_BLOCKING
	var/new_aim_time = tgui_input_number(user, "扣动扳机前你打算停顿多久（秒）？", "你觉得自己运气好吗？", (aim_time / (1 SECONDS)), 10, 0)
	if(loc != user || user.incapacitated)
		return CLICK_ACTION_BLOCKING
	aim_time = new_aim_time * (1 SECONDS)
	to_chat(user, span_warning("你打算在扣动扳机前停顿 [aim_time] 秒[aim_time == 0 ? "……祝你好运" : ""]。"))
	return CLICK_ACTION_SUCCESS

/obj/item/gun/ballistic/revolver/russian/dropped(mob/user, silent)
	. = ..()
	aim_time = initial(aim_time) // next person chooses their own time

/obj/item/gun/ballistic/revolver/russian/do_spin()
	. = ..()
	if(.)
		spun = TRUE

/obj/item/gun/ballistic/revolver/russian/can_shoot()
	return TRUE // we ALWAYS want to shoot. even if we don't have a chambered round, even if our chambered round has no bullet

/obj/item/gun/ballistic/revolver/russian/load_gun(obj/item/ammo, mob/living/user)
	. = ..()
	if(!.)
		return
	do_spin()

/obj/item/gun/ballistic/revolver/russian/can_trigger_gun(mob/living/user, akimbo_usage)
	if(akimbo_usage)
		return FALSE
	return ..()

/obj/item/gun/ballistic/revolver/russian/attack_self(mob/user)
	if(!spun)
		spin_chamber(user)
		return TRUE
	return ..()

/obj/item/gun/ballistic/revolver/russian/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	from_firing = FALSE // never eject casings from firing the gun
	return ..()

/obj/item/gun/ballistic/revolver/russian/try_fire_gun(atom/target, mob/living/user, params)
	if(user.combat_mode)
		return FALSE // melee attack
	if(target != user)
		shoot_with_empty_chamber(user)
		spun = FALSE
		user.visible_message(
			span_danger("[user] 试图用 \the [src] 朝别的东西开火，结果只是让自己看起来像个白痴。"),
			span_danger("\The [src] 的反战斗机构阻止你朝除自己以外的任何人开火！"),
		)
		return TRUE // no melee attack
	if(!spun)
		to_chat(user, span_warning("你得先转动 \the [src] 的弹巢！"))
		return TRUE // no melee attack
	if(HAS_TRAIT(user, TRAIT_CURSED)) // I cannot live, I cannot die, trapped in myself, body my holding cell.
		to_chat(user, span_warning("多么可怕的夜晚……竟被诅咒缠身！"))
		return TRUE // no melee attack
	if(loc != user)
		if(tk_firing(user))
			to_chat(user, span_warning("光是俄罗斯轮盘就够紧张了，还得集中精神用念力！"))
		else
			to_chat(user, span_warning("你得把枪拿在手里才能开火！"))
		return TRUE // no melee attack

	return ..() // try to shoot the gun

// Replaces clumsy check with a do after
/obj/item/gun/ballistic/revolver/russian/check_botched(mob/living/user, atom/target)
	if(aim_time <= 0)
		return FALSE
	user.visible_message(
		span_danger("[user] 把 [src] 对准了自己的[chinese_body_zone_display(parse_zone(user.zone_selected))]……"),
		span_userdanger("你把 [src] 对准了自己的[chinese_body_zone_display(parse_zone(user.zone_selected))]……"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	if(prob(10) && !HAS_TRAIT(user, TRAIT_FEARLESS))
		user.adjust_jitter(aim_time)
	if(!do_after(user, aim_time, target))
		if(!user.incapacitated)
			user.visible_message(
				span_danger("[user] 泄了气，把 \the [src] 放下了。"),
				span_userdanger("你泄了气，把 \the [src] 放下了。"),
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
		return TRUE
	return FALSE

/obj/item/gun/ballistic/revolver/russian/before_firing(atom/target, mob/user)
	if(target != user)
		CRASH("Russian revolver somehow got to before_firing with a target that isn't the user!")
	// we will definitely have a chambered round, but not always projectile
	if(check_zone(user.zone_selected) == BODY_ZONE_HEAD)
		chambered.loaded_projectile?.damage = 300
		chambered.loaded_projectile?.wound_bonus = 100
	else
		chambered.loaded_projectile?.damage = 80
		chambered.loaded_projectile?.wound_bonus = 10

/obj/item/gun/ballistic/revolver/russian/fire_gun(atom/target, mob/living/user, flag, params)
	// . = false = no shot fired
	. = ..()
	spun = FALSE
	var/is_target_face = check_zone(user.zone_selected) == BODY_ZONE_HEAD
	var/aimed_at_readable = parse_zone(user.zone_selected)
	var/loaded_rounds = get_ammo(FALSE, FALSE) // check before it is fired
	if(loaded_rounds && is_target_face)
		add_memory_in_range(user, 7, /datum/memory/witnessed_russian_roulette, \
			protagonist = user, \
			antagonist = src, \
			rounds_loaded = loaded_rounds, \
			aimed_at = aimed_at_readable, \
			result = (. ? "lost" : "won"), \
		)

	if(!.)
		if(loaded_rounds && is_target_face)
			user.add_mood_event("russian_roulette_win", /datum/mood_event/russian_roulette_win, loaded_rounds)
		user.visible_message(
			span_danger("[user][is_target_face ? "": " 怯懦地"]把 \the [src] 对准自己的 [aimed_at_readable]，扣动扳机，然后……什么也没发生！"),
			span_danger("你[is_target_face ? "": " 怯懦地"]把 \the [src] 对准自己的 [aimed_at_readable]，扣动扳机，然后……什么也没发生！"),
			span_hear("你听到咔嗒一声！"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		return TRUE // so they don't hit themselves in the forehead. because returning FALSE translates to "do melee attack" for whatever reason

	user.visible_message(
		span_danger("[user][is_target_face ? "": " 怯懦地"]把 \the [src] 对准自己的 [aimed_at_readable]，就在这时枪响了！"),
		span_danger("你[is_target_face ? "": " 怯懦地"]把 \the [src] 对准自己的 [aimed_at_readable]，就在这时枪响了！[user.stat >= HARD_CRIT ? " <b>眼前突然一片漆黑。</b>" : ""]"),
		span_hear("你听到一声闷哼[!IS_UNCONSCIOUS_OR_CRIT(user) ? "" : "，紧接着扑通一声"]！"),
		vision_distance = COMBAT_MESSAGE_RANGE,
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	shoot_self(user, check_zone(user.zone_selected))
	return .

/obj/item/gun/ballistic/revolver/russian/on_mail_unwrap(atom/source, mob/user, obj/item/mail/traitor/letter)
	if((get_ammo(FALSE, FALSE) > 1) || (get_ammo(TRUE, TRUE) < 6))
		return NONE
	return ..()

/// Called after successfully(if you can call it that) shooting ourselves
/obj/item/gun/ballistic/revolver/russian/proc/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	user.add_mood_event(
		"russian_roulette_lose",
		affecting == BODY_ZONE_HEAD ? /datum/mood_event/russian_roulette_lose : /datum/mood_event/russian_roulette_lose_cheater,
	)

/obj/item/gun/ballistic/revolver/russian/soul
	name = "被诅咒的俄罗斯左轮手枪"
	desc = "想玩这把左轮，你得拿自己的灵魂当赌注。"

/obj/item/gun/ballistic/revolver/russian/soul/shoot_self(mob/living/user, affecting = BODY_ZONE_HEAD)
	. = ..()
	if(affecting == BODY_ZONE_HEAD)
		var/obj/item/soulstone/anybody/revolver/stone = new(user.drop_location())
		if(!stone.capture_soul(user, forced = TRUE)) //Something went wrong
			qdel(stone)
			return
		user.visible_message(
			span_danger("[user] 的灵魂被 \the [src] 攫走了！"),
			span_userdanger("你赌输了！你的灵魂被收走了！"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		return

	user.visible_message(
		span_danger("[user] 因试图在这局游戏中作弊而受到了惩罚！"),
		span_userdanger("你赌输了！你的灵魂不仅被收走，还因为你企图欺瞒死亡而被卷走了！"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	user.dust(drop_items = TRUE)

/obj/item/gun/ballistic/revolver/reverse //Fires directly at its user... unless the user is a clown, of course.
	clumsy_check = FALSE

/obj/item/gun/ballistic/revolver/reverse/can_trigger_gun(mob/living/user, akimbo_usage)
	if(akimbo_usage)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_CLUMSY) || is_clown_job(user.mind?.assigned_role))
		return ..()
	if(process_fire(user, user, FALSE, null, BODY_ZONE_HEAD))
		user.visible_message(span_warning("[user] 不知怎么竟朝自己的脸开了一枪！"), span_userdanger("你不知怎么竟朝自己的脸开了一枪！这到底怎么做到的？！"))
		user.emote("scream")
		user.drop_all_held_items()
		user.Paralyze(80)

/obj/item/gun/ballistic/revolver/reverse/mateba
	name = /obj/item/gun/ballistic/revolver/mateba::name
	desc = /obj/item/gun/ballistic/revolver/mateba::desc
	clumsy_check = FALSE
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/peashooter
	name = "豆豆枪"
	icon_state = "peashooter"
	desc = "一株会射出硬化豌豆的野生植物突变体。不可思议。"
	fire_sound = 'sound/items/weapons/peashoot.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/peashooter
