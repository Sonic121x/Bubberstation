#define BLOB_REROLL_RADIUS 60

/** Simple price check */
/mob/eye/blob/proc/can_buy(cost = 15)
	if(blob_points < cost)
		to_chat(src, span_warning("你买不起这个，至少需要 [cost] 点资源！"))
		balloon_alert(src, "还需要 [cost-blob_points] 点资源！")
		return FALSE
	add_points(-cost)
	return TRUE

/** Places the core itself */
/mob/eye/blob/proc/place_blob_core(placement_override = BLOB_NORMAL_PLACEMENT, pop_override = FALSE)
	if(placed && placement_override != BLOB_FORCE_PLACEMENT)
		return

	if(placement_override == BLOB_NORMAL_PLACEMENT)
		if(!pop_override && !check_core_visibility())
			return
		var/turf/placement = get_turf(src)
		if(placement.density)
			to_chat(src, span_warning("此处过于拥挤，无法放置变形菌核心！"))
			return
		if(!is_valid_turf(placement))
			to_chat(src, span_warning("你不能在这里放置核心！"))
			return
		if(!check_objects_tile(placement))
			return
		if(!pop_override && world.time <= manualplace_min_time && world.time <= autoplace_max_time)
			to_chat(src, span_warning("现在放置变形菌核心还太早！"))
			return
	else
		if(placement_override == BLOB_RANDOM_PLACEMENT)
			var/turf/force_tile = pick(GLOB.blobstart)
			forceMove(force_tile) //got overrided? you're somewhere random, motherfucker

	if(placed && blob_core)
		blob_core.forceMove(loc)
	else
		var/obj/structure/blob/special/core/core = new(get_turf(src), src, 1)
		core.overmind = src
		blobs_legit += src
		blob_core = core
		core.update_appearance()

	update_health_hud()
	placed = TRUE
	announcement_time = world.time + OVERMIND_ANNOUNCEMENT_MAX_TIME

/** Checks proximity for mobs */
/mob/eye/blob/proc/check_core_visibility()
	for(var/mob/living/player in range(7, src))
		if(player.has_faction(ROLE_BLOB))
			continue
		if(player.client)
			to_chat(src, span_warning("有人离得太近，无法放置变形菌核心！"))
			return FALSE

	for(var/mob/living/player in view(13, src))
		if(player.has_faction(ROLE_BLOB))
			continue
		if(player.client)
			to_chat(src, span_warning("有人能从这儿看到你的变形菌核心！"))
			return FALSE

	return TRUE


/** Checks for previous blobs or denose objects on the tile. */
/mob/eye/blob/proc/check_objects_tile(turf/placement)
	for(var/obj/object in placement)
		if(istype(object, /obj/structure/blob))
			if(istype(object, /obj/structure/blob/normal))
				qdel(object)
			else
				to_chat(src, span_warning("这里已经有变形菌了！"))
				return FALSE
		else
			if(object.density)
				to_chat(src, span_warning("此处过于拥挤，无法放置变形菌核心！"))
				return FALSE

	return TRUE

/** Moves the core elsewhere. */
/mob/eye/blob/proc/transport_core()
	if(blob_core)
		forceMove(blob_core.drop_location())

/** Jumps to a node */
/mob/eye/blob/proc/jump_to_node()
	if(!length(GLOB.blob_nodes))
		return

	var/list/nodes = list()
	for(var/index in 1 to length(GLOB.blob_nodes))
		var/obj/structure/blob/special/node/blob = GLOB.blob_nodes[index]
		nodes["变形菌节点 #[index]（[get_area_name(blob)]）"] = blob

	var/node_name = tgui_input_list(src, "选择要跳转到的节点", "节点跳跃", nodes)
	if(isnull(node_name) || isnull(nodes[node_name]))
		return

	var/obj/structure/blob/special/node/chosen_node = nodes[node_name]
	if(chosen_node)
		forceMove(chosen_node.loc)

/** Places important blob structures */
/mob/eye/blob/proc/create_special(price, blobstrain, min_separation, needs_node, turf/tile)
	if(!tile)
		tile = get_turf(src)
	var/obj/structure/blob/blob = (locate(/obj/structure/blob) in tile)
	if(!blob)
		to_chat(src, span_warning("这里没有变形菌！"))
		balloon_alert(src, "这里没有变形菌！")
		return
	if(!istype(blob, /obj/structure/blob/normal))
		to_chat(src, span_warning("无法使用这个变形菌，请找一个普通的。"))
		balloon_alert(src, "需要普通的变形菌！")
		return
	if(needs_node)
		var/area/area = get_area(src)
		if(!(area.area_flags & BLOBS_ALLOWED)) //factory and resource blobs must be legit
			to_chat(src, span_warning("这种变形菌必须放置在空间站上！"))
			balloon_alert(src, "无法在站外放置！")
			return
		if(nodes_required && !(locate(/obj/structure/blob/special/node) in orange(BLOB_NODE_PULSE_RANGE, tile)) && !(locate(/obj/structure/blob/special/core) in orange(BLOB_CORE_PULSE_RANGE, tile)))
			to_chat(src, span_warning("你需要把这个变形菌放得离节点或核心更近！"))
			balloon_alert(src, "离节点或核心太远了！")
			return
	if(min_separation)
		for(var/obj/structure/blob/other_blob in orange(min_separation, tile))
			if(other_blob.type == blobstrain)
				to_chat(src, span_warning("附近已有相似的变形菌，请离它 [min_separation] 格以上！"))
				other_blob.balloon_alert(src, "太近了！")
				return
	if(!can_buy(price))
		return

	return blob.change_to(blobstrain, src)

/** Toggles requiring nodes */
/mob/eye/blob/proc/toggle_node_req()
	nodes_required = !nodes_required
	if(nodes_required)
		to_chat(src, span_warning("你现在需要附近有节点或核心才能放置工厂变形菌和资源变形菌。"))
	else
		to_chat(src, span_warning("你现在不再需要附近有节点或核心就能放置工厂变形菌和资源变形菌。"))

/** Creates a shield to reflect projectiles */
/mob/eye/blob/proc/create_shield(turf/tile)
	var/obj/structure/blob/shield/shield = locate(/obj/structure/blob/shield) in tile
	if(!shield)
		shield = create_special(BLOB_UPGRADE_STRONG_COST, /obj/structure/blob/shield, 0, FALSE, tile)
		shield?.balloon_alert(src, "已升级为[shield.name]！")
		return

	if(istype(shield, /obj/structure/blob/shield/reflective))
		to_chat(src, span_warning("这个护盾变形菌已经达到你能做到的极限坚固程度了！"))
		return

	if(shield.get_integrity() < shield.max_integrity * 0.5)
		to_chat(src, span_warning("这个护盾变形菌受损过重，无法正常改造！"))
		return

	if(!can_buy(BLOB_UPGRADE_REFLECTOR_COST))
		return

	to_chat(src, span_warning("你在护盾变形菌上分泌出一层反射黏液，使它能够反射弹射物，但代价是对爆炸的抗性降低。"))
	shield = shield.change_to(/obj/structure/blob/shield/reflective, src)
	shield.balloon_alert(src, "已升级为[shield.name]！")

/** Preliminary check before polling ghosts. */
/mob/eye/blob/proc/create_blobbernaut()
	var/turf/current_turf = get_turf(src)
	var/obj/structure/blob/special/factory/factory = locate(/obj/structure/blob/special/factory) in current_turf
	if(!factory)
		to_chat(src, span_warning("你必须位于工厂变形菌上！"))
		return
	if(factory.blobbernaut || factory.is_creating_blobbernaut) //if it already made or making a blobbernaut, it can't do it again
		to_chat(src, span_warning("这个工厂变形菌已经在维持一只变形菌巨兽了。"))
		return
	if(factory.get_integrity() < factory.max_integrity * 0.5)
		to_chat(src, span_warning("这个工厂变形菌受损过重，无法维持变形菌巨兽。"))
		return
	if(!can_buy(BLOBMOB_BLOBBERNAUT_RESOURCE_COST))
		return

	factory.is_creating_blobbernaut = TRUE
	to_chat(src, span_notice("你尝试生产一只变形菌巨兽。"))
	pick_blobbernaut_candidate(factory)

/// Polls ghosts to get a blobbernaut candidate.
/mob/eye/blob/proc/pick_blobbernaut_candidate(obj/structure/blob/special/factory/factory)
	if(isnull(factory))
		return
	var/icon/blobbernaut_icon = icon(icon, "blobbernaut")
	blobbernaut_icon.Blend(blobstrain.color, ICON_MULTIPLY)
	var/image/blobbernaut_image = image(blobbernaut_icon)
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target(
		check_jobban = ROLE_BLOB,
		poll_time = 20 SECONDS,
		checked_target = factory,
		ignore_category = POLL_IGNORE_BLOB,
		alert_pic = blobbernaut_image,
		jump_target = factory,
		role_name_text = "变形菌巨兽",
		chat_text_border_icon = blobbernaut_image,
	)
	on_poll_concluded(factory, chosen_one)

/// Called when the ghost poll concludes
/mob/eye/blob/proc/on_poll_concluded(obj/structure/blob/special/factory/factory, mob/dead/observer/ghost)
	if(isnull(ghost))
		to_chat(src, span_warning("你没能为你的变形菌巨兽召来意识。你的点数已退还。请稍后再试。"))
		add_points(BLOBMOB_BLOBBERNAUT_RESOURCE_COST)
		factory.assign_blobbernaut(null)
		return

	var/mob_type = /mob/living/basic/blob_minion/blobbernaut/minion
	var/mob/living/basic/blob_minion/blobbernaut/minion/blobber = new mob_type(get_turf(factory), blob_borne = TRUE)
	blobber.AddComponent(/datum/component/blob_minion, new_overmind = src, new_death_cloud_size = blobber.death_cloud_size)
	factory.assign_blobbernaut(blobber)
	blobber.assign_key(ghost.key, blobstrain)

/** Moves the core */
/mob/eye/blob/proc/relocate_core()
	var/turf/tile = get_turf(src)
	var/obj/structure/blob/special/node/blob = locate(/obj/structure/blob/special/node) in tile

	if(!blob)
		to_chat(src, span_warning("你必须位于变形菌节点上！"))
		return

	if(!blob_core)
		to_chat(src, span_userdanger("你没有核心，即将死亡！愿你安息。"))
		return

	var/area/area = get_area(tile)
	if(isspaceturf(tile) || area && !(area.area_flags & BLOBS_ALLOWED))
		to_chat(src, span_warning("你不能把核心迁移到这里！"))
		return

	if(!can_buy(BLOB_POWER_RELOCATE_COST))
		return

	var/turf/old_turf = get_turf(blob_core)
	var/old_dir = blob_core.dir
	blob_core.forceMove(tile)
	blob_core.setDir(blob.dir)
	blob.forceMove(old_turf)
	blob.setDir(old_dir)

/** Searches the tile for a blob and removes it. */
/mob/eye/blob/proc/remove_blob(turf/tile)
	var/obj/structure/blob/blob = locate() in tile

	if(!blob)
		to_chat(src, span_warning("那里没有变形菌！"))
		return

	if(blob.point_return < 0)
		to_chat(src, span_warning("无法移除这个变形菌。"))
		return

	if(max_blob_points < blob.point_return + blob_points)
		to_chat(src, span_warning("你的资源太多，无法移除这个变形菌！"))
		return

	if(blob.point_return)
		add_points(blob.point_return)
		to_chat(src, span_notice("从移除[blob]中获得 [blob.point_return] 点资源。"))
		blob.balloon_alert(src, "+[blob.point_return] 点资源")

	qdel(blob)

/** Expands to nearby tiles */
/mob/eye/blob/proc/expand_blob(turf/tile)
	if(world.time < last_attack)
		return
	var/list/possible_blobs = list()

	for(var/obj/structure/blob/blob in range(tile, 1))
		possible_blobs += blob

	if(!length(possible_blobs))
		to_chat(src, span_warning("目标格子旁边没有变形菌！"))
		return

	if(!can_buy(BLOB_EXPAND_COST))
		return

	var/attack_success
	for(var/mob/living/player in tile)
		if(!player.can_blob_attack())
			continue
		if(player.has_faction(ROLE_BLOB)) //no friendly/dead fire
			continue
		if(player.stat != DEAD)
			attack_success = TRUE
		blobstrain.attack_living(player, possible_blobs)

	var/obj/structure/blob/blob = locate() in tile

	if(blob)
		if(attack_success) //if we successfully attacked a turf with a blob on it, only give an attack refund
			blob.blob_attack_animation(tile, src)
			add_points(BLOB_ATTACK_REFUND)
		else
			to_chat(src, span_warning("那里已经有变形菌了！"))
			add_points(BLOB_EXPAND_COST) //otherwise, refund all of the cost
	else
		directional_attack(tile, possible_blobs, attack_success)

	if(attack_success)
		last_attack = world.time + CLICK_CD_MELEE
	else
		last_attack = world.time + CLICK_CD_RAPID


/** Finds cardinal and diagonal attack directions */
/mob/eye/blob/proc/directional_attack(turf/tile, list/possible_blobs, attack_success = FALSE)
	var/list/cardinal_blobs = list()
	var/list/diagonal_blobs = list()

	for(var/obj/structure/blob/blob in possible_blobs)
		if(get_dir(blob, tile) in GLOB.cardinals)
			cardinal_blobs += blob
		else
			diagonal_blobs += blob

	var/obj/structure/blob/attacker
	if(length(cardinal_blobs))
		attacker = pick(cardinal_blobs)
		if(!attacker.expand(tile, src))
			add_points(BLOB_ATTACK_REFUND) //assume it's attacked SOMETHING, possibly a structure
	else
		attacker = pick(diagonal_blobs)
		if(attack_success)
			attacker.blob_attack_animation(tile, src)
			playsound(attacker, 'sound/effects/splat.ogg', 50, TRUE)
			add_points(BLOB_ATTACK_REFUND)
		else
			add_points(BLOB_EXPAND_COST) //if we're attacking diagonally and didn't hit anything, refund
	return

/** Rally spores to a location */
/mob/eye/blob/proc/rally_spores(turf/tile)
	to_chat(src, "你召集了你的孢子。")
	var/list/surrounding_turfs = TURF_NEIGHBORS(tile)
	if(!length(surrounding_turfs))
		return
	for(var/mob/living/basic/blob_mob as anything in blob_mobs)
		if(!isturf(blob_mob.loc) || get_dist(blob_mob, tile) > 35 || blob_mob.key)
			continue
		blob_mob.ai_controller.clear_blackboard_key(BB_CURRENT_TARGET)
		blob_mob.ai_controller.set_blackboard_key(BB_TRAVEL_DESTINATION, pick(surrounding_turfs))

/** Opens the reroll menu to change strains */
/mob/eye/blob/proc/strain_reroll()
	if (!free_strain_rerolls && blob_points < BLOB_POWER_REROLL_COST)
		to_chat(src, span_warning("你至少需要 [BLOB_POWER_REROLL_COST] 点资源才能再次重掷菌株！"))
		return

	open_reroll_menu()

/** Controls changing strains */
/mob/eye/blob/proc/open_reroll_menu()
	if (!strain_choices)
		strain_choices = list()

		var/list/new_strains = GLOB.valid_blobstrains.Copy() - blobstrain.type
		for (var/unused in 1 to BLOB_POWER_REROLL_CHOICES)
			var/datum/blobstrain/strain = pick_n_take(new_strains)

			var/image/strain_icon = image('icons/mob/nonhuman-player/blob.dmi', "blob_core")
			strain_icon.color = initial(strain.color)

			var/info_text = span_boldnotice("[initial(strain.name)]")
			info_text += "<br>[span_notice("[initial(strain.analyzerdescdamage)]")]"
			if (!isnull(initial(strain.analyzerdesceffect)))
				info_text += "<br>[span_notice("[initial(strain.analyzerdesceffect)]")]"

			//BUBBERSATION CHANGE START: INSTANT ALERT WARNING
			if(initial(strain.instant_alert_on_change))
				info_text += "<br>[span_danger("警告：将菌株切换为此项会立即让所有人注意到你的存在！")]"
			//BUBBERSTATION CHANGE END: INSTANT ALERT WARNING

			var/datum/radial_menu_choice/choice = new
			choice.image = strain_icon
			choice.info = info_text

			strain_choices[initial(strain.name)] = choice

	var/strain_result = show_radial_menu(src, src, strain_choices, radius = BLOB_REROLL_RADIUS, tooltips = TRUE)
	if (isnull(strain_result))
		return

	/* BUBBERSTATION CHANGE START: REFACTORS THIS.
	if (!free_strain_rerolls && !can_buy(BLOB_POWER_REROLL_COST))
		return
	BUBBERSTATION CHANGE END: REFACTORS THIS. */

	//Below code has basically been bubberstation refactored. Too many changes to make even semi-modular.
	for (var/_other_strain in GLOB.valid_blobstrains)
		var/datum/blobstrain/other_strain = _other_strain
		if (initial(other_strain.name) == strain_result)

			if(!has_announced && initial(other_strain.instant_alert_on_change) && tgui_alert(src, "选择此菌株会让全体船员知道你的存在。你确定要继续吗？","*注意到你的菌株*", list("Yes","No")) != "Yes")
				return

			if(free_strain_rerolls)
				free_strain_rerolls -= 1
			else if(!can_buy(BLOB_POWER_REROLL_COST))
				return

			set_strain(other_strain)
// BUBBER REFACTOR END
			last_reroll_time = world.time
			strain_choices = null

			return

#undef BLOB_REROLL_RADIUS
