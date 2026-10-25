/obj/item/implant/stealth
	name = "S3 植入体"
	desc = "能让你在众目睽睽之下隐匿行踪。"
	actions_types = list(/datum/action/item_action/agent_box)

	implant_info = "手动激活。\
		在使用者周围制造一个极其脆弱的纸板箱，其内置了渐进式光学迷彩。"

	implant_lore = "赛博太阳 S3 植入体，俗称“潜行”植入体，允许使用者就地制造一个“潜行”纸板箱包裹自身，\
		该箱体牺牲了它作为纸板箱的大部分（本就微不足道的）强度，来支撑一层光学迷彩织物。\
		遗憾的是，光学迷彩无法立刻完成初始化；与活动生物发生碰撞会破坏迷彩，\
		而在迷彩被破坏后或初次激活时，迷彩系统必须重新校准周围环境。\
		不过，一旦完成校准，它就肉眼不可见。"

/obj/item/implanter/stealth
	name = "植入器" // Skyrat edit , was originaly implanter (stealth)
	imp_type = /obj/item/implant/stealth
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // Skyrat edit
	special_desc = "辛迪加用于潜行植入体的植入器" // Skyrat edit

//Box Object

/obj/structure/closet/cardboard/agent
	name = "不显眼的纸板箱"
	desc = "它太普通了，以至于你之前完全没注意到它。"
	icon_state = "agentbox"
	max_integrity = 1 // "This dumb box shouldn't take more than one hit to make it vanish."
	move_speed_multiplier = 0.5
	enable_door_overlay = FALSE

/obj/structure/closet/cardboard/agent/Initialize(mapload)
	. = ..()
	go_invisible()

/obj/structure/closet/cardboard/agent/proc/go_invisible()
	animate(src, alpha = 0, time = 20)

/obj/structure/closet/cardboard/agent/after_open(mob/living/user)
	. = ..()
	qdel(src)

/obj/structure/closet/cardboard/agent/process()
	alpha = max(0, alpha - 50)

/obj/structure/closet/cardboard/agent/proc/reveal()
	alpha = 255
	addtimer(CALLBACK(src, PROC_REF(go_invisible)), 10, TIMER_OVERRIDE|TIMER_UNIQUE)

/obj/structure/closet/cardboard/agent/Bump(atom/A)
	. = ..()
	if(istype(A, /obj/machinery/door))
		for(var/mob/mob_in_box in contents)
			A.Bumped(mob_in_box)
	if(isliving(A))
		reveal()

/obj/structure/closet/cardboard/agent/Bumped(atom/movable/A)
	. = ..()
	if(isliving(A))
		reveal()
