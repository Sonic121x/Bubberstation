// This contains all boxes that will be used on round-start spawning into a job.

// Ordinary survival box. Every crewmember gets one of these.
/obj/item/storage/box/survival
	name = "生存箱"
	desc = "一个装有保障你与他人生命安全的最基本物资的箱子。"
	icon_state = "internals"
	illustration = "emergencytank"
	/// What type of mask are we going to use for this box?
	var/mask_type = /obj/item/clothing/mask/breath
	/// Which internals tank are we going to use for this box?
	var/internal_type = /obj/item/tank/internals/emergency_oxygen
	/// What medipen should be present in this box?
	var/medipen_type = /obj/item/reagent_containers/hypospray/medipen
	/// Are we crafted?
	var/crafted = FALSE
	/// Should we contain an escape hook on maps with z-levels?
	var/give_hook = TRUE
	/// Do we get to benefit from Nanotrasen's largesse?
	var/give_premium_goods = TRUE

/obj/item/storage/box/survival/create_storage(max_slots, max_specific_storage, max_total_storage, list/canhold, list/canthold, storage_type)
	. = ..()
	if(crafted || !HAS_TRAIT(SSstation, STATION_TRAIT_PREMIUM_INTERNALS))
		return
	atom_storage.max_slots += 2
	atom_storage.max_total_storage += 4
	desc = "一个升级版的生存必需品箱，看来纳米传讯今天比平时更看重你的生命。" // BUBBER EDIT ADDITION
	name = "高级[name]" // BUBBER EDIT CHANGE
	icon_state = "internals_large" // BUBBER EDIT CHANGE - ORIGINAL: [icon_state]_large

/obj/item/storage/box/survival/PopulateContents()
	if(crafted)
		return
	if(!isnull(mask_type))
		new mask_type(src)

	if(!isnull(internal_type))
		new internal_type(src)

	if(!isnull(medipen_type))
		new medipen_type(src)

	if(give_premium_goods && HAS_TRAIT(SSstation, STATION_TRAIT_PREMIUM_INTERNALS))
		new /obj/item/flashlight/flare(src)
		new /obj/item/radio/off(src)

	if(HAS_TRAIT(SSstation, STATION_TRAIT_RADIOACTIVE_NEBULA))
		new /obj/item/storage/pill_bottle/potassiodide(src)

	if(give_hook && length(SSmapping.levels_by_trait(ZTRAIT_STATION)) > 1 && SSmapping.current_map.give_players_hooks)
		new /obj/item/climbing_hook/emergency(src)

	new /obj/item/oxygen_candle(src) //SKYRAT EDIT ADDITION

/obj/item/storage/box/survival/radio/PopulateContents()
	..() // we want the survival stuff too.
	new /obj/item/radio/off(src)

/obj/item/storage/box/survival/proc/apply_overrides()
	if(!ishuman(loc) || QDELING(src))
		return
	var/mob/living/carbon/human/owner = loc
	if(!length(owner.dna.species.survival_box_overrides))
		return
	var/list/items_to_clear = list(
		locate(mask_type) in src,
		locate(internal_type) in src,
		locate(medipen_type) in src,
	)
	QDEL_LIST(items_to_clear)
	var/list/survival_box_overrides = owner.dna.species.survival_box_overrides.Copy()
	for(var/survival_types in survival_box_overrides)
		var/item_to_add = survival_box_overrides[survival_types]
		new item_to_add(src)

// Prisoners don't get an escape hook
/obj/item/storage/box/survival/prisoner
	give_hook = FALSE
	give_premium_goods = FALSE

// Mining survival box
/obj/item/storage/box/survival/mining
	mask_type = /obj/item/clothing/mask/gas/explorer/folded

/obj/item/storage/box/survival/mining/PopulateContents()
	..()
	new /obj/item/crowbar/red(src)
	new /obj/item/healthanalyzer/simple/miner(src)

// Engineer survival box
/obj/item/storage/box/survival/engineer
	name = "扩容生存箱"
	desc = "一个装有保障你与他人生命安全的最基本物资的箱子。这一个标注为配备扩容气罐。"
	illustration = "extendedtank"
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi

/obj/item/storage/box/survival/engineer/radio/PopulateContents()
	..() // we want the regular items too.
	new /obj/item/radio/off(src)

// Syndie survival box
/obj/item/storage/box/survival/syndie
	name = "行动就绪生存箱"
	desc = "一个装有你行动必需品的箱子。这一个标注为配备扩容气罐和一本实用生存指南。"
	icon_state = "syndiebox"
	illustration = "extendedtank"
	mask_type = /obj/item/clothing/mask/gas/syndicate
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi
	medipen_type =  /obj/item/reagent_containers/hypospray/medipen/atropine

/obj/item/storage/box/survival/syndie/PopulateContents()
	..()
	new /obj/item/crowbar/red(src)
	new /obj/item/screwdriver/red(src)
	new /obj/item/weldingtool/mini(src)
	new /obj/item/paper/fluff/operative(src)

/obj/item/storage/box/survival/centcom
	name = "紧急响应生存箱"
	desc = "一个装有保障你小队成员生命安全的最基本物资的箱子。这一个标注为配备双联气罐。"
	illustration = "extendedtank"
	internal_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/item/storage/box/survival/centcom/PopulateContents()
	. = ..()
	new /obj/item/crowbar(src)

// Security survival box
/obj/item/storage/box/survival/security
	mask_type = /obj/item/clothing/mask/gas/sechailer

/obj/item/storage/box/survival/security/radio/PopulateContents()
	..() // we want the regular stuff too
	new /obj/item/radio/off(src)

// Medical survival box
/obj/item/storage/box/survival/medical
	mask_type = /obj/item/clothing/mask/breath/medical

/obj/item/storage/box/survival/crafted
	crafted = TRUE

/obj/item/storage/box/survival/engineer/crafted
	crafted = TRUE

//Mime spell boxes

/obj/item/storage/box/mime
	name = "隐形箱子"
	desc = "可惜不够大，装不下那个默剧演员。"
	foldable_result = null
	icon_state = "box"
	inhand_icon_state = null
	alpha = 0

/obj/item/storage/box/mime/attack_hand(mob/user, list/modifiers)
	..()
	if(HAS_MIND_TRAIT(user, TRAIT_MIMING))
		alpha = 255

/obj/item/storage/box/mime/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	if (iscarbon(old_loc))
		alpha = 0
	return ..()

/obj/item/storage/box/hug
	name = "拥抱箱"
	desc = "专为敏感人士准备的特别箱子。"
	icon_state = "hugbox"
	illustration = "heart"
	foldable_result = null

/obj/item/storage/box/hug/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]把拥抱箱夹在了自己的颈静脉上！看来这箱子终究不是什么拥抱箱……"))
	return BRUTELOSS

/obj/item/storage/box/hug/attack_self(mob/user)
	..()
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, SFX_RUSTLE, 50, vary=TRUE, extrarange=-5)
	user.visible_message(span_notice("[user]拥抱了[src]。"),span_notice("你拥抱了[src]。"))

/obj/item/storage/box/hug/black
	icon_state = "hugbox_black"
	illustration = "heart_black"

// clown box, we also use this for the honk bot assembly
/obj/item/storage/box/clown
	name = "小丑箱"
	desc = "给小丑准备的彩色纸板箱"
	illustration = "clown"

/obj/item/storage/box/clown/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/bodypart/arm/left/robot) && !istype(tool, /obj/item/bodypart/arm/right/robot))
		return ..()
	if(contents.len) //prevent accidently deleting contents
		balloon_alert(user, "里面有东西！")
		return ITEM_INTERACT_BLOCKING
	if(!user.temporarilyRemoveItemFromInventory(tool))
		return ITEM_INTERACT_BLOCKING
	qdel(tool)
	loc.balloon_alert(user, "轮子装好了，HONK！")
	var/obj/item/bot_assembly/honkbot/assembly = new(drop_location())
	var/held_index = user.is_holding(src)
	qdel(src)
	if (held_index)
		user.put_in_hand(assembly, held_index)
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/box/clown/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]打开了[src]，结果被它吞了进去！看来是想自杀！"))
	playsound(user, 'sound/misc/scary_horn.ogg', 70, vary = TRUE)
	forceMove(user.drop_location())
	var/obj/item/mob_holder/consumed = new(src, user)
	consumed.desc = "这是[user.real_name]！看来是自杀了！"
	return OXYLOSS

// Special stuff for medical hugboxes.
/obj/item/storage/box/hug/medical/PopulateContents()
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)

//Clown survival box
/obj/item/storage/box/survival/hug
	name = "拥抱箱"
	desc = "专为敏感人士准备的特别箱子。"
	icon_state = "hugbox"
	illustration = "heart"
	foldable_result = null
	mask_type = null
	var/random_funny_internals = TRUE

/obj/item/storage/box/survival/hug/PopulateContents()
	if(!random_funny_internals)
		return ..()
	internal_type = pick(
			/obj/item/tank/internals/emergency_oxygen/engi/clown/n2o,
			/obj/item/tank/internals/emergency_oxygen/engi/clown/bz,
			/obj/item/tank/internals/emergency_oxygen/engi/clown/helium,
			)
	return ..()

//Mime survival box
/obj/item/storage/box/survival/hug/black
	icon_state = "hugbox_black"
	illustration = "heart_black"
	random_funny_internals = FALSE

//Duplicated suicide/attack self procs, since the survival boxes are a subtype of box/survival
/obj/item/storage/box/survival/hug/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]把拥抱箱夹在了自己的颈静脉上！看来这箱子终究不是什么拥抱箱……"))
	return BRUTELOSS

/obj/item/storage/box/survival/hug/attack_self(mob/user)
	..()
	user.changeNext_move(CLICK_CD_MELEE)
	playsound(loc, SFX_RUSTLE, 50, vary=TRUE, extrarange=-5)
	user.visible_message(span_notice("[user]拥抱了[src]。"),span_notice("你拥抱了[src]。"))

/obj/item/storage/box/hug/plushes
	name = "战术拥抱套件"
	desc = "一个可爱的小箱子，里面装满了柔软可爱的玩偶，非常适合安抚刚刚经历创伤事件的人。传说地狱里有一个角落，\
	专门留给那些把箱子据为己有的医疗官。"

/obj/item/storage/box/hug/plushes/PopulateContents()
	for(var/i in 1 to 7)
		var/plush_path = /obj/effect/spawner/random/entertainment/plushie
		new plush_path(src)

/obj/item/storage/box/survival/mining/bonus
	mask_type = null
	internal_type = /obj/item/tank/internals/emergency_oxygen/double

/obj/item/storage/box/survival/mining/bonus/PopulateContents()
	..()
	new /obj/item/gps/mining(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)

/obj/item/storage/box/miner_modkits
	name = "矿工模块套件/战利品箱"
	desc = "包含游戏中的每一个模块套件和战利品。"

/obj/item/storage/box/miner_modkits/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(
		/obj/item/borg/upgrade/modkit,
		/obj/item/crusher_trophy
	))
	atom_storage.numerical_stacking = TRUE

/obj/item/storage/box/miner_modkits/PopulateContents()
	for(var/trophy in subtypesof(/obj/item/crusher_trophy))
		new trophy(src)
	for(var/modkit in subtypesof(/obj/item/borg/upgrade/modkit))
		for(var/i in 1 to 10) //minimum cost ucrrently is 20, and 2 pkas, so lets go with that
			new modkit(src)

/obj/item/storage/box/skillchips
	name = "技能芯片箱"
	desc = "包含每种技能芯片各一份"

/obj/item/storage/box/skillchips/PopulateContents()
	var/list/skillchips = subtypesof(/obj/item/skillchip)

	for(var/skillchip in skillchips)
		new skillchip(src)

/obj/item/storage/box/skillchips/science
	name = "科研职业技能芯片箱"
	desc = "包含每种科研职业技能芯片的备用件。"

/obj/item/storage/box/skillchips/science/PopulateContents()
	new/obj/item/skillchip/job/roboticist(src)
	new/obj/item/skillchip/job/roboticist(src)

/obj/item/storage/box/skillchips/engineering
	name = "工程职业技能芯片箱"
	desc = "包含每种工程职业技能芯片的备用件。"

/obj/item/storage/box/skillchips/engineering/PopulateContents()
	new/obj/item/skillchip/job/engineer(src)
	new/obj/item/skillchip/job/engineer(src)

/obj/item/storage/box/contractor/fulton_extraction
	name = "富尔顿提取套件"
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/contractor/fulton_extraction/PopulateContents()
	new /obj/item/extraction_pack/syndicate(src)
	new /obj/item/fulton_core/syndicate(src)
