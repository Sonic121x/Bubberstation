/datum/lazy_template/reebe
	key = LAZY_TEMPLATE_KEY_OUTPOST_OF_COGS
	map_dir = "_maps/skyrat/lazy_templates"
	map_name = "reebe"


/// Spawn reebe with the appropriate fanfare after sacrificing a blood cultist
/proc/spawn_reebe(atom/target_atom)
	set waitfor = FALSE

	var/static/reebe_began_spawning = FALSE

	if(reebe_began_spawning)
		return

	reebe_began_spawning = TRUE

	var/turf/atom_turf = get_turf(target_atom) // Protection in case this gets deleted
	var/area/atom_area = get_area(target_atom)

	sleep(2 SECONDS)

	send_clock_message(null, "<b>随着纳尔西的一名异教徒被汲取殆尽，我们现在可以开启通往齿轮之城——受祝福的里比圣所——的传送门了！只需再等一小会儿……</b>", "<span class='brass'>")

	sleep(5 SECONDS)

	SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_OUTPOST_OF_COGS)

	for(var/mob/target as anything in GLOB.player_list)
		if(!isnewplayer(target) && !HAS_TRAIT(target, TRAIT_DEAF) && is_station_level(target.z))
			to_chat(target, span_brass("你听到远处传来模糊的齿轮碰撞声……"))

	sleep(7 SECONDS)

	if(!atom_turf)
		atom_turf = get_safe_random_station_turf()

	var/obj/effect/portal/permanent/one_way/reebe/clock_only/portal = new(atom_turf)

	sleep(1 SECONDS)

	if(!atom_area)
		atom_area = get_area(atom_turf)

	send_clock_message(null, "[atom_area] 处已开启一道通往我们圣城的传送门，这是以拉特瓦之名值得荣耀的一天。", "<span class='bigbrass'>", msg_ghosts = FALSE)
	notify_ghosts("[atom_area] 处已开启一道通往我们圣城的传送门，这是以拉特瓦之名值得荣耀的一天。",
		source = atom_area,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
		header = "通往里比的传送门",
	)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(reebe_station_warning), atom_area, portal), 5 MINUTES)


/// Tells the station that there's a clockie portal, along with making it usable by all
/proc/reebe_station_warning(area/atom_area, obj/effect/portal/permanent/one_way/reebe/clock_only/portal)
	if(!portal)
		return

	send_clock_message(null, "传送门的稳定性正在下降！很快，不忠于拉特瓦的人也能进入，并会有更多裂隙开启！", "<span class='brass'>")

	sleep(15 SECONDS)

	if(!portal)
		return

	if(!atom_area)
		atom_area = get_area(portal)

	priority_announce("[atom_area] 处检测到异常读数，请确保附近船员的安全。")

	for(var/obj/effect/landmark/late_cog_portals/late_portal in GLOB.landmarks_list)
		var/obj/effect/landmark/portal_exit/new_exit = new(get_turf(late_portal))
		new_exit.id = "reebe_entry"
		qdel(late_portal)

	portal.visible_message("[portal] 喷出一阵蒸汽，颜色变得更蓝了。你觉得现在进去更安全了。")
	portal.desc += " 现在似乎更容易进去了。"
	new /obj/effect/temp_visual/steam_release(get_turf(portal))
	animate(portal, 3 SECONDS, color = "#326de3")
	portal.clock_only = FALSE



/obj/item/paper/crumpled/ruins/reebe1
	name = "潦草的便条"
	default_raw_text = {"司法官错了。<br>
	这里不是里比。我曾抱有希望，希望拉特瓦的某一部分仍活在这座圣城之中。<br>
	但这里什么都没有，只有一座……前方前哨。还有那些该死的纳尔西走狗！我能感觉到他们正试图进入传送门！"}


/obj/item/paper/crumpled/bloody/reebe2
	name = "潦草的便条"
	default_raw_text = {"异教徒们闯入了这片圣地。<br>
	我们的许多兄弟姐妹在这场战斗中倒下了，只剩我一个。能知道自己又带走了一群纳尔西信徒，我死也甘愿。<br>
	要是那该死的传送门能及时打开就好了……"}


/obj/effect/mob_spawn/corpse/human/blood_cultist
	name = "血教徒"
	outfit = /datum/outfit/blood_cultist


/datum/outfit/blood_cultist
	name = "Blood Cultist"

	uniform = /obj/item/clothing/under/color/black
	suit = /obj/item/clothing/suit/hooded/cultrobes/alt
	shoes = /obj/item/clothing/shoes/cult/alt


/datum/outfit/blood_cultist/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	equipped.eye_color_left = BLOODCULT_EYE
	equipped.eye_color_right = BLOODCULT_EYE
	equipped.update_body()

	var/obj/item/clothing/suit/hooded/hooded = equipped.wear_suit
	var/datum/component/toggle_attached_clothing/hood = hooded.GetComponent(/datum/component/toggle_attached_clothing)
	hood.toggle_deployable() // start unhooded


/obj/effect/mob_spawn/corpse/human/clock_cultist
	name = "发条教徒"
	outfit = /datum/outfit/clock

/obj/effect/mob_spawn/corpse/human/clock_cultist/armored
	name = "披甲发条教徒"
	outfit = /datum/outfit/clock/armor

/obj/effect/mob_spawn/corpse/human/clock_cultist/support
	name = "支援型发条教徒"
	outfit = /datum/outfit/clock/support

/obj/effect/landmark/late_cog_portals
	name = "后期齿轮传送门生成点"
