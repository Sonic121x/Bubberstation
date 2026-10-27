/obj/item/organ/brain/psyker
	name = "灵能者大脑"
	desc = "这颗大脑呈蓝色，分为两个半球，充盈着灵能力量。什么样的怪物才会用这种东西？"
	icon_state = "brain-psyker"
	actions_types = list(
		/datum/action/cooldown/spell/pointed/psychic_projection,
		/datum/action/cooldown/spell/charged/psychic_booster,
		/datum/action/cooldown/spell/forcewall/psychic_wall,
	)
	w_class = WEIGHT_CLASS_NORMAL
	shade_color = "blue"
	variant_traits_added = list(TRAIT_ANTIMAGIC_NO_SELFBLOCK)
	/// Echolocation component we assigned
	VAR_FINAL/datum/weakref/echolocation_component
	/// Antimagic component we assigned
	VAR_FINAL/datum/weakref/antimagic_component

/obj/item/organ/brain/psyker/on_mob_insert(mob/living/carbon/inserted_into)
	. = ..()
	echolocation_component = WEAKREF(inserted_into.AddComponent(/datum/component/echolocation, echo_icon = "psyker"))
	antimagic_component = WEAKREF(inserted_into.AddComponent(/datum/component/anti_magic, antimagic_flags = MAGIC_RESISTANCE_MIND))

/obj/item/organ/brain/psyker/on_mob_remove(mob/living/carbon/removed_from)
	. = ..()
	qdel(echolocation_component)
	qdel(antimagic_component)

/obj/item/organ/brain/psyker/on_life(seconds_per_tick)
	. = ..()
	var/obj/item/bodypart/head/psyker/psyker_head = owner.get_bodypart(zone)
	if(istype(psyker_head))
		return
	if(!SPT_PROB(2, seconds_per_tick))
		return
	to_chat(owner, span_userdanger("你的头好痛……它装不下你的大脑！"))
	owner.adjust_disgust(33 * seconds_per_tick)
	apply_organ_damage(5 * seconds_per_tick, 199)

/obj/item/bodypart/head/psyker
	limb_id = BODYPART_ID_PSYKER
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodypart_traits = list(TRAIT_BALD, TRAIT_SHAVED)
	head_flags = HEAD_DEBRAIN | HEAD_NO_DISFIGURE // ignore disfigurement by damage, as we're always disfigured

/obj/item/bodypart/head/psyker/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_DISFIGURED, INNATE_TRAIT)

/// flavorful variant of psykerizing that deals damage and sends messages before calling psykerize()
/mob/living/carbon/human/proc/slow_psykerize()
	if(stat == DEAD || !get_bodypart(BODY_ZONE_HEAD) || istype(get_bodypart(BODY_ZONE_HEAD), /obj/item/bodypart/head/psyker))
		return
	to_chat(src, span_userdanger("你感觉不舒服……"))
	sleep(5 SECONDS)
	if(stat == DEAD || !get_bodypart(BODY_ZONE_HEAD))
		return
	to_chat(src, span_userdanger("你感觉自己的皮肤正在撕裂！"))
	emote("scream")
	apply_damage(30, BRUTE, BODY_ZONE_HEAD)
	sleep(5 SECONDS)
	if(!psykerize())
		to_chat(src, span_warning("变形消退了……"))
		return
	apply_damage(50, BRUTE, BODY_ZONE_HEAD)
	to_chat(src, span_userdanger("你的头颅裂开了！你的大脑发生了变异！"))
	new /obj/effect/gibspawner/generic(drop_location(), src, get_blood_dna_list())
	emote("scream")

/// Proc with no side effects that turns someone into a psyker. returns FALSE if it could not psykerize.
/mob/living/carbon/human/proc/psykerize()
	var/obj/item/bodypart/head/old_head = get_bodypart(BODY_ZONE_HEAD)
	var/obj/item/organ/brain/old_brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/old_eyes = get_organ_slot(ORGAN_SLOT_EYES)
	if(stat == DEAD || !old_head || !old_brain)
		return FALSE
	var/obj/item/bodypart/head/psyker/psyker_head = new()
	if(!psyker_head.replace_limb(src))
		return FALSE
	psyker_head.species_id = dna?.species?.id
	qdel(old_head)
	var/obj/item/organ/brain/psyker/psyker_brain = new() /// turns out if you make a flashing monochromatic outline against black background that refreshes on inconsistant intervals, it hurts peoples eyes. Who'da thunk.
	old_brain.before_organ_replacement(psyker_brain)
	old_brain.Remove(src, special = TRUE, movement_flags = NO_ID_TRANSFER)
	qdel(old_brain)
	psyker_brain.Insert(src, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	if(old_eyes)
		qdel(old_eyes)
	return TRUE

/datum/religion_rites/nullrod_transformation
	name = "变形术"
	desc = "你的全部力量需要一把枪械才能施展。你可以将禁魔杖转化为一把枪。"
	ritual_length = 10 SECONDS
	///The rod that will be transmogrified.
	var/obj/item/nullrod/transformation_target

/datum/religion_rites/nullrod_transformation/perform_rite(mob/living/user, atom/religious_tool)
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/human_user = user
	var/datum/brain_trauma/special/burdened/burden = human_user.has_trauma_type(/datum/brain_trauma/special/burdened)
	if(!burden || burden.burden_level < 9)
		to_chat(human_user, span_warning("你的负担还不够深重。"))
		return FALSE
	for(var/obj/item/possible_rod in get_turf(religious_tool))
		if(HAS_TRAIT(possible_rod, TRAIT_NULLROD_ITEM))
			transformation_target = possible_rod
			return ..()
	to_chat(human_user, span_warning("你需要把一根禁魔杖放在 [religious_tool] 上才能这么做！"))
	return FALSE

/datum/religion_rites/nullrod_transformation/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/obj/item/null_rod = transformation_target
	transformation_target = null
	if(QDELETED(null_rod) || null_rod.loc != get_turf(religious_tool))
		to_chat(user, span_warning("你的目标离开了祭坛！"))
		return FALSE
	to_chat(user, span_warning("[null_rod] 变成了一把枪！"))
	user.emote("smile")
	qdel(null_rod)
	new /obj/item/gun/ballistic/revolver/chaplain(get_turf(religious_tool))
	return TRUE

/obj/item/gun/ballistic/revolver/chaplain
	name = "牧师的左轮手枪"
	desc = "我的天哪。"
	icon_state = "lucky"
	force = 10
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/revchap
	obj_flags = UNIQUE_RENAME
	custom_materials = null
	actions_types = list(/datum/action/item_action/pray_refill)
	projectile_damage_multiplier = 0.72 //it's exactly 18 force for normal bullets
	/// Needs burden level nine to refill.
	var/needs_burden = TRUE
	/// List of all possible names and descriptions.
	var/static/list/possible_names = list(
		"安息祈文" = "愿他们安息。",
		"安魂曲" = "他们永远无法抵达真理。",
		"退散吧" = "有枪也许能让驱魔更有效，谁知道呢？",
		"外在救赎" = "救赎来自外部。",
		"救赎次序" = "第一步？开火。",
		"赦罪" = "你的罪孽已得赦免。",
		"神之杖" = "再次分开红海。",
		"圣杯" = "你找到它了！",
		"燃烧荆棘" = "适合任何火攻伏击。",
		"审判" = "首先，见鬼。这么想当老大？哥们，太酷了，你也是！而且很强！",
		"天堂篇" = "人生喜剧的神圣终幕。",
		"DVNO" = "不用问我的名字，也能看出我有多酷。",
		"金星超级监狱" = "你知道在金星上工作和生活的人几乎都参与硫磺开采吗？对这件火药武器来说倒是很贴切。",
		"涅槃" = "赐予宁静、自由与至高幸福者。",
		"脑裂" = "拉丁语意为“大脑分裂”。多么贴切。",
		"终极死亡" = "你的希望最后才死去。",
		"生命之光" = "无处可逃，再无更伟大的命运可创造。",
		"断折者" = "易碎：请勿弯折或折断。",
		"砰砰" = "这个名字源自枪械开火的拟声词。",
		"正义" = "正义即光辉。",
		"光辉" = "光辉即正义。",
		"启示录" = "唤醒你的信仰。",
		"新安全 M62" = "数百年后，这种枪械因电影业塑造的男性气质联想而广受欢迎。",
		"破灭者" = "这 !@#%* 到底是什么东西！",
		"INKVD" = "灵魂的救主，污秽思想的斗士。",
		"生命汲取者" = "据说能从他人的生命能量中汲取力量的器物。",
		"虚无射线" = "枪管上无星之金属吸收光线，并将其导往虚无之地。握把的亚克力纹路仿照地脉绘制。",
		"莫蒂斯" = "把信念寄托在这把武器能奏效上。",
		"拉米尔" = "字面意思是“神已鸣雷”。你甚至可以把枪声理解为雷鸣。",
		"莽汉" = "喂，你不会拿着它乱来吧，对吧？",
		"拉西坦加" = "规则由强者书写。",
		"A10" = "神之拳。请远离可怕之物。",
		"幸运" = "这一脚踢在脑袋上可真够劲，不是吗？",
	)

/obj/item/gun/ballistic/revolver/chaplain/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core, FALSE)
	name = pick(possible_names)
	desc = possible_names[name]

/obj/item/gun/ballistic/revolver/chaplain/suicide_act(mob/living/user)
	. = ..()
	name = "教宗已选出"
	desc = "我向你们宣布一个极大的喜讯。"

/obj/item/gun/ballistic/revolver/chaplain/attack_self(mob/living/user)
	pray_refill(user)

/obj/item/gun/ballistic/revolver/chaplain/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (isammocasing(tool) || istype(tool, /obj/item/ammo_box))
		user.balloon_alert(user, "不能手动装弹！")
		return ITEM_INTERACT_BLOCKING

	return ..()

/obj/item/gun/ballistic/revolver/chaplain/proc/pray_refill(mob/living/carbon/human/user)
	if(DOING_INTERACTION_WITH_TARGET(user, src) || !istype(user))
		return
	var/datum/brain_trauma/special/burdened/burden = user.has_trauma_type(/datum/brain_trauma/special/burdened)
	if(needs_burden && (!burden || burden.burden_level < 9))
		to_chat(user, span_warning("你的负担还不够深重。"))
		return
	user.manual_emote("双掌合十……")
	if(!do_after(user, 5 SECONDS, src))
		balloon_alert(user, "被打断了！")
		return
	user.say("#哦，伟大的 [GLOB.deity]，请赐予我所需的弹药！", forced = "ammo prayer")
	magazine.top_off()
	user.playsound_local(get_turf(src), 'sound/effects/magic/magic_block_holy.ogg', 50, TRUE)
	chamber_round()

/datum/action/item_action/pray_refill
	name = "补充弹药"
	desc = "进行祈祷，为你的武器补充弹药。"

/obj/item/ammo_box/magazine/internal/cylinder/revchap
	name = "牧师左轮手枪弹巢"
	ammo_type = /obj/item/ammo_casing/c38/holy
	caliber = CALIBER_38
	max_ammo = 5

/obj/item/ammo_casing/c38/holy
	name = "幸运 .38 子弹壳"
	desc = "一个幸运的 .38 子弹壳。光是握着它，你就觉得自己很幸运。"
	caliber = CALIBER_38
	projectile_type = /obj/projectile/bullet/c38/holy
	custom_materials = null

/obj/projectile/bullet/c38/holy
	name = "幸运 .38 子弹"
	ricochets_max = 2
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3
	wound_bonus = -10
	embed_type = null

/obj/projectile/bullet/c38/holy/on_hit(atom/target, blocked, pierce_hit)
	. = ..()
	var/roll_them_bones = rand(1,38)
	if(roll_them_bones == 1 && isliving(target))
		playsound(target, 'sound/machines/synth/synth_yes.ogg', 50, TRUE)
		playsound(target, pick(list('sound/machines/coindrop.ogg', 'sound/machines/coindrop2.ogg')), 40, TRUE)
		new /obj/effect/temp_visual/crit(get_turf(target))

/datum/action/cooldown/spell/pointed/psychic_projection
	name = "灵能投射"
	desc = "将你的心灵投射到目标身上，扭曲其视野并注入绝对恐惧。这会使其快速倾泻手中枪械的弹药。"
	ranged_mousepointer = 'icons/effects/mouse_pointers/cult_target.dmi'
	button_icon_state = "blind"
	school = SCHOOL_PSYCHIC
	cooldown_time = 1 MINUTES
	antimagic_flags = MAGIC_RESISTANCE_MIND
	spell_max_level = 1
	invocation_type = INVOCATION_NONE
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	cast_range = 5
	active_msg = "你准备将心灵投射到目标身上……"
	/// Duration of the effects.
	var/projection_duration = 10 SECONDS

/datum/action/cooldown/spell/pointed/psychic_projection/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(cast_on))
		return FALSE
	var/mob/living/living_target = cast_on
	return !living_target.has_status_effect(/datum/status_effect/psychic_projection)

/datum/action/cooldown/spell/pointed/psychic_projection/cast(mob/living/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(cast_on, span_notice("你的心智感觉异样，但很快就过去了。"))
		to_chat(owner, span_warning("法术没有产生效果！"))
		return FALSE
	to_chat(cast_on, span_userdanger("你的心智被扭曲了！"))
	cast_on.emote("scream")
	cast_on.apply_status_effect(/datum/status_effect/psychic_projection, projection_duration)
	return TRUE

/// Status effect that adds a weird view to its owner and causes them to rapidly shoot a firearm in their general direction.
/datum/status_effect/psychic_projection
	id = "psychic_projection"
	alert_type = null
	remove_on_fullheal = TRUE
	tick_interval = 0.2 SECONDS
	/// Times the target has dry fired a weapon.
	var/times_dry_fired = 0
	/// Needs to reach times_dry_fired for the next dry fire to happen.
	var/firing_delay = 0

/datum/status_effect/psychic_projection/on_creation(mob/living/new_owner, duration = 10 SECONDS)
	src.duration = duration
	return ..()

/datum/status_effect/psychic_projection/on_apply()
	var/atom/movable/plane_master_controller/game_plane_master_controller = owner.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME]
	if(!game_plane_master_controller)
		return FALSE
	game_plane_master_controller.add_filter("psychic_blur", 10, angular_blur_filter(0, 0, 3))
	game_plane_master_controller.add_filter("psychic_wave", 10, wave_filter(240, 240, 3, 0, WAVE_SIDEWAYS))
	return TRUE

/datum/status_effect/psychic_projection/on_remove()
	var/atom/movable/plane_master_controller/game_plane_master_controller = owner.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME]
	if(!game_plane_master_controller)
		return
	game_plane_master_controller.remove_filter("psychic_blur")
	game_plane_master_controller.remove_filter("psychic_wave")

/datum/status_effect/psychic_projection/tick(seconds_between_ticks)
	var/obj/item/gun/held_gun = owner?.is_holding_item_of_type(/obj/item/gun)
	if(!held_gun)
		return
	if(!held_gun.can_shoot())
		if(firing_delay < times_dry_fired)
			firing_delay++
			return
		firing_delay = 0
		times_dry_fired++
	else
		times_dry_fired = 0
	var/turf/target_turf = get_offset_target_turf(get_ranged_target_turf(owner, owner.dir, 7), dx = rand(-1, 1), dy = rand(-1, 1))
	held_gun.process_fire(target_turf, owner, TRUE, null, pick(GLOB.all_body_zones))
	held_gun.fire_cd = FALSE

/datum/action/cooldown/spell/charged/psychic_booster
	name = "灵能增幅"
	desc = "蓄积心灵力量，使枪械射速更快并自动追踪目标。要更聪明地思考，而不是更费力。"
	button_icon_state = "projectile"
	sound = 'sound/items/weapons/gun/shotgun/rack.ogg'
	school = SCHOOL_PSYCHIC
	cooldown_time = 1 MINUTES
	antimagic_flags = MAGIC_RESISTANCE_MIND
	spell_max_level = 1
	invocation_type = INVOCATION_NONE
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	channel_message = span_notice("你专注于扣扳机的手指……")
	charge_overlay_icon = 'icons/effects/effects.dmi'
	charge_overlay_state = "purplesparkles"
	channel_time = 5 SECONDS
	/// Are we currently active?
	var/boosted = FALSE
	/// How long the effect lasts for?
	var/effect_time = 10 SECONDS

/datum/action/cooldown/spell/charged/psychic_booster/Destroy()
	if(boosted)
		stop_effects()
	return ..()

/datum/action/cooldown/spell/charged/psychic_booster/Remove(mob/living/remove_from)
	if(boosted)
		stop_effects()
	return ..()

/datum/action/cooldown/spell/charged/psychic_booster/cast(atom/cast_on)
	. = ..()
	if(boosted)
		return
	boosted = TRUE
	to_chat(owner, span_boldnotice("你的扣扳机手指感觉更有力了。"))
	ADD_TRAIT(cast_on, TRAIT_DOUBLE_TAP, type)
	RegisterSignal(cast_on, COMSIG_PROJECTILE_FIRER_BEFORE_FIRE, PROC_REF(modify_projectile))
	addtimer(CALLBACK(src, PROC_REF(stop_effects)), effect_time)

/datum/action/cooldown/spell/charged/psychic_booster/proc/stop_effects()
	boosted = FALSE
	to_chat(owner, span_danger("你的扣扳机手指感觉更无力了。"))
	REMOVE_TRAIT(owner, TRAIT_DOUBLE_TAP, type)
	UnregisterSignal(owner, COMSIG_PROJECTILE_FIRER_BEFORE_FIRE)

/datum/action/cooldown/spell/charged/psychic_booster/proc/modify_projectile(datum/source, obj/projectile/bullet, atom/firer, atom/original_target)
	var/atom/target = original_target
	if(isturf(target) || (isobj(target) && !target.density)) //if weird target, we try to compensate in our homing
		for(var/mob/living/shooting_target in range(1, get_turf(target)))
			if(shooting_target == firer)
				continue
			target = shooting_target
			break
	if(!bullet.can_hit_target(target, direct_target = TRUE, ignore_loc = TRUE))
		return
	bullet.original = target
	bullet.homing_turn_speed = 30
	bullet.set_homing_target(target)

/datum/action/cooldown/spell/forcewall/psychic_wall
	name = "灵能之墙"
	desc = "构筑一道灵能墙壁，能够偏转射弹并阻止物体穿过。"
	school = SCHOOL_PSYCHIC
	cooldown_time = 30 SECONDS
	cooldown_reduction_per_rank = 0 SECONDS
	antimagic_flags = MAGIC_RESISTANCE_MIND
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	spell_max_level = 1
	invocation_type = INVOCATION_NONE
	wall_type = /obj/effect/forcefield/psychic

/datum/action/cooldown/spell/forcewall/psychic_wall/spawn_wall(turf/cast_turf)
	. = ..()
	play_fov_effect(cast_turf, 5, "forcefield", time = 10 SECONDS)
