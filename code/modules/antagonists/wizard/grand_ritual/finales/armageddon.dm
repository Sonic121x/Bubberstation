#define DOOM_SINGULARITY "singularity"
#define DOOM_TESLA "tesla"
#define DOOM_METEORS "meteors"

/// Kill yourself and probably a bunch of other people
/datum/grand_finale/armageddon
	name = "湮灭"
	desc = "这群船员对你的冒犯已经超出了恶作剧的范畴。献出终极的牺牲，给他们上一堂连你的长辈都会真正敬重的课。\
		你无法在这一切中幸存。"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "legion_head"
	minimum_time = 90 MINUTES // This will probably immediately end the round if it gets finished.
	ritual_invoke_time = 60 SECONDS // Really give the crew some time to interfere with this one.
	dire_warning = TRUE
	glow_colour = "#be000048"
	/// Things to yell before you die
	var/static/list/possible_last_words = list(
		"烈焰与毁灭！",
		"毁——灭——！！",
		"HAHAHAHAHAHA!! AHAHAHAHAHAHAHAHAA!!",
		"Hee hee hee!! Hoo hoo hoo!! Ha ha haaa!!",
		"Ohohohohohoho!!",
		"在恐惧中瑟瑟发抖吧，渺小的凡人！",
		"在我的荣光前颤抖吧！",
		"挑个神祈祷吧！",
		"没用的！",
		"如果神明想让你活下去，就不会创造我！",
		"神之所以待在天上，是害怕我所创造的东西！",
		"毁灭已至！",
		"万物众生，皆从吾意！",
	)

/datum/grand_finale/armageddon/trigger(mob/living/carbon/human/invoker)
	priority_announce(pick(possible_last_words), null, 'sound/effects/magic/voidblink.ogg', sender_override = "[invoker.real_name]", color_override = "purple")
	var/turf/current_location = get_turf(invoker)
	invoker.gib(DROP_ALL_REMAINS)

	var/static/list/doom_options = list()
	if (!length(doom_options))
		doom_options = list(DOOM_SINGULARITY, DOOM_TESLA)
		if (!SSmapping.is_planetary())
			doom_options += DOOM_METEORS

	switch(pick(doom_options))
		if (DOOM_SINGULARITY)
			var/obj/singularity/singulo = new(current_location)
			singulo.energy = 300
		if (DOOM_TESLA)
			var/obj/energy_ball/tesla = new (current_location)
			tesla.energy = 200
		if (DOOM_METEORS)
			GLOB.meteor_mode ||= new()
			GLOB.meteor_mode.meteordelay = 0
			GLOB.meteor_mode.start_meteor()
			priority_announce("已探测到流星正沿碰撞轨道逼近空间站。", "流星警报", ANNOUNCER_METEORS)

#undef DOOM_SINGULARITY
#undef DOOM_TESLA
#undef DOOM_METEORS
