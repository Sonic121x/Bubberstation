#define CLIMAX_VAGINA "阴道"
#define CLIMAX_PENIS "阴茎"
#define CLIMAX_BOTH "两者"

#define CLIMAX_ON_FLOOR "射在地板上"
#define CLIMAX_IN_OR_ON "射在别人身上或体内"
#define CLIMAX_OPEN_CONTAINER "注入试剂容器"
#define CLIMAX_PORTAL "穿过传送门"

// both of these are pretty much arbitrary
#define MIN_CUM_THRESHOLD 5
#define MIN_VAGINA_WETNESS_THRESHOLD 3.33

/mob/living/carbon/human
	/// Used to prevent nightmare scenarios.
	var/refractory_period

/mob/living/carbon/human/proc/climax(manual = TRUE)
	if (CONFIG_GET(flag/disable_erp_preferences))
		return

	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/autocum) && !manual)
		return
	if(refractory_period > REALTIMEOFDAY)
		return
	refractory_period = REALTIMEOFDAY + 30 SECONDS
	if(has_status_effect(/datum/status_effect/climax_cooldown) || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	if(HAS_TRAIT(src, TRAIT_NEVERBONER) || has_status_effect(/datum/status_effect/climax_cooldown) || (!has_vagina() && !has_penis()))
		visible_message(span_purple("[src] 抽搐着，试图高潮，却毫无结果。"), \
			span_purple("你无法高潮！"))
		return TRUE

	// Reduce pop-ups and make it slightly more frictionless (lewd).
	var/climax_choice = has_penis() ? CLIMAX_PENIS : CLIMAX_VAGINA

	if(manual)
		var/list/genitals = list()
		if(has_vagina())
			genitals.Add(CLIMAX_VAGINA)
			if(has_penis())
				genitals.Add(CLIMAX_PENIS)
				genitals.Add(CLIMAX_BOTH)
		else if(has_penis())
			genitals.Add(CLIMAX_PENIS)
		climax_choice = tgui_alert(src, "你正在高潮，请选择用哪种生殖器高潮。", "生殖器偏好！", genitals)

	switch(gender)
		if(MALE)
			conditional_pref_sound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)
		if(FEMALE)
			conditional_pref_sound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)

	var/self_orgasm = FALSE
	var/self_their = p_their()

	var/obj/item/organ/genital/testicles/testicles = get_organ_slot(ORGAN_SLOT_TESTICLES)
	testicles?.calculate_cumshot()

	if(climax_choice == CLIMAX_PENIS || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/genital/penis/penis = get_organ_slot(ORGAN_SLOT_PENIS)
		if(!testicles || testicles.reagents.total_volume < MIN_CUM_THRESHOLD) //If we have no god damn balls, we can't cum anywhere... GET BALLS! , OR theres so little in your balls that nothing comes out...
			visible_message(span_userlove("[src] 高潮了，但阴茎什么也没射出来！"), \
				span_userlove("你高潮了，感觉很棒，但你的阴茎什么也没射出来！"))

		else if(is_wearing_condom())
			var/obj/item/clothing/sextoy/condom/condom = src.penis // bruh 💀⚰️💀⚰️💀⚰️💀⚰️💀
			condom.condom_use() // condoms probably should become reagent containers at some point
			visible_message(span_userlove("[src] 把精液射进 [condom] 里，把它装满了！"), \
				span_userlove("你把浓稠的精液射进 [condom]，它全接住了！"))
			testicles.reagents.remove_all(testicles.cumshot_size)

		else if(!is_bottomless() && penis.visibility_preference != GENITAL_ALWAYS_SHOW)
			visible_message(span_userlove("[src] 射在了衣服里！"), \
				span_userlove("你射了出来，但你没脱衣服，所以把衣服弄脏了！"))
			self_orgasm = TRUE
			testicles.reagents.remove_all(testicles.cumshot_size)

		else
			var/list/interactable_inrange_humans = list()
			// monkey see, monkey do
			var/list/interactable_inrange_open_containers = list()

			// Unfortunately prefs can't be checked here, because byond/tgstation moment.
			for(var/mob/living/carbon/human/iterating_human in (view(1, src) - src))
				interactable_inrange_humans[iterating_human.name] = iterating_human

			// this should be making a list of cups(?)
			for(var/obj/item/reagent_containers/cup/iterating_open_container in (view(1, src) - src))
				interactable_inrange_open_containers[iterating_open_container.name] = iterating_open_container

			var/list/buttons = list(CLIMAX_ON_FLOOR)
			if(interactable_inrange_humans.len)
				buttons += CLIMAX_IN_OR_ON

			if(interactable_inrange_open_containers.len)
				buttons += CLIMAX_OPEN_CONTAINER

			// If your using a LustWish portal lets you cum through it
			var/obj/structure/lewd_portal/portal = src.buckled
			if(istype(portal, /obj/structure/lewd_portal))
				buttons += CLIMAX_PORTAL

			var/penis_climax_choice = tgui_alert(src, "选择要把精液射向哪里。", "射精偏好！", buttons)

			var/create_cum_decal = FALSE

			if(!penis_climax_choice || penis_climax_choice == CLIMAX_ON_FLOOR)
				create_cum_decal = TRUE
				visible_message(span_userlove("[src] 把黏稠的精液射在地板上！"), \
					span_userlove("你一股又一股地把滚烫的精液射在地板上！"))
				testicles.reagents.remove_all(testicles.cumshot_size)

			else if(penis_climax_choice == CLIMAX_OPEN_CONTAINER)
				var/target_choice = tgui_input_list(src, "选择要射入的容器。", "选择目标！", interactable_inrange_open_containers)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src] 把黏稠的精液射在地板上！"), \
						span_userlove("你一股又一股地把滚烫的精液射在地板上！"))
					testicles.reagents.remove_all(testicles.cumshot_size)
				else
					var/obj/item/reagent_containers/cup/target_open_container = interactable_inrange_open_containers[target_choice]
					if(target_open_container.is_refillable() && target_open_container.is_drainable())
						// here's where we actually do the cumming(?)
						var/cum_volume = testicles.cumshot_size
						var/total_volume_w_cum = cum_volume + target_open_container.reagents.total_volume
						conditional_pref_sound(get_turf(src), SFX_DESECRATION, 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)
						if(target_open_container.reagents.holder_full())
							// its full already
							add_cum_splatter_floor(get_turf(target_open_container))
							visible_message(span_userlove("[src] 想射进 [target_open_container]，但它已经满了，滚烫的精液洒到了地板上！"), \
								span_userlove("你想射进 [target_open_container]，但它已经满了，于是全都落在了地板上！"))
						else
							testicles.reagents.trans_to(target_open_container, testicles.cumshot_size, transferred_by = src)
							if(total_volume_w_cum > target_open_container.volume)
								// overflow, make the decal
								add_cum_splatter_floor(get_turf(target_open_container))
								visible_message(span_userlove("[src] 把黏稠的精液射进 [target_open_container]，它太满了，溢了出来！"), \
									span_userlove("你一股又一股地把滚烫的精液射进 [target_open_container]，让它溢了出来！"))
							else
								visible_message(span_userlove("[src] 把黏稠的精液射进 [target_open_container]！"), \
									span_userlove("你一股又一股地把滚烫的精液射进 [target_open_container]！"))
					else
						// cum fail
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] 把黏稠的精液射在地板上！"), \
							span_userlove("你一股又一股地把滚烫的精液射在地板上！"))
						testicles.reagents.remove_all(testicles.cumshot_size)

			else if(penis_climax_choice == CLIMAX_PORTAL)
				to_chat(src, "你一股又一股地把滚烫的精液射出，命中了另一侧的东西！")
				portal.relayed_body.visible_message("[portal.relayed_body] 把黏稠的精液射在地板上！")
				add_cum_splatter_floor(get_turf(portal.relayed_body))

			else
				var/target_choice = tgui_input_list(src, "选择要射入或射在谁身上。", "选择目标！", interactable_inrange_humans)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src] 把黏稠的精液射在地板上！"), \
						span_userlove("你一股又一股地把滚烫的精液射在地板上！"))
				else
					var/mob/living/carbon/human/target_human = interactable_inrange_humans[target_choice]
					var/target_human_them = target_human.p_them()

					var/list/target_buttons = list()

					if(!target_human.wear_mask)
						target_buttons += "嘴"
					if(target_human.has_vagina(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_VAGINA
					if(target_human.has_anus(REQUIRE_GENITAL_EXPOSED))
						target_buttons += "屁眼"
					if(target_human.has_penis(REQUIRE_GENITAL_EXPOSED))
						var/obj/item/organ/genital/penis/other_penis = target_human.get_organ_slot(ORGAN_SLOT_PENIS)
						if(other_penis.sheath != "None")
							target_buttons += "鞘"
					target_buttons += "射在其身上"

					var/climax_into_choice = tgui_input_list(src, "你想射在 [target_human] 身上还是体内？", "最后的前线！", target_buttons)

					if(!climax_into_choice)
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] 把黏稠的精液射在地板上！"), \
							span_userlove("你一股又一股地把滚烫的精液射在地板上！"))
					else if(climax_into_choice == "射在其身上")
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] 把黏稠的精液射在 [target_human] 身上！"), \
							span_userlove("你一股又一股地把滚烫的精液射在 [target_human] 身上！"))
					else
						visible_message(
							span_userlove("[src] 将阴茎整根顶入 [target_human] 的 [climax_into_choice]，向其中射精！"),
							span_userlove("你将阴茎整根顶入 [target_human] 的 [climax_into_choice]，向其中射精！"))
						to_chat(target_human, span_userlove("随着 [src] 将精液射入，你的 [climax_into_choice] 被温热的精液填满。"))

						if(climax_into_choice == "嘴")
							testicles.reagents.trans_to(target_human, testicles.cumshot_size, transferred_by = src, methods = INGEST)

					// if someone wanted to, they could add code for actually putting cum inside of a vagina since it's a reagent container now...
					// would need to change up the fluid_generation.dm and tweak the organ itself for it to make sense though
					// same for other organs

			if(create_cum_decal)
				add_cum_splatter_floor(get_turf(src))

		try_lewd_autoemote("moan")
		if(climax_choice == CLIMAX_PENIS)
			apply_status_effect(/datum/status_effect/climax)
			apply_status_effect(/datum/status_effect/climax_cooldown)
			if(self_orgasm)
				add_mood_event("orgasm", /datum/mood_event/climaxself)
			return TRUE

	if(climax_choice == CLIMAX_VAGINA || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/genital/vagina/vagina = get_organ_slot(ORGAN_SLOT_VAGINA)
		if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
			visible_message(
				span_userlove("[src] 抽搐着呻吟，从阴道中达到高潮！"),
				span_userlove("你抽搐着呻吟，从阴道中达到高潮！"))
			if(vagina.reagents.total_volume >= MIN_VAGINA_WETNESS_THRESHOLD)
				add_cum_splatter_floor(get_turf(src), female = TRUE)
		else
			if(vagina.reagents.total_volume >= MIN_VAGINA_WETNESS_THRESHOLD)
				visible_message(
					span_userlove("[src] 从阴道里射在了内裤上！"),
					span_userlove("你从阴道里射在了内裤上！呃。"))
				self_orgasm = TRUE
			else
				visible_message(
					span_userlove("[src] 从阴道里射在了内裤上！"),
					span_userlove("你从阴道里射在了内裤上，但你不够湿，所以没弄脏。"))

	apply_status_effect(/datum/status_effect/climax)
	apply_status_effect(/datum/status_effect/climax_cooldown)
	if(self_orgasm)
		add_mood_event("orgasm", /datum/mood_event/climaxself)
	return TRUE

#undef CLIMAX_VAGINA
#undef CLIMAX_PENIS
#undef CLIMAX_BOTH
#undef CLIMAX_ON_FLOOR
#undef CLIMAX_IN_OR_ON
#undef CLIMAX_OPEN_CONTAINER

#undef MIN_CUM_THRESHOLD
#undef MIN_VAGINA_WETNESS_THRESHOLD
#undef CLIMAX_PORTAL
