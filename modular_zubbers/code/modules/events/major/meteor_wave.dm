GLOBAL_LIST_INIT(meteors_candy_halloween, list(
	/obj/effect/meteor/candy/party_popper = 6,
	/obj/effect/meteor/candy/pumpkin = 16,
	/obj/effect/meteor/candy/pumpking = 6,
	/obj/effect/meteor/candy/corgi = 6,
	/obj/effect/meteor/candy/syndie = 1,
	/obj/effect/meteor/candy/bluespace = 2,
	/obj/effect/meteor/candy/banana = 2,
))

/datum/round_event/meteor_wave
	/// Time we give before the wave for cargo to order / engineering to set up meteor shields
	var/warning_time = 210 EVENT_SECONDS
	/// Number of SSevent ticks for the wave to last (TG original: 60)
	var/wave_duration = 45
	/// Prefix for the announcement
	var/announce_prefix = "陨石警报"
	/// Description for the announcement
	var/announce_desc = "陨石"
	/// Added to the announcement giving a preview of the wave intensity
	var/announce_fluff = "建议船员前往空间站中央区域躲避。"

/datum/round_event/meteor_wave/threatening
	warning_time = 420 EVENT_SECONDS // smoke a joint and start your mindless repairs
	announce_fluff = "货运部可采购便携式护盾发生器。请确保所有敏感区域与设备均受到护盾保护。"

/datum/round_event/meteor_wave/catastrophic
	warning_time = 420 EVENT_SECONDS
	announce_fluff = "货运部可采购便携式护盾发生器。请确保所有敏感区域与设备均受到护盾保护。"

/datum/round_event/meteor_wave/dust_storm
	warning_time = 6 EVENT_SECONDS

/datum/round_event/meteor_wave/meaty
	announce_prefix = "糟糕，快拿拖把。"
	announce_desc = "肉矿石"
	announce_fluff = "请勿食用太空肉。我们知道这很诱人，但现在不是考验烹饪好奇心的时候。"

/datum/round_event/meteor_wave/candy
	wave_name = "candy"
	announce_prefix = "超恐怖快递来袭"
	announce_desc = "恐怖包裹"
	announce_fluff = "如果你试图把碎片塞进嘴里，后果自负。我们为什么非得提醒你这种事？"

/datum/round_event/meteor_wave/New()
	. = ..()
	start_when = rand(warning_time, warning_time * 1.5)
	end_when = start_when + rand(wave_duration, wave_duration * 1.5)

/datum/round_event/meteor_wave/determine_wave_type()
	if(!wave_name)
		wave_name = pick_weight(list(
			"normal" = 50,
			"threatening" = 40,
			"catastrophic" = 10))

	if(check_holidays(HALLOWEEN))
		if(prob(50))
			wave_name = "candy"
			wave_type = GLOB.meteors_candy_halloween
			warning_time = /datum/round_event/meteor_wave/candy::warning_time
			announce_prefix = /datum/round_event/meteor_wave/candy::announce_prefix
			announce_desc = /datum/round_event/meteor_wave/candy::announce_desc
			announce_fluff = /datum/round_event/meteor_wave/candy::announce_fluff
			return

	switch(wave_name)
		if("normal")
			wave_type = GLOB.meteors_normal
		if("threatening")
			wave_type = GLOB.meteors_threatening
		if("catastrophic")
			if(check_holidays(HALLOWEEN))
				wave_type = GLOB.meteorsSPOOKY
			else
				wave_type = GLOB.meteors_catastrophic
		if("meaty")
			wave_type = GLOB.meateors
		if("space dust")
			wave_type = GLOB.meteors_dust
		if("halloween")
			wave_type = GLOB.meteorsSPOOKY
		if("candy")
			wave_type = GLOB.meteors_candy_halloween
		else
			stack_trace("Wave name of [wave_name] not recognised.")
			kill()

/datum/round_event/meteor_wave/announce(fake)
	priority_announce(
			text = "检测到[announce_desc]正处于与空间站相撞的航线上。能量场发生器已关闭或缺失。首次撞击约在[DisplayTimeText(start_when * 20, 10)]后。[announce_fluff]",
			title = announce_prefix,
			sound = ANNOUNCER_METEORWARNING,
		)

	if(fake)
		return

	if(warning_time > /datum/round_event/meteor_wave::warning_time)
		addtimer(CALLBACK(src, PROC_REF(meteor_reminder)), ((start_when * 20) - 15 SECONDS))

/datum/round_event/meteor_wave/proc/meteor_reminder()
	SSsecurity_level.minimum_security_level(min_level = SEC_LEVEL_ORANGE, eng_access = TRUE, maint_access = FALSE)
	priority_announce(
			text = "[announce_desc]正在接近，请做好撞击准备。远程扫描仪显示大量陨石正在逼近，那种撞击会让你重新审视自己的人生选择。所以，抓紧了，尽量别撞上什么太重要的东西。",
			title = announce_prefix,
			sound = 'sound/items/radio/radio_important.ogg', // basically silent, since the securitylevel proc will make a sound
			sender_override = "[command_name()] 工程部",
			color_override = "orange",
		)

/datum/round_event_control/meteor_wave/candy
	name = "陨石波：糖果"
	typepath = /datum/round_event/meteor_wave/candy
	weight = 0
	description = "节日专属的陨石波，满是糖果。"

/obj/effect/meteor
	lifetime = 45 SECONDS

/obj/effect/meteor/candy
	name = "调试用糖果陨石"
	desc = "如果你看到这个，请把一根奶油夹心棒塞进离你最近的程序员嘴里"
	dropamt = 8
	meteordrop = list(
		/obj/item/food/candy/hundred_credit_bar,
		/obj/item/food/candy/coconut_joy,
		/obj/item/food/candy/hurr_bar,
		/obj/item/food/candy/laughter_bar,
		/obj/item/food/candy/kit_catgirl_metaclique_bar,
		/obj/item/food/candy/twink_bar,
		/obj/item/food/candy/malf_way,
		/obj/item/food/candy/triggerfinger,
		/obj/item/food/sosjerky,
		/obj/item/food/syndicake,
		/obj/item/food/energybar,
		/obj/item/food/cnds/random,
		/obj/item/food/cornchips,
		/obj/item/food/shok_roks/random,
		/obj/item/food/cookie/sugar/spookyskull,
		/obj/item/food/cookie/sugar/spookycoffin,
		/obj/item/food/candy_corn,
	)

/obj/effect/meteor/candy/get_hit()
	hits--
	if(hits <= 0)
		meteor_effect()
		candy_effect()
		qdel(src)

/obj/effect/meteor/candy/proc/candy_effect()
	var/list/scatter_locations = list()
	var/turf/my_turf = get_turf(src)
	for(var/turf/turf_in_view in view(2, my_turf))
		if(isclosedturf(turf_in_view))
			continue

		scatter_locations += turf_in_view

	for(var/throws = dropamt, throws > 0, throws--)
		var/thing_to_spawn = pick(meteordrop)
		var/turf/spawn_loc = pick(scatter_locations)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(make_fluff_debris), thing_to_spawn, spawn_loc), 1 SECONDS);

/proc/make_fluff_debris(type_to_make, location)
	new type_to_make(location)
	new /obj/effect/decal/cleanable/confetti(location)

/obj/effect/meteor/candy/ram_turf(turf/rammed_turf)
	if(!isspaceturf(rammed_turf))
		new /obj/effect/decal/cleanable/confetti(rammed_turf)

/obj/effect/meteor/candy/pumpkin
	name = "猫灯南瓜"
	desc = "装满糖果的南瓜形陨石。有点吓人。"
	icon_state = "spooky"
	threat = 5

/obj/effect/meteor/candy/pumpkin/meteor_effect()
	..()
	explosion(src, heavy_impact_range = 1, light_impact_range = 2, flash_range = 3, adminlog = FALSE)

/obj/effect/meteor/candy/pumpking
	name = "南瓜王"
	desc = "南瓜王来了！"
	icon_state = "spooky"
	hits = 6
	heavy = TRUE
	dropamt = 9
	threat = 10

/obj/effect/meteor/candy/pumpking/Initialize(mapload)
	. = ..()
	src.transform *= 2
	meteorsound = pick('sound/effects/hallucinations/im_here1.ogg', 'sound/effects/hallucinations/im_here2.ogg')

/obj/effect/meteor/candy/pumpking/meteor_effect()
	..()
	explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 3, flash_range = 4, adminlog = FALSE)

/obj/effect/meteor/candy/party_popper
	name = "派对拉炮"
	desc = "用于庆祝和惹恼清洁工的小装置。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "party_popper"
	pass_flags = PASSTABLE | PASSGRILLE
	hitpwr = EXPLODE_LIGHT
	hits = 3
	threat = 4
	meteorsound = 'sound/effects/snap.ogg'

/obj/effect/meteor/candy/party_popper/meteor_effect()
	..()
	new /obj/item/reagent_containers/spray/chemsprayer/party(get_turf(src))

/obj/effect/meteor/candy/corgi
	name = "柯基皮纳塔"
	desc = "到底是谁觉得从狗身上打出糖果是件好玩的事？"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "pinata"
	threat = 5

/obj/effect/meteor/candy/corgi/meteor_effect()
	..()
	explosion(src, heavy_impact_range = 1, light_impact_range = 2, flash_range = 3, adminlog = FALSE)

/obj/effect/meteor/candy/syndie
	name = "辛迪加皮纳塔"
	desc = "红色的跑得更快……现在你知道为什么了。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "pinata_syndie"
	hits = 12
	heavy = TRUE
	threat = 30
	meteordrop = list(/obj/item/reagent_containers/cocaine)
	meteorsound = 'sound/effects/bamf.ogg'
	var/package_count = 8

/obj/effect/meteor/candy/syndie/meteor_effect()
	..()
	var/start_turf = get_turf(src)

	while(package_count > 0)
		var/startSide = pick(GLOB.cardinals)
		var/turf/destination = spaceDebrisStartLoc(startSide, z)
		new /obj/effect/meteor/cluster_fragment(start_turf, destination)
		package_count--

	explosion(src, heavy_impact_range = 2, light_impact_range = 3, flash_range = 4, adminlog = FALSE)

/obj/effect/meteor/cocaine_brick
	name = "可卡因砖碎片"
	desc = "高速飞行的碎片，来自爆炸的……白色粉末。"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocainebrick"
	dropamt = 7
	meteordrop = list(/obj/item/reagent_containers/cocaine)
	meteorsound = 'sound/effects/bamf.ogg'

/obj/effect/meteor/candy/bluespace
	name = "蓝空间团块"
	desc = "一块核心含有蓝空间尘埃的巨大晶洞，正疾驰穿过太空。这正是船员们要研究的东西。对他们来说可真方便。"
	icon_state = "bluespace"
	dropamt = 9
	hits = 12
	threat = 12
	signature = "蓝空间通量"

/obj/effect/meteor/candy/bluespace/Bump()
	..()
	if(prob(35))
		do_teleport(src, get_turf(src), 6, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/effect/meteor/candy/banana
	name = "香蕉矿团块"
	desc = "也许是从传说中的小丑星球上炸下来的一块……真烦人。"
	icon_state = "bananium"
	dropamt = 9
	hits = 175 //Honks everything, including space tiles. Depending on the angle/how much stuff it hits, there's a fair chance that it will spare the station from the actual explosion
	meteordrop = list(/obj/item/stack/ore/bananium)
	meteorsound = 'sound/items/bikehorn.ogg'
	threat = 15
	movement_type = PHASING
	signature = "喜剧"

/obj/effect/meteor/candy/banana/meteor_effect()
	..()
	playsound(src, 'sound/items/airhorn/AirHorn.ogg', 100, TRUE, -1)
	for(var/atom/movable/object in view(4, get_turf(src)))
		var/turf/throwtarget = get_edge_target_turf(get_turf(src), get_dir(get_turf(src), get_step_away(object, get_turf(src))))
		object.safe_throw_at(throwtarget, 5, 1, force = MOVE_FORCE_STRONG)

/obj/effect/meteor/banana/ram_turf(turf/bumped)
	for(var/mob/living/slipped in get_turf(bumped))
		slipped.slip(100, slipped.loc,- GALOSHES_DONT_HELP|SLIDE, 0, FALSE)
		slipped.visible_message(span_warning("[src]把[slipped]鸣笛滑倒在地！"), span_userdanger("[src]无害地穿过你，把你撞倒了。"))
	get_hit()
