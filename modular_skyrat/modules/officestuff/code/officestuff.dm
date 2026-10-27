/obj/structure/grandfatherclock
	name = "落地钟"
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "grandfather_clock"
	desc = "滴答，滴答，滴答，滴答。它高耸而骇人，发出响亮不祥的滴答声，指针却停在午夜将至的位置。越是靠近，微弱的低语就越响，逐渐化为尖叫、恳求，或是别的什么。无论那是什么，它都在说：‘我是法师，你将服从于我。’"
	var/datum/looping_sound/grandfatherclock/soundloop

// stolen from the wall clock
/obj/structure/grandfatherclock/examine(mob/user)
	. = ..()
	. += span_info("当前CST（本地）时间：[round_timestamp()]。")
	. += span_info("当前TCT（银河）时间：[time2text(world.realtime, "hh:mm:ss")]。")
	if(soundloop)
		. += span_notice("钟的指针自由走动着。可以用<b>螺丝刀</b>将其固定。")
	else
		. += span_notice("钟的指针已用<b>螺丝</b>固定。")


// . += span_notice("The <b>screws</b> on the clock hands are loose, freely ticking away.")
// door_status" = density ? "closed" : "open",
/datum/looping_sound/grandfatherclock
	mid_sounds = list('modular_skyrat/modules/officestuff/sound/clock_ticking.ogg' = 1)
	mid_length = 12 SECONDS
	volume = 10
	ignore_walls = FALSE

/obj/structure/grandfatherclock/Initialize(mapload)
	. = ..()
	soundloop = new(src, TRUE)

/obj/structure/grandfatherclock/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/grandfatherclock/screwdriver_act(mob/living/user, obj/item/tool)
	if(!soundloop)
		balloon_alert(user, "正在松开指针……")
		if(do_after(user, 2 SECONDS, src))
			soundloop = new(src, TRUE)
			balloon_alert(user, "指针已松开！")
			return ITEM_INTERACT_SUCCESS
		return ..()

	balloon_alert(user, "正在固定指针……")
	if(do_after(user, 2 SECONDS, src))
		QDEL_NULL(soundloop)
		balloon_alert(user, "指针已固定！")
		return ITEM_INTERACT_SUCCESS
	return ..()
/obj/structure/sign/painting/meat
	name = "肉与人像"
	desc = "一幅描绘扭曲人影的画作，画中人坐在剖成两半的牛胴体之间。"
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "meat"
	sign_change_name = "画作 - 肉"
	is_editable = TRUE

/obj/structure/sign/painting/parting
	name = "分海"
	desc = "一幅描绘大海分开的画作，红日映照着蔚蓝的海洋。"
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "jmwt4"
	is_editable = TRUE
	sign_change_name = "画作 - 海浪"


/obj/structure/sign/paint
	name = "画作"
	desc = "你不应该看到这个。"
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "gravestone"


