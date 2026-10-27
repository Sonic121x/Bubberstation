/datum/martial_art/spiders_bite
	name = "蛛咬拳"
	id = MARTIALART_SPIDERSBITE
	help_verb = "回顾武学教诲"
	grab_damage_modifier = 10
	grab_escape_chance_modifier = -20
	/// REF() to the last mob we kicked
	var/last_hit_ref
	/// Counts the number of sequential kicks the user has landed on a target
	var/last_hit_count = 0
	/// Reference to the tackling component applied
	var/datum/component/tackler/tackle_comp

/datum/martial_art/spiders_bite/activate_style(mob/living/new_holder)
	. = ..()
	RegisterSignal(new_holder, COMSIG_HUMAN_PUNCHED, PROC_REF(kick_disarm))
	tackle_comp = new_holder.AddComponent(/datum/component/tackler, \
		stamina_cost = 20, \
		base_knockdown = 0.2 SECONDS, \
		range = 5, \
		speed = 1.5, \
		skill_mod = 6, \
		min_distance = 1, \
		silent_gain = TRUE, \
	)

/datum/martial_art/spiders_bite/deactivate_style(mob/living/old_holder)
	. = ..()
	UnregisterSignal(old_holder, COMSIG_HUMAN_PUNCHED)
	QDEL_NULL(tackle_comp)

/datum/martial_art/spiders_bite/proc/kick_disarm(mob/living/source, mob/living/target, damage, attack_type, obj/item/bodypart/affecting, final_armor_block, kicking, limb_sharpness)
	SIGNAL_HANDLER

	if(!kicking)
		last_hit_ref = null
		return
	var/new_hit_ref = REF(target)
	if(last_hit_ref == new_hit_ref)
		last_hit_count++
	else
		last_hit_count = 1
		last_hit_ref = new_hit_ref

	if(!prob(33 * last_hit_count))
		return

	var/obj/item/weapon = target.get_active_held_item()
	if(isnull(weapon) || !target.dropItemToGround(weapon))
		return
	source.visible_message(
		span_warning("[source]一脚踢飞了[target]手中的[weapon.name]！"),
		span_notice("你顺应重力之流，一脚踢飞了[target]手中的[weapon.name]！"),
		span_hear("你听到一声闷响，随后是物品落地的哐啷声。"),
	)

/datum/martial_art/spiders_bite/get_prefered_attacking_limb(mob/living/martial_artist, mob/living/target)
	if(!target.has_status_effect(/datum/status_effect/staggered))
		return null

	return IS_LEFT_INDEX(martial_artist.active_hand_index) ? BODY_ZONE_L_LEG : BODY_ZONE_R_LEG

/datum/martial_art/spiders_bite/get_style_help()
	. = list()

	. += span_info("<b><i>你凝神内省，回忆起蜘蛛氏族的技法……</i></b>\n\
		&bull; 谨记，<b>多足蜘蛛</b>：徒手攻击踉跄的对手时必定使用踢击，命中率和伤害更高。\n\
		&bull; 谨记，<b>腾跃攀爬</b>：右键点击投掷模式即可发起擒抱，其失败概率极低。\n\
		&bull; 谨记，<b>重力之流</b>：踢击对手时有概率将其武器踢落，连续踢击会提高此概率。\n\
		&bull; 谨记，<b>蛛网缠身</b>：你的抓取更难挣脱。")
	return .
