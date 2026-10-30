// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	name = "\improper 烈日等离子投射器"
	desc = "一款过时的副武器，偶尔仍有CIN成员使用。\
		使用等离子能源包供能。\
		只要有电并扣住扳机，就会从磁性枪管中喷出一股精度很差的灼热等离子流。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "slonce"
	greyscale_config = /datum/greyscale_config/szot_dynamica_32
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1

	fire_sound = 'modular_zubbers/sound/weapons/incinerate.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.1 SECONDS
	spread = 15

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, autofire_shot_delay = fire_delay)
	AddElement(/datum/element/gags_recolorable)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine_more(mob/user)
	. = ..()

	. += "“烈日”最初是一项旨在推进加速等离子武器技术的\
		试验。尽管设计在精度和射程方面存在明显缺陷，\
		CIN联合军事司令部（以下称为联合司令部）仍对它产生了兴趣，\
		希望用它对抗太阳更先进的护甲技术。\
		事实证明，这种武器产生的等离子团对护甲的效果\
		并不像联合司令部期望的那样好，实际上恰恰相反。\
		但它很擅长让没有防护却不幸中弹的人\
		遭受严重烧伤。因此，陆军军官和舰船乘员\
		经常使用“烈日”作为备用武器，焚烧偶尔遇到的太空\
		海盗或战俘。"

	return .

// Plasma sharpshooter pistol
// Shoots single, strong plasma blasts at a slow rate

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	name = "\improper 恒星等离子精射手枪"
	desc = "一款过时的副武器，偶尔仍有CIN成员使用。\
		使用等离子能源包供能。\
		能够较为精准地发射灼热的等离子团。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "gwiazda"
	greyscale_config = /datum/greyscale_config/szot_dynamica_32
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1

	fire_sound = 'modular_zubbers/sound/weapons/burn.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.6 SECONDS
	spread = 2.5
	actions_types = list(/datum/action/item_action/activate_plasma_overclock)
	var/current_projspeed_mod = 1.5 // default so the first shot always is at full, duh
	var/overclocking = FALSE
	var/self_destruct_timer

	projectile_damage_multiplier = 3 // 30 damage a shot
	projectile_wound_bonus = 10 // +55 of the base projectile, burn baby burn

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_MOVABLE_POST_THROW, PROC_REF(shakeit))
	AddElement(/datum/element/gags_recolorable)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine(mob/user, overclocking)
	. = ..()
	if(overclocking)
		. += span_notice("武器烧得通红，还在冒出蒸汽！")
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine_more(mob/user)
	. = ..()
	. += "“恒星”进一步改进了“烈日”的设计，优化了\
		能量循环，采用制造精度更高的磁性发射器，整体也更加\
		符合人体工程学。虽然面对护甲仍然表现不佳，\
		但它以大幅降低射速为代价，显著提升了精度和威力。\
		军中对这件武器的评价褒贬不一，许多人更喜欢\
		等离子扫射带来的强大阻止力，另一些人则很高兴\
		自己总算能打中面前的东西了。"

	return .

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(overclocking && chambered)
		chambered.projectile_type = /obj/projectile/beam/laser/plasma_glob/supercharged

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/update_projspeed(mob/user)
	var/shots_in_mag = src.get_ammo()
	if(overclocking)
		projectile_speed_multiplier = 1.6
	else if(shots_in_mag >= 13)
		projectile_speed_multiplier = 1.5
	else if(shots_in_mag >= 10 && shots_in_mag <= 12)
		projectile_speed_multiplier = 1.3
	else if(shots_in_mag >= 8 && shots_in_mag <= 9)
		projectile_speed_multiplier = 1.2
	else if(shots_in_mag >= 5 && shots_in_mag <= 7)
		projectile_speed_multiplier = 1.1
	else if(shots_in_mag >= 1 && shots_in_mag <= 4)
		projectile_speed_multiplier = 1.0
	else
		projectile_speed_multiplier = 0.8

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/activate_oveclock(mob/user, current_proj_speed)

/datum/action/item_action/activate_plasma_overclock //Gotta be hud, its un-revertable. Imagine misclicking and blowing up your gun without knowing...
	button_icon = 'icons/obj/weapons/guns/ammo.dmi'
	button_icon_state = "9x19p"
	name = "超频等离子充能器"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS

//Checks if we can overclock the gun, if so, starts the process
/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/ui_action_click(mob/user, actiontype)
	if(!istype(actiontype, /datum/action/item_action/activate_plasma_overclock))
		return ..()
	if(!overclocking)
		overclocking = !overclocking
	balloon_alert(user, "[overclocking ? "等离子线圈过热，要爆炸了！" : "关不掉了！"]")
	if(overclocking)
		overclock(user)
	playsound(src, 'sound/effects/magic/lightning_chargeup.ogg', 50)
	update_item_action_buttons()

	//Base overclock proc, changes our projectile for releasing the flare + explosion
/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/overclock(mob/living/user, slot)
	if(user)
		START_PROCESSING(SSprocessing, src)
		addtimer(CALLBACK(src, PROC_REF(audio_warning)), 7 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(kaboom)), 10 SECONDS)
		shakeit()
		add_shared_particles(/particles/smoke/steam)

/obj/item/ammo_casing/energy/laser/plasma_glob/ready_proj(atom/target, mob/living/user, quiet, zone_override, atom/fired_from)
	var/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/gun = fired_from
	if(istype(gun))
		if(gun.overclocking)
			loaded_projectile.name = "过载等离子团"
			loaded_projectile.icon_state = "plasma_glob_super"
			loaded_projectile.weak_against_armour = FALSE
		gun.update_projspeed(user)
	. = ..()

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/shakeit()
	SIGNAL_HANDLER

	if(!overclocking)
		return
	spasm_animation()

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/kaboom(mob/living/user)
	STOP_PROCESSING(SSprocessing, src)
	var/turf/last_surprise = get_turf(src)
	explosion(src, light_impact_range = 1, flame_range = 3, explosion_cause = src)
	last_surprise.add_liquid(/datum/reagent/toxin/plasma, 3, no_react = FALSE, chem_temp = 300)
	new /obj/effect/hotspot(last_surprise)
	UnregisterSignal(src, COMSIG_MOVABLE_POST_THROW)
	remove_shared_particles(/particles/bonfire)
	qdel(src)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/proc/audio_warning(mob/living/user)
	playsound(src, 'modular_zubbers/sound/weapons/plasma_explosion.ogg', 100, FALSE, 20, , , , TRUE)
	for(var/mob/living/carbon/M in orange(20, src))
		if(!HAS_TRAIT(M, TRAIT_DEAF))
			to_chat(M, span_warning("你听见远处传来能量脉冲，仿佛一座微型反应堆在远方释放了冲击波……"))

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/process(seconds_per_tick)
	var/mob/living/carbon/wielder = ismob(loc) ? loc : null
	var/obj/item/bodypart/affecting = wielder.get_bodypart("[(wielder.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	if(isnull(wielder))
		return
	if(isnull(affecting))
		return
	if(wielder.is_holding(src))
		wielder.apply_damage(2.5, BURN, affecting)
		to_chat(wielder, span_warning("[src]烫伤了你的手，它太热了！"))

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		if(prob(15 * severity))
			overclock()


// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/shotgun_revolver
	name = "\improper 海狸12号口径左轮手枪"
	desc = "一款过时的副武器，偶尔仍有CIN成员使用。采用左轮结构，弹巢可容纳四发霰弹。没错，是霰弹。这把枪使用12号口径弹药。"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	projectile_damage_multiplier = 0.9
	recoil = 1
	weapon_weight = WEAPON_MEDIUM
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "bobr"
	greyscale_config = /datum/greyscale_config/szot_dynamica_32
	greyscale_colors = "#83825E#CD445B"
	flags_1 = parent_type::flags_1 | IS_PLAYER_COLORABLE_1 | NO_NEW_GAGS_PREVIEW_1
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	spread = SAWN_OFF_ACC_PENALTY

/obj/item/gun/ballistic/revolver/shotgun_revolver/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)

/obj/item/gun/ballistic/revolver/shotgun_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/revolver/shotgun_revolver/examine_more(mob/user)
	. = ..()

	. += "“海狸”最初作为限量生产的运动枪械研发，后来\
		引起了军方的兴趣。冲突爆发后，市场需求迅速从打靶\
		变成了把地球政府突击队当靶子打。\
		这个型号不同于最初的民用版本，配备军用\
		制式手枪握把和耐候表面涂层。虽然“海狸”并非\
		配发给每个CIN士兵的制式武器，但其价格较为\
		低廉，因此在部队中相当受欢迎。"

	return .
