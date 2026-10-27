#define PERSONAL_SPACE_DAMAGE 2
#define ASS_SLAP_EXTRA_RANGE -1

// Emotes
/mob/living/carbon/disarm(mob/living/carbon/target)
	if(zone_selected == BODY_ZONE_PRECISE_MOUTH)
		var/target_on_help_and_unarmed = !target.combat_mode && !target.get_active_held_item()
		if(target_on_help_and_unarmed || HAS_TRAIT(target, TRAIT_RESTRAINED))
			do_slap_animation(target)
			playsound(target.loc, 'sound/items/weapons/slap.ogg', 50, TRUE, -1)
			visible_message("<span class='danger'>[src] 一巴掌扇在 [target] 脸上！</span>",
				"<span class='notice'>你一巴掌扇在 [target] 脸上！ </span>",\
			"你听到一声巴掌声。")
			target.unwag_tail()
			return
	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == src.dir)
		if(HAS_TRAIT(target, TRAIT_PERSONALSPACE) && (!IS_UNCONSCIOUS_OR_CRIT(target)) && (!target.handcuffed)) //You need to be conscious and uncuffed to use Personal Space
			if(target.combat_mode && (!HAS_TRAIT(target, TRAIT_PACIFISM))) //Being pacified prevents violent counters
				var/obj/item/bodypart/affecting = src.get_bodypart(BODY_ZONE_HEAD)
				if(affecting?.receive_damage(PERSONAL_SPACE_DAMAGE))
					src.update_damage_overlays()
				visible_message(span_danger("[src] 想扇 [target] 的屁股，结果反被扇了一巴掌！"),
				span_danger("你想扇 [target] 的屁股，结果被打了回来，好痛！"),
				"你听到一声巴掌声。", ignored_mobs = list(target))
				playsound(target.loc, 'sound/effects/snap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
				to_chat(target, span_danger("[src] 想扇你的屁股，结果被你打了回去！"))
				return
			else
				visible_message(span_danger("[src] 想扇 [target] 的屁股，但被挡住了！"),
				span_danger("你想扇 [target] 的屁股，但被挡了下来！"),
				"你听到一声巴掌声。", ignored_mobs = list(target))
				playsound(target.loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
				to_chat(target, span_danger("[src] 想扇你的屁股，但你挡住了！"))
				return
		else
			do_ass_slap_animation(target)
			playsound(target.loc, 'sound/items/weapons/slap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
			visible_message("<span class='danger'>[src] 一巴掌拍在 [target] 的屁股上！</span>",\
				"<span class='notice'>你一巴掌拍在 [target] 的屁股上，真是太解压了。</span>",\
				"你听到一声巴掌声。", ignored_mobs = list(target))
			to_chat(target, "<span class='danger'>[src] 拍了你的屁股！")
			return
	return ..()

#undef PERSONAL_SPACE_DAMAGE
#undef ASS_SLAP_EXTRA_RANGE
