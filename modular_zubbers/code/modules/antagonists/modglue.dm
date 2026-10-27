/obj/item/mod/module/dna_lock/reinforced
	var/obj/item/implant/explosive/macro // Not really a macrobomb :P

/obj/item/implant/explosive/proc/modsuit_explosion()

	playsound(loc, 'sound/items/timer.ogg', 30, FALSE)
	if(!panic_beep_sound)
		sleep(delay * 0.25)
	//total of 8 bomb beeps, and we've already beeped once
	var/bomb_beeps_until_boom = 8
	if(!panic_beep_sound)
		while(bomb_beeps_until_boom > 0)
			//for extra spice
			var/beep_volume = 35
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.25)
			bomb_beeps_until_boom--
			beep_volume += 5
		explode()
	else
		addtimer(CALLBACK(src, PROC_REF(explode)), delay)
		while(delay > 1) //so we dont accidentally enter an infinite sleep
			var/beep_volume = 35
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.2)
			delay -= delay * 0.2
			beep_volume += 5
#define PULL_SUIT "强行脱下"
#define IGNORE_SUIT "不要脱下"
#define DUMP_CONTENTS "倒出储物箱物品"
/obj/item/mod/module/dna_lock/reinforced/proc/explode(mob/user, mob/owner)
	if(!dna_check(user))
		macro = new/obj/item/implant/explosive(src)
		macro.modsuit_explosion()
		owner.spasm_animation(600)
	else
		to_chat(user, "知道自己的MOD外骨骼没有在脸前爆炸，你感到安心。")

/obj/item/mod/control/pre_equipped/contractor/doStrip(mob/living/carbon/stripper, mob/owner)
	if(!istype(stripper, /mob/living/carbon))
		return
	var/obj/item/mod/module/dna_lock/reinforced/dna_lock = locate(/obj/item/mod/module/dna_lock/reinforced) in modules
	var/alert
	if(dna_lock)
		alert = tgui_alert(stripper,
			"你试图从[owner]身上脱下MOD外骨骼时，发现了一个疑似防拆装置。\n继续拉扯似乎会扯动炸弹引信。还要继续吗？？？",
			"你真的确定吗？",
			list(PULL_SUIT, IGNORE_SUIT, DUMP_CONTENTS), 10 SECONDS, TRUE)


	if(alert == PULL_SUIT)
		ASYNC
			if(dna_lock.dna)
				dump_modsuit_toss_contents()
				dna_lock.explode(user = stripper, owner = owner)
				qdel(src)
		. = ..()
	if(alert == DUMP_CONTENTS)
		dump_modsuit_toss_contents()

/obj/item/mod/control/pre_equipped/ninja/doStrip(mob/living/carbon/stripper, mob/owner)
	if(!istype(stripper, /mob/living/carbon))
		return
	var/obj/item/mod/module/dna_lock/reinforced/dna_lock = locate(/obj/item/mod/module/dna_lock/reinforced) in modules
	var/alert
	if(dna_lock)
		alert = tgui_alert(stripper,
			"你试图从[owner]身上脱下MOD外骨骼时，发现了一个疑似防拆装置。\n继续拉扯似乎会扯动炸弹引信。还要继续吗？？？",
			"你真的确定吗？",
			list(PULL_SUIT, IGNORE_SUIT, DUMP_CONTENTS), 10 SECONDS, TRUE)


	if(alert == PULL_SUIT)
		ASYNC
			if(dna_lock.dna)
				dump_modsuit_toss_contents()
				dna_lock.explode(user = stripper, owner = owner)
				qdel(src)
		. = ..()
	if(alert == DUMP_CONTENTS)
		dump_modsuit_toss_contents()

/obj/item/mod/control
	COOLDOWN_DECLARE(trash_cooldown)
	COOLDOWN_DECLARE(funny_sound_cooldown)

/obj/item/mod/control/proc/dump_modsuit_toss_contents()
	if(QDELETED(src))
		return FALSE
	var/obj/item/mod/module/storage/storage = locate() in contents
	if(!storage)
		playsound(src, 'sound/effects/quack.ogg')
		return FALSE
	for(var/atom/movable/i in storage.contents)
		sleep(0.2 SECONDS)
		reset_thing(i)
		i.loc = get_turf(src)
		var/turf/throw_at = get_ranged_target_turf_direct(src, usr, 7, rand(-60,60))
		if(i.safe_throw_at(throw_at, rand(2,4), rand(1,3), usr, spin = TRUE))
			playsound(i, 'sound/items/weapons/punchmiss.ogg', 10)

	return TRUE

/proc/reset_thing(atom/movable/thing)
	thing.layer = initial(thing.layer)
	SET_PLANE_IMPLICIT(thing, initial(thing.plane))
	thing.mouse_opacity = initial(thing.mouse_opacity)
	thing.screen_loc = null
	if(thing.maptext)
		thing.maptext = ""

#undef PULL_SUIT
#undef IGNORE_SUIT
#undef DUMP_CONTENTS
