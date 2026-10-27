//Gives you wizard if you land on 20. Fail, and the dice teleports somewhere else.

/obj/item/dice/d20/teleporting_die_of_fate
	name = "巫师命运之骰"
	desc = "一枚荒唐至极的魔法 d20。掷出 20，你就有机会赢得一次赢取奖品的机会！"
	microwave_riggable = FALSE //lol. lmao
	COOLDOWN_DECLARE(roll_cd) //Prevents exploits
	var/smite_rng_seed = 1
	var/do_teleport = TRUE
	var/relocation_timer
	var/was_touched = FALSE

	var/teleport_delay = 10 MINUTES
	var/teleport_delay_pickup = 5 MINUTES
	var/uses_left = 20 //The dice will still get consumed if someone gets wizard. Set to a value already less than 0 and it will be infinite.

/obj/item/dice/d20/teleporting_die_of_fate/no_teleport
	do_teleport = FALSE

/obj/item/dice/d20/teleporting_die_of_fate/cursed //Always rolls 1. Careful with this, as this is a reliable way to summon a smite. One time use.
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 1
	do_teleport = FALSE
	uses_left = 1

/obj/item/dice/d20/teleporting_die_of_fate/cursed/infinite //Just in case you needed to make (nearly) infinite pain.
	uses_left = 1337

/obj/item/dice/d20/teleporting_die_of_fate/blessed //Always rolls 20. This is basically single use since it just makes you wizard and deletes itself.
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 20
	do_teleport = FALSE

/obj/item/dice/d20/teleporting_die_of_fate/Initialize(mapload)
	. = ..()
	src.add_filter("dice_glow", 2, list("type" = "outline", "color" = "#AC14FF30", "size" = 4))
	src.set_light(5,0.25,"#AC14FF")
	smite_rng_seed = rand(1,11) //The only reason I do this is for testing :^). It does have some benefit to not having the same 2 effects occur in a row.
	SSpoints_of_interest.make_point_of_interest(src)
	if(do_teleport)
		create_timer(teleport_delay)

/obj/item/dice/d20/teleporting_die_of_fate/Destroy()
	relocation_timer = null //Deleted elsewhere.
	. = ..()

/obj/item/dice/d20/teleporting_die_of_fate/proc/create_timer(desired_time = teleport_delay)
	relocation_timer = addtimer(CALLBACK(src, PROC_REF(relocate)), desired_time, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_OVERRIDE)
	return relocation_timer


/obj/item/dice/d20/teleporting_die_of_fate/examine(mob/user)
	. = ..()
	. += span_notice("掷出 20，你或许就会变得有魔力……")
	. += span_warning("掷出 1，你就会躺进医疗部！")
	if(relocation_timer && isobserver(user))
		. += span_notice("骰子将在 [DisplayTimeText(timeleft(relocation_timer),1)] 后转移位置！")
		. += span_warning("它还剩余 <b>[uses_left]</b> 次使用机会……")

/obj/item/dice/d20/teleporting_die_of_fate/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user) || !user.mind || IS_WIZARD(user))
		to_chat(user, span_warning("你感觉骰子的魔力只对普通人有效！你最好别去碰它。"))
		user.dropItemToGround(src)
	else if(do_teleport && !was_touched)
		create_timer(teleport_delay_pickup)
		was_touched = TRUE

/obj/item/dice/d20/teleporting_die_of_fate/diceroll(mob/user, in_hand=FALSE)

	if(!COOLDOWN_FINISHED(src, roll_cd))
		to_chat(user, span_warning("等等，[src] 还没从你上次那一掷里缓过来！"))
		return

	. = ..()

	if(!ishuman(user) || !user.mind || IS_WIZARD(user))
		to_chat(user, span_warning("你感觉骰子的魔力只对普通人有效！"))
		return

	var/turf/current_turf = get_turf(src)
	current_turf.visible_message(span_userdanger("[src] 短暂地闪了一下。"))

	addtimer(CALLBACK(src, PROC_REF(effect), user, .), 1 SECONDS)
	COOLDOWN_START(src, roll_cd, 2.5 SECONDS)

/obj/item/dice/d20/teleporting_die_of_fate/proc/relocate()

	var/turf/current_turf = get_turf(src)

	if(uses_left > 0)
		uses_left--
		if(uses_left <= 0)
			if(rigged != DICE_TOTALLY_RIGGED)
				notify_ghosts(
					"[src] 已彻底用尽，被从现实中移除了。",
					source = src
				)
			current_turf.visible_message(span_warning("[src] 淡出现实……"))
			qdel(src)
			return

	create_timer(teleport_delay)
	was_touched = FALSE //Reset

	var/turf/desired_turf = get_safe_lucky_player_turf(areas_to_exclude = list(get_area(src)))

	if(!desired_turf) //Failsafe.
		desired_turf = get_safe_random_station_turf()

	if(!desired_turf) //Do nothing as a failsafe for a failsafe.
		return

	current_turf.visible_message(span_warning("[src] 淡出，前往另一处地点！"))

	//Teleport!
	src.forceMove(desired_turf)

	new/obj/effect/temp_visual/emp/pulse(desired_turf) //Does not cause an EMP :^)
	playsound(desired_turf,'sound/effects/magic/magic_missile.ogg',50,8,FALSE)

	notify_ghosts(
		"[src] 已传送到 [desired_turf.loc]！",
		source = src
	)


/obj/item/dice/d20/teleporting_die_of_fate/proc/effect(mob/living/carbon/human/user,roll)

	var/turf/current_turf = get_turf(src)

	new/obj/effect/temp_visual/emp/pulse(current_turf) //Does not cause an EMP :^)
	playsound(current_turf,'sound/effects/magic/magic_missile.ogg',50,8,FALSE)

	if(roll != 20)
		if(roll == 1) //lol. lmao
			user.emote("scream")
			user.investigate_log("被巫师命运之骰制裁了。", INVESTIGATE_DEATHS)
			notify_ghosts(
				"[user] 用 [src] 掷出了 1！快来指着他笑！",
				source = user
			)
			addtimer(CALLBACK(src, PROC_REF(apply_random_smite), user), 1 SECONDS)

		if(do_teleport)
			relocate()

		return

	user.emote("laugh")
	current_turf.visible_message(span_userdanger("魔力从 [src] 涌出，注入 [user]！"))
	user.drop_everything(del_on_drop = FALSE, force = TRUE, del_if_nodrop = TRUE)
	user.mind.make_wizard()

	notify_ghosts(
		"[user] 用 [src] 掷出了天然 20！",
		source = user
	)

	qdel(src)


/obj/item/dice/d20/teleporting_die_of_fate/proc/apply_random_smite(mob/living/carbon/human/target)

	switch(smite_rng_seed % 9)
		if(0)
			//Bad luck.
			target.AddComponent( \
				/datum/component/omen, \
				incidents_left = 7, \
				bless_fixable = TRUE, \
			)
			to_chat(target, span_warning("你对此有种不祥的预感……"))
		if(1)
			//Drain bamage.
			target.adjust_organ_loss(ORGAN_SLOT_BRAIN, BRAIN_DAMAGE_DEATH - 1, BRAIN_DAMAGE_DEATH - 1)
			to_chat(target, span_warning("你因为掷了 [src] 而觉得自己<b>蠢透了</b>……"))
		if(2)
			//Forced to speak a random language.
			target.apply_status_effect(/datum/status_effect/tower_of_babel, teleport_delay_pickup)
			to_chat(target, span_warning("来吧，我们下去，在那里变乱他们的语言，使他们彼此言语不通。这他妈一定超好笑！"))
		if(3)
			//Raining fireball.
			target.Immobilize(3 SECONDS)
			new /obj/effect/temp_visual/target(get_turf(target))
			to_chat(target, span_warning("我要施放火球术！"))
		if(4)
			//Lighting bolt smite.
			var/turf/lightning_source = get_turf(src)
			lightning_source.Beam(target, icon_state="lightning[rand(1,12)]", time = 5)
			target.adjust_fire_loss(LIGHTNING_BOLT_DAMAGE)
			playsound(get_turf(target), 'sound/effects/magic/lightningbolt.ogg', 50, TRUE)
			target.electrocution_animation(LIGHTNING_BOLT_ELECTROCUTION_ANIMATION_LENGTH)
			to_chat(target, span_warning("闪电束！！"))
		if(5)
			//Ick Ock Phobia
			target.gain_trauma(/datum/brain_trauma/mild/phobia/ocky_icky, TRAUMA_RESILIENCE_SURGERY)
			to_chat(target, span_warning("那些该死的程序员想害我们！！！"))
		if(6)
			//A rod comes and fucks you up. And the station.
			var/turf/target_turf = get_turf(target)
			var/startside = pick(GLOB.cardinals)
			var/turf/start_turf = spaceDebrisStartLoc(startside, target_turf.z)
			var/turf/end_turf = spaceDebrisFinishLoc(startside, target_turf.z)
			if(start_turf && end_turf)
				new /obj/effect/immovablerod(start_turf, end_turf, target, FALSE)
			to_chat(target, span_warning("咦，好像什么都没发生。看来我是无敌的……"))
		if(7)
			//A pod comes down and slams you.
			target.Immobilize(3 SECONDS)
			podspawn(list(
				"target" = get_turf(target),
				"path" = /obj/structure/closet/supplypod/centcompod,
				"style" = /datum/pod_style/centcom,
				"spawn" = /obj/item/toy/plush/lizard_plushie,
				"damage" = 50,
				"explosionSize" = list(0, 0, 2, 4),
				"effectStun" = TRUE
			))
			to_chat(target, span_warning("特快专递！"))
		if(8)
			//You turn into a lizard. If you're already a lizard, you're now scared of lizards.
			//Can be fixed via SAD.
			if(target.dna && !istype(target.dna.species,/datum/species/lizard))
				target.set_species(/datum/species/lizard)
				to_chat(target, span_warning("你变成蜥蜴了，哈利。"))
			else
				target.gain_trauma(/datum/brain_trauma/mild/phobia/lizards, TRAUMA_RESILIENCE_SURGERY)
				to_chat(target, span_warning("等一下，我一直都是只蜥蜴？！"))



	smite_rng_seed++
