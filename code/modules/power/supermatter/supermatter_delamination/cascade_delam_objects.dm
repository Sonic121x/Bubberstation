/obj/crystal_mass
	name = "晶体团块"
	desc = "你看到这团巨大的晶体朝你逼近，每一次看似随机的动作都伴随着碎裂与尖啸。"
	icon = 'icons/turf/walls.dmi'
	icon_state = "crystal_cascade_1"
	layer = AREA_LAYER
	plane = ABOVE_LIGHTING_PLANE
	opacity = FALSE
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	light_power = 1
	light_range = 5
	light_color = COLOR_VIVID_YELLOW
	move_resist = INFINITY
	///All dirs we can expand to
	var/list/available_dirs = list(NORTH,SOUTH,EAST,WEST,UP,DOWN)
	///Handler that helps with properly killing mobs that the crystal grows over
	var/datum/component/supermatter_crystal/sm_comp
	///Cooldown on the expansion process
	COOLDOWN_DECLARE(sm_wall_cooldown)

/obj/crystal_mass/Initialize(mapload, dir_to_remove)
	. = ..()
	icon_state = "crystal_cascade_[rand(1,6)]"
	START_PROCESSING(SSsupermatter_cascade, src)

	sm_comp = AddComponent(/datum/component/supermatter_crystal, null, null)

	playsound(src, 'sound/misc/cracking_crystal.ogg', 45, TRUE)

	available_dirs -= dir_to_remove

	var/turf/our_turf = get_turf(src)

	if(our_turf)
		our_turf.opacity = FALSE

	// Ideally this'd be part of the SM component, but the SM itself snowflakes bullets (emitters are bullets).
	RegisterSignal(src, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(eat_bullets))

/obj/crystal_mass/process()

	if(!COOLDOWN_FINISHED(src, sm_wall_cooldown))
		return

	if(!available_dirs || available_dirs.len <= 0)
		return PROCESS_KILL

	COOLDOWN_START(src, sm_wall_cooldown, rand(0, 3 SECONDS))

	var/picked_dir = pick_n_take(available_dirs)
	var/turf/next_turf = get_step_multiz(src, picked_dir)

	icon_state = "crystal_cascade_[rand(1,6)]"

	if(!next_turf || locate(/obj/crystal_mass) in next_turf)
		return

	for(var/atom/movable/checked_atom as anything in next_turf)
		if(isliving(checked_atom))
			sm_comp.dust_mob(src, checked_atom, span_danger("[src] 扑向 [checked_atom]，碰触了对方…… \
					对方的身体开始闪耀出刺目的光芒，随后由内而外结晶，并融入 [src]！"),
				span_userdanger("晶体团块扑向你，正中你的胸口。当致盲的白光充满你的视野时，你心里想：“该死。”"))
		else if(istype(checked_atom, /obj/cascade_portal))
			checked_atom.visible_message(span_userdanger("\The [checked_atom] 发出一声尖啸，在被 \a [src] 击中时闭合消失！太迟了！"))
			playsound(get_turf(checked_atom), 'sound/effects/magic/charge.ogg', 50, TRUE)
			playsound(get_turf(checked_atom), 'sound/effects/supermatter.ogg', 50, TRUE)
			qdel(checked_atom)
		else if(isitem(checked_atom))
			playsound(get_turf(checked_atom), 'sound/effects/supermatter.ogg', 50, TRUE)
			qdel(checked_atom)

	new /obj/crystal_mass(next_turf, get_dir(next_turf, src))

/obj/crystal_mass/proc/eat_bullets(datum/source, obj/projectile/hitting_projectile)
	SIGNAL_HANDLER

	visible_message(
		span_warning("[hitting_projectile] 伴随着一声巨响撞入 [src]，随即迅速闪成灰烬。"),
		null,
		span_hear("你听到一声巨响，同时被一阵热浪席卷。"),
	)

	playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	qdel(hitting_projectile)
	return COMPONENT_BULLET_BLOCKED

/obj/crystal_mass/singularity_act()
	return

/obj/crystal_mass/attack_tk(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/jedi = user
	to_chat(jedi, span_userdanger("这主意真是太有分量了。"))
	jedi.ghostize()
	var/obj/item/organ/brain/rip_u = locate(/obj/item/organ/brain) in jedi.organs
	if(rip_u)
		rip_u.Remove(jedi)
		qdel(rip_u)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/crystal_mass/Destroy()
	STOP_PROCESSING(SSsupermatter_cascade, src)
	sm_comp = null
	return ..()

/obj/cascade_portal
	name = "蓝空间裂隙"
	desc = "当你的头脑试图理解眼前之物时，它开始天旋地转。"
	icon = 'icons/effects/224x224.dmi'
	icon_state = "reality"
	anchored = TRUE
	appearance_flags = LONG_GLIDE
	density = TRUE
	plane = MASSIVE_OBJ_PLANE
	light_color = COLOR_RED
	light_power = 0.7
	light_range = 15
	move_resist = INFINITY
	pixel_x = -96
	pixel_y = -96
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/cascade_portal/Initialize(mapload)
	. = ..()
	var/turf/location = get_turf(src)
	var/area_name = get_area_name(src)
	message_admins("出口裂隙已在 [area_name] 生成。[ADMIN_VERBOSEJMP(location)]")
	log_game("蓝空间出口裂隙已在 [area_name] 生成。")
	investigate_log("已在 [area_name] 生成。", INVESTIGATE_ENGINE)

/obj/cascade_portal/Destroy(force)
	var/turf/location = get_turf(src)
	var/area_name = get_area_name(src)
	message_admins("位于 [area_name] 的出口裂隙已删除。[ADMIN_VERBOSEJMP(location)]")
	log_game("位于 [area_name] 的蓝空间出口裂隙已被删除。")
	investigate_log("已被删除。", INVESTIGATE_ENGINE)
	return ..()

/obj/cascade_portal/Bumped(atom/movable/hit_object)
	consume(hit_object)
	new /obj/effect/particle_effect/sparks(loc)
	playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/**
 * Proc to consume the objects colliding with the portal
 *
 * Arguments: atom/movable/consumed_object is the object hitting the portal
 */
/obj/cascade_portal/proc/consume(atom/movable/consumed_object)
	if(isliving(consumed_object))
		consumed_object.visible_message(span_danger("\The [consumed_object] 走入了 \the [src]…… \
			一阵刺目的光芒笼罩了其身体，随后彻底消失！"),
			span_userdanger("你走入了 \the [src]，一股强大的蓝色光芒冲刷着你的身体。 \
				你还来不及反思这个决定，就已经脸朝下摔在冰冷坚硬的地板上。"),
			span_hear("你听到一声巨响，同时一阵扭曲掠过你身边。"))

		var/list/arrival_turfs = get_area_turfs(/area/centcom/central_command_areas/evacuation)
		var/turf/arrival_turf
		do
			arrival_turf = pick_n_take(arrival_turfs)
		while(!is_safe_turf(arrival_turf))

		var/mob/living/consumed_mob = consumed_object
		message_admins("[key_name_admin(consumed_mob)] 进入了 [src] [ADMIN_VERBOSEJMP(src)]。")
		investigate_log("被 [key_name(consumed_mob)] 进入。", INVESTIGATE_ENGINE)
		consumed_mob.forceMove(arrival_turf)
		consumed_mob.Paralyze(100)
		consumed_mob.adjust_brute_loss(30)
		consumed_mob.flash_act(1, TRUE, TRUE)

		new /obj/effect/particle_effect/sparks(consumed_object)
		playsound(consumed_object, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	else if(isitem(consumed_object))
		consumed_object.visible_message(span_danger("\The [consumed_object] 撞上 \the [src]，随即消失不见。"), null,
			span_hear("你听到一声巨响，同时一阵微小的扭曲掠过你身边。"))

		qdel(consumed_object)
